DECLARE
   a number(10);
   b varchar2(50);
   c number (10,2);
BEGIN
  SELECT jbsid, jbsname, jbsprice INTO a,b,c
  FROM Job
  WHERE jbsid=1;
  INSERT INTO Job VALUES(3,b,c);
END;
/
 
