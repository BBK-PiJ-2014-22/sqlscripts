CREATE OR REPLACE PROCEDURE 
    discount_project (id IN Proj.prjID%TYPE, discount BINARY_DOUBLE )
IS
BEGIN
    UPDATE Proj
    SET prjcost = prjcost * (1.0 - discount)
    WHERE prjid = id;
END;
/


