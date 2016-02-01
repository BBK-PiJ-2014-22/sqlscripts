CREATE OR REPLACE TRIGGER work_hours_limit
BEFORE UPDATE OF wHours ON WORK
FOR EACH ROW
WHEN (new.wHours - old.wHours > 5)
BEGIN
    RAISE_APPLICATION_ERROR(-20666, 'Cannot raise wHours by more than 5', TRUE);
END;
/

