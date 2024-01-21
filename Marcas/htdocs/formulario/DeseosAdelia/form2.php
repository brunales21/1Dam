<?php
$link = mysqli_connect("localhost", "root","") or die('No se pudo conectar: ' . mysql_error());
$db = mysqli_select_db($link,"bddadelia")or die('No se pudo seleccionar la base de datos'); 
// volcamos en variables cada uno de los campos que queremos almacenar en la base de datos
// en nuestro caso POST(‘name de cada uno de los imput del formulario )
$check1 = isset($_POST['checkbox1']) ? $_POST['checkbox1'] : '';
$check2 = isset($_POST['checkbox2']) ? $_POST['checkbox2'] : '';
$check3 = isset($_POST['checkbox3']) ? $_POST['checkbox3'] : '';

$opinion=$_POST['opinion'];
$sabor=$_POST['sabor'];
$precio=$_POST['precio'];
$catador=$_POST['catador'];
$email=$_POST['email'];
$color=$_POST['color'];




$consulta="INSERT INTO estudio (check1, check2, check3, opinion, sabor, precio, catador, email, color)
VALUES ('$check1','$check2','$check3','$opinion','$sabor','$precio','$catador','$email','$color')";

// Si queremos visualizar la consulta que se envía al servidor pondremos:
echo "----------------------".$consulta."--";
mysqli_query($link,$consulta) or die ("<h3> Error al insertar en la tabla </h3>");
//Si queremos encriptar la contraseña podemos utilizar la función md5(variable donde se almacena)
echo "¡Graciassss! Hemos recibido sus datos.\n";
?>