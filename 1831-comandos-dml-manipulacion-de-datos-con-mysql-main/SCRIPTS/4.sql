-- COMMIT Y ROLLBACK

INSERT INTO `ventas_jugos`.`tb_vendedor`
(`MATRICULA`,
`NOMBRE`,
`BARRIO`,
`COMISION`,
`FECHA_ADMISION`,
`DE_VACACIONES`)
VALUES
('256',
'Fernando Ruiz',
'Oblatos'>,
0.1,
'2015-06-14',
0);

select * from tb_vendedor;

-- creo un punto en la DB

start transaction;

INSERT INTO `ventas_jugos`.`tb_vendedor`
(`MATRICULA`,
`NOMBRE`,
`BARRIO`,
`COMISION`,
`FECHA_ADMISION`,
`DE_VACACIONES`)
VALUES
('257',
'Fernando Rojas',
'Oblatos'>,
0.1,
'2015-06-14',
0);
INSERT INTO `ventas_jugos`.`tb_vendedor`
(`MATRICULA`,
`NOMBRE`,
`BARRIO`,
`COMISION`,
`FECHA_ADMISION`,
`DE_VACACIONES`)
VALUES
('258',
'David Rojas',
'Valle'>,
0.1,
'2015-06-14',
0);

update tb_vendedor set COMISION = COMISION* 1.05;

-- con ROLLBACK vuelvo al punto que creé:alter
ROLLBACK;

-- con COMMIT confirmo las operaciones y no se puede hacer rollback
COMMIT;