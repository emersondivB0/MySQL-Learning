select current_timestamp() as resultado;
select concat("La fecha y la hora de hoy son: ", current_timestamp) as resultado;
select concat("La fecha y el horario son: ",
date_format(current_timestamp(), "%d/%m/%Y")) as resultado;
-- %Y devuelve el año en 4 cifras, %y devuelve el año en 2 cifras
select convert(23.45, char) as resultado;
select substring((23.45, char),3,1) as resultado;

-- Queremos construir un SQL cuyo resultado sea, para cada cliente:
-- “El cliente Pepito Pérez facturó 120000 en el año 2016”.
-- Solamente para el año 2016.

SELECT CONCAT('El cliente ', TC.NOMBRE, ' facturó ', 
CONVERT(SUM(IFa.CANTIDAD * IFa.precio), CHAR(20))
 , ' en el año ', CONVERT(YEAR(F.FECHA_VENTA), CHAR(20))) AS FRASE FROM facturas F
INNER JOIN items_facturas IFa ON F.NUMERO = IFa.NUMERO
INNER JOIN tabla_de_clientes TC ON F.DNI = TC.DNI
WHERE YEAR(FECHA_VENTA) = 2016
GROUP BY TC.NOMBRE, YEAR(FECHA_VENTA);