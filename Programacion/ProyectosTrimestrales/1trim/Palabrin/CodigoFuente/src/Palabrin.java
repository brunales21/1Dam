import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.Random;
import java.util.Scanner;


public class Palabrin {

    public static final String EMPTY_GAP = Color.WHITE_BRIGHT+"_";
    public static final int WORD_LEN = 8;
    public static Random rand = new Random();
    public static Scanner writer = new Scanner(System.in);

    //Se usará para asignarle el fichero especificado
    public static String[] dictionary;

    //Contendrá el diccionario completo (de palabras de 8 caracteres)
    public static String[] globalDictionary;

    static {
        try {
            globalDictionary = getDictionary("palabrasDificiles.txt");
        } catch (FileNotFoundException e) {
            throw new RuntimeException(e);
        }
    }




    public static void main(String[] args) throws FileNotFoundException {
        palabrin();

    }

    public static void palabrin() throws FileNotFoundException {

        int highestScore = 0;

        do {
            boolean won = false;
            boolean gaveUp = false;
            setDifficulty();

            int intentos = 10;
            int puntuacion = 1000;

            System.out.println(Color.BLUE+"Tienes: "+intentos+" intentos!!");

            //Se asigna a randword una palabra aleatoria del diccionario
            String randWord = getRandomWord(dictionary);

            //(Para casos de prueba)
            //System.out.println(Color.GREEN+randWord);

            //"output" de momento contiene "________". Se actualizara cuando introduzcamos un intento
            String output = Color.WHITE_BRIGHT+getStringOf(WORD_LEN, EMPTY_GAP);
            //Para en un futuro meter el output sin colores
            String simpleOutput = "";

            //Se utilizara para mostrar la pista POKE
            char pista = 0;

            saltoDeLinea();
            System.out.println(output);

            //Variables usadas para el funcionamiento de POKE
            boolean hayPokes = true;
            String pokeChars = wordMixer(randWord);
            int i = 0;
            int contadorPokes = 0;

            //Bucle del juego
            do {

                //"word" contiene el input del usuario
                String word = getWord().toLowerCase();

                //Si el input es una palabra de 8 caracteres...
                if (word.length() == WORD_LEN) {
                    System.out.println(Color.BLUE+"Tienes: "+(intentos-=1)+" intentos!!");
                    //Control de poke
                    i = 0;
                    hayPokes = true;
                }

                if (word.equalsIgnoreCase("x")) {
                    gaveUp = true;
                    break;
                }


                //Si introducimos "poke", el juego nos da una pista con respecto al último intento
                if (word.equalsIgnoreCase("poke")) {
                    do {
                        if (i>7) {
                            hayPokes = false;
                            break;
                        }
                        pista = pokeChars.charAt(i++);

                    } while (contains(simpleOutput, pista));

                    if (hayPokes) {
                        contadorPokes++;
                        System.out.println(Color.WHITE_BRIGHT+"Pista: "+Color.GREEN_BRIGHT+pista);
                    } else {
                        System.out.println(Color.RED+"No quedan pistas.");
                    }
                    //para que vuelva a pedir una palabra
                    continue;
                }

                //Nos devuelve nuestro output siguiendo la logica del juego (distintos colores)
                output = engine(word, randWord);
                //Hace lo mismo que engine pero sin colores (para luego poder comparar estas letras con los pokes, ya que una 'a' azul es diferente que una 'a')
                simpleOutput = getSimpleOutput(word, randWord);

                //Lo muestra por pantalla y resta un intento si hemos fallado. Son 10 como maximo.
                System.out.println(output);
                if (!word.equals(randWord)) {
                    puntuacion -= 100;
                    if (intentos<=0) {
                        saltoDeLinea();
                        System.out.println(Color.YELLOW+"Lo siento, no has adivinado la palabra, la palaba era: "+randWord);
                        break;
                    }
                } else {
                    //si entra es porque ganó
                    won = true;
                }


            } while (!won);

            saltoDeLinea();

            //Mostrar resumen de la partida
            if (!gaveUp) {
                if (intentos>0) {
                    System.out.println(Color.GREEN_BOLD_BRIGHT + "Felicidades, has acertado la palabra");
                    if (puntuacion > highestScore) {
                        highestScore = puntuacion;
                        System.out.println(Color.YELLOW_BOLD_BRIGHT + "Nueva puntuacion record: " + highestScore);
                    } else {
                        System.out.println(Color.GREEN_BRIGHT + "Tu puntuacion: " + puntuacion);
                    }
                }
                if (contadorPokes>0) {
                    System.out.println(Color.YELLOW+"Has usado "+contadorPokes+" POKEs");
                }

            } else {
                System.out.println(Color.RED_BRIGHT+"Abandonaste esta partida, la palabra era "+randWord);
            }


            saltoDeLinea();

        } while (seguirJugando());
    }


    //Utilidad: devuelve una palabra aleatoria
    public static String getRandomWord(String[] words) {
        Random rand = new Random();
        return words[rand.nextInt(words.length)];
    }


