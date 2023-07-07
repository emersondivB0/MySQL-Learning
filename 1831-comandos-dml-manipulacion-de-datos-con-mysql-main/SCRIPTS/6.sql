-- Establecer valores por defecto en campos

create table tb_default(
id int auto_increment,
descripcion varchar(50) not null,
direccion varchar(100) null,
ciudad varchar(50) default 'Monterrey',
fecha_creacion timestamp default current_timestamp(),
primary key(id)
);
 insert into tb_default
 (descripcion, direccion, ciudad, fecha_creacion)
 values ('cliente x', 'Calle Sol, 525', 'Cancún', '2021-01-01');
 
 insert into tb_default
 (descripcion)
 values ('cliente y');
 
 select * from tb_default;