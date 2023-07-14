SELECT DISTINCT SABOR FROM tabla_de_productos;

/*
Maracuyá, Limón, Frutilla, Uva - Rico
Sandïa, Mango - Normal
Los demás - Comunes
*/
SELECT DISTINCT SABOR FROM tabla_de_productos WHERE CODIGO_DEL_PRODUCTO = '1002726';

CALL define_sabor('243083');

DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `define_sabor`(vcodigo VARCHAR(20))
BEGIN
DECLARE vsabor VARCHAR(30);
SELECT DISTINCT SABOR INTO vsabor FROM tabla_de_productos WHERE CODIGO_DEL_PRODUCTO = vcodigo;
CASE vsabor
WHEN 'Maracuyá' THEN SELECT 'Muy Rico';
WHEN 'Limón' THEN SELECT 'Muy Rico';
WHEN 'Frutilla' THEN SELECT 'Muy Rico';
WHEN 'Uva' THEN SELECT 'Muy Rico';
WHEN 'Sandía' THEN SELECT 'Normal';
WHEN 'Mango' THEN SELECT 'Normal';
ELSE SELECT 'Jugos Comunes';
END CASE;
END$$
DELIMITER ;

CALL define_sabor_error('1000800');