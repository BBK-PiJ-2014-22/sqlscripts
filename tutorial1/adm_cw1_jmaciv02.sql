/*Advances in Data Management Coursework 1
Student ID: jmaciv02

@author Jamie MacIver
*/

--Exercise 1.1
CREATE OR REPLACE PROCEDURE 
	updateJobPrices	(id IN Job.jbsID%TYPE, price IN Job.jbsprice%TYPE)
IS
BEGIN
    UPDATE Job j
    SET j.jbsprice = price
    WHERE j.jbsid = id;
END;
/
--Exercise 1.2
CREATE OR REPLACE FUNCTION empHoursOfWork
    (eID IN Employee.empid%TYPE, pID IN Proj.prjid%TYPE)
    RETURN EmpPrjContribution.chours%TYPE
IS
    total EmpPrjContribution.chours%TYPE := 0.0;
BEGIN
    SELECT SUM(chours) INTO total
    FROM empprjcontribution e 
    WHERE e.empid = eID and e.prjid = pID;
    
    RETURN total;
END;
/

--Exercise 1.3
CREATE OR REPLACE PROCEDURE employeeCosts
IS
    CURSOR totalContributions IS
        SELECT e.empid, e.prjid, SUM(chours)*20 AS total_cost
        FROM EmpPrjContribution e 
        GROUP BY e.empid, e.prjid;
BEGIN
   FOR cont IN totalContributions LOOP
       DBMS_OUTPUT.PUT_LINE('empID:'|| cont.empid || 
                            ' prjID:'|| cont.prjid || 
                            ' tCost:'|| cont.total_cost);
   END LOOP;
END;
/

--Exercise 2.1
CREATE OR REPLACE TRIGGER print_employee_name
AFTER INSERT ON Employee
FOR EACH ROW
DECLARE 
    newJob Job.jbsname%TYPE;
BEGIN         
    newJob = SELECT jbsname FROM job WHERE jbsid = :new.jbsid;
    DBMS_OUTPUT.Put_Line(:new.empname || ' - ' || jbsname);
END;
/

--Exercise 2.2

