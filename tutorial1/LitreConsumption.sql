CREATE OR REPLACE PROCEDURE LitreConsumption(
    mID in Machines.mchID%TYPE,
    startDate Date,
    endDate Date,
    maxLitre Oil.oLitre%TYPE)
IS
    overConsumptionException EXCEPTION ;
    consumedLitre Oil.oLitre%TYPE ;
BEGIN
    SELECT SUM(o.oLitre) INTO consumedLitre
    FROM Oil o, Machines m
    WHERE o.mchID = m.mchID AND m.mchID = mID
        AND (o.oDate BETWEEN startDate and endDate);
        
    IF consumedLitre > maxLitre THEN
        RAISE overConsumptionException ;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Total Oil Consumed: ' || consumedLitre);
    END IF ;
EXCEPTION
    WHEN overConsumptionException THEN
        DBMS_OUTPUT.PUT_LINE('Machine exceeded maximum oil consumption');
END;
/
