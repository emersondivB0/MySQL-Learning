-- AUTO_INCREMENT

create table tb_identificacion(
id int auto_increment not null,
descripcion varchar(50) null,
primary key(id)
);

select * from tb_identificacion;
insert into tb_identificacion(descripcion)
values ('cliente A');
insert into tb_identificacion(descripcion)
values ('cliente B');
insert into tb_identificacion(descripcion)
values ('cliente C');
insert into tb_identificacion(descripcion)
values ('cliente D');

insert into tb_identificacion(id, descripcion)
values (100, 'cliente E');
insert into tb_identificacion(DESCRIPCION)
values ('cliente F');
select * from tb_identificacion;