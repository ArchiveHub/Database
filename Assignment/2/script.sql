# 1 
SELECT 
    A.Age, concat_ws(" ", A.Fname, A.Lname) as Name, A.major 
FROM 
    Student as A 
join 
    (SELECT min(Age) as Age, major FROM Student GROUP BY Major) as B 
on 
    A.major = B.major and A.Age = B.Age;

# 2 
SELECT 
    DName, min(GPA), concat_ws(" ", Lname, Fname) as Name 
FROM 
    (SELECT Student.StuID, CID, Lname, Fname, avg(gradepoint) as GPA, DName FROM Student, Enrolled_in, Gradeconversion, Department 
WHERE 
    Student.StuID = Enrolled_in.StuID and Grade = lettergrade and Major = DNO GROUP BY StuId) as A 
GROUP BY DName;

# 3 
SELECT 
    Student.StuId, concat_ws(" ", Lname, Fname) as Name, Major, Sex, avg(gradepoint) 
FROM 
    Student, Enrolled_in, Gradeconversion WHERE Student.StuId in (SELECT distinct WhoLikes FROM Likes as global 
WHERE 
    not exists (SELECT A.StuId FROM (SELECT StuID FROM Course, Enrolled_in WHERE CName like "ALGORITHM%" and Course.CID = Enrolled_in.CID) as A 
    WHERE 
        not exists (SELECT WhoLikes FROM Likes as local WHERE local.WhoisLiked = A.StuId and local.WhoLikes = global.WhoLikes))) 
GROUP BY Student.StuID;

# 4 
SELECT 
    CName, Major, Grade, concat_ws(" ", Fname, Lname) as Name 
FROM 
    Course, Student, Enrolled_in 
WHERE 
    Student.StuId in 
    (SELECT distinct C.WhoLoves FROM Enrolled_in as A, Enrolled_in as B, Loves as C, Loves as D 
    WHERE 
        A.Cid = B.Cid and B.StuId = C.WhoLoves and C.WhoLoves = D.WhoIsLoved and C.WhoIsLoved = D.WhoLoves) and Student.StuID = Enrolled_in.StuID and Enrolled_in.CID = Course.CID;

# 5 
SELECT 
    Lname, B.times 
FROM 
    (SELECT Lname, count(*) as times FROM Student WHERE Sex = 'F' GROUP BY Fname) as B 
join 
    (SELECT max(times)as times FROM (SELECT Fname, count(*) as times FROM Student WHERE Sex = 'F' GROUP BY Fname) as A) as C WHERE B.times = C.times;

# 6 
SELECT 
    StudentA, StudentB, StudentC 
FROM 
    (SELECT concat_ws(" ", Student.Fname, Student.Lname) as StudentA, WhoLoves, WhoIsLoved FROM Loves, Student WHERE StuId = WhoLoves) as A, 
    (SELECT concat_ws(" ", Student.Fname, Student.Lname) as StudentB, WhoLoves, WhoIsLoved FROM Loves, Student WHERE StuId = WhoLoves) as B, 
    (SELECT concat_ws(" ", Student.Fname, Student.Lname) as StudentC, WhoLoves, WhoIsLoved FROM Loves, Student WHERE StuId = WhoLoves) as C 
WHERE 
    A.WhoLoves = B.WhoIsLoved and B.WhoLoves = C.WhoIsLoved and C.WhoLoves = A.WhoisLoved;

# 7 
SELECT 
    concat_ws(" ", Lname, Fname) as Name, Student.Age, Student.Major 
FROM 
    Student 
join 
    (SELECT min(Age) as Age, Major FROM Student GROUP BY Major) as A 
    on 
    Student.Age = A.Age and Student.major = A.major;

# 8 
SELECT 
    Fname, max(times) as times 
FROM 
    (SELECT Fname, count(Fname) as times FROM Student WHERE Sex = 'F' GROUP BY Fname) as A;

# 9 
SELECT 
    distinct concat_ws(" ", Student.Fname, Student.Lname) as StudentName, Major, concat_ws(" ", Faculty.Fname, Faculty.Lname) 
FROM 
    Enrolled_in, Student, Faculty, 
    (SELECT avg(Age) as Age, CID FROM Student, Enrolled_in WHERE Student.StuID = Enrolled_in.StuID GROUP BY CID) as A 
WHERE 
    Student.StuID = Enrolled_in.StuID and Enrolled_in.CID = A.CID and Student.Age < A.Age and Advisor = FacID;


