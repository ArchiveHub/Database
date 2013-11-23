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


