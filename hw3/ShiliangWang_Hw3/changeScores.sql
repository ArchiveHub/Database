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
