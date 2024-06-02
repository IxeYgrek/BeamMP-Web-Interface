-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: localhost    Database: gaming
-- ------------------------------------------------------
-- Server version	8.0.36-0ubuntu0.22.04.1

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

--
-- Table structure for table `beamng_mod`
--

DROP TABLE IF EXISTS `beamng_mod`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `beamng_mod` (
  `nom` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `chemin` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `image` varchar(255) NOT NULL,
  `preview` varchar(255) DEFAULT NULL,
  `id_beamng` varchar(255) NOT NULL,
  `map_active` tinyint DEFAULT NULL,
  `map_officielle` tinyint DEFAULT NULL,
  `mod_actif` tinyint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `beamng_mod`
--

LOCK TABLES `beamng_mod` WRITE;
/*!40000 ALTER TABLE `beamng_mod` DISABLE KEYS */;
INSERT INTO `beamng_mod` VALUES ('Automation Test Track','Testbereich Automation: Ein Asphaltkreis. 1 Sircuit Erde. Neigungsprüfungen...','map','','/beamng/image_map/image_automation_test_track.jpg','','automation_test_track',0,1,0),('Derby','Mehrere Arenen für Abriss-Derbys und Rennen auf einer in der texanischen Landschaft gebauten Erdpiste.','map','','/beamng/image_map/image_derby.jpg','','derby',0,1,0),('ETK-Pilotenausbildungszentrum','Ein modernes Trainingszentrum für Piloten, das sich in Deutschland befindet.','map','','/beamng/image_map/image_driver_training.jpg','','driver_training',1,1,0),('Ostküste, USA','Ein Überblick über die Ostküste der USA. Stark inspiriert von den Bundesstaaten Maine und New Hampshire.','map','','/beamng/image_map/image_east_coast_usa.jpg','','east_coast_usa',0,1,0),('Gridmap v2','Ein surreales Testgelände mit mehreren Hindernissen, Sprungrampen und Testobjekten.','map','','/beamng/image_map/image_gridmap_v2.jpg','','gridmap_v2',0,1,0),('Hirochi Stromkreis','Die Hirochi-Strecke ist eine neu gestaltete historische Rennstrecke an der Ostküste der USA.','map','','/beamng/image_map/image_hirochi_raceway.jpg','','hirochi_raceway',0,1,0),('Industrieller Standort','Ein Küstengebiet mit einem Industriegebiet, mehreren kleinen Rennstrecken und Feldern.','map','','/beamng/image_map/image_industrial.jpg','','industrial',0,1,0),('Italien','Eine kleine italienische Insel mit einer wunderschönen Küste, Dörfern und Weinbergen.','map','','/beamng/image_map/image_italy.jpg','','italy',0,1,0),('Johnson Valley','Dieses trockene, steinige Tal östlich von Los Angeles bietet einen Raum für Offroad-Fahrten, der eine buschige Ebene, einen felsigen Berg und hohe Dünen umfasst.','map','','/beamng/image_map/image_johnson_valley.jpg','','johnson_valley',0,1,0),('Dschungel-Felseninsel','Diese tropische Insel im Pazifik hat eine dichte Vegetation und viele Pfade und Straßen, die es zu erkunden gilt.','map','','/beamng/image_map/image_jungle_rock_island.jpg','','jungle_rock_island',0,1,0),('Kleines Gitter','Ein leeres Raster, so weit das Auge reicht','map','','/beamng/image_map/image_smallgrid.jpg','','smallgrid',0,1,0),('Kleine Insel','Diese kleine Insel vor der Küste Kaliforniens verfügt über wenig Infrastruktur, hat aber eine lustige kleine Küstenstraße und viel offenes Land, das es zu erkunden gilt!','map','','/beamng/image_map/image_small_island.jpg','','small_island',0,1,0),('Utah, USA','Die Canyons von Utah machen sie zu einem wahren Fahrparadies. Rase über gut ausgebaute Asphaltstraßen, mache dein Auto bei Offroad-Rallyes schmutzig oder stürze dich in die Felsen der Canyons.','map','','/beamng/image_map/image_utah.jpg','','utah',0,1,0),('Westküste, USA','Erkunden Sie die Westküste der USA. Stellvertretend für verschiedene kalifornische Orte.','map','','/beamng/image_map/image_west_coast_usa.jpg','','west_coast_usa',0,1,0);
/*!40000 ALTER TABLE `beamng_mod` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-31 21:33:26
