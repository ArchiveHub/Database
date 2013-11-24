
-- create view
DROP VIEW IF EXISTS TotalPoints;
DROP VIEW IF EXISTS Weights;
DROP VIEW IF EXISTS WtdPts;
CREATE VIEW TotalPoints AS (SELECT HW1, HW2a, HW2b, Midterm, HW3, FExam FROM Rawscores WHERE LName = "TOTAL" and FName = "POINTS");

CREATE VIEW Weights AS (SELECT HW1, HW2a, HW2b, Midterm, HW3, FExam FROM Rawscores WHERE LName = "WEIGHT" and FName = "OFSCORE");

CREATE VIEW WtdPts AS (SELECT 1.0 / TotalPoints.HW1 * Weights.HW1 AS HW1, 1.0 /TotalPoints.HW2a * Weights.HW2a AS HW2a, 1.0 / TotalPoints.HW2b * Weights.HW2b AS HW2b, 1.0 / TotalPoints.Midterm * Weights.Midterm AS Midterm, 1.0 / TotalPoints.HW3 * Weights.HW3 AS HW3, 1.0 / TotalPoints.FExam * Weights.FExam AS FExam FROM TotalPoints, Weights);

-- (a)
drop procedure IF EXISTS ShowRawScore;
delimiter #
-- define procedure with 1 parameter of type integer
CREATE PROCEDURE ShowRawScore (IN ssn INTEGER) 
BEGIN
  -- use parameter in query
  declare c INT;
  select count(*) into c from Rawscores r where  r.SSN = ssn;
  IF c = 0
  THEN select "invalid SSN, the student doesn't exists!";
  ELSE SELECT * from Rawscores r where r.SSN = ssn;
  END IF;

END#
delimiter ;

-- (b)
DROP PROCEDURE IF EXISTS ShowPercentages;
delimiter #
CREATE PROCEDURE ShowPercentages (IN ssn_number INT)
BEGIN

    SELECT Rawscores.SSN, 100 * Rawscores.HW1 / TotalPoints.HW1 AS HW1, 100 * Rawscores.HW2a / TotalPoints.HW2a AS HW2a, 100 * Rawscores.HW2b / TotalPoints.HW2b AS HW2b, 100 * Rawscores.Midterm / TotalPoints.Midterm AS Midterm, 100  * Rawscores.HW3 / TotalPoints.HW3 AS HW3, 100 * Rawscores.FExam / TotalPoints.FExam AS FExam FROM Rawscores, TotalPoints WHERE Rawscores.SSN = ssn_number;

    SELECT FName, LName, 100 * ((Rawscores.HW1 * WtdPts.HW1) + (Rawscores.HW2a * WtdPts.HW2a) + (Rawscores.HW2b * WtdPts.HW2b) + (Rawscores.Midterm * WtdPts.Midterm) + (Rawscores.HW3 * WtdPts.HW3) + (Rawscores.FExam * WtdPts.FExam)) AS CumAvg FROM Rawscores JOIN WtdPts WHERE SSN = ssn_number;
END#

delimiter ;

-- (c)
DROP PROCEDURE IF EXISTS AllRawScores; 
delimiter #
-- define procedure with 1 parameter of type integer
CREATE PROCEDURE AllRawScores (IN password varchar(15)) 
BEGIN
  declare c INT;
  select count(*) into c from Passwords where CurPasswords = password;
  IF c = 0
  THEN select "invalid password !";
  ELSE SELECT * from Rawscores
       WHERE SSN != '0001' and SSN != '0002'
       order by section, Lname, Fname;
  END IF;
  -- use parameter in query
  
END#
delimiter ;

-- (d)
DROP PROCEDURE IF EXISTS AllPercentages;
delimiter #

