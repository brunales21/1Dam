package com.iesinfanta;

import java.util.Scanner;

public class SumaDosNumeros {

    public static void main(String[] args) {
        // TODO Auto-generated method stub
          int n1, n2, suma;
          Scanner teclado = new Scanner( System.in );

          System.out.print( "Introduzca primer número: " );
          //nextInt() lee un entero por consola
          n1 = teclado.nextInt();

          System.out.print( "Introduzca segundo número: " );
          n2 = teclado.nextInt();

          suma = n1 + n2;

          System.out.println( "La suma de " + n1 + " más " + n2 + " es " + suma + "." );

          teclado.close();

    }

}