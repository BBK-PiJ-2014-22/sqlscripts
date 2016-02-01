CREATE OR REPLACE PROCEDURE cursor_test IS
    CURSOR job_enum IS
    SELECT * FROM Job WHERE jbsprice > 100;
    job_rec job_enum%ROWTYPE;
BEGIN
    OPEN job_enum;
    FETCH job_enum INTO job_rec;
    DBMS_OUTPUT.PUT_LINE('Current Job: ' || job_rec.jbsname );
    CLOSE job_enum;
END;
/

