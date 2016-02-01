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
