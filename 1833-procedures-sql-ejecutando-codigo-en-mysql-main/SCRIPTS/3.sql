USE jugos_ventas;
SELECT * FROM tabla_de_clientes;
SELECT FECHA_DE_NACIMIENTO FROM tabla_de_clientes
WHERE DNI = '1471156710';

CALL edad_clientes(5840119709);

/*
Crea un Stored Procedure que, basado en una fecha, calcule el número de facturas. 
Si aparecen más de 70 facturas exhibimos el mensaje: ‘Muchas facturas’. 
En otro caso, exhibimos el mensaje ‘Pocas facturas’. 
También, debe exhibir el número de facturas. Llamaremos este Stored Procedure como: evaluacion_facturas.
La fecha empleada para evaluar la cantidad de facturas será un parámetro del Stored Procedure.
*/

SELECT * FROM facturas;

CALL evaluacion_facturas(20160729);