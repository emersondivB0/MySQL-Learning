DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `precio_producto_case`(vcodigo VARCHAR(20))
BEGIN
DECLARE vresultado varchar(40);
DECLARE vprecio FLOAT;
SELECT PRECIO_DE_LISTA INTO vprecio FROM tabla_de_productos WHERE CODIGO_DEL_PRODUCTO = vcodigo;
CASE
WHEN vprecio >= 12 THEN SET vresultado = 'Producto Costoso';
WHEN vprecio >= 7 AND vprecio < 12 THEN SET vresultado = 'Producto Asequible';
WHEN vprecio < 7 THEN SET vresultado = 'Producto Barato';
END CASE;
SELECT vresultado;
END$$
DELIMITER ;
CALL precio_producto_case('1000800');