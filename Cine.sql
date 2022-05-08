# ************************************************************
# Sequel Pro SQL dump
# Version 5446
#
# https://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 8.0.28)
# Database: Cine
# Generation Time: 2022-05-08 02:59:24 +0000
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

DROP TABLE IF EXISTS `funciones`;

/*Creación de la tabla funciones, que registra las distintas funciones del cine. Esta es la tabla más compleja del esquema, cuya clave primaria en vez de ser un ID es una clave concatenada formada por la película, la sala y la hora de inicio de la función. Se relaciona con las tablas sala y película*/
CREATE TABLE `funciones` (
  `id_pelicula` int unsigned NOT NULL,
  `id_sala` int unsigned NOT NULL,
  `hora_inicio_funcion` datetime NOT NULL,
  PRIMARY KEY (`id_pelicula`,`id_sala`,`hora_inicio_funcion`),
  KEY `función-sala` (`id_sala`),
  CONSTRAINT `función-película` FOREIGN KEY (`id_pelicula`) REFERENCES `peliculas` (`id_pelicula`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `función-sala` FOREIGN KEY (`id_sala`) REFERENCES `salas` (`id_sala`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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

DROP VIEW IF EXISTS `funciones_en_palermo`;

CREATE TABLE `funciones_en_palermo` (
   `nombre_pelicula` VARCHAR(200) NULL DEFAULT '',
   `nombre_sala` VARCHAR(50) NULL DEFAULT '',
   `hora_inicio_funcion` DATETIME NOT NULL
) ENGINE=MyISAM;



# Dump of table funciones_en_recoleta
# ------------------------------------------------------------

DROP VIEW IF EXISTS `funciones_en_recoleta`;

CREATE TABLE `funciones_en_recoleta` (
   `nombre_pelicula` VARCHAR(200) NULL DEFAULT '',
   `nombre_sala` VARCHAR(50) NULL DEFAULT '',
   `hora_inicio_funcion` DATETIME NOT NULL
) ENGINE=MyISAM;



# Dump of table generos
# ------------------------------------------------------------

DROP TABLE IF EXISTS `generos`;

/*Creación de la tabla géneros, que guarda los distintos géneros identificados con un ID*/
CREATE TABLE `generos` (
  `id_genero` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre_genero` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '',
  PRIMARY KEY (`id_genero`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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

DROP TABLE IF EXISTS `peliculas`;

/*Creación de la tabla películas, que guarda los datos de las distintas películas en el cine (nombre, clasificación, duración en minutos, fecha de ingreso y salida de cartelera, género) Se relaciona con la tabla géneros mediante el ID de género*/
CREATE TABLE `peliculas` (
  `id_pelicula` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre_pelicula` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '',
  `id_genero` int unsigned DEFAULT NULL,
  `clasificacion` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '',
  `Duración en minutos` int DEFAULT NULL,
  `fecha_ingreso_cartelera` date DEFAULT NULL,
  `fecha_salida_cartelera` date DEFAULT NULL,
  PRIMARY KEY (`id_pelicula`),
  KEY `género-película` (`id_genero`),
  CONSTRAINT `género-película` FOREIGN KEY (`id_genero`) REFERENCES `generos` (`id_genero`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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

DROP VIEW IF EXISTS `peliculas_en_cartelera`;

CREATE TABLE `peliculas_en_cartelera` (
   `nombre_pelicula` VARCHAR(200) NULL DEFAULT ''
) ENGINE=MyISAM;



# Dump of table peliculas_fuera_de_cartelera
# ------------------------------------------------------------

DROP VIEW IF EXISTS `peliculas_fuera_de_cartelera`;

CREATE TABLE `peliculas_fuera_de_cartelera` (
   `nombre_pelicula` VARCHAR(200) NULL DEFAULT ''
) ENGINE=MyISAM;



# Dump of table peliculas_infantiles
# ------------------------------------------------------------

DROP VIEW IF EXISTS `peliculas_infantiles`;

CREATE TABLE `peliculas_infantiles` (
   `nombre_pelicula` VARCHAR(200) NULL DEFAULT ''
) ENGINE=MyISAM;



# Dump of table salas
# ------------------------------------------------------------

DROP TABLE IF EXISTS `salas`;

/*Creación de la tabla salas, que guarda las distintas salas del cine. Cada sala pertenece a una sucursal, por lo que se relaciona con esa tabla*/
CREATE TABLE `salas` (
  `id_sala` int unsigned NOT NULL,
  `nombre_sala` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '',
  `id_sucursal` int unsigned NOT NULL,
  PRIMARY KEY (`id_sala`),
  KEY `sala-sucursal` (`id_sucursal`),
  CONSTRAINT `sala-sucursal` FOREIGN KEY (`id_sucursal`) REFERENCES `Sucursales` (`id_sucursal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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

DROP TABLE IF EXISTS `Sucursales`;

/*Creación de la tabla sucursales, que guarda las distintas sucursales del cine*/
CREATE TABLE `Sucursales` (
  `id_sucursal` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre_sucursal` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id_sucursal`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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

/*Creación de vista que muestra todas las funciones en la sucursal de Recoleta*/
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `funciones_en_recoleta`
AS SELECT
   `peliculas`.`nombre_pelicula` AS `nombre_pelicula`,
   `salas`.`nombre_sala` AS `nombre_sala`,
   `funciones`.`hora_inicio_funcion` AS `hora_inicio_funcion`
FROM ((`funciones` join `peliculas` on((`funciones`.`id_pelicula` = `peliculas`.`id_pelicula`))) join `salas` on((`funciones`.`id_sala` = `salas`.`id_sala`))) where (`salas`.`id_sucursal` = 1);


# Replace placeholder table for funciones_en_palermo with correct view syntax
# ------------------------------------------------------------

DROP TABLE `funciones_en_palermo`;

/*Creación de vista que muestra todas las funciones en la sucursal de Palermo*/
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `funciones_en_palermo`
AS SELECT
   `peliculas`.`nombre_pelicula` AS `nombre_pelicula`,
   `salas`.`nombre_sala` AS `nombre_sala`,
   `funciones`.`hora_inicio_funcion` AS `hora_inicio_funcion`
FROM ((`funciones` join `peliculas` on((`funciones`.`id_pelicula` = `peliculas`.`id_pelicula`))) join `salas` on((`funciones`.`id_sala` = `salas`.`id_sala`))) where (`salas`.`id_sucursal` = 2);


# Replace placeholder table for peliculas_fuera_de_cartelera with correct view syntax
# ------------------------------------------------------------

DROP TABLE `peliculas_fuera_de_cartelera`;

/*Creación de vista que muestra todas las películas que están fuera de cartelera*/
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `peliculas_fuera_de_cartelera`
AS SELECT
   `peliculas`.`nombre_pelicula` AS `nombre_pelicula`
FROM `peliculas` where (`peliculas`.`fecha_salida_cartelera` is not null);


# Replace placeholder table for peliculas_infantiles with correct view syntax
# ------------------------------------------------------------

DROP TABLE `peliculas_infantiles`;

/*Creación de vista que muestra todas las películas infantiles*/
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `peliculas_infantiles`
AS SELECT
   `peliculas`.`nombre_pelicula` AS `nombre_pelicula`
FROM `peliculas` where (`peliculas`.`id_genero` = 8);


# Replace placeholder table for peliculas_en_cartelera with correct view syntax
# ------------------------------------------------------------

DROP TABLE `peliculas_en_cartelera`;

/*Creación de vista que muestra todas las películas que están en cartelera*/
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `peliculas_en_cartelera`
AS SELECT
   `peliculas`.`nombre_pelicula` AS `nombre_pelicula`
FROM `peliculas` where (`peliculas`.`fecha_salida_cartelera` is null);

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
