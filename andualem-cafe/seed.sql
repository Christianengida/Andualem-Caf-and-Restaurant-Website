-- seed.sql
-- Full menu for Andualem Café & Restaurant

DELETE FROM menu_items;

INSERT INTO menu_items (name, description, price, category, image_url, is_available) VALUES

-- STARTERS
('Sambusa', 'Crispy pastry filled with spiced lentils or beef, served with dipping sauce.', 5.99, 'Starters',
 'https://images.unsplash.com/photo-1761243743989-726fb70af78d?auto=format&fit=crop&w=1200&q=80', 1),

('Azifa', 'Cold green lentil salad dressed with lime, mustard, and jalapeño.', 6.49, 'Starters',
 'https://images.unsplash.com/photo-1505576399279-565b52d4ac71?auto=format&fit=crop&w=1200&q=80', 1),

('Timatim Salad', 'Fresh tomato and jalapeño salad with herbs and a light dressing.', 5.49, 'Starters',
 'https://images.unsplash.com/photo-1561451055-0de615569a38?auto=format&fit=crop&w=1200&q=80', 1),

('Kategna', 'Toasted injera brushed with spiced butter and berbere.', 4.99, 'Starters',
 'https://images.unsplash.com/photo-1542367592-8849eb950fd8?auto=format&fit=crop&w=1200&q=80', 1),

-- VEGETARIAN ENTREES
('Misir Wot', 'Red lentils slow-cooked in a rich berbere sauce (vegan).', 13.99, 'Vegetarian Entrees',
 'https://images.unsplash.com/photo-1606791496080-69a6e309f42c?auto=format&fit=crop&w=1200&q=80', 1),

('Shiro', 'Smooth chickpea flour stew seasoned with garlic and Ethiopian spices (vegan).', 13.49, 'Vegetarian Entrees',
 'https://images.unsplash.com/photo-1658930613708-3a7bb1f4c9b4?auto=format&fit=crop&w=1200&q=80', 1),

('Kik Alicha', 'Mild yellow split pea stew with turmeric and ginger (vegan).', 12.99, 'Vegetarian Entrees',
 'https://images.unsplash.com/photo-1658930613708-3a7bb1f4c9b4?auto=format&fit=crop&w=1200&q=80', 1),

('Atakilt Wot', 'Spiced cabbage, carrots, and potatoes sautéed with onion and turmeric (vegan).', 12.49, 'Vegetarian Entrees',
 'https://images.unsplash.com/photo-1572171579626-e79450374587?auto=format&fit=crop&w=1200&q=80', 1),

('Gomen', 'Ethiopian-style collard greens cooked with garlic and spiced butter (vegan).', 12.49, 'Vegetarian Entrees',
 'https://images.unsplash.com/photo-1572171579626-e79450374587?auto=format&fit=crop&w=1200&q=80', 1),

('Vegetable Combo', 'A sampler of four vegetarian dishes served with injera.', 17.99, 'Vegetarian Entrees',
 'https://images.unsplash.com/photo-1542367592-8849eb950fd8?auto=format&fit=crop&w=1200&q=80', 1),

-- MEAT ENTREES
('Doro Wot', 'Slow-simmered chicken in a deep berbere stew with a hard-boiled egg, served with injera.', 18.99, 'Meat Entrees',
 'https://images.unsplash.com/photo-1708782344490-9026aaa5eec7?auto=format&fit=crop&w=1200&q=80', 1),

('Tibs', 'Sautéed beef with onions, tomatoes, jalapeño, and Ethiopian spices.', 17.49, 'Meat Entrees',
 'https://images.unsplash.com/photo-1507150370052-1e798df49f29?auto=format&fit=crop&w=1200&q=80', 1),

('Kitfo', 'Ethiopian-style steak tartare seasoned with mitmita and spiced butter. Served raw, medium, or cooked.', 19.99, 'Meat Entrees',
 'https://images.unsplash.com/photo-1546010361-3b7b468209e3?auto=format&fit=crop&w=1200&q=80', 1),

('Gored Gored', 'Cubed raw beef marinated in awaze and spiced butter — a bold Ethiopian classic.', 19.49, 'Meat Entrees',
 'https://images.unsplash.com/photo-1546010361-3b7b468209e3?auto=format&fit=crop&w=1200&q=80', 1),

('Minchet Abish', 'Ground beef cooked with onions, berbere, and Ethiopian spices.', 16.99, 'Meat Entrees',
 'https://images.unsplash.com/photo-1507150370052-1e798df49f29?auto=format&fit=crop&w=1200&q=80', 1),

