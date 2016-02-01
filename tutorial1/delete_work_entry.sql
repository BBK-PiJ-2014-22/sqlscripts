CREATE OR REPLACE PROCEDURE 
    delete_work_entry (id IN Machines.mchID%TYPE)
IS
BEGIN
    FOR entry IN (SELECT * FROM Work) LOOP
        IF entry.mchid = id
        THEN 
             DELETE FROM Work where wid = entry.wid;
        END IF;
    END LOOP;
END;
/
