CREATE VIEW TotalPoints AS (SELECT HW1, HW2a, HW2b, Midterm, HW3, FExam FROM Rawscores WHERE LName = "TOTAL" and FName = "POINTS");

CREATE VIEW Weights AS (SELECT HW1, HW2a, HW2b, Midterm, HW3, FExam FROM Rawscores WHERE LName = "WEIGHT" and FName = "OFSCORE");

CREATE VIEW WtdPts AS (SELECT 1.0 / TotalPoints.HW1 * Weights.HW1 AS HW1, 1.0 /TotalPoints.HW2a * Weights.HW2a AS HW2a, 1.0 / TotalPoints.HW2b * Weights.HW2b AS HW2b, 1.0 / TotalPoints.Midterm * Weights.Midterm AS Midterm, 1.0 / TotalPoints.HW3 * Weights.HW3 AS HW3, 1.0 / TotalPoints.FExam * Weights.FExam AS FExam FROM TotalPoints, Weights);

