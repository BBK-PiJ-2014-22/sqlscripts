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
