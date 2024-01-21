-- Paso 1
use pokedex;

SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

START TRANSACTION;
SELECT * FROM pokemon WHERE nombre = 'Blastoise';

-- Paso 3
SELECT altura FROM pokemon WHERE nombre = 'Blastoise';
COMMIT;