('Yebeg Alicha', 'Tender lamb stew cooked in a mild, fragrant sauce with turmeric and ginger.', 20.99, 'Meat Entrees',
 'https://images.unsplash.com/photo-1689860892307-7db54ab276ba?auto=format&fit=crop&w=1200&q=80', 1),

-- CHEF'S SPECIALS
('Shekla Tibs', 'Bone-in beef ribs sizzled in a clay pot with butter, onions, and rosemary.', 22.99, 'Chef''s Specials',
 'https://images.unsplash.com/photo-1507150370052-1e798df49f29?auto=format&fit=crop&w=1200&q=80', 1),

('Leb Leb Kitfo', 'Lightly cooked kitfo topped with homemade ayib (cottage cheese) and gomen.', 21.99, 'Chef''s Specials',
 'https://images.unsplash.com/photo-1546010361-3b7b468209e3?auto=format&fit=crop&w=1200&q=80', 1),

('Dulet', 'Minced tripe, liver, and lean beef sautéed with peppers and Ethiopian spices.', 20.49, 'Chef''s Specials',
 'https://images.unsplash.com/photo-1507150370052-1e798df49f29?auto=format&fit=crop&w=1200&q=80', 1),

('Quanta Firfir', 'Torn injera tossed with dried beef strips, berbere, and clarified butter.', 18.99, 'Chef''s Specials',
 'https://images.unsplash.com/photo-1542367592-8849eb950fd8?auto=format&fit=crop&w=1200&q=80', 1),

-- FAMILY COMBO
('Family Style Platter', 'A large spread of meat and vegetarian dishes served on injera — perfect for sharing. Feeds 3–4.', 59.99, 'Family Combo',
 'https://images.unsplash.com/photo-1542367592-8849eb950fd8?auto=format&fit=crop&w=1200&q=80', 1),

('Couples Platter', 'Two meat and two vegetarian dishes served on injera for two.', 34.99, 'Family Combo',
 'https://images.unsplash.com/photo-1542367592-8849eb950fd8?auto=format&fit=crop&w=1200&q=80', 1),

('House Special Combo', 'Chef''s selection of the day''s best dishes served with injera.', 24.99, 'Family Combo',
 'https://images.unsplash.com/photo-1542367592-8849eb950fd8?auto=format&fit=crop&w=1200&q=80', 1),

-- SIDES
('Injera', 'Traditional Ethiopian sourdough flatbread made from teff flour.', 2.50, 'Sides',
 'https://images.unsplash.com/photo-1542367592-8849eb950fd8?auto=format&fit=crop&w=1200&q=80', 1),

('Rice', 'Steamed basmati rice, lightly seasoned.', 2.99, 'Sides',
 'https://images.unsplash.com/photo-1536304993881-ff6e9eefa2a6?auto=format&fit=crop&w=1200&q=80', 1),

('Ayib', 'Fresh Ethiopian cottage cheese, mild and creamy.', 3.49, 'Sides',
 'https://images.unsplash.com/photo-1658930613708-3a7bb1f4c9b4?auto=format&fit=crop&w=1200&q=80', 1),

('Awaze', 'Spicy Ethiopian chili paste made with berbere and tej.', 1.99, 'Sides',
 'https://images.unsplash.com/photo-1761243743989-726fb70af78d?auto=format&fit=crop&w=1200&q=80', 1),

-- DRINKS
('Ethiopian Coffee', 'Traditional jebena-brewed coffee served in three rounds — the full ceremony experience.', 4.99, 'Drinks',
 'https://images.unsplash.com/photo-1631166092772-d07aed54b9a0?auto=format&fit=crop&w=1200&q=80', 1),

('Spiced Tea', 'Warm tea brewed with cardamom, ginger, and cloves. Ask for dairy-free.', 3.49, 'Drinks',
 'https://images.unsplash.com/photo-1568832849324-167c62c7849b?auto=format&fit=crop&w=1200&q=80', 1),

('Mango Juice', 'Fresh-pressed mango juice, served chilled.', 3.99, 'Drinks',
 'https://images.unsplash.com/photo-1562114676-007657641f2e?auto=format&fit=crop&w=1200&q=80', 1),

('Tej', 'Traditional Ethiopian honey wine with a naturally sweet, fermented flavor.', 5.99, 'Drinks',
 'https://images.unsplash.com/photo-1656203549816-f7b8e48222a5?auto=format&fit=crop&w=1200&q=80', 1);
