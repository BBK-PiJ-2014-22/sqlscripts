CREATE OR REPLACE TRIGGER prevent_machine_del
BEFORE DELETE ON Machines
DECLARE
    machine_del_error EXCEPTION;
BEGIN
    RAISE machine_del_error ;
EXCEPTION
    WHEN machine_del_error THEN
    RAISE_APPLICATION_ERROR(-20004,
    'Deleting from the Machines table is not permitted');
END;
/
