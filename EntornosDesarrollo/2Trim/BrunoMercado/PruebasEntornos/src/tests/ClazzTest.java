package tests;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class ClazzTest {

    //Tests para el método getHighestInc

    @Test
    public void testGetHigherInc1() {
        int[] numbers = {1, 2, 3, 4, 5};
        int expected = 1;
        int result = Clazz.getHigherInc(numbers);
        assertNotEquals(expected, result);
    }

    @Test
    public void testGetHigherInc2() {
        int[] numbers = {5, 4, 3, 2, 1};
        int expected = 0;
        int result = Clazz.getHigherInc(numbers);
        assertEquals(expected, result);
    }

    @Test
    public void testGetHigherInc3() {
        int[] numbers = {1, 2, 3, 2, 1};
        int expected = 2;
        int result = Clazz.getHigherInc(numbers);
        assertTrue(expected == result);
    }

    //Tests para el método encontrarMaximo

    @Test
    public void testEncontrarMaximo1() {
        int[] arreglo = {1, 2, 3, 4, 5};
        int expected = 5;
        int result = Clazz.encontrarMaximo(arreglo);
        assertEquals(expected, result, "El máximo de la secuencia no ha sido correctamente identificado.");
    }

    @Test
    public void testEncontrarMaximo2() {
        int[] arr = {1, 2, 3, 4, 5};
        int expected = 3;
        int actualResult = Clazz.encontrarMaximo(arr);
        assertFalse(expected == actualResult);
    }

    @Test
    public void testEncontrarMaximo3() {
        int[] arreglo = {1, 2, 3, 2, 1};
        int expected = 3;
        int result = Clazz.encontrarMaximo(arreglo);
        assertEquals(expected, result);
    }

    //Tests para el método sumaPares

    @Test
    public void testSumaPares1() {
        int expected = 2450;
        int actual = Clazz.sumaPares();
        assertTrue(expected == actual);
    }

    @Test
    public void testSumaPares2() {
        int expected = 0;
        int actual = Clazz.sumaPares();
        assertNotEquals(expected, actual);
    }

    @Test
    public void testSumaPares3() {
        int expected = 2451;
        int actual = Clazz.sumaPares();
        assertFalse(expected == actual);
    }

    @Test
    public void testSumaPares4() {
        int expected = 10000;
        int actual = Clazz.sumaPares();
        assertTrue(actual < expected);
    }
}