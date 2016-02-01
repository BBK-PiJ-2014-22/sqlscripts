CREATE OR REPLACE FUNCTION diesel_consumption (mID IN Machines.mchID%TYPE)
    RETURN Oil.oLitre%TYPE
IS
    cLitre Oil.oLitre%TYPE := 0.0 ; 
BEGIN
    SELECT o.oLitre INTO cLitre
    FROM Oil o, Machines m
    WHERE o.mchID = m.mchID AND m.mchID = mID;
RETURN cLitre;
END;
/
