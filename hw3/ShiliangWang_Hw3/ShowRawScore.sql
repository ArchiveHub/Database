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
