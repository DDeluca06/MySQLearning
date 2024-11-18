# Creating our Database
CREATE DATABASE rentabox;
USE rentabox;

    # Table Names 
    # 1. Customer
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(15),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
    # 2. Film
CREATE TABLE film (
    film_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    release_year YEAR,
    language VARCHAR(50),
    rental_duration INT DEFAULT 7,
    rental_rate DECIMAL(5, 2),
    replacement_cost DECIMAL(5, 2),
    rating ENUM('G', 'PG', 'PG-13', 'R', 'NC-17'),
    special_features SET('Trailers', 'Commentaries', 'Deleted Scenes', 'Behind the Scenes')
);
    # 3. Inventory
CREATE TABLE inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    film_id INT NOT NULL,
    store_id INT NOT NULL,
    status ENUM('Available', 'Rented', 'Maintenance') DEFAULT 'Available',
    FOREIGN KEY (film_id) REFERENCES film(film_id)
);
    # 4. Rentals
CREATE TABLE rentals (
    rental_id INT AUTO_INCREMENT PRIMARY KEY,
    rental_date DATETIME NOT NULL, # ????????? Why am I gettting incorrect datetime value errors?
    inventory_id INT NOT NULL,
    customer_id INT NOT NULL,
    return_date DATETIME,
    staff_id INT NOT NULL,
    FOREIGN KEY (inventory_id) REFERENCES inventory(inventory_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

    # Objective:
    # List all movies rented by customers, 
    # along with their first and last names.
SELECT customer.customer_id, customer.first_name, customer.last_name, film.title, rentals.rental_date
FROM rentals
INNER JOIN customer ON rentals.customer_id = customer.customer_id
INNER JOIN inventory ON rentals.inventory_id = inventory.inventory_id
INNER JOIN film ON inventory.film_id = film.film_id
ORDER BY customer.customer_id ASC;
# Creating Fake Data on seperate files