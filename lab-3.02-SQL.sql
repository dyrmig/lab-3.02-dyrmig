CREATE SCHEMA demo;
CREATE SCHEMA demo_test;
-- 1. Normalize the following blog database
CREATE TABLE author (
	id INT NOT NULL AUTO_INCREMENT,
    author_name VARCHAR(255),
    PRIMARY KEY(id)
    );
CREATE TABLE post (
	id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(255),
    word_count INT,
    views INT,
    author_id INT,
    PRIMARY KEY(id),
    FOREIGN KEY(author_id) REFERENCES author(id)
	);
    
-- 2. Normalize the following airline database
CREATE TABLE customer (
	id INT NOT NULL AUTO_INCREMENT,
	customer_name VARCHAR(225) NOT NULL,
	customer_status VARCHAR(10),
    customer_mileage INT,
	PRIMARY KEY(id)
	);
CREATE TABLE aircraft (
	id INT NOT NULL AUTO_INCREMENT,
	aircraft_name VARCHAR(225) NOT NULL,
	aircraft_seats INT,
	PRIMARY KEY(id)
	);
CREATE TABLE flight (
	id INT NOT NULL AUTO_INCREMENT,
	flight_number VARCHAR(10) NOT NULL,
	flight_mileage INT,
    aircraft_id INT,
	PRIMARY KEY(id),
    FOREIGN KEY(aircraft_id) REFERENCES aircraft(id)
	);
CREATE TABLE customer_flight (
	customer_id INT NOT NULL,
    flight_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(id),
    FOREIGN KEY (flight_id) REFERENCES flight(id)
);
INSERT INTO customer(customer_name, customer_status, customer_mileage) VALUES
	("Agustine Riviera", "Silver", 115235),
	("Alaina Sepulvida", "None", 6008),
	("Tom Jones", "Gold", 205767),
	("Sam Rio", "None", 2653),
	("Jessica James", "Silver", 127656),
	("Ana Janco", "Silver", 136773),
	("Jennifer Cortez", "Gold", 300582),
	("Christian Janco", "Silver", 14642)
	;
INSERT INTO aircraft(aircraft_name, aircraft_seats) VALUES
	("Boeing 747", 400),
	("Airbus A330", 236),
	("Boeing 777", 264)
	;
INSERT INTO flight(flight_number, flight_mileage, aircraft_id) VALUES
	("DL143", 135, 1),
	("DL122", 4370, 2),
	("DL53", 2078, 3),
	("DL222", 1765, 3),
	("DL37", 531, 1)
	;
INSERT INTO customer_flight VALUES
	(1,1),
	(1,2),
	(2,2),
	(1,1),
	(3,2),
	(3,3),
	(1,1),
	(4,1),
	(1,1),
	(3,4),
	(5,1),
	(4,1),
	(6,4),
	(7,4),
	(5,2),
	(4,5),
	(8,4)
	;
    
-- 3. get the total number of flights in the database.
SELECT COUNT(*) FROM flight;

-- 4. get the average flight distance.
SELECT AVG(flight_mileage) FROM flight;

-- 5. get the average number of seats.
SELECT AVG(aircraft_seats) FROM aircraft;

-- 6. get the average number of miles flown by customers grouped by status.
SELECT customer_status, AVG(customer_mileage) FROM customer GROUP BY customer_status;

-- 7. get the maximum number of miles flown by customers grouped by status.
SELECT customer_status, MAX(customer_mileage) FROM customer GROUP BY customer_status;

-- 8. get the total number of aircraft with a name containing Boeing.
SELECT COUNT(*) FROM aircraft WHERE aircraft_name LIKE '%boeing%';

-- 9. find all flights with a distance between 300 and 2000 miles.
SELECT * FROM flight WHERE flight_mileage BETWEEN 300 AND 2000;

-- 10. find the average flight distance booked grouped by customer status (this should require a join).
SELECT customer.customer_status, AVG(flight.flight_mileage)
FROM customer
JOIN customer_flight ON customer.id = customer_id
JOIN flight ON flight_id = flight.id
GROUP BY customer.customer_status
;

-- 11. find the most often booked aircraft by gold status members (this should require a join).
SELECT aircraft_name, count(aircraft_name) FROM customer
JOIN customer_flight ON customer.id = customer_id
JOIN flight ON flight_id = flight.id
JOIN aircraft ON aircraft_id = aircraft.id WHERE customer_status = "Gold"
GROUP BY aircraft_name
ORDER BY COUNT(*) DESC
LIMIT 1;