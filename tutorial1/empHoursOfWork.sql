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
