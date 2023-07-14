-- WHILE LOOP
 CREATE TABLE tb_looping (ID INT);
 
 SELECT * FROM tb_looping;
 
 CALL looping(1,10);
 
 /*
 Teniendo en cuenta que la siguiente función añade 1 día a la fecha:

SELECT ADDDATE(FECHA_VENTA, INTERVAL 1 DAY);

Crea un Stored Procedure que, a partir del día 01/01/2017, cuente el número de 
facturas hasta el día 10/01/2017. Debemos mostrar la fecha y el número de facturas 
día tras día. Llamaremos este SP como: suma_dias_facturas.

Tips:
Declara variables del tipo DATE: Fecha inicial y fecha final; 
Haz un loop para probar que la fecha inicial < fecha final; muestra en el output 
de MySQL la fecha y el número de facturas. No olvides convertir las variables 
en tipo VARCHAR; Suma la fecha en 1 día.
*/

DELIMITER $$
CREATE PROCEDURE `suma_dias_facturas`()
BEGIN
DECLARE fecha_inicial DATE;
DECLARE fecha_final DATE;
DECLARE n_facturas INT;
SET fecha_inicial = '20170101';
SET fecha_final = '20170110';
WHILE fecha_inicial <= fecha_final
DO
SELECT COUNT(*) INTO n_facturas  FROM facturas WHERE FECHA_VENTA = fecha_inicial;
SELECT concat(DATE_FORMAT(fecha_inicial, '%d/%m/%Y'), '-' , CAST(n_facturas AS CHAR(50))) AS RESULTADO;
SELECT ADDDATE(fecha_inicial, INTERVAL 1 DAY) INTO fecha_inicial;
END WHILE;
END $$