-- TRIGGER

REATE TABLE `tb_factura1` (
  `NUMERO` varchar(5) NOT NULL,
  `FECHA` date DEFAULT NULL,
  `DNI` varchar(11) NOT NULL,
  `MATRICULA` varchar(5) NOT NULL,
  `IMPUESTO` float DEFAULT NULL,
  PRIMARY KEY (`NUMERO`),
  KEY `FK_CLIENTE1` (`DNI`),
  KEY `FK_VENDEDOR1` (`MATRICULA`),
  CONSTRAINT `FK_CLIENTE1` FOREIGN KEY (`DNI`) REFERENCES `tb_cliente` (`DNI`),
  CONSTRAINT `FK_VENDEDOR1` FOREIGN KEY (`MATRICULA`) REFERENCES `tb_vendedor` (`MATRICULA`)
) ;

CREATE TABLE `tb_items_facturas1` (
  `NUMERO` varchar(5) NOT NULL,
  `CODIGO` varchar(10) NOT NULL,
  `CANTIDAD` int DEFAULT NULL,
  `PRECIO` float DEFAULT NULL,
  PRIMARY KEY (`NUMERO`,`CODIGO`),
  KEY `FK_PRODUCTO1` (`CODIGO`),
  CONSTRAINT `FK_FACTURA1` FOREIGN KEY (`NUMERO`) REFERENCES `tb_factura` (`NUMERO`),
  CONSTRAINT `FK_PRODUCTO1` FOREIGN KEY (`CODIGO`) REFERENCES `tb_producto` (`CODIGO`)
) ;

INSERT INTO tb_factura1 
VALUES('0100', '2021-01-01', '1471156710', '235', 0.10 );
INSERT INTO tb_items_facturas1
VALUES('0100', '1002767', 100, 25),
('0100', '1004327', 200, 25),
('0100', '1013793', 300, 25);

SELECT A.FECHA, SUM(B.CANTIDAD * B.PRECIO) AS VENTA_TOTAL
FROM tb_factura1 A
INNER JOIN
tb_items_facturas1 B
ON A.NUMERO = B.NUMERO
GROUP BY A.FECHA;

INSERT INTO tb_factura1 
VALUES('0101', '2021-01-01', '1471156710', '235', 0.10 );
INSERT INTO tb_items_facturas1
VALUES('0101', '1002767', 100, 25),
('0101', '1004327', 200, 25),
('0101', '1013793', 300, 25);

INSERT INTO tb_factura1 
VALUES('0102', '2021-01-01', '1471156710', '235', 0.10 );
INSERT INTO tb_items_facturas1
VALUES('0102', '1002767', 200, 25),
('0102', '1004327', 300, 25),
('0102', '1013793', 400, 25);

SELECT A.FECHA, SUM(B.CANTIDAD * B.PRECIO) AS VENTA_TOTAL
FROM tb_factura1 A
INNER JOIN
tb_items_facturas1 B
ON A.NUMERO = B.NUMERO
GROUP BY A.FECHA;

/*
Podemos crear un TRIGGER para que la tabla tb_facturacion sea recalculada siempre que un nuevo registro sea incluido en la tabla de tb_items_facturas1. De esta manera, digita y ejecuta:
*/

DELIMITER //
CREATE TRIGGER TG_FACTURACION_INSERT 
AFTER INSERT ON tb_items_facturas1
FOR EACH ROW BEGIN
  DELETE FROM tb_facturacion;
  INSERT INTO tb_facturacion
  SELECT A.FECHA, SUM(B.CANTIDAD * B.PRECIO) AS VENTA_TOTAL
  FROM tb_factura1 A
  INNER JOIN
  tb_items_facturas1 B
  ON A.NUMERO = B.NUMERO
  GROUP BY A.FECHA;
END //

/*Al insertar nuevos registros no es preciso ejecutar el cálculo de la tabla consolidada. Para ello digita y ejecuta: */

INSERT INTO tb_factura1 
VALUES('0103', '2021-01-01', '1471156710', '235', 0.10 );
INSERT INTO tb_items_facturas1
VALUES('0103', '1002767', 200, 25),
('0103', '1004327', 300, 25),
('0103', '1013793', 400, 25);

SELECT * FROM tb_facturacion;

INSERT INTO tb_factura1 
VALUES('0104', '2021-01-01', '1471156710', '235', 0.10 );
INSERT INTO tb_items_facturas1
VALUES('0104', '1002767', 200, 25),
('0104', '1004327', 400, 30),
('0104', '1013793', 500, 25);

SELECT * FROM tb_facturacion;

/*
Sin embargo, fue creado un TRIGGER sólo para la inclusión de registros en una tabla. Vamos a añadir TRIGGERs para la actualización y exclusión de datos. Para ello digita y ejecuta:
*/

DELIMITER //
CREATE TRIGGER TG_FACTURACION_DELETE
AFTER DELETE ON tb_items_facturas1
FOR EACH ROW BEGIN
  DELETE FROM tb_facturacion;
  INSERT INTO tb_facturacion
  SELECT A.FECHA, SUM(B.CANTIDAD * B.PRECIO) AS VENTA_TOTAL
  FROM tb_factura1 A
  INNER JOIN
  tb_items_facturas1 B
  ON A.NUMERO = B.NUMERO
  GROUP BY A.FECHA;
END //

DELIMITER //
CREATE TRIGGER TG_FACTURACION_UPDATE
AFTER UPDATE ON tb_items_facturas1
FOR EACH ROW BEGIN
  DELETE FROM tb_facturacion;
  INSERT INTO tb_facturacion
  SELECT A.FECHA, SUM(B.CANTIDAD * B.PRECIO) AS VENTA_TOTAL
  FROM tb_factura1 A
  INNER JOIN
  tb_items_facturas1 B
  ON A.NUMERO = B.NUMERO
  GROUP BY A.FECHA;
END //

/*
Vamos a alterar/excluir algunos registros. Para ello digita y ejecuta:
*/

UPDATE tb_items_facturas1 SET CANTIDAD = 800
WHERE NUMERO = '0101' AND CODIGO = '1002767';

DELETE FROM tb_items_facturas1
WHERE NUMERO = '0104' AND CODIGO = '1013793'; 