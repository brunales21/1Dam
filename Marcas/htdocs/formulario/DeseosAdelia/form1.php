<?php
$link = mysqli_connect("localhost", "root","") or die('No se pudo conectar: ' . mysql_error());
$db = mysqli_select_db($link,"bddadelia")or die('No se pudo seleccionar la base de datos'); 
// volcamos en variables cada uno de los campos que queremos almacenar en la base de datos
// en nuestro caso POST(‘name de cada uno de los imput del formulario )
$nombre=$_POST['name'];
$edad=$_POST['age'];
$localidad=$_POST['place'];
$provincia=$_POST['province'];
$privacidad=$_POST['condicion'];
$preferencia=$_POST['publicidad'];

$consulta="INSERT INTO usuario (nombre, edad, localidad, provincia, privacidad, preferencia)
VALUES ('$nombre','$edad','$localidad','$provincia','$condicion','$privacidad')";
// Si queremos visualizar la consulta que se envía al servidor pondremos:
echo "----------------------".$consulta."--";
mysqli_query($link,$consulta) or die ("<h3> Error al insertar en la tabla </h3>");
//Si queremos encriptar la contraseña podemos utilizar la función md5(variable donde se almacena)
echo "¡Graciassss! Hemos recibido sus datos.\n";
?>