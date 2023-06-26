SELECT ltrim("          mysql es fácil perra");
SELECT rtrim("mysql es fácil perra          ");
SELECT trim("          mysql es fácil perra            ");
SELECT CONCAT("es fácil", " en serio");
SELECT UPPER("es sencillo");
SELECT LOWER("DCSDCCASC");
SELECT NOMBRE, CONCAT(DIRECCION_1, ' ', BARRIO, ' ', CIUDAD, ' ', ESTADO) AS COMPLETO FROM tabla_de_clientes;
USE jugos_ventas;