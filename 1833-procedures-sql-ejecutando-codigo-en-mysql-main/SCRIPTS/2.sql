CALL incluir_productos_parametros('1000800','Sabor del Mar',
'Naranja', '700 ml', 'Botella de Vidrio', 2.25);

CALL incluir_productos_parametros('1000800','Sabor del Mar',
'Naranja', '700 ml', 'Botella de Vidrio', 2.25);

/*
Observa que hubo un error de clave primaria porque el producto 1000800 ya existe en la tabla.

13) Podemos tratar este error para que MySQL presente un mensaje amigable cuando ocurra duplicidad en los registros. Digita y ejecuta:
*/

/*
Vimos que el comando SET es utilizado para atribuir valores a las variables. Pero, podemos atribuir valores a las mismas usando el comando SELECT a través de la cláusula SELECT INTO. Digita y ejecuta:

DELIMITER $$
CREATE PROCEDURE `mostrar_sabor`(vcodigo VARCHAR(15))
BEGIN
DECLARE vsabor VARCHAR(20);
SELECT SABOR INTO vsabor FROM tabla_de_productos WHERE CODIGO_DEL_PRODUCTO = vcodigo;
SELECT vsabor;
END$$
DELIMITER ;
*/

CALL mostrar_sabor('1101035');
