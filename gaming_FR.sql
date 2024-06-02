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
INSERT INTO `beamng_mod` VALUES ('Automation Test Track','Zone de tests Automation : Un circuit asphalt. Un sircuit terre. Tests de pentes...','map','','/beamng/image_map/image_automation_test_track.jpg','','automation_test_track',0,1,0),('Derby','Plusieurs arènes pour les derbies de démolition et les courses sur piste de terre construite dans la campagne texane.','map','','/beamng/image_map/image_derby.jpg','','derby',0,1,0),('Centre de formation des pilotes ETK','Un centre d\'entraînement moderne pour les pilotes, situé en Allemange.','map','','/beamng/image_map/image_driver_training.jpg','','driver_training',1,1,0),('Côte Est, USA','Un aperçu de la côte est des Etats-Unis. Fortement inspirée des états du Maine et du New Hampshire.','map','','/beamng/image_map/image_east_coast_usa.jpg','','east_coast_usa',0,1,0),('Gridmap v2','Un terrain d\'essais surréaliste comportant plusieurs obstacles, des rampes de sauts et des objets de test.','map','','/beamng/image_map/image_gridmap_v2.jpg','','gridmap_v2',0,1,0),('Circuit Hirochi','Le circuit Hirochi est une piste historique refaite à neuf située sur la côte Est des Etats-Unis.','map','','/beamng/image_map/image_hirochi_raceway.jpg','','hirochi_raceway',0,1,0),('Site industriel','Une zone côtière avec une zone industrielle, plusieurs petites pistes de courses et des champs.','map','','/beamng/image_map/image_industrial.jpg','','industrial',0,1,0),('Italie','Une petite île italienne avec un littoral, des villages et des vignobles magnifiques.','map','','/beamng/image_map/image_italy.jpg','','italy',0,1,0),('Johnson Valley','Cette vallée aride et rocailleuse à l\'Est de Los Angeles offre un espace dédié au hors-piste comprenant une plaine broussailleuse, une montagne rocheuse et de hautes dunes.','map','','/beamng/image_map/image_johnson_valley.jpg','','johnson_valley',0,1,0),('Ile Jungle Rock','Cette île tropicale du Pacifique possède une végétation dense et de nombreux sentiers et routes à explorer.','map','','/beamng/image_map/image_jungle_rock_island.jpg','','jungle_rock_island',0,1,0),('Petite grille','Une grille vide à perte de vue','map','','/beamng/image_map/image_smallgrid.jpg','','smallgrid',0,1,0),('Ile Small, USA','Cette petite île au large de la Californie dispose de peu d\'infrastructure, mais a une petite route côtière très amusante et beaucoup de terrain dégagé à explorer !','map','','/beamng/image_map/image_small_island.jpg','','small_island',0,1,0),('Utah, USA','Les canyons de l\'Utah en ont un véritable paradis de la conduite. Foncez sur des routes goudronnées bien entretenues, salissez votre voiture dans des rallyes tout-terrain ou partez à l\'assaut des rochers des canyons','map','','/beamng/image_map/image_utah.jpg','','utah',0,1,0),('Côte Ouest, USA','Explorez la côte Ouest des Etats-Unis. Représentative de divers sites californiens.','map','','/beamng/image_map/image_west_coast_usa.jpg','','west_coast_usa',0,1,0);
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
