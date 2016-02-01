CREATE OR REPLACE PROCEDURE AddJob
    (j IN NUMBER, n IN VARCHAR2, p IN NUMBER)
IS
BEGIN
    INSERT INTO Job (jbsID, jbsName, jbsPrice)
           VALUES (j,n,p);
END;
/