CREATE PROCEDURE AllPercentages (IN password VARCHAR(15))
BEGIN
    DECLARE c INT;
    SELECT COUNT(*) INTO C FROM Passwords WHERE CurPasswords = password;

    IF c = 0
        THEN SELECT "invalid";
    ELSE   
        SELECT Rawscores.SSN, FName, LName, Section, 100 * Rawscores.HW1 / TotalPoints.HW1 AS HW1, 100 * Rawscores.HW2a / TotalPoints.HW2a AS HW2a, 100 * Rawscores.HW2b / TotalPoints.HW2b AS HW2b, 100 * Rawscores.Midterm / TotalPoints.Midterm AS Midterm, 100  * Rawscores.HW3 / TotalPoints.HW3 AS HW3, 100 * Rawscores.FExam / TotalPoints.FExam AS FExam, 100 * ((Rawscores.HW1 * WtdPts.HW1) + (Rawscores.HW2a * WtdPts.HW2a) + (Rawscores.HW2b * WtdPts.HW2b) + (Rawscores.Midterm * WtdPts.Midterm) + (Rawscores.HW3 * WtdPts.HW3) + (Rawscores.FExam * WtdPts.FExam)) AS CumAvg FROM Rawscores JOIN TotalPoints JOIN WtdPts WHERE LName != 'TOTAL' and LName != 'WEIGHT' ORDER BY Section, CumAvg;
    END IF;

END#

delimiter ;

-- (e)
DROP PROCEDURE IF EXISTS Stat;
delimiter #
-- define procedure with 1 parameter of type integer
CREATE PROCEDURE Stat (IN password varchar(15)) 
BEGIN
  declare c INT;
  select count(*) into c from Passwords where CurPasswords = password;
  IF c = 0
  THEN select "invalid password !";
  ELSE    SELECT Rawscores.SSN, FName, LName, Section, 100 * Rawscores.HW1 / TotalPoints.HW1 AS HW1, 100 * Rawscores.HW2a / TotalPoints.HW2a AS HW2a, 100 * Rawscores.HW2b / TotalPoints.HW2b AS HW2b, 100 * Rawscores.Midterm / TotalPoints.Midterm AS Midterm, 100  * Rawscores.HW3 / TotalPoints.HW3 AS HW3, 100 * Rawscores.FExam / TotalPoints.FExam AS FExam, 100 * ((Rawscores.HW1 * WtdPts.HW1) + (Rawscores.HW2a * WtdPts.HW2a) + (Rawscores.HW2b * WtdPts.HW2b) + (Rawscores.Midterm * WtdPts.Midterm) + (Rawscores.HW3 * WtdPts.HW3) + (Rawscores.FExam * WtdPts.FExam)) AS CumAvg FROM Rawscores JOIN TotalPoints JOIN WtdPts WHERE LName != 'TOTAL' and LName != 'WEIGHT' ORDER BY Section, CumAvg;

    SELECT "AVG" as Stat, Section as Section,  100 * AVG(Rawscores.HW1) / TotalPoints.HW1 AS HW1, 100 * AVG(Rawscores.HW2a) / TotalPoints.HW2a AS HW2a, 100 * AVG(Rawscores.HW2b) / TotalPoints.HW2b AS HW2b, 100 * AVG(Rawscores.Midterm) / TotalPoints.Midterm AS Midterm, 100  * AVG(Rawscores.HW3) / TotalPoints.HW3 AS HW3, 100 * AVG(Rawscores.FExam) / TotalPoints.FExam AS FExam, 100 * AVG((Rawscores.HW1 * WtdPts.HW1) + (Rawscores.HW2a * WtdPts.HW2a) + (Rawscores.HW2b * WtdPts.HW2b) + (Rawscores.Midterm * WtdPts.Midterm) + (Rawscores.HW3 * WtdPts.HW3) + (Rawscores.FExam * WtdPts.FExam)) AS Cumavg FROM Rawscores, TotalPoints, WtdPts WHERE LName != 'TOTAL' and LName != 'WEIGHT' GROUP BY Section;

    SELECT "MAX" as Stat, Section as Section,  100 * MAX(Rawscores.HW1) / TotalPoints.HW1 AS HW1, 100 * MAX(Rawscores.HW2a) / TotalPoints.HW2a AS HW2a, 100 * MAX(Rawscores.HW2b) / TotalPoints.HW2b AS HW2b, 100 * MAX(Rawscores.Midterm) / TotalPoints.Midterm AS Midterm, 100  * MAX(Rawscores.HW3) / TotalPoints.HW3 AS HW3, 100 * MAX(Rawscores.FExam) / TotalPoints.FExam AS FExam, 100 * MAX((Rawscores.HW1 * WtdPts.HW1) + (Rawscores.HW2a * WtdPts.HW2a) + (Rawscores.HW2b * WtdPts.HW2b) + (Rawscores.Midterm * WtdPts.Midterm) + (Rawscores.HW3 * WtdPts.HW3) + (Rawscores.FExam * WtdPts.FExam)) AS Cumavg FROM Rawscores, TotalPoints, WtdPts WHERE LName != 'TOTAL' and LName != 'WEIGHT' GROUP BY Section;

    SELECT "MIN" as Stat, Section as Section,  100 * MIN(Rawscores.HW1) / TotalPoints.HW1 AS HW1, 100 * MIN(Rawscores.HW2a) / TotalPoints.HW2a AS HW2a, 100 * MIN(Rawscores.HW2b) / TotalPoints.HW2b AS HW2b, 100 * MIN(Rawscores.Midterm) / TotalPoints.Midterm AS Midterm, 100  * MIN(Rawscores.HW3) / TotalPoints.HW3 AS HW3, 100 * MIN(Rawscores.FExam) / TotalPoints.FExam AS FExam, 100 * MIN((Rawscores.HW1 * WtdPts.HW1) + (Rawscores.HW2a * WtdPts.HW2a) + (Rawscores.HW2b * WtdPts.HW2b) + (Rawscores.Midterm * WtdPts.Midterm) + (Rawscores.HW3 * WtdPts.HW3) + (Rawscores.FExam * WtdPts.FExam)) AS Cumavg FROM Rawscores, TotalPoints, WtdPts WHERE LName != 'TOTAL' and LName != 'WEIGHT' GROUP BY Section;

    SELECT "STDDEV" as Stat, Section as Section,  100 * STDDEV(Rawscores.HW1) / TotalPoints.HW1 AS HW1, 100 * STDDEV(Rawscores.HW2a) / TotalPoints.HW2a AS HW2a, 100 * STDDEV(Rawscores.HW2b) / TotalPoints.HW2b AS HW2b, 100 * STDDEV(Rawscores.Midterm) / TotalPoints.Midterm AS Midterm, 100  * STDDEV(Rawscores.HW3) / TotalPoints.HW3 AS HW3, 100 * STDDEV(Rawscores.FExam) / TotalPoints.FExam AS FExam, 100 * STDDEV((Rawscores.HW1 * WtdPts.HW1) + (Rawscores.HW2a * WtdPts.HW2a) + (Rawscores.HW2b * WtdPts.HW2b) + (Rawscores.Midterm * WtdPts.Midterm) + (Rawscores.HW3 * WtdPts.HW3) + (Rawscores.FExam * WtdPts.FExam)) AS Cumavg FROM Rawscores, TotalPoints, WtdPts WHERE LName != 'TOTAL' and LName != 'WEIGHT' GROUP BY Section;
	END IF;
  -- use parameter in query
  
