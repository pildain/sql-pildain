# ************************************************************
# Sequel Pro SQL dump
# Version 5446
#
# https://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 8.0.28)
# Database: Cine
# Generation Time: 2022-05-23 15:53:24 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table funciones
# ------------------------------------------------------------

LOCK TABLES `funciones` WRITE;
/*!40000 ALTER TABLE `funciones` DISABLE KEYS */;

INSERT INTO `funciones` (`id_pelicula`, `id_sala`, `hora_inicio_funcion`)
VALUES
	(5,1,'2022-05-07 20:00:00'),
	(6,2,'2022-05-07 20:00:00'),
	(7,3,'2022-05-07 20:00:00'),
	(5,4,'2022-05-07 20:00:00'),
	(6,5,'2022-05-07 20:00:00'),
	(7,6,'2022-05-07 20:00:00'),
	(5,7,'2022-05-07 20:00:00'),
	(6,8,'2022-05-07 20:00:00'),
	(7,9,'2022-05-07 20:00:00'),
	(5,10,'2022-05-07 20:00:00'),
	(6,11,'2022-05-07 20:00:00'),
	(7,12,'2022-05-07 20:00:00'),
	(5,13,'2022-05-07 20:00:00'),
	(6,14,'2022-05-07 20:00:00'),
	(7,15,'2022-05-07 20:00:00');

/*!40000 ALTER TABLE `funciones` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table funciones_en_palermo
# ------------------------------------------------------------



# Dump of table funciones_en_recoleta
# ------------------------------------------------------------



# Dump of table generos
# ------------------------------------------------------------

LOCK TABLES `generos` WRITE;
/*!40000 ALTER TABLE `generos` DISABLE KEYS */;

INSERT INTO `generos` (`id_genero`, `nombre_genero`)
VALUES
	(1,'Drama'),
	(2,'Comedia'),
	(3,'Romance'),
	(4,'Acción'),
	(5,'Ciencia ficción'),
	(6,'Fantasía'),
	(7,'Comedia romántica'),
	(8,'Infantil'),
	(9,'terror'),
	(10,'suspenso');

/*!40000 ALTER TABLE `generos` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table peliculas
# ------------------------------------------------------------

LOCK TABLES `peliculas` WRITE;
/*!40000 ALTER TABLE `peliculas` DISABLE KEYS */;

INSERT INTO `peliculas` (`id_pelicula`, `nombre_pelicula`, `id_genero`, `clasificacion`, `Duración en minutos`, `fecha_ingreso_cartelera`, `fecha_salida_cartelera`)
VALUES
	(1,'El Rey León',8,'ATP',89,'2021-10-01','2021-10-20'),
	(2,'El Señor De Los Anillos: La Comunidad Del Anillo',6,'+13',178,'2021-06-10','2021-06-30'),
	(3,'El Señor De Los Anillos: Las Dos Torres',6,'+13',179,'2021-06-10','2021-06-30'),
	(4,'El Señor De Los Anillos: El Retorno Del Rey',6,'+13',201,'2021-06-10','2021-06-30'),
	(5,'El Conjuro',9,'+16',112,'2022-05-01',NULL),
	(6,'Duro De Matar',4,'+16',132,'2022-05-01',NULL),
	(7,'Encanto',8,'ATP',109,'2022-05-01',NULL);

/*!40000 ALTER TABLE `peliculas` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table peliculas_en_cartelera
# ------------------------------------------------------------



# Dump of table peliculas_fuera_de_cartelera
# ------------------------------------------------------------



# Dump of table peliculas_infantiles
# ------------------------------------------------------------



# Dump of table salas
# ------------------------------------------------------------

LOCK TABLES `salas` WRITE;
/*!40000 ALTER TABLE `salas` DISABLE KEYS */;

