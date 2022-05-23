/*Obtención de la cantidad de películas en cartelera mediante la función creada para ello*/
SELECT cantidadPeliculasEnCartelera();
/*Creación de una función de El Rey León con el procedimiento crearFuncion. Esto deja constancia gracias al trigger de inserción*/
CALL crearFuncion (1, 5, "2022-05-21 19:00");
/*Obtención de los datos de la función previamente creada con la función datosFuncion*/
SELECT datosFuncion (1, 5, "2022-05-21 19:00");
/*Modificación de las funciones del Rey León, cambiándolas de la sala 2 de la sucursal de Palermo a la 1. Esto deja constancia gracias al trigger de modificación*/
UPDATE funciones
SET id_sala = 4
WHERE id_pelicula = 1;
/*Eliminación de El Rey León de cartelera con el procedimiento quitarDeCartelera. Esto deja constancia gracias al trigger de eliminación*/
CALL quitarDeCartelera (1);