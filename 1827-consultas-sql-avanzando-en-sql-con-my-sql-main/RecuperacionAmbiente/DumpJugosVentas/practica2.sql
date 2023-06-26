USE jugos_ventas;
SELECT ENVASE, TAMANO FROM tabla_de_productos;
-- Un query importante se hace con DISTINCT, esto devuelve todos los valores
-- Sin repetir, si hay más de uno, sólo muestra una vez:
SELECT DISTINCT ENVASE, TAMANO FROM tabla_de_productos;
SELECT DISTINCT ENVASE, TAMANO, SABOR FROM tabla_de_productos WHERE SABOR = 'naranja';

-- El comando LIMIT limita la cantidad de registros mostrados:
SELECT * FROM tabla_de_productos LIMIT 5;
-- Puedo darle un registro inicial para que muestre desde ahí:alter
SELECT * FROM tabla_de_productos LIMIT 5,4;
-- Queremos obtener las 10 primeras ventas del día 01/01/2017:
SELECT * FROM facturas WHERE FECHA_VENTA = '2017-01-01' LIMIT 10;

-- ORDER BY se ordena la consulta de acuerdo a un campo dado:
-- Por defecto ordena de forma ascendente:
SELECT * FROM tabla_de_productos order by PRECIO_DE_LISTA;
SELECT * FROM tabla_de_productos order by PRECIO_DE_LISTA DESC;
SELECT * FROM tabla_de_productos order by NOMBRE_DEL_PRODUCTO;
SELECT * FROM tabla_de_productos order by ENVASE DESC, NOMBRE_DEL_PRODUCTO ASC;
-- ¿Cuál (o cuáles) fue (fueron) la(s) mayor(es) venta(s) del producto “Refrescante, 
-- 1 Litro, Frutilla/Limón”, en cantidad? (Obtenga este resultado utilizando 2 comandos SQL).
SELECT * FROM tabla_de_productos WHERE NOMBRE_DEL_PRODUCTO LIKE '%Refrescante%';
SELECT * FROM items_facturas WHERE CODIGO_DEL_PRODUCTO = '1101035' order by CANTIDAD DESC;

-- Ahora el comando GROUP BY
-- 
SELECT ESTADO, LIMITE_DE_CREDITO FROM tabla_de_clientes;
SELECT ESTADO, SUM(LIMITE_DE_CREDITO) AS LIMITE_TOTAL FROM tabla_de_clientes GROUP BY ESTADO;
SELECT ENVASE, MAX(PRECIO_DE_LISTA) AS MAYOR_PRECIO FROM tabla_de_productos group by ENVASE;
SELECT ENVASE, COUNT(*) FROM tabla_de_productos group by ENVASE; -- cuenta todo
SELECT BARRIO, SUM(LIMITE_DE_CREDITO) AS LIMITE FROM tabla_de_clientes GROUP BY BARRIO;
SELECT BARRIO, SUM(LIMITE_DE_CREDITO) AS LIMITE FROM tabla_de_clientes WHERE CIUDAD = 'CIUDAD DE MEXICO' GROUP BY BARRIO;
SELECT CIUDAD, BARRIO, MAX(LIMITE_DE_CREDITO) AS LIMITE FROM tabla_de_clientes GROUP BY CIUDAD, BARRIO;
SELECT ESTADO, BARRIO, MAX(LIMITE_DE_CREDITO) AS LIMITE FROM tabla_de_clientes GROUP BY ESTADO, BARRIO;
SELECT ESTADO, BARRIO, MAX(LIMITE_DE_CREDITO) AS LIMITE, 
EDAD FROM tabla_de_clientes
WHERE EDAD >=20 
GROUP BY ESTADO, BARRIO 
ORDER BY EDAD;
-- Aprovechando el ejercicio del video anterior ¿Cuántos ítems vendidos cuentan 
-- con la mayor cantidad del producto '1101035'?
SELECT CODIGO_DEL_PRODUCTO, MAX(CANTIDAD) AS MAS_CANTIDAD FROM items_facturas 
WHERE CODIGO_DEL_PRODUCTO = '1101035'
GROUP BY CODIGO_DEL_PRODUCTO;