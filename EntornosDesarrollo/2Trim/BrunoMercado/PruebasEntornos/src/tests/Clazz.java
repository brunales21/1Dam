package tests;

public class Clazz {

    //Devuelve el mayor incremento de salto 1 del array pasado por parametro.
    public static int getHigherInc(int[] numbers) {
        int mayorResta = 0;
        int resta = 0;
        for (int i = 0; i < numbers.length-1; i++) {
            if (numbers[i+1]>=numbers[i]) {
                resta += numbers[i+1]-numbers[i];
                if (resta>mayorResta) {
                    mayorResta = resta;
                }
            } else {
                resta = 0;
            }
        }
        return mayorResta;
    }

    //Devuelve el mayor integer del array pasado por parametro.
    public static int encontrarMaximo(int[] numbers) {
        int maximo = numbers[0]; // Suponemos que el primer elemento es el máximo

        for (int i = 1; i < numbers.length; i++) {
            if (numbers[i] > maximo) {
                maximo = numbers[i];
            }
        }
        return maximo;
    }

    //Devuelve la suma total de pares del 1 al 100
    public static int sumaPares() {
        int suma = 0;
        for (int i = 0; i < 100; i++) {
            if (i % 2 == 0) {
                suma += i;
            }
        }
        return suma;
    }

}
