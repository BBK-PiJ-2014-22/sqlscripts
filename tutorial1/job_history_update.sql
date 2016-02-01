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

