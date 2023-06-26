SELECT CURDATE();
SELECT current_timestamp();
select year(current_timestamp());
select month(current_timestamp());
select day(current_timestamp());
select monthname(current_timestamp());
select dayname(current_timestamp());
select datediff(current_timestamp(),"1984-01-03") as diferencia_de_dias;
select current_timestamp() as dia_hoy,
date_sub(current_timestamp(), interval 1 month) as resultado;
select distinct FECHA_VENTA,
dayname(FECHA_VENTA) as DIA, monthname(FECHA_VENTA) as MES,
YEAR(FECHA_VENTA) AS AÑO from facturas;

-- Haz una consulta que muestre el nombre y la edad actual del cliente.

SELECT NOMBRE, TIMESTAMPDIFF(YEAR, FECHA_DE_NACIMIENTO, CURDATE()) AS    EDAD
FROM  tabla_de_clientes;