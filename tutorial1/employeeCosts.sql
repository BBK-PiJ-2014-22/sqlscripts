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


