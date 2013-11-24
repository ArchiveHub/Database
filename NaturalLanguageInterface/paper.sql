DROP TABLE Paper;
CREATE TABLE Paper(
        PID     VARCHAR(4) primary key,
        AID   VARCHAR(11),
        PDate   Date,
        ArName   VARCHAR(100),
	PeID    VARCHAR(4)		
        );


DROP TABLE Author;
CREATE TABLE Author(
	AID VARCHAR(11),
	AuName VARCHAR(11),
	BDate Date,
	DDate Date,
	);


DROP TABLE University;
CREATE TABLE University(
	UnID VARCHAR(11),
	UName VARCHAR(11),
	EDate Date,
	);

DROP TABLE Work_for;
CREATE TABLE Work_for(
	AID VARCHAR(11),
	UnID AID VARCHAR(11),
	SDate Date,
	EDate Date
);

