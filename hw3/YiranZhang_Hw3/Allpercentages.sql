delimiter #

CREATE PROCEDURE AllPercentages (IN password CHAR(20))
BEGIN

    SELECT Rawscores.SSN, 100 * Rawscores.HW1 / TotalPoints.HW1 AS HW1, 100 * Rawscores.HW2a / TotalPoints.HW2a AS HW2a, 100 * Rawscores.HW2b / TotalPoints.HW2b AS HW2b, 100 * Rawscores.Midterm / TotalPoints.Midterm AS Midterm, 100  * Rawscores.HW3 / TotalPoints.HW3 AS HW3, 100 * Rawscores.FExam / TotalPoints.FExam AS FExam FROM Rawscores, TotalPoints WHERE LName != 'TOTAL' and LName != 'WEIGHT';

    SELECT FName, LName, 100 * ((Rawscores.HW1 * WtdPts.HW1) + (Rawscores.HW2a * WtdPts.HW2a) + (Rawscores.HW2b * WtdPts.HW2b) + (Rawscores.Midterm * WtdPts.Midterm) + (Rawscores.HW3 * WtdPts.HW3) + (Rawscores.FExam * WtdPts.FExam)) AS CumAvg FROM Rawscores JOIN WtdPts WHERE LName != 'TOTAL' and LName != 'WEIGHT';
END#

delimiter ;