# 10
SELECT DNO, count 
FROM (SELECT DNO, COUNT(*) AS count
     FROM Minor_in
     WHERE StuID IN (SELECT StuID
                     FROM Student
                     WHERE (Major = 550 OR Major = 600))
     GROUP BY DNO
) AS C1
WHERE count IN (
               SELECT MAX(count)
               FROM (
                     SELECT DNO, COUNT(*) AS count
                     FROM Minor_in
                     WHERE StuID IN (SELECT StuID
                                     FROM Student
                                     WHERE (Major = 550 OR Major = 600))
                     GROUP BY DNO
                     ) AS MinorCount
               )
;


# 12 
SELECT 
    distinct A.StuID 
FROM 
    (SELECT StuID FROM Enrolled_in, Gradeconversion WHERE Grade = lettergrade GROUP BY StuID having avg(gradepoint) > '# 33') as A 
join 
    (SELECT StuID FROM Enrolled_in WHERE Grade = 'A') as B on A.StuID = B.StuID;

# 13 
SELECT 
    distinct WhoLoves, CName 
FROM
    Loves, Course, Enrolled_in 
WHERE 
    WhoIsLoved = Enrolled_in.StuID and Enrolled_in.CID = Course.CID 
order by 
    WhoLoves;

# 16 
SELECT 
    concat_ws(" ", Fname, Lname) as Name, Age, Major 
FROM 
    Student 
WHERE 
    StuID not in (SELECT StuID FROM Lives_in);

# 17 
SELECT 
    avg(Age) 
FROM 
    Student 
WHERE 
    LName in (SELECT LName FROM Faculty);

# 18 
SELECT 
    concat_ws(" ", Fname, Lname) as Name, Age, Sex 
FROM 
    Course, Enrolled_in, Student 
WHERE 
    Course.CID = Enrolled_in.CID and Student.StuID = Enrolled_in.StuID and (Course.CID = '6# 00315' or Course.CID = '6# 00415') and Enrolled_in.StuID in (SELECT StuID FROM Enrolled_in, Course WHERE Course.CID = Enrolled_in.CID and (Course.CID like '6# 001%' or Course.CID like '6# 002%'));

# 20 
SELECT 
    concat_ws(" ", Fname, Lname) as Name, sum(Credits) as totalCredits 
FROM 
    Student, Course, Enrolled_in 
WHERE 
    Student.StuID = Enrolled_in.StuID and Enrolled_in.CID = Course.CID 
GROUP BY 
    Enrolled_in.StuID having totalCredits > (SELECT avg(totalCredits) FROM (SELECT Enrolled_in.StuID, sum(Credits) as totalCredits FROM Course, Enrolled_in WHERE Course.CID = Enrolled_in.CID    GROUP BY Enrolled_in.StuID) as A);

# 21 
SELECT 
    concat_ws(" ", Fname, Lname) as Name, Age 
FROM 
    Student 
WHERE 
    Age > (SELECT avg(Age) + std(Age) FROM Student);

# 22 
SELECT 
    concat_ws(" ", Fname, Lname) as Name, Age 
FROM 
    Student, Minor_in, Department 
WHERE 
    Student.StuID = Minor_in.StuID and Minor_in.DNO = Department.DNO and Sex = 'F' and Division =  'EN' and Advisor in 
        (SELECT Faculty.FacID FROM Faculty, Member_of, Department WHERE Faculty.FacID = Member_of.FacID and Member_of.DNO = Department.DNO and Sex = 'F' and Department.Division = 'EN' and Appt_Type = 'Primary');

# 23 
SELECT 
    concat_ws(" ", Fname, Lname) as Name, Student.StuID 
FROM 
    Student 
WHERE 
    Student.StuID in 
    (SELECT 
        distinct StuID 
    FROM 
        Enrolled_in as global 
    WHERE 
        not exists ( SELECT CID FROM (SELECT CID FROM Faculty, Course WHERE Faculty.FacID = Course.Instructor and Faculty.Fname = 'Paul' and Faculty.Lname = 'Smolensky') as A 
        WHERE 
            not exists (SELECT CID, StuID FROM Enrolled_in as local WHERE local.CID = A.CID and local.StuID = global.StuID)));

# 24 
SELECT 
    concat_ws(" ", Fname, Lname) as Name, Student.StuID 
