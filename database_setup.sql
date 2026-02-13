-- ==============================
-- Video Game Analytics Database
-- ==============================

-- Create Database
CREATE DATABASE video_game_analytics;
USE video_game_analytics;

-- ==============================
-- Create Tables
-- ==============================

-- Games Table
CREATE TABLE games (
    game_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255),
    release_year INT,
    rating FLOAT,
    genres TEXT
);

-- Platforms Table
CREATE TABLE platforms (
    platform_id INT PRIMARY KEY AUTO_INCREMENT,
    platform_name VARCHAR(100)
);

-- Publishers Table
CREATE TABLE publishers (
    publisher_id INT PRIMARY KEY AUTO_INCREMENT,
    publisher_name VARCHAR(100)
);

-- Sales Table
CREATE TABLE sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    game_id INT,
    platform_id INT,
    publisher_id INT,
    na_sales FLOAT,
    eu_sales FLOAT,
    jp_sales FLOAT,
    other_sales FLOAT,
    global_sales FLOAT,
    FOREIGN KEY (game_id) REFERENCES games(game_id),
    FOREIGN KEY (platform_id) REFERENCES platforms(platform_id),
    FOREIGN KEY (publisher_id) REFERENCES publishers(publisher_id)
);

-- ==============================
-- Create Views
-- ==============================

-- Yearly Sales Trend
CREATE VIEW yearly_sales_trend AS
SELECT 
    g.release_year,
    SUM(s.global_sales) AS yearly_sales
FROM games g
JOIN sales s ON g.game_id = s.game_id
GROUP BY g.release_year;

-- Platform Performance
CREATE VIEW platform_performance AS
SELECT 
    p.platform_name,
    SUM(s.global_sales) AS total_sales
FROM sales s
JOIN platforms p ON s.platform_id = p.platform_id
GROUP BY p.platform_name;

-- Publisher Performance
CREATE VIEW publisher_performance AS
SELECT 
    pub.publisher_name,
    SUM(s.global_sales) AS total_sales
FROM sales s
JOIN publishers pub ON s.publisher_id = pub.publisher_id
GROUP BY pub.publisher_name;
