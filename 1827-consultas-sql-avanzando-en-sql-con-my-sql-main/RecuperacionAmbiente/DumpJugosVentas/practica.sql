use jugos_ventas;
select * from facturas;
-- Puedo consultar columnas específicas:
SELECT NOMBRE, DIRECCION_1, CP FROM tabla_de_clientes;
-- Consultar todo:
SELECT * FROM tabla_de_clientes;
-- Puedo consultar columnas con alias:
SELECT DNI AS RUT, NOMBRE AS CLIENTE FROM tabla_de_clientes;
-- Consultar todos los productos con un atributo específico:
SELECT * FROM tabla_de_productos WHERE SABOR = 'Mango';
-- MySQL no es case sensitive:
SELECT * FROM tabla_de_productos WHERE ENVASE = 'botella pet';
-- Consulta de rangos:
SELECT * FROM tabla_de_productos WHERE PRECIO_DE_LISTA > 16;

-- Se pueden usar operadores booleanos OR, AND, NOR, NAND, condicionales:
SELECT * FROM tabla_de_productos where SABOR = 'mango' AND TAMANO = '470 ml';
SELECT * FROM tabla_de_productos where SABOR = 'mango' OR TAMANO = '470 ml';
SELECT * FROM tabla_de_productos where NOT (SABOR = 'mango') OR TAMANO = '470 ml';
SELECT * FROM tabla_de_productos where NOT (SABOR = 'mango' AND TAMANO = '470 ml');
-- El OR sencillo puede ser un IN:
SELECT * FROM tabla_de_productos where SABOR IN ('mango', 'uva');
SELECT * FROM tabla_de_productos where SABOR ='mango' OR SABOR = 'uva';
SELECT * FROM tabla_de_clientes where CIUDAD IN ('ciudad de México', 'guadalajara') AND (EDAD between 20 AND 25);
-- Usando el comando LIKE, sirve para hacer queries de palabras en cualquier posición del campo:
SELECT * FROM tabla_de_productos WHERE SABOR LIKE '%manzana%' AND ENVASE = 'botella pet';
-- Todos los apellidos que terminen en 'ez':
SELECT * FROM tabla_de_clientes WHERE NOMBRE LIKE '%ez%';