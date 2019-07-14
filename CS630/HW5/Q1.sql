SET SERVEROUTPUT ON

CREATE OR REPLACE FUNCTION ThirdNearestPrice(price IN INTEGER)
RETURN INTEGER
IS pid integer := 0;
P  parts%ROWTYPE;


SELECT * INTO P FROM(
SELECT ROWNUM r, V.* FROM (
SELECT pid, ABS(price - Parts.price)distance, price FROM Parts
ORDER BY 2 asc, year desc, pid desc) V
) V2
WHERE r = 3
EXCEPTION
WHEN NO_DATA_FOUND THEN
RETURN -1;
END;