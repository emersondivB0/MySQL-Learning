-- Estructura JOIN, permite unir tablas
-- INNER JOIN: devuelve únicamente los registros con llaves correspondientes
-- LEFT JOIN: mantiene todos los registros de la tabla de la izquierda y
-- devuelve únicamente los correspondientes de la tabla de la derecha
-- RIGHT JOIN: mantiene todos los registros de la derecha y 
-- devuelve únicamente los correspondientes de la izquierda
-- FULL JOIN: devuelve todos
-- CROSS JOIN: devuelve el producto cartesiano de los registros de las tablas

SELECT * FROM tabla_de_vendedores;
SELECT * FROM facturas;
SELECT * FROM tabla_de_vendedores A
INNER JOIN
facturas B
ON A.MATRICULA = B.MATRICULA;

SELECT A.NOMBRE, B.MATRICULA, COUNT(*) FROM tabla_de_vendedores A
INNER JOIN
facturas B
ON A.MATRICULA = B.MATRICULA
GROUP BY A.NOMBRE, B.MATRICULA;

-- Obtén la facturación anual de la empresa. Ten en cuenta que el valor financiero de 
-- las ventas consiste en multiplicar la cantidad por el precio.

SELECT YEAR(FECHA_VENTA), SUM(CANTIDAD * PRECIO) AS FACTURACION
FROM facturas F 
INNER JOIN 
items_facturas IFa 
ON F.NUMERO = IFa.NUMERO
GROUP BY YEAR(FECHA_VENTA);