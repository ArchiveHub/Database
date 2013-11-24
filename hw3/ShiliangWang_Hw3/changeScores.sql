delimiter #

CREATE PROCEDURE ChangeScores (IN password VARCHAR(15), IN ssn_number VARCHAR(4), IN assignmentname VARCHAR(10), IN score DECIMAL(5, 2))
BEGIN
    DECLARE c INT;
    DECLARE s INT;
    DECLARE maxscore INT;
    SELECT COUNT(*) INTO C FROM Passwords WHERE CurPasswords = password;
    SELECT COUNT(*) INTO s FROM Rawscores WHERE SSN = ssn_number; 

    IF c = 0
        THEN SELECT "invalid password";
    ELSEIF s = 0
        THEN SELECT "invalid ssn";
    ELSE   
        IF assignmentname = 'HW1' THEN
            SELECT HW1 INTO maxscore FROM TotalPoints;
            IF score < 0 OR score > maxscore THEN
                SELECT "invalid score"; 
            ELSE 
                UPDATE Rawscores SET HW1 = score WHERE SSN = ssn_number;
            END IF;
        ELSEIF assignmentname = 'HW2a' THEN
            SELECT HW2a INTO maxscore FROM TotalPoints; 
            IF score < 0 OR score > maxscore
               THEN SELECT "invalid score"; 
            ELSE
                UPDATE Rawscores SET HW2a = score WHERE SSN = ssn_number;
            END IF;
        ELSEIF assignmentname = 'HW2b' THEN
            SELECT HW2b INTO maxscore FROM TotalPoints; 
            IF score < 0 OR score > maxscore
               THEN SELECT "invalid score"; 
            ELSE
                UPDATE Rawscores SET HW2b = score WHERE SSN = ssn_number;
            END IF;
        ELSEIF assignmentname = 'Midterm' THEN
            SELECT Midterm INTO maxscore FROM TotalPoints; 
            IF score < 0 OR score > maxscore
               THEN SELECT "invalid score"; 
            ELSE
                UPDATE Rawscores SET Midterm = score WHERE SSN = ssn_number;
            END IF;
        ELSEIF assignmentname = 'HW3' THEN
            SELECT HW3 INTO maxscore FROM TotalPoints; 
            IF score < 0 OR score > maxscore
               THEN SELECT "invalid score"; 
            ELSE
                UPDATE Rawscores SET HW3 = score WHERE SSN = ssn_number;
            END IF;
        ELSEIF assignmentname = 'FExam' THEN
            SELECT FExam INTO maxscore FROM TotalPoints; 
            IF score < 0 OR score > maxscore
               THEN SELECT "invalid score"; 
            ELSE 
                UPDATE Rawscores SET FExam = score WHERE SSN = ssn_number;
            END IF;
        END IF;
    END IF;
END#

delimiter ;
