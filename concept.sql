# If the database exists already, recreate it. If not, just create it.
# Data Types
DROP DATABASE IF EXISTS DTYPES;
CREATE DATABASE IF NOT EXISTS DTYPES;
USE DTYPES;

CREATE TABLE students(
	student_id INT AUTO_INCREMENT,
    full_name VARCHAR(40),
    age TINYINT,
    enrollment_date DATE,
    is_active BOOLEAN
);

# VENDOR DB
DROP DATABASE IF EXISTS eventdb;
CREATE DATABASE IF NOT EXISTS eventdb;
USE eventdb;

CREATE TABLE my_events(
	event_name VARCHAR(50),
    event_date DATE,
    event_time TIME,
    event_dateTime DATETIME,
    event_timeStamp TIMESTAMP
);

INSERT INTO `eventdb`.`my_events`
(`event_name`,
`event_date`,
`event_time`,
`event_dateTime`,
`event_timeStamp`)
VALUES
('Tech Conference AfroTech', '2024-11-13', '09:00:00', '2024-11-13 09:00:00', '2024-11-13 09:00:00'),
('Tech Conference Launchpad Hiring', '2024-11-13', '09:00:00', '2024-11-13 09:00:00', '2024-11-13 09:00:00');

SELECT * FROM my_events 
-- Where event_date BETWEEN current_date() AND current_date() + 7;
WHERE event_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), INTERVAL 7 DAY) + INTERVAL 1 SECOND;

# Strings, CHAR vs VARCHAR
# Storing Large Text
# Storing Integers
CREATE TABLE users(
    user_id INT AUTO_INCREMENT,
	username_char CHAR(10),
    username_varchar VARCHAR(10),
    user_desc LONGTEXT,
);

INSERT INTO my_events.users(username_char, username_varchar)
VALUES ();

# Storing JSON Data
CREATE TABLE settings(
	user_id INT AUTO_INCREMENT UNIQUE,
    preferences JSON
);

INSERT INTO airportdb.settings(user_id, preferences)
VALUES
(1,'{"themes": "dark", "notifications": true}'),
(2,'{"themes": "dark", "notifications": false}'),
(3,'{"themes": "dark", "notifications": false}'),
(4,'{"themes": "dark", "notifications": true}');

SELECT * FROM settings
WHERE JSON_EXTRACT(preferences, '$.notifications') = true;

# Combining Numbers & Dates
CREATE TABLE orders(
	order_id INT,
    order_date DATETIME,
    order_total DECIMAL(10,2)
);

