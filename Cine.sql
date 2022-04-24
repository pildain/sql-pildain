# ************************************************************
# Sequel Pro SQL dump
# Version 5446
#
# https://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 8.0.28)
# Database: Cine
# Generation Time: 2022-04-24 02:25:34 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table Sucursales
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Sucursales`;
/*Creación de la tabla sucursales, que guarda las distintas sucursales del cine*/
CREATE TABLE `Sucursales` (
  `id_sucursal` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre_sucursal` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`id_sucursal`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



# Dump of table funciones
# ------------------------------------------------------------

/*Creación de la tabla funciones, que registra las distintas funciones del cine. Esta es la tabla más compleja del esquema, cuya clave primaria en vez de ser un ID es una clave concatenada formada por la película, la sala y la hora de inicio de la función. Se relaciona con las tablas sala y película*/
CREATE TABLE `funciones` (
  `id_pelicula` int unsigned NOT NULL,
  `id_sala` int unsigned NOT NULL,
  `hora_inicio_funcion` datetime NOT NULL,
  `hora_fin_funcion` datetime DEFAULT NULL,
  PRIMARY KEY (`id_pelicula`,`id_sala`,`hora_inicio_funcion`),
  KEY `función-sala` (`id_sala`),
  CONSTRAINT `función-película` FOREIGN KEY (`id_pelicula`) REFERENCES `peliculas` (`id_pelicula`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `función-sala` FOREIGN KEY (`id_sala`) REFERENCES `salas` (`id_sala`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



# Dump of table generos
# ------------------------------------------------------------

/*Creación de la tabla géneros, que guarda los distintos géneros identificados con un ID*/
CREATE TABLE `generos` (
  `id_genero` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre_genero` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`id_genero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



# Dump of table peliculas
# ------------------------------------------------------------

/*Creación de la tabla películas, que guarda los datos de las distintas películas en el cine (nombre, clasificación, fecha de ingreso y salida de cartelera, género) Se relaciona con la tabla géneros mediante el ID de género*/
CREATE TABLE `peliculas` (
  `id_pelicula` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre_pelicula` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `id_genero` int unsigned DEFAULT NULL,
  `clasificacion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `fecha_ingreso_cartelera` date DEFAULT NULL,
  `fecha_salida_cartelera` date DEFAULT NULL,
  PRIMARY KEY (`id_pelicula`),
  KEY `género-película` (`id_genero`),
  CONSTRAINT `género-película` FOREIGN KEY (`id_genero`) REFERENCES `generos` (`id_genero`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



# Dump of table salas
# ------------------------------------------------------------

/*Creación de la tabla salas, que guarda las distintas salas del cine. Cada sala pertenece a una sucursal, por lo que se relaciona con esa tabla*/
CREATE TABLE `salas` (
  `id_sala` int unsigned NOT NULL,
  `nombre_sala` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `id_sucursal` int unsigned NOT NULL,
  PRIMARY KEY (`id_sala`),
  KEY `sala-sucursal` (`id_sucursal`),
  CONSTRAINT `sala-sucursal` FOREIGN KEY (`id_sucursal`) REFERENCES `Sucursales` (`id_sucursal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
