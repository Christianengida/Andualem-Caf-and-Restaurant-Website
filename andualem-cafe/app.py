import os
import json
from datetime import datetime, timezone
from decimal import Decimal

from sendgrid import SendGridAPIClient
from sendgrid.helpers.mail import Mail

from flask import Flask, render_template, request, redirect, url_for
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from flask_limiter import Limiter
from flask_limiter.util import get_remote_address
from dotenv import load_dotenv

load_dotenv()

db = SQLAlchemy()


class MenuItem(db.Model):
    __tablename__ = "menu_items"

    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(120), nullable=False)
    description = db.Column(db.String(300), nullable=True)
    price = db.Column(db.Numeric(10, 2), nullable=False)
    category = db.Column(db.String(50), nullable=False)
    image_url = db.Column(db.String(500), nullable=True)
    is_available = db.Column(db.Boolean, nullable=False, default=True)


class Order(db.Model):
    __tablename__ = "orders"

    id = db.Column(db.Integer, primary_key=True)
    customer_name = db.Column(db.String(120), nullable=False)
    phone = db.Column(db.String(30), nullable=False)
    notes = db.Column(db.Text, nullable=True)
    total_price = db.Column(db.Numeric(10, 2), nullable=False)
    created_at = db.Column(
        db.DateTime, nullable=False, default=lambda: datetime.now(timezone.utc)
    )
    items = db.relationship("OrderItem", back_populates="order", lazy=True)


class OrderItem(db.Model):
    __tablename__ = "order_items"

    id = db.Column(db.Integer, primary_key=True)
    order_id = db.Column(db.Integer, db.ForeignKey("orders.id"), nullable=False)
    name = db.Column(db.String(120), nullable=False)
    quantity = db.Column(db.Integer, nullable=False)
    unit_price = db.Column(db.Numeric(10, 2), nullable=False)
    order = db.relationship("Order", back_populates="items")


class Application(db.Model):
    __tablename__ = "applications"

    id = db.Column(db.Integer, primary_key=True)
    full_name = db.Column(db.String(120), nullable=False)
    email = db.Column(db.String(200), nullable=False)
    phone = db.Column(db.String(30), nullable=True)
    position = db.Column(db.String(120), nullable=False)
    message = db.Column(db.Text, nullable=True)
    created_at = db.Column(
        db.DateTime, nullable=False, default=lambda: datetime.now(timezone.utc)
    )


def _sendgrid_send(subject, body, to_email):
    api_key = os.getenv("SENDGRID_API_KEY", "")
    from_email = os.getenv("SENDGRID_FROM_EMAIL", os.getenv("RESTAURANT_EMAIL", "andualemcafe@gmail.com"))
    if not api_key:
        return False
    message = Mail(
        from_email=from_email,
        to_emails=to_email,
        subject=subject,
        plain_text_content=body,
    )
    try:
        SendGridAPIClient(api_key).send(message)
        return True
    except Exception:
        return False


def send_order_email(order, items):
    to_email = os.getenv("RESTAURANT_EMAIL", "andualemcafe@gmail.com")
    subject = f"New Order #{order.id} — {order.customer_name}"
    lines = [
        "New pickup order received!\n",
        f"Order #{order.id}",
        f"Date: {order.created_at.strftime('%B %d, %Y at %I:%M %p UTC')}",
        "",
        f"Customer: {order.customer_name}",
        f"Phone: {order.phone}",
        f"Notes: {order.notes or 'None'}",
        "",
        "--- Items ---",
    ]
    for item in items:
        subtotal = item["quantity"] * item["unit_price"]
        lines.append(
            f"  {item['quantity']}x {item['name']}  @  ${item['unit_price']:.2f}  =  ${subtotal:.2f}"
        )
    lines += ["", f"TOTAL: ${order.total_price}", "", "Payment: Cash on pickup"]
    return _sendgrid_send(subject, "\n".join(lines), to_email)


def send_application_email(application):
    to_email = os.getenv("RESTAURANT_EMAIL", "andualemcafe@gmail.com")
    subject = f"New Application — {application.full_name} ({application.position})"
    body = (
        f"New application received!\n\n"
        f"Name: {application.full_name}\n"
        f"Email: {application.email}\n"
        f"Phone: {application.phone or 'Not provided'}\n"
        f"Position: {application.position}\n\n"
        f"Message:\n{application.message or 'None'}\n\n"
        f"Submitted: {application.created_at.strftime('%B %d, %Y at %I:%M %p UTC')}"
    )
    return _sendgrid_send(subject, body, to_email)


