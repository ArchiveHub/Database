delimiter #
-- define procedure with 1 parameter of type integer
CREATE PROCEDURE ShowRawScore (IN ssn INTEGER) 
BEGIN
  -- use parameter in query
  SELECT * from RAWSCORES r where r.SSN = ssn;
END#
delimiter ;