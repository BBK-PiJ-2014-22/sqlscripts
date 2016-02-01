CREATE OR REPLACE PROCEDURE 
    delete_oil_entry (id IN Machines.mchID%TYPE)
IS
BEGIN
    FOR entry IN (SELECT * FROM Oil) LOOP
        IF entry.mchid = id
        THEN 
             DELETE FROM Oil where oid = entry.oid;
        END IF;
    END LOOP;
END;
/
