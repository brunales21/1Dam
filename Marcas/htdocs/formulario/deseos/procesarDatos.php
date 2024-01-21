<?php
$link = mysqli_connect("localhost", "root", "", "bddeseos") or die('No se pudo conectar: ' . mysql_error());
// volcamos en variables cada uno de los campos que queremos almacenar en la base de datos
// en nuestro caso POST(‘name de cada uno de los imput del formulario )
$nombreApellidos=$_POST['nombreApellidos'];
$direccion=$_POST['direccion'];
$localidad=$_POST['localidad'];
$provincia=$_POST['provincia'];
$condicion=$_POST['condicion'];
$email=$_POST['email'];
$deseo=$_POST['deseo'];


$consulta="INSERT INTO usuario (nombreApellidos, direccion, localidad, provincia, condicion, email, deseo)
VALUES ('$nombreApellidos','$direccion','$localidad','$provincia','$condicion','$email','$deseo)";
// Si queremos visualizar la consulta que se envía al servidor pondremos:
echo "----------------------".$consulta."--";
mysqli_query($link,$consulta) or die ("<h3> Error al insertar en la tabla </h3>");
//Si queremos encriptar la contraseña podemos utilizar la función md5(variable donde se almacena)
echo "¡Graciassss! Hemos recibido sus datos.\n";
?>