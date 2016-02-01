CREATE OR REPLACE PROCEDURE 
	updateJobPrices	(id IN Job.jbsID%TYPE, price IN Job.jbsprice%TYPE)
IS
BEGIN
    UPDATE Job j
    SET j.jbsprice = price
    WHERE j.jbsid = id;
END;
/
