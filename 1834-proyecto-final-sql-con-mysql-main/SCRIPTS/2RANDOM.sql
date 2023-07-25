-- MIN = 20 Y MAX = 250
-- RAND() * (MAX+MIN+1) + MIN

SELECT (RAND() * (250+20+1)) + 20 AS ALEATORIO;

SELECT FLOOR((RAND() * (250+20+1)) + 20) AS ALEATORIO; -- GENERA ALEATORIOS ENTEROS ENTRE 20 Y 250

-- ACTIVAR USO DE FUNCIONES
SET GLOBAL log_bin_trust_function_creators = 1;

SELECT f_aleatorio(1,10) AS RESULTADO;

-- 
SELECT f_cliente_aleatorio() AS CLEINTE;

/*
En el video de esta aula creamos una función para obtener el cliente a través 
de la función de número aleatorio. En este ejercicio, crea otra función para obtener 
el producto y también el vendedor usando como base la función aleatorio.
*/

DELIMITER //
CREATE FUNCTION `f_producto_aleatorio`() 
RETURNS varchar(10) 
BEGIN
DECLARE vresultado VARCHAR(10);
DECLARE vmax INT;
DECLARE valeatorio INT;
SELECT COUNT(*) INTO vmax FROM productos;
SET valeatorio = f_aleatorio(1,vmax);
SET valeatorio = valeatorio-1;
SELECT CODIGO INTO vresultado FROM productos LIMIT valeatorio,1;
RETURN vresultado;
END //

DELIMITER //
CREATE FUNCTION `f_vendedor_aleatorio`() 
RETURNS varchar(5) 
BEGIN
DECLARE vresultado VARCHAR(5);
DECLARE vmax INT;
DECLARE valeatorio INT;
SELECT COUNT(*) INTO vmax FROM vendedores;
SET valeatorio = f_aleatorio(1,vmax);
SET valeatorio = valeatorio-1;
SELECT MATRICULA INTO vresultado FROM vendedores LIMIT valeatorio,1;
RETURN vresultado;
END //