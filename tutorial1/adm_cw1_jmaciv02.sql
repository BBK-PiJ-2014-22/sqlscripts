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

CREATE OR REPLACE TRIGGER machine_integrity
BEFORE DELETE ON Machines
FOR EACH ROW
BEGIN
    delete_oil_entry(:old.mchid);
    delete_work_entry(:old.mchid);
END;
/
    
CREATE OR REPLACE PROCEDURE 
    delete_oil_entry (id IN Machines.mchID%TYPE)
IS
BEGIN
    FOR entry IN (SELECT * FROM Oil) LOOP
        IF entry.mchid = id
        THEN 
             DELETE FROM Oil where oid = entry.oid;
        END IF;
    END LOOP;
END;
/

CREATE OR REPLACE PROCEDURE 
    delete_work_entry (id IN Machines.mchID%TYPE)
IS
BEGIN
    FOR entry IN (SELECT * FROM Work) LOOP
        IF entry.mchid = id
        THEN 
             DELETE FROM Work where wid = entry.wid;
        END IF;
    END LOOP;
END;
/

--Exercise 2.3

CREATE OR REPLACE TRIGGER delete_employee_update_project
BEFORE DELETE ON Employee
FOR EACH ROW
BEGIN
    FOR entry IN (SELECT DISTINCT epc.prjid
                  FROM EmpPrjContribution epc
                  WHERE empid = :old.empid)
    LOOP
        discount_project(entry.prjid, 0.1);
    END LOOP;
    DELETE FROM EmpPrjContribution epc
    WHERE epc.empid = :old.empid;
END;
/

CREATE OR REPLACE PROCEDURE 
    discount_project (id IN Proj.prjID%TYPE, discount BINARY_DOUBLE )
IS
BEGIN
    UPDATE Proj
    SET prjcost = prjcost * (1.0 - discount)
    WHERE prjid = id;
END;
/


--Exercise 2.4

CREATE OR REPLACE TRIGGER work_hours_limit
BEFORE UPDATE OF wHours ON WORK
FOR EACH ROW
WHEN (new.wHours - old.wHours > 5)
BEGIN
    :new.wHours := :old.wHours;
    DBMS_output.PUT_LINE('Too many hours entered for update. Must be <5');
END;
/
/

--Exercise 2.5

CREATE OR REPLACE TRIGGER job_history_update
AFTER UPDATE OF jbsprice ON Job
FOR EACH ROW
DECLARE
    minPrice Job.jbsprice%TYPE;
BEGIN
    SELECT MIN(job_history.oldprice) INTO minPrice
    FROM job_history
    WHERE :new.jbsid = job_history.jbsid;
    IF (minPrice >= :new.jbsprice) THEN
       RAISE_APPLICATION_ERROR(-20900, 'Job price cannot be below minimum historical value');
    ELSE
       INSERT INTO job_history (jbsid, oldprice, datechanged)
       VALUES (:new.jbsid, :old.jbsprice, SYSDATE);
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
       INSERT INTO job_history (jbsid, oldprice, datechanged)
       VALUES (:new.jbsid, :old.jbsprice, SYSDATE);
END;
/    


