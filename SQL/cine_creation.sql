# ************************************************************
# Sequel Pro SQL dump
# Version 5446
#
# https://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 8.0.28)
# Database: Cine
# Generation Time: 2022-05-23 14:45:27 +0000
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

/*Creación de triggers para inserción, eliminación y modificación de funciones. Los de inserción y eliminación dejan registro en la tabla log_auditoria_funciones, y los de modificación en la tabla log_modificacion_funciones*/
DELIMITER ;;
/*!50003 SET SESSION SQL_MODE="ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION" */;;
/*!50003 CREATE */ /*!50017 DEFINER=`root`@`localhost` */ /*!50003 TRIGGER `trg_log_insercion_funciones` AFTER INSERT ON `funciones` FOR EACH ROW BEGIN

INSERT INTO log_auditoria_funciones (id_pelicula,id_sala,hora_inicio_funcion, nombre_accion , usuario, fecha_accion)
VALUES ( NEW.id_pelicula ,NEW.ID_sala, NEW.hora_inicio_funcion, 'INSERT' , CURRENT_USER(), NOW());
END */;;
/*!50003 SET SESSION SQL_MODE="ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION" */;;
/*!50003 CREATE */ /*!50017 DEFINER=`root`@`localhost` */ /*!50003 TRIGGER `trg_log_modificacion_funciones` AFTER UPDATE ON `funciones` FOR EACH ROW BEGIN

INSERT INTO log_auditoria_modificacion_funciones (antiguo_id_pelicula , antiguo_id_sala , antigua_hora_inicio_funcion , nuevo_id_pelicula , nuevo_id_sala , nueva_hora_inicio_funcion , nombre_accion , usuario, fecha_accion)
VALUES ( OLD.id_pelicula ,OLD.ID_sala, OLD.hora_inicio_funcion, NEW.id_pelicula ,NEW.ID_sala, NEW.hora_inicio_funcion, 'UPDATE' , CURRENT_USER(), NOW());
END */;;
/*!50003 SET SESSION SQL_MODE="ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION" */;;
/*!50003 CREATE */ /*!50017 DEFINER=`root`@`localhost` */ /*!50003 TRIGGER `trg_log_eliminacion_funciones` BEFORE DELETE ON `funciones` FOR EACH ROW BEGIN

INSERT INTO log_auditoria_funciones (id_pelicula,id_sala,hora_inicio_funcion, nombre_accion , usuario, fecha_accion)
VALUES ( OLD.id_pelicula ,OLD.ID_sala, OLD.hora_inicio_funcion, 'DELETE' , CURRENT_USER(), NOW());
END */;;
DELIMITER ;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;


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



# Dump of table log_auditoria_funciones
# ------------------------------------------------------------

DROP TABLE IF EXISTS `log_auditoria_funciones`;

