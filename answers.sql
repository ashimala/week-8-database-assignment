-- Question 1: Build a Complete Database Management System 
-- week 8 database assignment

-- creating a database called clinic booking system 

CREATE DATABASE ClinicBookingSystem;

USE ClinicBookingSystem;

-- creating tables for the clinic booking system

CREATE TABLE Patients (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    PhoneNumber VARCHAR(15) UNIQUE,
    Email VARCHAR(100) UNIQUE
);
CREATE TABLE Doctors (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Specialty VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(15) UNIQUE,
    Email VARCHAR(100) UNIQUE
);
CREATE TABLE Appointments (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATETIME NOT NULL,
    Reason VARCHAR(255),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);
CREATE TABLE Treatments (
    TreatmentID INT AUTO_INCREMENT PRIMARY KEY,
    AppointmentID INT,
    TreatmentDescription TEXT NOT NULL,
    Cost DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID)
);
CREATE TABLE Prescriptions (
    PrescriptionID INT AUTO_INCREMENT PRIMARY KEY,
    AppointmentID INT,
    MedicationName VARCHAR(100) NOT NULL,
    Dosage VARCHAR(50) NOT NULL,
    Frequency VARCHAR(50) NOT NULL,
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID)
);

-- inserting sample data into the tables at leats 5 records in each table

INSERT INTO Patients (FirstName, LastName, DateOfBirth, PhoneNumber, Email) 
VALUES ('John', 'Doe', '1980-05-15', '123-456-7890', 'johndoe@gmail.com'),
       ('Jane', 'Smith', '1990-07-20', '234-567-8901', 'janedoe@gmail.com'),
       ('Alice', 'Johnson', '1975-03-10', '345-678-9012', 'alicejohnson@gmail.com'),
       ('Bob', 'Brown', '1985-11-25', '456-789-0123', 'bobbrown@gmail.com'),
       ('Charlie', 'Davis', '2000-01-30', '567-890-1234', 'davischarlie@gmail.com');


INSERT INTO Doctors (FirstName, LastName, Specialty, PhoneNumber, Email) 
VALUES ('Dr. Emily', 'White', 'Cardiology', '678-901-2345', 'emilywhite@gmail.com'),
       ('Dr. Michael', 'Green', 'Dermatology', '789-012-3456', 'greenmachael@gmail.com'),
       ('Dr. Sarah', 'Black', 'Pediatrics', '890-123-4567', 'sarahblack@gmail.com'),
       ('Dr. David', 'Blue', 'Orthopedics', '901-234-5678', 'bluedavid@gmail.com'),
       ('Dr. Linda', 'Gray', 'Neurology', '012-345-6789', 'indagray@gmail.com');

INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate, Reason)
VALUES (1, 1, '2024-07-01 10:00:00', 'Regular Checkup'),
       (2, 2, '2024-07-02 11:30:00', 'Skin Rash'),
       (3, 3, '2024-07-03 09:00:00', 'Child Fever'),
       (4, 4, '2024-07-04 14:00:00', 'Knee Pain'),
       (5, 5, '2024-07-05 15:30:00', 'Headache');

INSERT INTO Treatments (AppointmentID, TreatmentDescription, Cost)
VALUES (1, 'Blood Test and Physical Examination', 150.00),
       (2, 'Topical Cream Application', 75.00),
       (3, 'Fever Management and Medication', 100.00),
       (4, 'Physical Therapy Session', 200.00),
       (5, 'Neurological Examination', 250.00);

INSERT INTO Prescriptions (AppointmentID, MedicationName, Dosage, Frequency)
VALUES (1, 'Vitamin D', '1000 IU', 'Once Daily'),
       (2, 'Hydrocortisone Cream', 'Apply Thin Layer', 'Twice Daily'),
       (3, 'Paracetamol', '500 mg', 'Every 6 Hours'),
       (4, 'Ibuprofen', '400 mg', 'Every 8 Hours'),
       (5, 'Aspirin', '81 mg', 'Once Daily');




-- Query to retrieve all appointments along with patient and doctor details. Example of one to one 


SELECT a.AppointmentID, a.AppointmentDate, a.Reason,
       p.FirstName AS PatientFirstName, p.LastName AS PatientLastName,
       d.FirstName AS DoctorFirstName, d.LastName AS DoctorLastName, d.Specialty
FROM Appointments a
JOIN Patients p ON a.PatientID = p.PatientID
JOIN Doctors d ON a.DoctorID = d.DoctorID; 

-- Query to find all treatments for a specific patient (e.g., PatientID = 1)


SELECT t.TreatmentID, t.TreatmentDescription, t.Cost, a.AppointmentDate
FROM Treatments t   
JOIN Appointments a ON t.AppointmentID = a.AppointmentID
WHERE a.PatientID = 1;  


-- Query to list all prescriptions given by a specific doctor (e.g., DoctorID = 2)
SELECT pr.PrescriptionID, pr.MedicationName, pr.Dosage, pr.Frequency, a.AppointmentDate
FROM Prescriptions pr
JOIN Appointments a ON pr.AppointmentID = a.AppointmentID
WHERE a.DoctorID = 2;



-- Query to calculate the total cost of treatments for each patient
SELECT p.PatientID, p.FirstName, p.LastName, SUM(t.Cost) AS TotalTreatmentCost
FROM Patients p
LEFT JOIN Appointments a ON p.PatientID = a.PatientID
LEFT JOIN Treatments t ON a.AppointmentID = t.AppointmentID
GROUP BY p.PatientID, p.FirstName, p.LastName;



-- Query to find doctors who have more than 2 appointments scheduled

SELECT d.DoctorID, d.FirstName, d.LastName, COUNT(a.AppointmentID) AS AppointmentCount
FROM Doctors d
JOIN Appointments a ON d.DoctorID = a.DoctorID

GROUP BY d.DoctorID, d.FirstName, d.LastName
HAVING COUNT(a.AppointmentID) > 2;


























-