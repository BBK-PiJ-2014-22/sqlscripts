INSERT INTO Machines (mchid, mchname, mchcode)
VALUES (4, 'Test Machine', 'TE5 7MA');

INSERT INTO WORK (wid, mchid, prjid, wdate, whours)
VALUES (4, 4, 1, '01-JAN-15', 10);

INSERT INTO WORK (wid, mchid, prjid, wdate, whours)
VALUES (5, 4, 1, '01-JAN-16', 10);

INSERT INTO OIL (oid, mchid, olitre, oprice, odate)
VALUES (4, 4, 50.5, .90, '01-JAN-16');

INSERT INTO OIL (oid, mchid, olitre, oprice, odate)
VALUES (5, 4, 50.5, .90, '01-JAN-16');