/*Creación de la tabla log_auditoria_funciones, usada para dejar constancia de la creación y eliminación de funciones*/
CREATE TABLE `log_auditoria_funciones` (
  `id_log` int NOT NULL AUTO_INCREMENT,
  `id_pelicula` int NOT NULL,
  `id_sala` int NOT NULL,
  `hora_inicio_funcion` datetime NOT NULL,
  `nombre_accion` varchar(10) DEFAULT NULL,
  `usuario` varchar(100) DEFAULT NULL,
  `fecha_accion` datetime DEFAULT NULL,
  PRIMARY KEY (`id_log`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



# Dump of table log_auditoria_modificacion_funciones
# ------------------------------------------------------------

DROP TABLE IF EXISTS `log_auditoria_modificacion_funciones`;

/*Creación de la tabla log_auditoria_modificacion_funciones, utilizada para dejar constancia de los cambios realizados a funciones existentes*/
CREATE TABLE `log_auditoria_modificacion_funciones` (
  `id_log` int NOT NULL AUTO_INCREMENT,
  `antiguo_id_pelicula` int NOT NULL,
  `antiguo_id_sala` int NOT NULL,
  `antigua_hora_inicio_funcion` datetime NOT NULL,
  `nuevo_id_pelicula` int NOT NULL,
  `nuevo_id_sala` int NOT NULL,
  `nueva_hora_inicio_funcion` datetime NOT NULL,
  `nombre_accion` varchar(10) DEFAULT NULL,
  `usuario` varchar(100) DEFAULT NULL,
  `fecha_accion` datetime DEFAULT NULL,
  PRIMARY KEY (`id_log`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



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



# Dump of table Sucursales
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Sucursales`;

/*Creación de la tabla sucursales, que guarda las distintas sucursales del cine*/
CREATE TABLE `Sucursales` (
  `id_sucursal` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre_sucursal` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id_sucursal`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;





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

--
-- Dumping routines (PROCEDURE) for database 'Cine'
--
DELIMITER ;;

/*Creación del procedimiento crearFuncion, sirve para crear una función rápidamente introduciendo el id de la película, el id de la sala y la hora de inicio*/
# Dump of PROCEDURE crearFuncion
# ------------------------------------------------------------

/*!50003 DROP PROCEDURE IF EXISTS `crearFuncion` */;;
/*!50003 SET SESSION SQL_MODE="ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `crearFuncion`(IN id_pelicula INT,IN id_sala INT,IN fecha_inicio_funcion DATETIME)
BEGIN 

INSERT INTO  funciones
 VALUES 

 (id_pelicula, id_sala, fecha_inicio_funcion);

END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
/*Creación del procedimiento quitarDeCartelera, sirve para quitar una película de cartelera eliminando todas sus funciones. Para llamarlo se introduce el id de la película*/
# Dump of PROCEDURE quitarDeCartelera
# ------------------------------------------------------------


/*!50003 DROP PROCEDURE IF EXISTS `quitarDeCartelera` */;;
/*!50003 SET SESSION SQL_MODE="ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `quitarDeCartelera`(IN id_pelicula INT)
BEGIN 

DELETE FROM funciones
WHERE (funciones.id_pelicula = id_pelicula);
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
DELIMITER ;

--
-- Dumping routines (FUNCTION) for database 'Cine'
--
DELIMITER ;;

/*Creación de la función cantidadPeliculasEnCartelera, devuelve la cantidad de películas en cartelera*/
# Dump of FUNCTION cantidadPeliculasEnCartelera
# ------------------------------------------------------------

/*!50003 DROP FUNCTION IF EXISTS `cantidadPeliculasEnCartelera` */;;
/*!50003 SET SESSION SQL_MODE="ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 FUNCTION `cantidadPeliculasEnCartelera`() RETURNS int
    DETERMINISTIC
BEGIN
DECLARE peliculasCartelera INT;
SELECT COUNT(*) INTO peliculasCartelera FROM peliculas WHERE (peliculas.fecha_salida_cartelera is null);
RETURN peliculasCartelera;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of FUNCTION datosFuncion
# ------------------------------------------------------------

/*Creación de la función datosFuncion, utilizada para obtener los datos de una función (nombre de la película, de la sala y hora de inicio). Para llamarla se introducen el id de la película, de la sala y la hora de inicio*/
/*!50003 DROP FUNCTION IF EXISTS `datosFuncion` */;;
/*!50003 SET SESSION SQL_MODE="ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 FUNCTION `datosFuncion`(id_pelicula INT, id_sala INT, hora_inicio_funcion DATETIME) RETURNS varchar(150) CHARSET utf8mb4
    DETERMINISTIC
BEGIN 

DECLARE FUNCION VARCHAR (250);
SELECT CONCAT (peliculas.nombre_pelicula, ", ", salas.nombre_sala, ", ", funciones.hora_inicio_funcion) INTO funcion FROM
funciones INNER JOIN salas ON funciones.id_sala = salas.id_sala INNER JOIN peliculas ON funciones.id_pelicula = peliculas.id_pelicula WHERE (funciones.id_pelicula = id_pelicula AND funciones.id_sala = id_sala AND funciones.hora_inicio_funcion = hora_inicio_funcion);
RETURN funcion;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
DELIMITER ;

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
