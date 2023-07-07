USE ventas_jugos;
INSERT INTO tb_producto (CODIGO, DESCRIPCION, SABOR, TAMANO, ENVASE,
PRECIO_LISTA) VALUES ('1040107', 'Light', 'Sandía', '350 ml', 'Lata', 4.56);

INSERT INTO tb_producto (CODIGO, SABOR, DESCRIPCION, TAMANO, ENVASE,
PRECIO_LISTA) VALUES ('1040108', 'Guanábana', 'Light', '350 ml', 'Lata', 4.00);

INSERT INTO tb_producto VALUES 
('1040109', 'Light', 'Asaí', '350 ml', 'Lata', 5.60), 
('1040110', 'Light', 'Manzana', '350 ml', 'Lata', 6.00),
('1040111', 'Light', 'Mango', '350 ml', 'Lata', 3.50);

/*
Selecciona la pestaña Administration, en el área Navigator.

9) Selecciona el link Data Import/Restore.

10) En la opción Import From Dump Project Folder escoge el directorio DumpJugosVentas.

11) Haz clic sobre el botón Start Import.

12) Verifica en la base jugos_ventas se las tablas fueron creadas.

13) Podemos acceder a la base jugos_ventas desde ventas_jugos. La forma de hacerlo es empleando los siguientes comandos:
*/

USE ventas_jugos;
SELECT * FROM jugos_ventas.tabla_de_productos;

/*
14) La siguiente consulta, muestra la lista de productos, en la tabla tabla_de_productos, de la base jugos_ventas los cuales aún no fueron incluidos en tb_productos, de la base ventas_jugos:
*/
SELECT CODIGO_DEL_PRODUCTO AS CODIGO, NOMBRE_DEL_PRODUCTO AS DESCRIPCION,
SABOR, TAMANO, ENVASE, PRECIO_DE_LISTA AS PRECIO_LISTA 
FROM jugos_ventas.tabla_de_productos
WHERE CODIGO_DEL_PRODUCTO NOT IN (SELECT CODIGO FROM tb_producto);

/*
Con ayuda del comando INSERT podemos incluir los productos desde la tabla jugos_ventas.tabla_de_productos hacia la tabla ventas_jugos.tb_producto. Digita y ejecuta:
*/
INSERT INTO tb_producto
SELECT CODIGO_DEL_PRODUCTO AS CODIGO, NOMBRE_DEL_PRODUCTO AS DESCRIPCION,
SABOR, TAMANO, ENVASE, PRECIO_DE_LISTA AS PRECIO_LISTA 
FROM jugos_ventas.tabla_de_productos
WHERE CODIGO_DEL_PRODUCTO NOT IN (SELECT CODIGO FROM tb_producto);

/*
17) Ahora, vamos a incluir clientes en la tabla tb_cliente. Digita y ejecuta:
*/

SELECT * FROM tb_cliente;

/*
18) Al lado derecho de donde aparece la tabla aparece el botón Form Editor. Allí tendremos un formulario para editar la tabla de clientes:

20.png

19) Incluye un nuevo cliente:

DNI: 1471156710; NOMBRE: Erica Carvajo; DIRECCION: Heriberto Frías 1107; BARRIO: Del Valle; CIUDAD: Ciudad de Mexico; ESTADO: EM; CP: 80012212; FECHA_NACIMIENTO: 1990-03-01; IDADE: 30; SEXO: F; LIMITE_CREDITO: 170000; VOLUME_COMPRA: 24500; PRIMEIRA_COMPRA: 1;

20) Confirma su inclusión haciendo clic sobre apply.

21) Ejecuta la consulta nuevamente. Digita y ejecuta:

*/

SELECT * FROM tb_cliente;

/*
22) Vamos a incluir a los clientes usando como fuente nuestra otra base de datos. Digita y ejecuta:
*/

/*
24) Vamos a mostrar ahora como incluir datos en la tabla tb_vendedor através de archivos externos. En los archivos que descargaste al preparar el ambiente, aparece dentro de la carpeta RecuperacionAmbiente un archivo llamado vendedores.csv.

25) Haz clic con el botón derecho del mouse sobre la tabla tb_vendedor y escoge la opción Table Data Import Wizard.

22.png

26) En File Path selecciona el archivo vendedores.csv.

27) Mantenga los datos por defecto.

28) Pueden existir problemas entre computadores y entre los archivos descargados. Debes ver la combinación correta entre el formato del archivo (Que puede ser modificado en el NOTEPAD clásico) y en el cuadro de diálogo de importación de datos.

8.png

29) Desmarca la opción VACACIONES:

30) Clic en Next varias veces hasta que los datos sean incluidos en tb_vendedor.

31) Verifica el contenido de la tabla tb_vendedor:

*/
SELECT * FROM tb_vendedor;