END#
delimiter ;

-- (f)
DROP PROCEDURE IF EXISTS ChangeScores;
delimiter #

CREATE PROCEDURE ChangeScores (IN password VARCHAR(15), IN ssn_number VARCHAR(4), IN assignmentname VARCHAR(10), IN score DECIMAL(5, 2))
BEGIN
    DECLARE c INT;
    SELECT COUNT(*) INTO C FROM Passwords WHERE CurPasswords = password;

    IF c = 0
        THEN SELECT "invalid";
    ELSE   
        IF assignmentname = 'HW1'
            THEN UPDATE Rawscores SET HW1 = score WHERE SSN = ssn_number;
        ELSEIF assignmentname = 'HW2a'
            THEN UPDATE Rawscores SET HW2a = score WHERE SSN = ssn_number;
        ELSEIF assignmentname = 'HW2b'
            THEN UPDATE Rawscores SET HW2b = score WHERE SSN = ssn_number;
        ELSEIF assignmentname = 'Midterm'
            THEN UPDATE Rawscores SET Midterm = score WHERE SSN = ssn_number;
        ELSEIF assignmentname = 'HW3'
            THEN UPDATE Rawscores SET HW3 = score WHERE SSN = ssn_number;
        ELSEIF assignmentname = 'FExam'
            THEN UPDATE Rawscores SET FExam = score WHERE SSN = ssn_number;
        END IF;
    END IF;
END#

delimiter ;



