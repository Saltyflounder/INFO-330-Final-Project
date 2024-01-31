--Yisa Wu--

--Question 1--
WITH StudentCredits AS (
    SELECT s.student_id, s.first_name, s.last_name,
        COALESCE(SUM(c.course_credits), 0) AS total_credits_completed
    FROM Students s
    LEFT JOIN Exams e ON s.student_id = e.student_id
    LEFT JOIN Courses c ON e.course_code = c.course_code
    GROUP BY s.student_id, s.first_name, s.last_name
)

SELECT sc.first_name, sc.last_name, sc.total_credits_completed,
    sc.total_credits_completed / avg_total_credits, 1 AS credits_ratio
FROM StudentCredits sc
LEFT JOIN (
    SELECT AVG(total_credits_completed) AS avg_total_credits
    FROM StudentCredits
) avg_credits ON 1=1;

--Question 2--
WITH StudentAvgScores AS (
    SELECT e.course_code, e.student_id, AVG(e.score) AS avg_score
    FROM Exams e
    GROUP BY e.course_code, e.student_id
),

CourseAvgScore AS (
    SELECT s.course_code, AVG(e.score) AS avg_course_score
    FROM Exams e
    JOIN Courses s ON e.course_code = s.course_code
    GROUP BY s.course_code
)

SELECT c.course_name,
    COUNT(s.avg_score > ca.avg_course_score) * 1.0 / COUNT(*) AS proportion_above_avg
FROM StudentAvgScores s
JOIN CourseAvgScore ca ON s.course_code = ca.course_code
JOIN Courses c ON s.course_code = c.course_code
GROUP BY c.course_name;

--Question 3--
WITH CourseStats AS (
    SELECT e.course_code, MIN(e.score) AS min_score,
    MAX(e.score) AS max_score, AVG(e.score) AS avg_score
    FROM Exams e
    GROUP BY e.course_code
),

OverallStats AS (
    SELECT MIN(e.score) AS overall_min_score, MAX(e.score) AS overall_max_score,
        AVG(e.score) AS overall_avg_score
    FROM Exams e
)

SELECT c.course_name,
    cs.min_score AS course_min_score,
    cs.max_score AS course_max_score,
    cs.avg_score AS course_avg_score,
    os.overall_min_score,
    os.overall_max_score,
    os.overall_avg_score
FROM CourseStats cs
JOIN Courses c ON cs.course_code = c.course_code
CROSS JOIN OverallStats os;

--Question 4--
--4a--
CREATE VIEW DepartmentInstructors_yiw AS
SELECT d.DepartmentName, i.LastName, i.FirstName,
    i.Status, i.AnnualSalary
FROM Departments d
JOIN Instructors i ON d.DepartmentID = i.DepartmentID;

--4b--
SELECT *
FROM DepartmentInstructors_yiw
WHERE Status = 'fulltime' AND DepartmentName = 'English';

--4c--
UPDATE DepartmentInstructors_yiw
SET AnnualSalary = AnnualSalary * 1.1
WHERE Status = 'fulltime' AND DepartmentName = 'English';

--Question 5--
CREATE FUNCTION fnStudentUnits_yiw(@StudentID INT)
RETURNS INT
AS
BEGIN
    DECLARE @TotalUnits INT;

    SELECT @TotalUnits = SUM(CourseUnits)
    FROM Courses c
    JOIN StudentCourses sc ON c.CourseID = sc.CourseID
    WHERE sc.StudentID = @StudentID;

    RETURN @TotalUnits;
END;

SELECT sc.StudentID, c.CourseNumber, c.CourseUnits,
    dbo.fnStudentUnits_yiw(sc.StudentID) AS TotalStudentUnits
FROM StudentCourses sc
JOIN Courses c ON sc.CourseID = c.CourseID;

--Question 6--
CREATE PROCEDURE spUpdateInstructor_yiw
    @InstructorID INT,
    @NewAnnualSalary DECIMAL(10, 2)
AS
BEGIN
    IF @NewAnnualSalary < 0
    BEGIN
        RAISEERROR('AnnualSalary must be a positive number.', 16, 1);
        RETURN;
    END

    UPDATE Instructors
    SET AnnualSalary = @NewAnnualSalary
    WHERE InstructorID = @InstructorID;
END;

-- Test 1: update the salary for InstructorID = 1 to $60,000 --
EXEC spUpdateInstructor_yiw @InstructorID = 1, @NewAnnualSalary = 60000;

-- Test 2: update the salary for InstructorID = 2 to a negative value (should be an error) --
EXEC spUpdateInstructor_yiw @InstructorID = 2, @NewAnnualSalary = -60000;

-- Question 7--
CREATE TRIGGER Instructors_INSERT_yiw
ON Instructors
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Instructors
    SET HireDate = GETDATE()
    WHERE HireDate IS NULL
      AND InstructorID IN (SELECT InstructorID FROM inserted);
END;

-- Test --
INSERT INTO Instructors (LastName, FirstName, Status, AnnualSalary, DepartmentID)
VALUES ('Doe', 'John', 'FullTime', 70000.00, 1);