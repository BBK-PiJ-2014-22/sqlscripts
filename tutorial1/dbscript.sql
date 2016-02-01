DROP TABLE EmpPrjContribution;
DROP TABLE Employee;
DROP TABLE Job_history;
DROP TABLE Oil;
DROP TABLE Work;
DROP TABLE Machines;
DROP TABLE Proj;
DROP TABLE Job;

create table Job (
	jbsID number(10) primary key,
	jbsname varchar2(50) NOT NULL ,
	jbsprice number(10,2) NOT NULL
);

create table Proj (
 prjID number (10) primary key,
 prjName varchar2(100) not null,
 prjAmount number(7,2) ,
 prjCost number(7,2),
 prjProfit  number(7,2)
);

create table Machines (
  mchID      number(10) primary key,
  mchName    varchar(50) not null,
  mchCode    varchar(10) ,
  mchYearPurchased date
);

create table Work
(
  wID        number(10) primary key,
  mchID      number(10),
  prjID      number(10),
  wDate      date,
  wHours     number(5,1),
  constraint mch_fk foreign key (mchID)
  references Machines(mchID) ,
  constraint prj_fk foreign key (prjID)
  references Proj(prjID) INITIALLY DEFERRED
);

create table Oil
(
	oID	number(10) primary key,
	mchID	number(10) ,
	oLitre	number(6,2) NOT NULL,
	oPrice	number(5,2) NOT NULL,
	oDate	date,
        constraint mch2_fk foreign key (mchID)
	references Machines(mchID)
);

create table Job_history (
  jbsID   number(10) NOT NULL,
  oldPrice number(6,2),
  dateChanged date DEFAULT SYSDATE,
  constraint jbs_fk foreign key (jbsID) references Job(jbsID)
);

create table Employee 
(
	empID	number(10) primary key,
	jbsID	number(10) NOT NULL,
	empName	varchar2(100),
	empSalary number(10),
	constraint emp_job foreign key (jbsID)
	references Job(jbsID)
);

create table EmpPrjContribution
(
	empprjID number(10) primary key,
	empID number(10) NOT NULL,
	prjID number(10) NOT NULL,
	cHours number(5,1),
	cDate date,
	constraint emp_fk foreign key (empID)
	references Employee(empID),
	constraint prj2_fk foreign key (prjID)
	references Proj(prjID)
);

-- Inserting Dummy Data

--- Job
insert into job values (1,'Building Cleaning',100.50); 
insert into job values (2,'Building Construction',120.50); 

--- Machines
insert into machines values (1,'VOLVO F16','VIW 66J',NULL);
insert into machines values (2,'VW Transporter','UH8 76L',NULL);
insert into machines values (3,'MAN V76','HG7 76K',NULL);

--- Projects
insert into proj values (1,'National Road Construction',20000.00,17000.00,NULL);
insert into proj values (2,'Rio-Antirio Bridge Construction',90000.00,75000.00,NULL);
insert into proj values (3,'Under-sea Motorway in Aktio',95000.00,86000.00,NULL);
insert into proj values (4,'Train Tunnel in Templi''s Valley',80000.00,70000.00,NULL);

--- Work
insert into work values (1,1,1,'20-JAN-2012',8.0);
insert into work values (2,2,1,'20-JAN-2012',9.0);
insert into work values (3,3,1,'21-JAN-2012',10.0);

--- Oil
insert into oil values (1,1,123.54,0.64,'21-Jan-2012');
INSERT INTO OIL VALUES (2,2,24.5,0.54,'12-MAR-12');
INSERT INTO OIL VALUES (3,3,34.43,0.63,'14-MAR-12');

-- Employee
INSERT INTO EMPLOYEE VALUES (1,1,'George Papamarkos',4961);
INSERT INTO EMPLOYEE VALUES (2,1,'Bob Fish',1980) ;
INSERT INTO EMPLOYEE VALUES (3,2,'Robert Johnson',1298);

-- EmpPrjContribution
INSERT INTO EmpPrjContribution VALUES (1,1,1,10.0,'21-JAN-2012');
INSERT INTO EmpPrjContribution VALUES (2,1,1,7.0,'22-JAN-2012');
INSERT INTO EmpPrjContribution VALUES (3,1,1,6.0,'24-JAN-2012');
INSERT INTO EmpPrjContribution VALUES (4,2,1,5.0,'21-JAN-2012');
INSERT INTO EmpPrjContribution VALUES (5,2,1,9.0,'25-JAN-2012');
INSERT INTO EmpPrjContribution VALUES (6,2,1,7.0,'23-JAN-2012');
INSERT INTO EmpPrjContribution VALUES (7,1,2,5.0,'21-JAN-2012');
INSERT INTO EmpPrjContribution VALUES (8,2,2,9.0,'25-JAN-2012');
INSERT INTO EmpPrjContribution VALUES (9,2,2,7.0,'23-JAN-2012');