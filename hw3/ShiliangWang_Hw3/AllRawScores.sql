delimiter #
-- define procedure with 1 parameter of type integer
CREATE PROCEDURE AllRawScores (IN password varchar(15)) 
BEGIN
  declare c INT;
  select count(*) into c from Passwords where CurPasswords = password;
  IF c = 0
  THEN select "invalid password !";
  ELSE SELECT * from Rawscores
       order by section, Lname, Fname;
  END IF;
  -- use parameter in query
  
END#
delimiter ;
