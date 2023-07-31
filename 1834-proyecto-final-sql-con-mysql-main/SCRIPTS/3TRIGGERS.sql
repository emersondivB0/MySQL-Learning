-- TRIGGERS
/*
Para validar el Stored Procedure realizaremos una consulta para obtener el cálculo de la facturación y ver si efectivamente la rutina sp_ventas está funcionando como debería:
*/


SELECT A.FECHA, SUM(B.CANTIDAD*B.PRECIO) AS FACTURACION
FROM facturas A 
INNER JOIN
items B
ON A.NUMERO = B.NUMERO
WHERE A.FECHA = '20210619'
GROUP BY A.FECHA;

CALL sp_venta('20210619', 20, 100);

/*
¿Qué ha sucedido?

4) Se ha presentado otro error de duplicidad en la clave primaria, esta vez en la tabla de items porque los campos NUMERO y CODIGO son claves primarias, y al generar 20 productos de forma aleatoria de una tabla que contiene 35 productos en total, la probabilidad de que obtengamos el mismo producto más de una vez es alta, y como la venta relaciona un mismo número de factura a los diversos productos, si se repite algún código de producto, habrá duplicidad en la tabla de items por tratarse del mismo número de factura. Dicho de otra forma, no podemos tener un mismo número de factura y un mismo código de producto en más de un registro en la misma tabla.

Para solucionar este inconveniente, debemos crear un nuevo contador que verifique que los productos en la tabla de items no se repitan. Después de hacer esta verificación, el sp podrá insertar datos a la tabla de items. Esto lo solucionaremos estableciendo una condición con el comando IF. Así, lo que debemos hacer es:

Haz clic derecho sobre sp_ventas y selecciona la opción Alter Stored Procedure:
*/

CALL sp_venta('20210619', 20, 100);
SELECT A.FECHA, SUM(B.CANTIDAD*B.PRECIO) AS FACTURACION
FROM facturas A 
INNER JOIN
items B
ON A.NUMERO = B.NUMERO
WHERE A.FECHA = '20210619'
GROUP BY A.FECHA;

CALL sp_venta('20210619', 100, 100);

/*
¿Qué sucede con la facturación?

La facturación aumenta, y comprobamos que efectivamente nuestro sp está funcionando como esperado.

6) Ahora, tomaremos los TRIGGERS que utilizamos en el curso de Manipulación de datos y los mejoraremos a través de sp. Digita y ejecuta los siguientes comandos:
*/

CREATE TABLE facturacion(
FECHA DATE NULL,
VENTA_TOTAL FLOAT
);

DELIMITER //
CREATE TRIGGER TG_FACTURACION_INSERT 
AFTER INSERT ON items
FOR EACH ROW BEGIN
  DELETE FROM facturacion;
  INSERT INTO facturacion
  SELECT A.FECHA, SUM(B.CANTIDAD * B.PRECIO) AS VENTA_TOTAL
  FROM facturas A
  INNER JOIN
  items B
  ON A.NUMERO = B.NUMERO
  GROUP BY A.FECHA;
END //

DELIMITER //
CREATE TRIGGER TG_FACTURACION_DELETE
AFTER DELETE ON items
FOR EACH ROW BEGIN
  DELETE FROM facturacion;
  INSERT INTO facturacion
  SELECT A.FECHA, SUM(B.CANTIDAD * B.PRECIO) AS VENTA_TOTAL
  FROM facturas A
  INNER JOIN
  items B
  ON A.NUMERO = B.NUMERO
  GROUP BY A.FECHA;
END //

DELIMITER //
CREATE TRIGGER TG_FACTURACION_UPDATE
AFTER UPDATE ON items
FOR EACH ROW BEGIN
  DELETE FROM facturacion;
  INSERT INTO facturacion
  SELECT A.FECHA, SUM(B.CANTIDAD * B.PRECIO) AS VENTA_TOTAL
  FROM facturas A
  INNER JOIN
  items B
  ON A.NUMERO = B.NUMERO
  GROUP BY A.FECHA;
END //

SELECT * FROM facturacion WHERE FECHA = '20210622';

CALL sp_venta('20210622', 15, 100);

/*
Si en algún momento cambian las reglas de negocio, tendríamos que modificar cada TRIGGER por separado, pero si almacenamos los comandos recurrentes en un sp, entonces el TRIGGER siempre va a llamar al sp y en caso de cambios en las reglas de negocio, únicamente habría que modificar el sp. Vamos a crear un sp llamado sp_triggers y en el amacenaremos los comandos que se repiten en cada TRIGGER:


*/

DELIMITER //
CREATE PROCEDURE `sp_triggers`()
BEGIN
  DELETE FROM facturacion;
  INSERT INTO facturacion
  SELECT A.FECHA, SUM(B.CANTIDAD * B.PRECIO) AS VENTA_TOTAL
  FROM facturas A
  INNER JOIN
  items B
  ON A.NUMERO = B.NUMERO
  GROUP BY A.FECHA;
END //

/*
Finalmente, eliminaremos los TRIGGERS y los recrearemos utilizando la rutina sp_triggers como se muestra a continuación:
*/

DROP TRIGGER TG_FACTURACION_DELETE;
DROP TRIGGER TG_FACTURACION_UPDATE;
DROP TRIGGER TG_FACTURACION_INSERT;

DELIMITER //
CREATE TRIGGER TG_FACTURACION_INSERT 
AFTER INSERT ON items
FOR EACH ROW BEGIN
  CALL sp_triggers;
END //

DELIMITER //
CREATE TRIGGER TG_FACTURACION_DELETE
AFTER DELETE ON items
FOR EACH ROW BEGIN
  CALL sp_triggers;
END //

DELIMITER //
CREATE TRIGGER TG_FACTURACION_UPDATE
AFTER UPDATE ON items
FOR EACH ROW BEGIN
  CALL sp_triggers;
END //