INSERT INTO `salas` (`id_sala`, `nombre_sala`, `id_sucursal`)
VALUES
	(1,'Recoleta sala 1',1),
	(2,'Recoleta sala 2',1),
	(3,'Recoleta sala 3',1),
	(4,'Palermo sala 1',2),
	(5,'Palermo sala 2',2),
	(6,'Palermo sala 3',2),
	(7,'Abasto sala 1',3),
	(8,'Abasto sala 2',3),
	(9,'Abasto sala 3',3),
	(10,'Caballito sala 1',4),
	(11,'Caballito sala 2',4),
	(12,'Caballito sala 3',4),
	(13,'Belgrano sala 1',5),
	(14,'Belgrano sala 2',5),
	(15,'Belgrano sala 3',5);

/*!40000 ALTER TABLE `salas` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table Sucursales
# ------------------------------------------------------------

LOCK TABLES `Sucursales` WRITE;
/*!40000 ALTER TABLE `Sucursales` DISABLE KEYS */;

INSERT INTO `Sucursales` (`id_sucursal`, `nombre_sucursal`)
VALUES
	(1,'Recoleta'),
	(2,'Palermo'),
	(3,'Abasto'),
	(4,'Caballito'),
	(5,'Belgrano');

/*!40000 ALTER TABLE `Sucursales` ENABLE KEYS */;
UNLOCK TABLES;




# Replace placeholder table for funciones_en_recoleta with correct view syntax
# ------------------------------------------------------------

DROP TABLE `funciones_en_recoleta`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `funciones_en_recoleta`
AS SELECT
   `peliculas`.`nombre_pelicula` AS `nombre_pelicula`,
   `salas`.`nombre_sala` AS `nombre_sala`,
   `funciones`.`hora_inicio_funcion` AS `hora_inicio_funcion`
FROM ((`funciones` join `peliculas` on((`funciones`.`id_pelicula` = `peliculas`.`id_pelicula`))) join `salas` on((`funciones`.`id_sala` = `salas`.`id_sala`))) where (`salas`.`id_sucursal` = 1);


# Replace placeholder table for funciones_en_palermo with correct view syntax
# ------------------------------------------------------------

DROP TABLE `funciones_en_palermo`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `funciones_en_palermo`
AS SELECT
   `peliculas`.`nombre_pelicula` AS `nombre_pelicula`,
   `salas`.`nombre_sala` AS `nombre_sala`,
   `funciones`.`hora_inicio_funcion` AS `hora_inicio_funcion`
FROM ((`funciones` join `peliculas` on((`funciones`.`id_pelicula` = `peliculas`.`id_pelicula`))) join `salas` on((`funciones`.`id_sala` = `salas`.`id_sala`))) where (`salas`.`id_sucursal` = 2);


# Replace placeholder table for peliculas_fuera_de_cartelera with correct view syntax
# ------------------------------------------------------------

DROP TABLE `peliculas_fuera_de_cartelera`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `peliculas_fuera_de_cartelera`
AS SELECT
   `peliculas`.`nombre_pelicula` AS `nombre_pelicula`
FROM `peliculas` where (`peliculas`.`fecha_salida_cartelera` is not null);


# Replace placeholder table for peliculas_infantiles with correct view syntax
# ------------------------------------------------------------

DROP TABLE `peliculas_infantiles`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `peliculas_infantiles`
AS SELECT
   `peliculas`.`nombre_pelicula` AS `nombre_pelicula`
FROM `peliculas` where (`peliculas`.`id_genero` = 8);


# Replace placeholder table for peliculas_en_cartelera with correct view syntax
# ------------------------------------------------------------

DROP TABLE `peliculas_en_cartelera`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `peliculas_en_cartelera`
AS SELECT
   `peliculas`.`nombre_pelicula` AS `nombre_pelicula`
FROM `peliculas` where (`peliculas`.`fecha_salida_cartelera` is null);

--
-- Dumping routines (PROCEDURE) for database 'Cine'
--
DELIMITER ;;

DELIMITER ;

--
-- Dumping routines (FUNCTION) for database 'Cine'
--
DELIMITER ;;

DELIMITER ;

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
