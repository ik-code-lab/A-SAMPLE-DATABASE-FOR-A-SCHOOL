CREATE DATABASE schooldb;

USE schooldb;

-- Table: Students
CREATE TABLE Students (
    StudentID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE,
    Email VARCHAR(100) UNIQUE,
    PhoneNumber VARCHAR(20),
    Address VARCHAR(255)
);

-- Table: Courses
CREATE TABLE Courses (
    CourseID INT AUTO_INCREMENT PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL UNIQUE,
    CourseCode VARCHAR(10) NOT NULL UNIQUE,
    Description TEXT
);

-- Table: Teachers
CREATE TABLE Teachers (
    TeacherID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    PhoneNumber VARCHAR(20),
    address VARCHAR(255),
    SubjectSpecialization VARCHAR(100),
    salary DECIMAL(10,2)
);

-- Table: Enrollments (Many-to-Many relationship between Students and Courses)
CREATE TABLE Enrollments (
    EnrollmentID INT AUTO_INCREMENT PRIMARY KEY,
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    EnrollmentDate DATE NOT NULL,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    UNIQUE KEY unique_enrollment (StudentID, CourseID) -- Ensure a student can't enroll in the same course twice
);

-- Table: Grades
CREATE TABLE Grades (
    GradeID INT AUTO_INCREMENT PRIMARY KEY,
    EnrollmentID INT NOT NULL,
    Grade DECIMAL(5, 2),
    GradingDate DATE NOT NULL,
    FOREIGN KEY (EnrollmentID) REFERENCES Enrollments(EnrollmentID),
    UNIQUE KEY unique_grade (EnrollmentID) -- Each enrollment should have one grade record
);

-- Table: CourseTeachers (Many-to-Many relationship between Courses and Teachers)
CREATE TABLE CourseTeachers (
    CourseTeacherID INT AUTO_INCREMENT PRIMARY KEY,
    CourseID INT NOT NULL,
    TeacherID INT NOT NULL,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    FOREIGN KEY (TeacherID) REFERENCES Teachers(TeacherID),
    UNIQUE KEY unique_course_teacher (CourseID, TeacherID) -- Ensure a teacher is not assigned to the same course multiple times
);