FROM 
    Student, Enrolled_in 
WHERE 
    Student.StuID = Enrolled_in.StuID and CID in 
    (SELECT CID FROM Student, Enrolled_in WHERE Student.StuID = Enrolled_in.StuID and Lname = 'Smith' and Fname = 'Linda');

# 27 
SELECT 
    avg(Age) 
FROM 
    Student 
WHERE
    Student.StuID in 
    (SELECT StuId FROM Participates_in GROUP BY StuID having count(actid) >= '2');

# 29 
SELECT 
    distinct concat_ws(" ", B.Fname, B.Lname) as Student1, concat_ws(" ", D.Fname, D.Lname) as Student2 
FROM 
    Lives_in as A, Student as B, Lives_in as C, Student as D WHERE A.DormID = C.DormID and A.room_number = C.room_number and A.StuId != C.StuId and B.StuId = A.StuId and D.StuId = C.StuId;

# 30
# Cannot test your result here, don't have your tables
# I think it would be nicer to include create table in this file.
# (a) 
insert into Baltimore_distance 
SELECT 
    distinct City1_code, City2_code, (A.distance + B.distance) as distance 
FROM 
    (SELECT City2_code as City1_code, distance FROM Direct_distance WHERE City1_code = 'BAL') as A, 
    (SELECT City2_code, distance FROM Direct_distance WHERE City1_code = 'BAL') as B;
# (b)
INSERT INTO Rectangular_distance
SELECT 
    DISTINCT A.city_code, B.city_code, (SQRT(POW(70 * A.latitude - 70 * B.latitude, 2) + POW(70 * A.longitude - 70 * B.longitude, 2))) as distance 
FROM 
    City as A, City as B;
# (c)
INSERT INTO All_distance
SELECT 
    A.City1_code, A.City2_code, Direct_distance.distance as direct_distance, baltimore_distance, rectangular_distance 
FROM 
    (SELECT 
        Baltimore_distance.City1_code, Baltimore_distance.City2_code, Baltimore_distance.distance as baltimore_distance, Rectangular_distance.distance as rectangular_distance 
    FROM 
        Baltimore_distance, Rectangular_distance 
    WHERE 
        Baltimore_distance.City1_code = Rectangular_distance.City1_code and Baltimore_distance.City2_code = Rectangular_distance.City2_code) as A LEFT JOIN Direct_distance on A.City1_code =         Direct_distance.City1_code and A.City2_code = Direct_distance.City2_code;
# (d)
INSERT INTO Best_distance 
SELECT 
    City1_code, City2_code, (IF(direct_distance IS NULL, LEAST(baltimore_distance, rectangular_distance), direct_distance)) as distance 
FROM 
    All_distances;

# 32 
SELECT 
    CONCAT_WS(" ", Fname, Lname) AS Name, Age, Major 
FROM 
    Student 
WHERE 
    StuID in 
    (SELECT
        A.StuID 
    FROM 
        (SELECT Student.StuID, AVG(gradepoint) AS avg FROM Student, Enrolled_in, Gradeconversion WHERE Student.StuID = Enrolled_in.StuID and Grade = lettergrade and CID NOT LIKE CONCAT(Major, '%') GROUP BY Student.StuID) AS A, 
        (SELECT Student.StuID, AVG(gradepoint) AS avg FROM Student, Enrolled_in, Gradeconversion WHERE Student.StuID = Enrolled_in.StuID and Grade = lettergrade and CID LIKE CONCAT(Major, '%') GROUP BY Student.StuID) AS B WHERE A.StuID = B.StuID and A.avg > B.avg);

# 33 
SELECT 
    DNO, AVG(Count) as Number_students  
FROM 
    (SELECT FacID, COUNT(*) AS Count, DNO FROM Student, Member_of WHERE Student.Advisor = Member_of.FacID and Appt_Type = 'Primary' GROUP BY FacID) AS A GROUP BY DNO;

# 34 
SELECT 
    MAX(Count) as Count,  Activity_name 
FROM 
    (SELECT Activity.actid, Activity_name, COUNT(*) AS Count FROM Activity, Participates_in WHERE Activity.actID = Participates_in.actID GROUP BY Activity.actid) AS A;   

# 35 
SELECT 
    activity_name 
FROM 
    Activity 
WHERE 
    ActID NOT IN 
    (SELECT ActID FROM Participates_in) AND ActID IN (SELECT ActID FROM Faculty_Participates_in);

