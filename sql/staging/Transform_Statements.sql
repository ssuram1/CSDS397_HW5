 INSERT INTO staging.departments (department_name)
SELECT DISTINCT department_clean
FROM (
    SELECT
        CASE
            WHEN LOWER(TRIM(department)) IN ('sales','sale','sls','slaes','saless')
                THEN 'Sales'
            WHEN LOWER(TRIM(department)) IN ('support','supprt','supp')
                THEN 'Support'
            WHEN LOWER(TRIM(department)) IN ('marketing','markting','mkting','mkt')
                THEN 'Marketing'
            WHEN LOWER(TRIM(department)) = 'operations'
                THEN 'Operations'
            WHEN LOWER(TRIM(department)) = 'leadership'
                THEN 'Leadership'
            WHEN LOWER(TRIM(department)) = 'development'
                THEN 'Development'
        END AS department_clean
    FROM sources.employee_raw
    WHERE department IS NOT NULL
) cleaned

WHERE department_clean IS NOT NULL;


INSERT INTO staging.countries (country_name)
SELECT DISTINCT
CONCAT(
    UPPER(LEFT(TRIM(country),1)),
    LOWER(SUBSTRING(TRIM(country),2))
)

FROM sources.employee_raw
WHERE country IS NOT NULL;


INSERT INTO staging.employees
(
employee_id,
full_name,
age,
date_of_joining,
years_of_experience,
salary,
department_id,
country_id
)

WITH ranked AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY `employee Id` ORDER BY `Date of Joining` DESC) AS rn
    FROM sources.employee_raw
    WHERE `employee Id` REGEXP '^[0-9]+'
)

SELECT
CAST(r.`employee Id` AS UNSIGNED) AS employee_id,
TRIM(r.name) AS full_name,
CAST(r.age AS UNSIGNED) AS age,
STR_TO_DATE(NULLIF(r.`Date of Joining`,''),'%Y-%m-%d') AS date_of_joining,
CAST(r.`Years of Experience` AS UNSIGNED) AS years_of_experience,
CAST(r.salary AS DECIMAL(10,2)) AS salary,
d.department_id,
c.country_id

FROM ranked r
JOIN staging.departments d
ON (
   CASE
        WHEN LOWER(TRIM(r.department)) IN ('sales','sale','sls','slaes','saless')
            THEN 'Sales'
        WHEN LOWER(TRIM(r.department)) IN ('support','supprt','supp')
            THEN 'Support'
        WHEN LOWER(TRIM(r.department)) IN ('marketing','markting','mkting','mkt')
            THEN 'Marketing'
        WHEN LOWER(TRIM(r.department)) = 'operations'
            THEN 'Operations'
        WHEN LOWER(TRIM(r.department)) = 'leadership'
            THEN 'Leadership'
        WHEN LOWER(TRIM(r.department)) = 'development'
            THEN 'Development'
   END
) = d.department_name

JOIN staging.countries c
ON CONCAT(
        UPPER(LEFT(TRIM(r.country),1)),
        LOWER(SUBSTRING(TRIM(r.country),2))
   ) = c.country_name

WHERE
rn = 1
AND r.name IS NOT NULL
AND TRIM(r.name) <> ''
AND r.age REGEXP '^[0-9]+'
AND CAST(r.age AS UNSIGNED) > 0
AND r.salary REGEXP '^[0-9]+(\\.[0-9]+)?$'
AND CAST(r.salary AS DECIMAL(10,2)) > 0
AND r.`Years of Experience` REGEXP '^[0-9]+'
AND CAST(r.`Years of Experience` AS UNSIGNED) < CAST(r.age AS UNSIGNED)
AND r.`Date of Joining` REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$';


INSERT INTO staging.performance
(
    employee_id,
    performance_rating,
    total_sales,
    support_rating
)
SELECT
    e.employee_id,
    CAST(r.`Performance Rating` AS UNSIGNED) AS performance_rating,
    CAST(r.`Total Sales` AS DECIMAL(12,2)) AS total_sales,
    CAST(r.`Support Rating` AS UNSIGNED) AS support_rating
FROM staging.employees e
JOIN (
    -- Subquery to select only one row per employee
    SELECT *
    FROM (
        SELECT *,
               ROW_NUMBER() OVER (PARTITION BY `employee Id` ORDER BY `Date of Joining` DESC) AS rn
        FROM sources.employee_raw
        WHERE `employee Id` REGEXP '^[0-9]+'
    ) ranked
    WHERE rn = 1
) r
    ON e.employee_id = CAST(r.`employee Id` AS UNSIGNED)
WHERE
    r.`Performance Rating` REGEXP '^[0-9]+'
    AND CAST(r.`Performance Rating` AS UNSIGNED) BETWEEN 1 AND 5
    AND r.`Total Sales` REGEXP '^[0-9]+(\\.[0-9]+)?$'
    AND CAST(r.`Total Sales` AS DECIMAL(12,2)) >= 0
    AND r.`Support Rating` REGEXP '^[0-9]+'
    AND CAST(r.`Support Rating` AS UNSIGNED) BETWEEN 0 AND 5;