CREATE OR REPLACE TRIGGER machine_integrity
BEFORE DELETE ON Machines
FOR EACH ROW
BEGIN
    delete_oil_entry(:old.mchid);
    delete_work_entry(:old.mchid);
END;
/
    
