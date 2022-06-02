SET autocommit = 0;
START TRANSACtION;
INSERT INTO sucursales (nombre_sucursal)
VALUES
("Córdoba"),
("Rosario"),
("San Luis"),
("Mar del Plata");
/*ROLLBACK;*/
COMMIT;

STARt TRANSACTION;
CALL crearFuncion (1, 5, "2022-05-31 20:00");
CALL crearFuncion (1, 6, "2022-05-31 20:00");
CALL crearFuncion (1, 7, "2022-05-31 20:00");
CALL crearFuncion (1, 8, "2022-05-31 20:00");
SAVEPOINT primeros_4;
CALL crearFuncion (2, 9, "2022-05-31 20:00");
CALL crearFuncion (2, 10, "2022-05-31 20:00");
CALL crearFuncion (2, 11, "2022-05-31 20:00");
CALL crearFuncion (2, 12, "2022-05-31 20:00");
SAVEPOINT segundos_4;
ROLLBACK TO primeros_4;
CALL quitarDeCartelera (1);
COMMIT;
