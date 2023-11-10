CREATE DATABASE Advising_Team_109
-------------------

CREATE TABLE Student(
    student_id INT PRIMARY KEY IDENTITY,
    f_name VARCHAR(40) NOT NULL,
    l_name VARCHAR(40) NOT NULL,
    gpa DECIMAL(3,2), -- Question 1
    faculty VARCHAR(40),
    email VARCHAR(40),
    major VARCHAR(40),
    password VARCHAR(40),
    financial_status AS CURRENT_TIMESTAMP() > Installment.deadline AND Installment.status = 1,
    semster INT,
    acquired_hours INT,
    assigned_hours INT,
    --advisor_id INT, 
    CONSTRAINT check_gpa CHECK (gpa BETWEEN 0.7 AND 5)
)




