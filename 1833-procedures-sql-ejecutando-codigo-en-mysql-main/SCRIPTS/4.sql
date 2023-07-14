SELECT * FROM tabla_de_productos;

/*
precio >= 12 producto costoso
precio >= 7 Y precio < 12 producto asequible
precio < 7 producto barato
*/

SELECT PRECIO_DE_LISTA FROM tabla_de_productos WHERE CODIGO_DEL_PRODUCTO = '1000800';

CALL precio_producto(1002334);

/*
¡Desafío! Observa la siguiente consulta:

SELECT SUM(B.CANTIDAD * B.PRECIO) AS TOTAL_VENTA FROM 
facturas A INNER JOIN items_facturas B
ON A.NUMERO = B.NUMERO
WHERE A.FECHA_VENTA = '20170301';

Esta consulta devuelve el valor de la facturación en una fecha determinada.

Construye un Stored Procedure llamado comparacion_ventas que compare las ventas 
en dos fechas distintas (Estas fechas serán los parámetros de la SP). 
Si la variación porcentual de estas ventas es mayor al 10% la respuesta debe ser ‘Verde’. 
Si está entre -10% y 10% debe retornar ‘Amarillo’. Si la variación es menor al -10% debe retornar ‘Rojo’.
*/

/*
DELIMITER $$
CREATE PROCEDURE `comparacion_ventas`(vfecha1 DATE, vfecha2 DATE)
BEGIN
DECLARE facturacion_inicial FLOAT;
DECLARE facturacion_final FLOAT;
DECLARE variacion float;
SELECT SUM(B.CANTIDAD * B.PRECIO) INTO facturacion_inicial  FROM 
facturas A INNER JOIN items_facturas B
ON A.NUMERO = B.NUMERO
WHERE A.FECHA_VENTA = vfecha1;
SELECT SUM(B.CANTIDAD * B.PRECIO) INTO facturacion_final  FROM 
facturas A INNER JOIN items_facturas B
ON A.NUMERO = B.NUMERO
WHERE A.FECHA_VENTA = vfecha2;
SET variacion = ((facturacion_final / facturacion_inicial) -1) * 100;
IF variacion > 10 THEN
SELECT 'Verde';
ELSEIF variacion >= -10 AND variacion <= 10 THEN
SELECT 'Amarillo';
ELSE
SELECT 'Rojo';
END IF;
END $$
*/
