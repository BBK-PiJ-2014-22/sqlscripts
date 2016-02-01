CREATE OR REPLACE TRIGGER work_hours_limit
BEFORE UPDATE OF wHours ON WORK
FOR EACH ROW
WHEN (new.wHours - old.wHours > 5)
BEGIN
    :new.wHours := :old.wHours;
    DBMS_output.PUT_LINE('Too many hours entered for update. Must be <5');
END;
/

