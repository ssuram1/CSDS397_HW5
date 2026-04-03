CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE countries (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    age INT CHECK (age BETWEEN 18 AND 70),
    date_of_joining DATE,
    years_of_experience INT,
    salary DECIMAL(10,2),
    department_id INT,
    country_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (country_id) REFERENCES countries(country_id)
);

CREATE TABLE performance (
    employee_id INT PRIMARY KEY,
    performance_rating INT CHECK (performance_rating BETWEEN 1 AND 5),
    total_sales DECIMAL(12,2),
    support_rating INT,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);


