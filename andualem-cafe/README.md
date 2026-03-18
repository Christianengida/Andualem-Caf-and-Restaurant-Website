# Andualem Café & Restaurant

A full-stack restaurant web application for Andualem Café & Restaurant, an Ethiopian restaurant. Customers can browse the menu, add items to a cart, place pickup orders, and submit job applications.

## Features

- **Menu** — Categorized menu with images, descriptions, and prices
- **Shopping Cart** — Persistent cart using `localStorage`, survives page navigation
- **Online Ordering** — Customers submit pickup orders with name, phone, and notes
- **Email Notifications** — Restaurant owner receives an email for every new order and job application via SendGrid
- **Job Applications** — Applicants can apply for open positions directly on the site
- **Bot Protection** — Honeypot fields and rate limiting on all form endpoints
- **Responsive UI** — Mobile-friendly layout with a hamburger navigation menu

## Tech Stack

| Layer | Technology |
|---|---|
| Backend | Python, Flask |
| Database | SQLite |
| ORM & Migrations | Flask-SQLAlchemy, Flask-Migrate |
| Email | SendGrid API |
| Rate Limiting | Flask-Limiter |
| Frontend | HTML, CSS, Vanilla JavaScript |

## Setup

**1. Clone the repo**
```bash
git clone https://github.com/Christianengida/Andualem-Caf-and-Restaurant-Website.git
cd Andualem-Caf-and-Restaurant-Website
```

**2. Create a virtual environment and install dependencies**
```bash
python3 -m venv .venv
source .venv/bin/activate
pip install flask flask-sqlalchemy flask-migrate flask-limiter sendgrid python-dotenv
```

**3. Set up your `.env` file**
```
SECRET_KEY=your-secret-key
DATABASE_URL=sqlite:///app.db
SENDGRID_API_KEY=your-sendgrid-api-key
SENDGRID_FROM_EMAIL=your-verified-sender@email.com
RESTAURANT_EMAIL=restaurant@email.com
```

**4. Initialize the database**
```bash
flask db upgrade
sqlite3 instance/app.db < seed.sql
```

**5. Run the app**
```bash
python3 app.py
```

Visit `http://127.0.0.1:5000`

## Pages

| Route | Description |
|---|---|
| `/` | Home page |
| `/menu` | Full menu with categories |
| `/checkout` | Cart and order submission |
| `/apply` | Job application form |
| `/confirmation/<id>` | Order confirmation page |
