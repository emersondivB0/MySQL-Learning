USE ventas_jugos;

select * from tb_producto;

update tb_producto set PRECIO_LISTA = 5 where CODIGO = '1000889';

update tb_producto set DESCRIPCION = 'Sabor de la Montaña', TAMANO = '1 Litro', ENVASE = 'Botella Pet' where CODIGO = '1000889';

-- En la tabla de clientes, el volumen está en dl, podemos poner todo el campo en l:
update tb_cliente set VOLUMEN_COMPRA = VOLUMEN_COMPRA/10;

/*
Actualiza la dirección del cliente con el DNI 5840119709 Colocando como nueva dirección Jorge Emilio 23, 
barrio San Antonio, ciudad Guadalajara, Estado de Jalisco y el CP 44700000.

*/
UPDATE tb_clientes SET 
DIRECCION = 'Jorge Emilio 23',
BARRIO = 'San Antonio',
CIUDAD = 'Guadalajara',
ESTADO = 'JC',
CEP = '44700000'
WHERE DNI = '5840119709';

-- Traer datos de otra tabla
select * from tb_vendedor;
select * from jugos_ventas.tabla_de_vendedores;

select * from tb_vendedor A
inner join
jugos_ventas.tabla_de_vendedores B
on A.MATRICULA = substring(B.MATRICULA,3,3);

update tb_vendedor A
inner join
jugos_ventas.tabla_de_vendedores B
on A.MATRICULA = substring(B.MATRICULA,3,3)
set A.DE_VACACIONES = B.VACACIONES;

/*
Podemos observar que los vendedores se encuentran en barrios asociados a ellos. 
Vamos a aumentar en 30% el volumen de compra de los clientes que tienen, en sus direcciones, 
barrios donde los vendedores cuentan con oficinas.

Tip: Vamos a usar un UPDATE con FROM apoyándonos con el siguiente INNER JOIN:
*/

SELECT A.DNI FROM tb_clientes A
INNER JOIN tb_vendedor B
ON A.BARRIO = B.BARRIO;

UPDATE tb_clientes A 
INNER JOIN 
tb_vendedor B
ON A.BARRIO = B.BARRIO
SET A.VOLUMEN_COMPRA = A.VOLUMEN_COMPRA * 1.3;

-- excluir datos d euna tabla:
-- primero incluimos valores de prueba:

INSERT INTO tb_producto (CODIGO,DESCRIPCION,SABOR,TAMANO,ENVASE,PRECIO_LISTA)
     VALUES ('1001001','Sabor Alpino','Mango','700 ml','Botella',7.50),
         ('1001000','Sabor Alpino','Melón','700 ml','Botella',7.50),
         ('1001002','Sabor Alpino','Guanábana','700 ml','Botella',7.50),
         ('1001003','Sabor Alpino','Mandarina','700 ml','Botella',7.50),
         ('1001004','Sabor Alpino','Banana','700 ml','Botella',7.50),
         ('1001005','Sabor Alpino','Asaí','700 ml','Botella',7.50),
         ('1001006','Sabor Alpino','Mango','1 Litro','Botella',7.50),
         ('1001007','Sabor Alpino','Melón','1 Litro','Botella',7.50),
         ('1001008','Sabor Alpino','Guanábana','1 Litro','Botella',7.50),
         ('1001009','Sabor Alpino','Mandarina','1 Litro','Botella',7.50),
         ('1001010','Sabor Alpino','Banana','1 Litro','Botella',7.50),
         ('1001011','Sabor Alpino','Asaí','1 Litro','Botella',7.50);


SELECT * FROM tb_producto WHERE DESCRIPCION = 'Sabor Alpino';

delete from tb_producto where CODIGO = '1001000';

delete from tb_producto where TAMANO = '1 Litro';

select COODIGO_DEL_PRODUCTO from jugos_ventas.tabla_de_productos;

select CODIGO from tb_producto
where CODIGO not in (select COODIGO_DEL_PRODUCTO from jugos_ventas.tabla_de_productos);
delete from tb_producto
where CODIGO not in (select COODIGO_DEL_PRODUCTO 
from jugos_ventas.tabla_de_productos);

/*
Vamos a excluir las facturas (Apenas el encabezado) cuyos clientes tengan menos de 18 años.

Tip: Usaremos la siguiente consulta:
*/

SELECT A.DNI FROM tb_clientes A
INNER JOIN tb_vendedor B
ON A.BARRIO = B.BARRIO;

DELETE A FROM tb_facturas A
INNER JOIN 
tb_clientes B 
ON A.DNI = B.DNI
WHERE B.EDAD < 18;

-- Alterar y borrar toda una tabla:

CREATE TABLE `tb_producto2` (
  `CODIGO` varchar(10) NOT NULL,
  `DESCRIPCION` varchar(100) DEFAULT NULL,
  `SABOR` varchar(50) DEFAULT NULL,
  `TAMANO` varchar(50) DEFAULT NULL,
  `ENVASE` varchar(50) DEFAULT NULL,
  `PRECIO_LISTA` float DEFAULT NULL,
  PRIMARY KEY (`CODIGO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

insert into tb_producto2
select * from tb_producto; -- copia todo

update tb_producto2 set PRECIO_LISTA = PRECIO_LISTA* 1.15;

delete from tb_producto2; -- borra toda la tabla