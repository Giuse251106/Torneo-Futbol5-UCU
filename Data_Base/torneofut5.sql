
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Estructura de tabla para `cancha`

DROP TABLE IF EXISTS `cancha`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cancha` (
  `nombre_cancha` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_complejo` int NOT NULL,
  `superficie` enum('sintetico','parquet') COLLATE utf8mb4_unicode_ci NOT NULL,
  `techada` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`nombre_cancha`,`id_complejo`),
  KEY `id_complejo` (`id_complejo`),
  CONSTRAINT `cancha_ibfk_1` FOREIGN KEY (`id_complejo`) REFERENCES `complejo` (`id_complejo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `cancha` WRITE;
/*!40000 ALTER TABLE `cancha` DISABLE KEYS */;
INSERT INTO `cancha` VALUES ('Cancha 1',1,'sintetico',0),('Cancha 1',2,'parquet',1),('Cancha 2',1,'sintetico',1);
/*!40000 ALTER TABLE `cancha` ENABLE KEYS */;
UNLOCK TABLES;

-- Estructura de tabla para `complejo`

DROP TABLE IF EXISTS `complejo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `complejo` (
  `id_complejo` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `direccion` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `departamento` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_complejo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


LOCK TABLES `complejo` WRITE;
/*!40000 ALTER TABLE `complejo` DISABLE KEYS */;
INSERT INTO `complejo` VALUES (1,'Complejo Deportivo Campus','Av. 8 de Octubre 2738','Montevideo'),(2,'Fútbol 5 Pocitos','Bulevar España 2150','Montevideo');
/*!40000 ALTER TABLE `complejo` ENABLE KEYS */;
UNLOCK TABLES;

-- Estructura de tabla para `equipo`

DROP TABLE IF EXISTS `equipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipo` (
  `id_equipo` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_torneo` int NOT NULL,
  `id_facultad` int NOT NULL,
  `ci_capitan` int DEFAULT NULL,
  PRIMARY KEY (`id_equipo`),
  UNIQUE KEY `id_equipo` (`id_equipo`,`id_torneo`),
  UNIQUE KEY `nombre` (`nombre`,`id_torneo`),
  KEY `id_torneo` (`id_torneo`),
  KEY `id_facultad` (`id_facultad`),
  KEY `fk_equipo_capitan` (`ci_capitan`,`id_torneo`),
  CONSTRAINT `equipo_ibfk_1` FOREIGN KEY (`id_torneo`) REFERENCES `torneo` (`id_torneo`),
  CONSTRAINT `equipo_ibfk_2` FOREIGN KEY (`id_facultad`) REFERENCES `facultad` (`id_facultad`),
  CONSTRAINT `fk_equipo_capitan` FOREIGN KEY (`ci_capitan`, `id_torneo`) REFERENCES `equipo_jugador_torneo` (`ci_jugador`, `id_torneo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


LOCK TABLES `equipo` WRITE;
/*!40000 ALTER TABLE `equipo` DISABLE KEYS */;
INSERT INTO `equipo` VALUES (1,'Ingeniería FC',1,1,4000001),(2,'Los Abogados',1,2,4100001),(3,'Empresariales United',1,3,4200001),(4,'Psico Sport',1,4,4300001);
/*!40000 ALTER TABLE `equipo` ENABLE KEYS */;
UNLOCK TABLES;

-- Estructura de tabla para `equipo_jugador_torneo`

DROP TABLE IF EXISTS `equipo_jugador_torneo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipo_jugador_torneo` (
  `id_equipo` int NOT NULL,
  `ci_jugador` int NOT NULL,
  `id_torneo` int NOT NULL,
  `numero_camiseta` int NOT NULL,
  PRIMARY KEY (`ci_jugador`,`id_torneo`),
  UNIQUE KEY `id_equipo` (`id_equipo`,`numero_camiseta`),
  KEY `id_equipo_2` (`id_equipo`,`id_torneo`),
  CONSTRAINT `equipo_jugador_torneo_ibfk_1` FOREIGN KEY (`id_equipo`, `id_torneo`) REFERENCES `equipo` (`id_equipo`, `id_torneo`),
  CONSTRAINT `equipo_jugador_torneo_ibfk_2` FOREIGN KEY (`ci_jugador`) REFERENCES `jugador` (`ci`),
  CONSTRAINT `chk_camiseta` CHECK ((`numero_camiseta` between 1 and 99))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `equipo_jugador_torneo` WRITE;
/*!40000 ALTER TABLE `equipo_jugador_torneo` DISABLE KEYS */;
INSERT INTO `equipo_jugador_torneo` VALUES (1,4000001,1,1),(1,4000005,1,4),(1,4000004,1,5),(1,4000002,1,7),(1,4000003,1,9),(1,4000006,1,11),(2,4100006,1,1),(2,4100005,1,3),(2,4100004,1,5),(2,4100002,1,7),(2,4100003,1,9),(2,4100001,1,10),(3,4200006,1,1),(3,4200005,1,2),(3,4200004,1,4),(3,4200002,1,8),(3,4200003,1,9),(3,4200001,1,10),(4,4300006,1,1),(4,4300005,1,3),(4,4300004,1,5),(4,4300003,1,6),(4,4300002,1,7),(4,4300001,1,10);
/*!40000 ALTER TABLE `equipo_jugador_torneo` ENABLE KEYS */;
UNLOCK TABLES;

-- Estructura de tabla para `facultad`

DROP TABLE IF EXISTS `facultad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facultad` (
  `id_facultad` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_facultad`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `facultad` WRITE;
/*!40000 ALTER TABLE `facultad` DISABLE KEYS */;
INSERT INTO `facultad` VALUES (3,'Ciencias Empresariales'),(5,'Comunicación'),(2,'Derecho'),(1,'Ingeniería y Tecnologías'),(4,'Psicología');
/*!40000 ALTER TABLE `facultad` ENABLE KEYS */;
UNLOCK TABLES;

-- Estructura de tabla para `gol`

DROP TABLE IF EXISTS `gol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gol` (
  `id_gol` int NOT NULL AUTO_INCREMENT,
  `id_partido` int NOT NULL,
  `ci_jugador` int NOT NULL,
  `minuto` int NOT NULL,
  `autogol` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_gol`),
  KEY `id_partido` (`id_partido`,`ci_jugador`),
  CONSTRAINT `gol_ibfk_1` FOREIGN KEY (`id_partido`, `ci_jugador`) REFERENCES `planilla_partido` (`id_partido`, `ci_jugador`),
  CONSTRAINT `chk_gol_minuto` CHECK ((`minuto` between 0 and 60))
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


LOCK TABLES `gol` WRITE;
/*!40000 ALTER TABLE `gol` DISABLE KEYS */;
INSERT INTO `gol` VALUES (1,1,4000001,12,0),(2,1,4000002,33,0),(3,1,4100001,40,0),(4,2,4200001,20,0),(5,2,4300001,48,0),(6,3,4200001,10,0),(7,3,4000004,55,1),(8,4,4100001,5,0),(9,4,4100003,18,0),(10,4,4300002,30,0),(11,4,4100001,44,0),(12,4,4300001,52,0),(13,6,4100002,29,0),(14,6,4200003,38,0);
/*!40000 ALTER TABLE `gol` ENABLE KEYS */;
UNLOCK TABLES;

-- Estructura de tabla para `jugador`

DROP TABLE IF EXISTS `jugador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jugador` (
  `ci` int NOT NULL,
  `nombre` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellido` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `id_facultad` int NOT NULL,
  `tipo` enum('grado','posgrado','docente','funcionario') COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`ci`),
  UNIQUE KEY `email` (`email`),
  KEY `id_facultad` (`id_facultad`),
  CONSTRAINT `jugador_ibfk_1` FOREIGN KEY (`id_facultad`) REFERENCES `facultad` (`id_facultad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `jugador` WRITE;
/*!40000 ALTER TABLE `jugador` DISABLE KEYS */;
INSERT INTO `jugador` VALUES (4000001,'Martín','Pereira','martin.pereira@ucu.edu.uy','2003-02-14',1,'grado'),(4000002,'Lucas','Techera','lucas.techera@ucu.edu.uy','2002-07-30',1,'grado'),(4000003,'Diego','Rodríguez','diego.rodriguez@ucu.edu.uy','2001-11-05',1,'grado'),(4000004,'Santiago','Fagúndez','santiago.fagundez@ucu.edu.uy','1998-04-22',1,'posgrado'),(4000005,'Andrés','Mazzini','andres.mazzini@ucu.edu.uy','1985-09-10',1,'docente'),(4000006,'Joaquín','Silva','joaquin.silva@ucu.edu.uy','2004-01-18',1,'grado'),(4100001,'Nicolás','Acosta','nicolas.acosta@ucu.edu.uy','2002-03-09',2,'grado'),(4100002,'Facundo','Benítez','facundo.benitez@ucu.edu.uy','2003-06-25',2,'grado'),(4100003,'Mateo','Cabrera','mateo.cabrera@ucu.edu.uy','2001-12-01',2,'grado'),(4100004,'Bruno','Delgado','bruno.delgado@ucu.edu.uy','2002-08-17',2,'grado'),(4100005,'Ricardo','Estévez','ricardo.estevez@ucu.edu.uy','1980-05-12',2,'funcionario'),(4100006,'Tomás','Ferreira','tomas.ferreira@ucu.edu.uy','1997-10-03',2,'posgrado'),(4200001,'Agustín','Gómez','agustin.gomez@ucu.edu.uy','2003-01-27',3,'grado'),(4200002,'Emiliano','Herrera','emiliano.herrera@ucu.edu.uy','2002-09-14',3,'grado'),(4200003,'Franco','Iglesias','franco.iglesias@ucu.edu.uy','2001-05-20',3,'grado'),(4200004,'Gonzalo','Juárez','gonzalo.juarez@ucu.edu.uy','1996-02-08',3,'posgrado'),(4200005,'Ignacio','Long','ignacio.long@ucu.edu.uy','2004-07-11',3,'grado'),(4200006,'Marcelo','Mendoza','marcelo.mendoza@ucu.edu.uy','1978-12-30',3,'docente'),(4300001,'Pablo','Núñez','pablo.nunez@ucu.edu.uy','2002-04-04',4,'grado'),(4300002,'Rodrigo','Olivera','rodrigo.olivera@ucu.edu.uy','2003-10-19',4,'grado'),(4300003,'Sebastián','Píriz','sebastian.piriz@ucu.edu.uy','2001-08-23',4,'grado'),(4300004,'Valentín','Quiroga','valentin.quiroga@ucu.edu.uy','2002-11-29',4,'grado'),(4300005,'Walter','Rivero','walter.rivero@ucu.edu.uy','1983-03-15',4,'funcionario'),(4300006,'Héctor','Suárez','hector.suarez@ucu.edu.uy','1979-06-07',4,'docente'),(4400001,'Camila','Techera','camila.techera@ucu.edu.uy','2003-05-05',5,'grado'),(4400002,'Leonardo','Umpiérrez','leonardo.umpierrez@ucu.edu.uy','1981-09-21',5,'docente');
/*!40000 ALTER TABLE `jugador` ENABLE KEYS */;
UNLOCK TABLES;

-- Estructura de tabla para`login`

DROP TABLE IF EXISTS `login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `login` (
  `correo` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rol` enum('administrador','planillero') COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`correo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `login` WRITE;
/*!40000 ALTER TABLE `login` DISABLE KEYS */;
INSERT INTO `login` VALUES ('admin@ucu.edu.uy','$2b$12$REEMPLAZAR_POR_HASH_BCRYPT','administrador'),('planillero@ucu.edu.uy','$2b$12$REEMPLAZAR_POR_HASH_BCRYPT','planillero');
/*!40000 ALTER TABLE `login` ENABLE KEYS */;
UNLOCK TABLES;

-- Estructura de tabla para `partido`

DROP TABLE IF EXISTS `partido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `partido` (
  `id_partido` int NOT NULL AUTO_INCREMENT,
  `id_torneo` int NOT NULL,
  `numero_fecha` int NOT NULL,
  `id_equipo_local` int NOT NULL,
  `id_equipo_visitante` int NOT NULL,
  `dia` date NOT NULL,
  `id_turno` int NOT NULL,
  `nombre_cancha` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_complejo` int NOT NULL,
  `estado` enum('programado','jugado','postergado','cancelado') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'programado',
  `fecha_jugado` datetime DEFAULT NULL,
  PRIMARY KEY (`id_partido`),
  KEY `id_torneo` (`id_torneo`),
  KEY `id_equipo_local` (`id_equipo_local`,`id_torneo`),
  KEY `id_equipo_visitante` (`id_equipo_visitante`,`id_torneo`),
  KEY `id_turno` (`id_turno`),
  KEY `nombre_cancha` (`nombre_cancha`,`id_complejo`),
  CONSTRAINT `partido_ibfk_1` FOREIGN KEY (`id_torneo`) REFERENCES `torneo` (`id_torneo`),
  CONSTRAINT `partido_ibfk_2` FOREIGN KEY (`id_equipo_local`, `id_torneo`) REFERENCES `equipo` (`id_equipo`, `id_torneo`),
  CONSTRAINT `partido_ibfk_3` FOREIGN KEY (`id_equipo_visitante`, `id_torneo`) REFERENCES `equipo` (`id_equipo`, `id_torneo`),
  CONSTRAINT `partido_ibfk_4` FOREIGN KEY (`id_turno`) REFERENCES `turno` (`id_turno`),
  CONSTRAINT `partido_ibfk_5` FOREIGN KEY (`nombre_cancha`, `id_complejo`) REFERENCES `cancha` (`nombre_cancha`, `id_complejo`),
  CONSTRAINT `chk_partido_fecha` CHECK ((`numero_fecha` > 0)),
  CONSTRAINT `chk_partido_jugado` CHECK (((`estado` <> _utf8mb4'jugado') or (`fecha_jugado` is not null))),
  CONSTRAINT `chk_partido_rivales` CHECK ((`id_equipo_local` <> `id_equipo_visitante`))
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `partido` WRITE;
/*!40000 ALTER TABLE `partido` DISABLE KEYS */;
INSERT INTO `partido` VALUES (1,1,1,1,2,'2026-10-05',1,'Cancha 1',1,'jugado','2026-10-05 19:00:00'),(2,1,1,3,4,'2026-10-05',1,'Cancha 2',1,'jugado','2026-10-05 19:00:00'),(3,1,2,1,3,'2026-10-12',2,'Cancha 1',1,'jugado','2026-10-12 20:00:00'),(4,1,2,2,4,'2026-10-12',2,'Cancha 1',2,'jugado','2026-10-12 20:00:00'),(5,1,3,1,4,'2026-10-19',3,'Cancha 1',1,'cancelado',NULL),(6,1,3,2,3,'2026-10-19',3,'Cancha 1',2,'jugado','2026-10-19 21:00:00'),(7,1,4,1,4,'2026-11-09',4,'Cancha 2',1,'programado',NULL);
/*!40000 ALTER TABLE `partido` ENABLE KEYS */;
UNLOCK TABLES;

-- Estructura de tabla para `planilla_partido`

DROP TABLE IF EXISTS `planilla_partido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `planilla_partido` (
  `id_partido` int NOT NULL,
  `ci_jugador` int NOT NULL,
  `id_equipo` int NOT NULL,
  PRIMARY KEY (`id_partido`,`ci_jugador`),
  KEY `ci_jugador` (`ci_jugador`),
  KEY `id_equipo` (`id_equipo`),
  CONSTRAINT `planilla_partido_ibfk_1` FOREIGN KEY (`id_partido`) REFERENCES `partido` (`id_partido`),
  CONSTRAINT `planilla_partido_ibfk_2` FOREIGN KEY (`ci_jugador`) REFERENCES `jugador` (`ci`),
  CONSTRAINT `planilla_partido_ibfk_3` FOREIGN KEY (`id_equipo`) REFERENCES `equipo` (`id_equipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `planilla_partido` WRITE;
/*!40000 ALTER TABLE `planilla_partido` DISABLE KEYS */;
INSERT INTO `planilla_partido` VALUES (1,4000001,1),(1,4000002,1),(1,4000003,1),(1,4000004,1),(1,4000005,1),(3,4000001,1),(3,4000002,1),(3,4000004,1),(3,4000005,1),(3,4000006,1),(1,4100001,2),(1,4100002,2),(1,4100003,2),(1,4100004,2),(1,4100005,2),(4,4100001,2),(4,4100002,2),(4,4100003,2),(4,4100004,2),(4,4100005,2),(6,4100001,2),(6,4100002,2),(6,4100003,2),(6,4100004,2),(6,4100005,2),(2,4200001,3),(2,4200002,3),(2,4200003,3),(2,4200004,3),(2,4200005,3),(3,4200001,3),(3,4200002,3),(3,4200003,3),(3,4200004,3),(3,4200005,3),(6,4200001,3),(6,4200002,3),(6,4200003,3),(6,4200004,3),(6,4200005,3),(2,4300001,4),(2,4300002,4),(2,4300003,4),(2,4300004,4),(2,4300005,4),(4,4300001,4),(4,4300002,4),(4,4300003,4),(4,4300004,4),(4,4300005,4);
/*!40000 ALTER TABLE `planilla_partido` ENABLE KEYS */;
UNLOCK TABLES;

-- Estructura de tabla para `sancion_jugador`

DROP TABLE IF EXISTS `sancion_jugador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sancion_jugador` (
  `id_sancion` int NOT NULL AUTO_INCREMENT,
  `ci_jugador` int NOT NULL,
  `id_torneo` int NOT NULL,
  `motivo` enum('roja','acumulacion de amarillas','disciplinaria') COLLATE utf8mb4_unicode_ci NOT NULL,
  `numero_fecha_inicio` int NOT NULL,
  `cantidad_fechas` int NOT NULL,
  `id_tarjeta_origen` int DEFAULT NULL,
  PRIMARY KEY (`id_sancion`),
  KEY `ci_jugador` (`ci_jugador`),
  KEY `id_torneo` (`id_torneo`),
  KEY `id_tarjeta_origen` (`id_tarjeta_origen`),
  CONSTRAINT `sancion_jugador_ibfk_1` FOREIGN KEY (`ci_jugador`) REFERENCES `jugador` (`ci`),
  CONSTRAINT `sancion_jugador_ibfk_2` FOREIGN KEY (`id_torneo`) REFERENCES `torneo` (`id_torneo`),
  CONSTRAINT `sancion_jugador_ibfk_3` FOREIGN KEY (`id_tarjeta_origen`) REFERENCES `tarjeta` (`id_tarjeta`) ON DELETE CASCADE,
  CONSTRAINT `chk_sancion_cantidad` CHECK ((`cantidad_fechas` >= 1)),
  CONSTRAINT `chk_sancion_inicio` CHECK ((`numero_fecha_inicio` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `sancion_jugador` WRITE;
/*!40000 ALTER TABLE `sancion_jugador` DISABLE KEYS */;
INSERT INTO `sancion_jugador` VALUES (1,4000003,1,'roja',2,1,1),(2,4200002,1,'acumulacion de amarillas',4,1,7),(3,4300004,1,'disciplinaria',3,2,NULL);
/*!40000 ALTER TABLE `sancion_jugador` ENABLE KEYS */;
UNLOCK TABLES;

-- Estructura de tabla para `tarjeta`

DROP TABLE IF EXISTS `tarjeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tarjeta` (
  `id_tarjeta` int NOT NULL AUTO_INCREMENT,
  `id_partido` int NOT NULL,
  `ci_jugador` int NOT NULL,
  `minuto` int NOT NULL,
  `color` enum('amarilla','roja') COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_tarjeta`),
  KEY `id_partido` (`id_partido`,`ci_jugador`),
  CONSTRAINT `tarjeta_ibfk_1` FOREIGN KEY (`id_partido`, `ci_jugador`) REFERENCES `planilla_partido` (`id_partido`, `ci_jugador`),
  CONSTRAINT `chk_tarjeta_minuto` CHECK ((`minuto` between 0 and 60))
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `tarjeta` WRITE;
/*!40000 ALTER TABLE `tarjeta` DISABLE KEYS */;
INSERT INTO `tarjeta` VALUES (1,1,4000003,50,'roja'),(2,1,4100002,25,'amarilla'),(3,2,4200002,22,'amarilla'),(4,2,4300003,30,'amarilla'),(5,3,4200002,41,'amarilla'),(6,4,4100004,37,'amarilla'),(7,6,4200002,15,'amarilla');
/*!40000 ALTER TABLE `tarjeta` ENABLE KEYS */;
UNLOCK TABLES;

-- Estructura de tabla para `torneo`

DROP TABLE IF EXISTS `torneo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `torneo` (
  `id_torneo` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `anio` int NOT NULL,
  `semestre` int NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `estado` enum('inscripcion','en curso','finalizado') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'inscripcion',
  PRIMARY KEY (`id_torneo`),
  UNIQUE KEY `anio` (`anio`,`semestre`),
  CONSTRAINT `chk_torneo_fechas` CHECK ((`fecha_fin` >= `fecha_inicio`)),
  CONSTRAINT `chk_torneo_semestre` CHECK ((`semestre` in (1,2)))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `torneo` WRITE;
/*!40000 ALTER TABLE `torneo` DISABLE KEYS */;
INSERT INTO `torneo` VALUES (1,'Torneo Interfacultades 2026-2',2026,2,'2026-10-05','2026-12-18','en curso');
/*!40000 ALTER TABLE `torneo` ENABLE KEYS */;
UNLOCK TABLES;

-- Estructura de tabla para `turno`

DROP TABLE IF EXISTS `turno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `turno` (
  `id_turno` int NOT NULL AUTO_INCREMENT,
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL,
  PRIMARY KEY (`id_turno`),
  UNIQUE KEY `hora_inicio` (`hora_inicio`),
  CONSTRAINT `chk_turno_duracion` CHECK (((time_to_sec(`hora_fin`) - time_to_sec(`hora_inicio`)) = 3600)),
  CONSTRAINT `chk_turno_rango` CHECK (((`hora_inicio` >= _utf8mb4'18:00:00') and (`hora_fin` <= _utf8mb4'23:00:00')))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


LOCK TABLES `turno` WRITE;
/*!40000 ALTER TABLE `turno` DISABLE KEYS */;
INSERT INTO `turno` VALUES (1,'18:00:00','19:00:00'),(2,'19:00:00','20:00:00'),(3,'20:00:00','21:00:00'),(4,'21:00:00','22:00:00'),(5,'22:00:00','23:00:00');
/*!40000 ALTER TABLE `turno` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

