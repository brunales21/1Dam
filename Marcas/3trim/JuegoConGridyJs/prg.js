
var rutaBase = "imgs/";

var cantidadFiguras = 16;
var figuras = new Array();

var sel1 = null;
var sel2 = null;

var aciertos = 0;

var iniTime = new Date();


function showSegundos() {
  document.getElementById("segundos").innerHTML = parseInt((new Date() - iniTime)/1000);
  setTimeout(function() { showSegundos(); }, 1000);
}

function generarFiguras() {
	for (var i=0; i<cantidadFiguras; i++) {
		num = parseInt(Math.random() * cantidadFiguras);
		figuras[i] = num;
		for (var j=0; j<i; j++) {
			if (figuras[j] == num) {
				i--;
				break;
			}
		}
	}
}

function generateFigures() {
  for (let i = 0; i < cantidadFiguras; i++) {
    while (contains(array, num)) {
      num = parseInt(Math.random() * cantidadFiguras);
    }
    array[i] = num; 
  }

}

function showMensaje(mensaje) {
  document.getElementById("mensaje").innerHTML = mensaje;
  console.log(mensaje);
}

function seleccionar(id) {
  if (sel1 != null && sel2 != null) return;
  
  image = document.getElementById(id);
  image.setAttribute("onclick", "");
  
  mostrarFigura(id);
  
  var sel = id;
  if (sel1 == null) {
    sel1 = sel;
  } else {
    sel2 = sel;
    var val1 = figuras[sel1];
    var val2 = figuras[sel2];
    if (checkAcierto(val1, val2)) {
      console.log("ACIERTO!!!");
      sel1 = null;
      sel2 = null;
      aciertos++;
      if (aciertos == cantidadFiguras / 2) {
        showMensaje("ENHORABUENA!!! Has ganado en " + parseInt((new Date() - iniTime)/1000) + " segundos!!");
        fondo = document.getElementById("body");
        fondo.style.backgroundColor = "green";
      }
    } else {
      console.log("NO...")
      setTimeout(function() { deseleccionar(); }, 1000);  
    }
  }
}

function deseleccionar() {
  ocultarFigura(sel1);
  ocultarFigura(sel2);
  sel1 = null;
  sel2 = null;
}

function checkAcierto(val1, val2) {
  console.log(val1);
  console.log(val2);
  return (val1-val2 == 1 || val1-val2 == -1) && esImpar(max(val1, val2))
}

function max(a, b) {
  if (a > b) return a;
  else return b;
}
  
function esImpar(a) {
  if (a & 1 == 1) return true;
  else return false;
}

function mostrarFigura(id) {
	nombreImagen = rutaBase + figuras[id]  + ".jpg";
	image = document.getElementById(id);
	image.setAttribute("src", nombreImagen);
}

function mostrarFiguras() {
	for (var i=0; i<cantidadFiguras; i++) {
		mostrarFigura(i);
	}
}

function ocultarFigura(id) {
  nombreImagenOculta = rutaBase + "-.jpg";
  image = document.getElementById(id);
	image.setAttribute("src", nombreImagenOculta);
  image.setAttribute("onclick", "seleccionar(this.id)");
}

function limpiarTablero() {	
	for (var i=0; i<cantidadFiguras; i++) {
		figuras[i] = null;		
		ocultarFigura(i);
	}
}

function nuevoJuego() {
    fondo = document.getElementById("body");
    fondo.style.backgroundColor = "rgb(0, 208, 255)";
    showMensaje("A jugar!!!");
    startBoton = document.getElementById("boton");
    startBoton.innerHTML = "Jugar otra partida.";
    showSegundos();
    aciertos = 0;
    iniTime = new Date();
    limpiarTablero();
    generarFiguras();
}


	    