def create_app():
    app = Flask(__name__)
    app.config["SECRET_KEY"] = os.getenv("SECRET_KEY", "dev-secret-change-me")
    app.config["SQLALCHEMY_DATABASE_URI"] = os.getenv(
        "DATABASE_URL", "sqlite:///app.db"
    )
    app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

    db.init_app(app)
    Migrate(app, db)

    limiter = Limiter(
        get_remote_address,
        app=app,
        default_limits=[],
        storage_uri="memory://",
    )

    @app.get("/")
    def home():
        return render_template("index.html")

    @app.get("/menu")
    def menu():
        category_order = ["Starters", "Vegetarian Entrees", "Meat Entrees", "Chef's Specials", "Family Combo", "Sides", "Drinks"]
        items = (
            MenuItem.query.filter_by(is_available=True)
            .order_by(MenuItem.name)
            .all()
        )
        categories = {}
        for item in items:
            categories.setdefault(item.category, []).append(item)
        # Sort categories by preferred order, unknown ones go last
        sorted_categories = {
            k: categories[k]
            for k in category_order
            if k in categories
        }
        for k in categories:
            if k not in sorted_categories:
                sorted_categories[k] = categories[k]
        return render_template("menu.html", categories=sorted_categories)

    @app.get("/checkout")
    def checkout():
        return render_template("checkout.html")

    @app.post("/checkout")
    @limiter.limit("5 per minute")
    def submit_order():
        # Honeypot — bots fill hidden fields
        if request.form.get("website"):
            return redirect(url_for("home"))

        customer_name = request.form.get("customer_name", "").strip()
        phone = request.form.get("phone", "").strip()
        notes = request.form.get("notes", "").strip()
        cart_json = request.form.get("cart_data", "[]")

        if not customer_name or not phone:
            return render_template(
                "checkout.html", error="Name and phone number are required."
            )

        try:
            cart_items = json.loads(cart_json)
        except (json.JSONDecodeError, ValueError):
            return render_template("checkout.html", error="Invalid cart data. Please try again.")

        if not cart_items:
            return render_template("checkout.html", error="Your cart is empty.")

        total = sum(
            Decimal(str(item["price"])) * int(item["quantity"])
            for item in cart_items
        )

        order = Order(
            customer_name=customer_name,
            phone=phone,
            notes=notes or None,
            total_price=total,
        )
        db.session.add(order)
        db.session.flush()

        for item in cart_items:
            oi = OrderItem(
                order_id=order.id,
                name=item["name"],
                quantity=int(item["quantity"]),
                unit_price=Decimal(str(item["price"])),
            )
            db.session.add(oi)

        db.session.commit()

        email_items = [
            {
                "name": item["name"],
                "quantity": int(item["quantity"]),
                "unit_price": float(item["price"]),
            }
            for item in cart_items
        ]
        send_order_email(order, email_items)

        return redirect(url_for("confirmation", order_id=order.id))

    @app.get("/confirmation/<int:order_id>")
    def confirmation(order_id):
        order = Order.query.get_or_404(order_id)
        return render_template("confirmation.html", order=order)

    @app.get("/apply")
    def apply():
        return render_template("apply.html")

    @app.post("/apply")
    @limiter.limit("3 per hour")
    def submit_application():
        if request.form.get("website"):
            return redirect(url_for("home"))

        full_name = request.form.get("full_name", "").strip()
        email = request.form.get("email", "").strip()
        phone = request.form.get("phone", "").strip()
        position = request.form.get("position", "").strip()
        message = request.form.get("message", "").strip()

        if not full_name or not email or not position:
            return render_template(
                "apply.html", error="Name, email, and position are required."
            )

        application = Application(
            full_name=full_name,
            email=email,
            phone=phone or None,
            position=position,
            message=message or None,
        )
        db.session.add(application)
        db.session.commit()
        send_application_email(application)

        return render_template("apply.html", success=True)

    return app


app = create_app()

if __name__ == "__main__":
    app.run(debug=True, host="127.0.0.1", port=5000)