    //Utilidad: devuelve la palabra introducida por teclado (si la palabra no existe en el diccionarioGlobal, volverá a pedir una)
    public static String getWord() {
        Scanner sc2 = new Scanner(System.in);
        String word;
        do {
            word = sc2.nextLine();
            if (contains(globalDictionary, word) || word.equalsIgnoreCase("poke") || word.equalsIgnoreCase("x")) {
                break;
            } else {
                System.out.println(Color.RED+"*palabra no valida*");
            }
        } while (true);
        return word;
    }


    //Utilidad: (logica del juego) devuelve el string en funcion del input del usuario
    public static String engine(String input, String randWord) {
        String[] inputChars = getArrayOf(getStringOf(input.length(), "_"));
        for (int i = 0; i<input.length(); i++) {
            //Si coinciden, se pinta de verde
            if (charInSamePositions(input, randWord, i)) {
                inputChars[i] = Color.GREEN_BOLD_BRIGHT+input.charAt(i);
                //sino, si contiene esa letra..
            } else if (contains(input, input.charAt(i)) && contains(randWord, input.charAt(i))) {
                //si hay mas ocurrencias de la letra en input que en randWord..
                if (ocurrencesOfChar(input, input.charAt(i)) > ocurrencesOfChar(randWord, input.charAt(i))) {
                    //se quita esa letra de input y colocamos "_"
                    inputChars[i] = Color.WHITE_BOLD_BRIGHT+"_";
                    input = replaceBy(input, i, ' ');
                } else {
                    //si hay las mismas ocurrencias o menos que en randWord, se pintarán de amarillo
                    inputChars[i] = Color.YELLOW_BOLD_BRIGHT+input.charAt(i);
                }

            } else {
                //si la letra no coincide con ninguna otra..
                inputChars[i] = Color.WHITE_BOLD_BRIGHT+"_";
            }
        }
        return stringArrayToString(inputChars);
    }

    public static String getSimpleOutput(String input, String randWord) {
        String[] inputChars = getArrayOf(getStringOf(input.length(), "_"));
        for (int i = 0; i<input.length(); i++) {
            //Si coinciden, se pinta de verde
            if (charInSamePositions(input, randWord, i)) {
                inputChars[i] = input.charAt(i)+"";
                //sino, si contiene esa letra..
            } else if (contains(input, input.charAt(i)) && contains(randWord, input.charAt(i))) {
                //si hay mas ocurrencias de la letra en input que en randWord..
                if (ocurrencesOfChar(input, input.charAt(i)) > ocurrencesOfChar(randWord, input.charAt(i))) {
                    //se quita esa letra de input y colocamos "_"
                    inputChars[i] = "_";
                    input = replaceBy(input, i, ' ');
                } else {
                    //si hay las mismas ocurrencias o menos que en randWord, se pintarán de amarillo
                    inputChars[i] = input.charAt(i)+"";
                }

            } else {
                //si la letra no coincide con ninguna otra..
                inputChars[i] = "_";
            }
        }
        return stringArrayToString(inputChars);
    }


    //Utilidad: remplazar un caracter por otro (sirve para vaciar una posicion especifica)
    public static String replaceBy(String s, int pos, char c) {
        char[] chars = toCharArray(s);
        chars[pos] = c;
        return charArrayToString(chars);
    }


    //Utilidad: devuelve las ocurrencias de un char en un string. Ejemplo: ocurrencesOfChar("pepe", 'p') -> 2
    public static int ocurrencesOfChar(String a, char c) {
        int sum = 0;
        for (int i = 0; i<a.length(); i++)  {
            if (a.charAt(i) == c) {
                sum++;
            }
        }
        return sum;
    }


    //Utilidad: sirve para saber si dos palabras coinciden en un caracter en la misma posicion
    // (en la funcion palabrin() sirve para pintar el char de verde).
    public static boolean charInSamePositions(String a, String b, int pos) {
        return a.charAt(pos) == b.charAt(pos);
    }


    //Utilidad: devuelve la cantidad de lineas que tiene el fichero pasado por parametro
    public static int getLinesCount(String file) throws FileNotFoundException {
        int len = 0;
        Scanner sc = new Scanner(new FileReader(file));
        while (sc.hasNext()) {
            len++;
            sc.nextLine();
        }
        return len;
    }


    //Utilidad: volcamos en el array "dictionary" todas las palabras del fichero que se introduzca como parametro
    public static String[] getDictionary(String file) throws FileNotFoundException {
        // array de Strings para cargar palabras de 8 caracteres
        String[] diccionario = new String[getLinesCount(file)];

        // Utilizaremos un Scanner para cargar el fichero txt
        Scanner sc;
        int i = 0;

        try {
            // Cargamos el fichero txt guardado en la carpeta del proyecto
            sc = new Scanner(new FileReader(file));
            String str;

            //repetir hasta terminar de leer el fichero
            while (sc.hasNext()) {
                str = sc.next();

                // añadir palabra al diccionario
                diccionario[i] = str;
                i++;
            }


        } catch (FileNotFoundException e) {
            // asegurarse que la ruta y el nombre del fichero son correctos
            System.err.println("Fichero no encontrado");
        }
        return diccionario;
    }


