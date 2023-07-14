USE jugos_ventas;
CALL hola_mundo;
CALL concatenar;
CALL concatenar_con_comentarios;
CALL exhibir_variable;
CALL declaracion;
CALL atribuir_valores;

/*
Crea un SP con las siguientes 4 variables y que al utilizar el comando CALL, 
las mismas puedan ser visualizadas.

/*
Nombre: Cliente. 
Tipo: Caracteres con 10 posiciones. 
Valor: Juan.

Nombre: Edad. 
Tipo: Entero. 
Valor: 10.

Nombre: Fecha_Nacimiento. 
Tipo: Fecha. 
Valor: 10/01/2007.

Nombre: Costo. 
Tipo: Número con casillas decimales. 
Valor: 10.23 .
*/

CALL mostrar_cliente;