# 37 
SELECT 
    DISTINCT CONCAT_WS(" ", A_Student.Fname, A_Student.Lname) AS Name1, CONCAT_WS(" ", B_Student.Fname, B_Student.Lname) AS Name2 
FROM 
    Lives_in AS A, Student AS A_Student, City AS A_City, Lives_in AS B, Student AS B_Student, City AS B_City 
WHERE 
    A.DormID = B.DormID AND A.StuID < B.StuID AND A_Student.StuID = A.StuID AND A_Student.city_code = A_City.city_code AND B_Student.StuID = B.StuID AND B_Student.city_code = B_City.city_code AND A_City.Country != B_City.Country;

# 38 
SELECT 
    Major, COUNT(*) 
FROM 
    Student, Participates_in WHERE Student.StuID = Participates_in.StuID 
GROUP BY 
    Major;

# 39 
SELECT 
    DISTINCT CONCAT_WS(" ", Faculty.Fname, Faculty.Lname) AS Name 
FROM 
    Student, Member_of, Faculty, 
    (SELECT 
        DISTINCT C.StuID2, DNO 
    FROM 
        (SELECT 
            DISTINCT A.StuID AS StuID1, B.StuID AS StuID2 
        FROM 
            Enrolled_in AS A, Enrolled_in AS B 
        WHERE A.CID = B.CID AND A.StuID != B.StuID) AS C, 
        (SELECT 
            StuID2, DNO 
        FROM 
            (SELECT 
                DISTINCT A.StuID as StuID1, B.StuID as StuID2 
            FROM 
                Lives_in AS A, Lives_in AS B 
            WHERE 
                A.StuID != B.StuID AND A.DormID = B.DormID and A.Room_number = B.Room_number
            ) AS Roommate, 
            (SELECT 
                DISTINCT Student.StuID, Member_of.DNO 
            FROM 
                Student, Member_of, Minor_in WHERE Major = Member_of.DNO OR (Minor_in.DNO = Member_of.DNO and Student.StuID = Minor_in.StuID)) AS A 
            WHERE 
                Roommate.StuID1 = A.StuID
        ) AS D 
        WHERE 
        C.StuID1 = D.StuID2
    ) AS E 
    WHERE 
        Member_of.DNO = E.DNO AND Student.StuID = E.StuID2 AND Student.Advisor = Faculty.FacID;

# 40 
SELECT 
    CONCAT_WS(" ", Student.Fname, Student.Lname) AS Name, SUM(Credits) AS Total_credits 
FROM 
    Student, Enrolled_in, Course 
WHERE 
    Student.StuID = Enrolled_in.StuID AND Course.CID = Enrolled_in.CID AND Enrolled_in.CID LIKE CONCAT(Major, '%') 
GROUP BY 
    Student.StuID HAVING Total_credits > 
    (SELECT AVG(Credits) AS Avg_credits FROM (SELECT Student.StuID, SUM(Credits) AS Credits FROM Student, Enrolled_in, Course WHERE Student.StuID = Enrolled_in.StuID AND Course.CID = Enrolled_in.CID AND Enrolled_in.CID LIKE CONCAT(Major, '%') GROUP BY Student.StuID) AS A);

# 41 
SELECT 
    CName, CONCAT_WS(" ", Faculty.Fname, Faculty.Lname) AS Instructor_name, COUNT(*) AS Num_students 
FROM 
    Enrolled_in, Course, Faculty 
WHERE 
    Enrolled_in.CID = Course.CID AND Course.Instructor = Faculty.FacID 
GROUP BY 
    Enrolled_in.CID 
HAVING 
    Num_students > (SELECT AVG(Num_students) FROM (SELECT CID, COUNT(*) AS Num_students FROM Enrolled_in GROUP BY CID) AS A);

# 42 
SELECT 
    CONCAT_WS(" ", Fname, Lname) AS Instructor_name, Room, Building 
FROM 
    Member_of, Faculty 
WHERE 
    Faculty.FacID = Member_of.FacID AND DNO = '600' AND Appt_Type = 'Secondary' AND Building != 'NEB';

# 43 
SELECT
    COUNT(*) AS Count
FROM 
    Student, Preferences 
WHERE 
    Major = '600' AND Student.StuID = Preferences.StuID AND Student.StuID NOT IN (SELECT WhoLikes FROM Likes) AND Smoking = 'Yes'; 