    //Utilidad: configura el array "dictionary" en funcion de la dificultad que el usuario introduzca por teclado
    public static String[] setDifficulty() throws FileNotFoundException {
        System.out.println(Color.CYAN_BOLD+"Elige la dificultad\n1-Facil      2-Normal    3-Dificil");
        int d = writer.nextInt();

        switch (d) {
            case 1: dictionary = getDictionary("palabrasFaciles.txt");
                break;
            case 2: dictionary = getDictionary("palabrasNormales.txt");
                break;
            case 3: dictionary = getDictionary("palabrasDificiles.txt");
                break;
        }
        return dictionary;
    }


    //Mezcla la palabra: Ejemplo: "monica" -> "nicoma"
    public static String wordMixer(String word) {
        StringBuilder aux = new StringBuilder("");
        int len = word.length();
        char c;
        for (int i = 0; i<len; i++) {
            c = word.charAt(rand.nextInt(word.length()));
            aux.append(c);
            word = removeLetter(word, word.indexOf(c));
        }
        return aux.toString();
    }


    //Borra la letra de una posicion. Ejemplo: "carlos", 5 -> "carlo"
    public static String removeLetter(String s, int pos) {
        StringBuilder newWord = new StringBuilder("");
        for (int i = 0; i<s.length(); i++) {
            if (i != pos) {
                newWord.append(s.charAt(i));
            }
        }
        return newWord.toString();
    }

    //Borra los espacios de la palabra
    public static String removeSpaces(String s) {
        StringBuilder newWord = new StringBuilder("");
        for (int i = 0; i<s.length(); i++) {
            if (s.charAt(i) != ' ') {
                newWord.append(s.charAt(i));
            }
        }
        return newWord.toString();
    }


    //Output: devuelve un string del len y char que pases como parametro
    public static String getStringOf(int len, String s) {
        StringBuilder a = new StringBuilder("");
        for (int i = 0; i<len; i++) {
            a.append(s);
        }
        return a.toString();
    }


    //Si el string contiene el char especificado, devuelve true
    public static boolean contains(String s, char c) {
        for (int i = 0; i<s.length(); i++) {
            if (s.charAt(i)==c) {
                return true;
            }
        }
        return false;
    }

    //Si el array de string contiene el char especificado, devuelve true
    public static boolean contains(String[] s, String c) {
        for (String a: s) {
            if (c.equalsIgnoreCase(a)) {
                return true;
            }
        }
        return false;
    }


    public static void saltoDeLinea() {
        System.out.println();
    }


    static final String RESPUESTAS_POSITIVAS = "YSys";
    static final String RESPUESTAS_NEGATIVAS = "Nn";


    //Esta funcion simplemente devuelve verdadero o falso en funcion del input (si recibe una s/y devuelve verdadero, si no falso)
    public static boolean seguirJugando() {

        Scanner scanner = new Scanner(System.in);
        String input;
        do {
            System.out.println(Color.WHITE_BOLD_BRIGHT+"DESEA JUGAR OTRA PARTIDA? (y/n)");
            input = scanner.nextLine();
        } while (RESPUESTAS_POSITIVAS.indexOf(input.charAt(0)) == -1 && RESPUESTAS_NEGATIVAS.indexOf(input.charAt(0)) == -1);

        if (RESPUESTAS_POSITIVAS.indexOf(input.charAt(0)) != -1) {
            return true;
        }
        return false;
    }


    //Funciones de casteo

    //Output: castea de String a array de String (letra por letra)
    public static String stringArrayToString(String[] array) {
        StringBuilder b = new StringBuilder();
        for (String a: array) {
            b.append(a);
        }
        return b.toString();
    }

    //Output: castea de array de chars a String
    public static String charArrayToString(char[] array) {
        StringBuilder b = new StringBuilder();
        for (char a: array) {
            b.append(a);
        }
        return b+"";
    }

    //Output: castea de String a array de chars
    public static char[] toCharArray(String word) {
        char[] chars = new char[word.length()];
        for (int i = 0; i<word.length(); i++) {
            chars[i] = word.charAt(i);
        }
        return chars;
    }

    //Ejemplo de funcionamiento ("coche") -> {"c", "o", "c", "h", "e"}
    public static String[] getArrayOf(String s) {
        String[] a = new String[s.length()];
        for (int i = 0; i<s.length(); i++) {
            a[i] = s.charAt(i)+"";
        }
        return a;
    }








/*

    public static int differentChars(char[] chars) {
        char[] auxChars = new char[chars.length];
        System.arraycopy(chars, 0, auxChars, 0, chars.length);
        int contador
        for (int i = 0; i<chars.length; i++) {

        }
    }


 public static void add(char[] array, char s) {
        for (int i = 0; i<array.length; i++) {
            if (array[i] == 0) {
                array[i] = s;
                break;
            }
        }
    }

    public static void remove(char[] chars, char c) {
        for (int i = 0; i<chars.length; i++) {
            char x = chars[i];
            if (x == c) {
                chars[i] = 0;
            }
        }
    }

 */

}

