select * from facturas;
select * from items_facturas;
select F.DNI, F.FECHA_VENTA, IFa.CANTIDAD FROM facuras F
INNER JOIN
items_facturas IFa
on F.NUMERO = IFa.NUMERO;

-- Siempre que se hagan funciones, colocar alias

select F.DNI, date_format(F.FECHA_VENTA, "%m - %Y") as MES_AÑO, IFa.CANTIDAD FROM facuras F
INNER JOIN
items_facturas IFa
on F.NUMERO = IFa.NUMERO;

/*CANTIDAD DE VENTAS POR MES PARA CADA CLIENTE*/

select F.DNI, date_format(F.FECHA_VENTA, "%m - %Y") as MES_AÑO, 
sum(IFa.CANTIDAD) as cantidad_vendida FROM facuras F
INNER JOIN
items_facturas IFa
on F.NUMERO = IFa.NUMERO
group by
F.DNI, date_format(F.FECHA_VENTA, "%m - %Y");

/*En esta aula construimos un informe que presentó a los clientes que tenían 
ventas inválidas. Complementa este informe listando solamente a los que tuvieron 
ventas inválidas y calcula la diferencia entre el límite de venta máximo y la 
cantidad vendida en porcentuales.

Tips:
Utiliza el comando SQL empleado al final del video.
Filtra solamente las líneas donde: (A.CANTIDAD_VENDIDA - A.CANTIDAD_MAXIMA) < 0

Lista el campo X.CANTIDAD_LIMITE

Crea nuevo campo ejecutando la fórmula: 
(1 - (X.QUANTIDADE_LIMITE/X.QUANTIDADE_VENDAS)) * 100.*/

SELECT A.DNI, A.NOMBRE, A.MES_AÑO, 
A.CANTIDAD_VENDIDA - A.CANTIDAD_MAXIMA AS DIFERENCIA,
CASE
   WHEN  (A.CANTIDAD_VENDIDA - A.CANTIDAD_MAXIMA) <= 0 THEN 'Venta Válida'
   ELSE 'Venta Inválida'
END AS STATUS_VENTA, ROUND((1 - (A.CANTIDAD_MAXIMA/A.CANTIDAD_VENDIDA)) * 100,2) AS PORCENTAJE
 FROM(
SELECT F.DNI, TC.NOMBRE, DATE_FORMAT(F.FECHA_VENTA, "%m - %Y") AS MES_AÑO, 
SUM(IFa.CANTIDAD) AS CANTIDAD_VENDIDA, 
MAX(VOLUMEN_DE_COMPRA)/10 AS CANTIDAD_MAXIMA  
FROM facturas F 
INNER JOIN 
items_facturas IFa
ON F.NUMERO = IFa.NUMERO
INNER JOIN 
tabla_de_clientes TC
ON TC.DNI = F.DNI
GROUP BY
F.DNI, TC.NOMBRE, DATE_FORMAT(F.FECHA_VENTA, "%m - %Y"))A
WHERE (A.CANTIDAD_MAXIMA - A.CANTIDAD_VENDIDA) < 0;

/* Límite de ventas por cliente (volumen en decilitros)*/

select * from tabla_de_clientes TC;
select DNI, NOMBRE, VOLUMEN_DE_COMPRA from tabla_de_clientes TC;
select F.DNI, TC.NOMBRE, date_format(F.FECHA_VENTA, "%m - %Y") as MES_AÑO, 
sum(IFa.CANTIDAD) as cantidad_vendida, max(VOLUMEN_DE_COMPRA)/10 as CANTIDAD_MAXIMA 
FROM facuras F
INNER JOIN
items_facturas IFa
on F.NUMERO = IFa.NUMERO
inner join
tabla_de_clientes TC
on TC.DNI = F.DNI
group by
F.DNI, TC.NOMBRE, date_format(F.FECHA_VENTA, "%m - %Y");

SELECT A.DNI, A.NOMBRE, A.MES_AÑO, 
A.CANTIDAD_VENDIDA - A.CANTIDAD_MAXIMA AS DIFERENCIA,
CASE
   WHEN  (A.CANTIDAD_VENDIDA - A.CANTIDAD_MAXIMA) <= 0 THEN 'Venta Válida'
   ELSE 'Venta Inválida'
END AS STATUS_VENTA
 FROM(
SELECT F.DNI, TC.NOMBRE, DATE_FORMAT(F.FECHA_VENTA, "%m - %Y") AS MES_AÑO, 
SUM(IFa.CANTIDAD) AS CANTIDAD_VENDIDA, 
MAX(VOLUMEN_DE_COMPRA)/10 AS CANTIDAD_MAXIMA  
FROM facturas F 
INNER JOIN 
items_facturas IFa
ON F.NUMERO = IFa.NUMERO
INNER JOIN 
tabla_de_clientes TC
ON TC.DNI = F.DNI
GROUP BY
F.DNI, TC.NOMBRE, DATE_FORMAT(F.FECHA_VENTA, "%m - %Y"))A;

/*Otro ejemplo de informe es el que determina la venta por sabores, para el año de 2016, 
presentando el porcentaje de participación de cada uno de estos sabores, ordenados.*/

SELECT VENTAS_SABOR.SABOR, VENTAS_SABOR.AÑO, VENTAS_SABOR.CANTIDAD_TOTAL,
ROUND((VENTAS_SABOR.CANTIDAD_TOTAL/VENTA_TOTAL.CANTIDAD_TOTAL)*100,2) 
AS PORCENTAJE FROM (
SELECT P.SABOR, SUM(IFa.CANTIDAD) AS CANTIDAD_TOTAL, 
YEAR(F.FECHA_VENTA) AS AÑO FROM
tabla_de_productos P
INNER JOIN
items_facturas IFa
ON P.CODIGO_DEL_PRODUCTO = IFa.CODIGO_DEL_PRODUCTO
INNER JOIN
facturas F
ON F.NUMERO = IFa.NUMERO
WHERE YEAR(F.FECHA_VENTA) = 2016
GROUP BY P.SABOR, YEAR(F.FECHA_VENTA)
ORDER BY SUM(IFa.CANTIDAD) DESC) VENTAS_SABOR
INNER JOIN (
SELECT SUM(IFa.CANTIDAD) AS CANTIDAD_TOTAL, 
YEAR(F.FECHA_VENTA) AS AÑO FROM
tabla_de_productos P
INNER JOIN
items_facturas IFa
ON P.CODIGO_DEL_PRODUCTO = IFa.CODIGO_DEL_PRODUCTO
INNER JOIN
facturas F
ON F.NUMERO = IFa.NUMERO
WHERE YEAR(F.FECHA_VENTA) = 2016
GROUP BY YEAR(F.FECHA_VENTA)) VENTA_TOTAL
ON VENTA_TOTAL.AÑO = VENTAS_SABOR.AÑO
ORDER BY VENTAS_SABOR.CANTIDAD_TOTAL DESC;