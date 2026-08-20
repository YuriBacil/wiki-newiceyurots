-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: theforgottenserver_web
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `web_accounts`
--

DROP TABLE IF EXISTS `web_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `web_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `password` varchar(255) NOT NULL,
  `web_group` int(11) DEFAULT 1,
  `created` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `web_accounts`
--

LOCK TABLES `web_accounts` WRITE;
/*!40000 ALTER TABLE `web_accounts` DISABLE KEYS */;
INSERT INTO `web_accounts` VALUES (1,'1','7c4a8d09ca3762af61e59520943dc26494f8941b',1,0),(5,'5','7c4a8d09ca3762af61e59520943dc26494f8941b',3,0),(15,'victormendes','7c4a8d09ca3762af61e59520943dc26494f8941b',1,0),(16,'yuribacil','$2y$10$7rnaNxhE2lWCuX.3Z6/5Y.yba/5IvyL6FuaeiPQx36YBcMmK22Ch.',1,1787004043);
/*!40000 ALTER TABLE `web_accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `web_cache_stats`
--

DROP TABLE IF EXISTS `web_cache_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `web_cache_stats` (
  `cache_key` varchar(50) NOT NULL,
  `cache_value` longtext NOT NULL,
  `updated_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`cache_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `web_cache_stats`
--

LOCK TABLES `web_cache_stats` WRITE;
/*!40000 ALTER TABLE `web_cache_stats` DISABLE KEYS */;
/*!40000 ALTER TABLE `web_cache_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `web_community_comment_votes`
--

DROP TABLE IF EXISTS `web_community_comment_votes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `web_community_comment_votes` (
  `comment_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `vote_type` tinyint(4) NOT NULL,
  PRIMARY KEY (`comment_id`,`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `web_community_comment_votes`
--

LOCK TABLES `web_community_comment_votes` WRITE;
/*!40000 ALTER TABLE `web_community_comment_votes` DISABLE KEYS */;
/*!40000 ALTER TABLE `web_community_comment_votes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `web_community_comments`
--

DROP TABLE IF EXISTS `web_community_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `web_community_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `account_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `web_community_comments`
--

LOCK TABLES `web_community_comments` WRITE;
/*!40000 ALTER TABLE `web_community_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `web_community_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `web_community_posts`
--

DROP TABLE IF EXISTS `web_community_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `web_community_posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `web_community_posts`
--

LOCK TABLES `web_community_posts` WRITE;
/*!40000 ALTER TABLE `web_community_posts` DISABLE KEYS */;
/*!40000 ALTER TABLE `web_community_posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `web_community_votes`
--

DROP TABLE IF EXISTS `web_community_votes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `web_community_votes` (
  `post_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `vote_type` tinyint(4) NOT NULL,
  PRIMARY KEY (`post_id`,`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `web_community_votes`
--

LOCK TABLES `web_community_votes` WRITE;
/*!40000 ALTER TABLE `web_community_votes` DISABLE KEYS */;
/*!40000 ALTER TABLE `web_community_votes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `web_item_drops`
--

DROP TABLE IF EXISTS `web_item_drops`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `web_item_drops` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `monster` varchar(100) NOT NULL,
  `chance` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_item` (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4525 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `web_item_drops`
--

LOCK TABLES `web_item_drops` WRITE;
/*!40000 ALTER TABLE `web_item_drops` DISABLE KEYS */;
INSERT INTO `web_item_drops` VALUES (3771,1294,'Massive Earth Elemental','100.0'),(3772,1294,'Earth Elemental','100.0'),(3773,1294,'Demon','30.0'),(3774,1294,'Goblin Demon','30.0'),(3775,1294,'Tortoise','15.0'),(3776,2175,'Priestess','0.6'),(3777,2175,'Spit Nettle','0.6'),(3778,2175,'Winter Wolf','0.6'),(3779,2175,'Carniphila','0.6'),(3780,2175,'Novice of the Cult','0.6'),(3781,2175,'Polar Bear','0.6'),(3782,2182,'Cyclops','10.0'),(3783,2182,'Crypt Shambler','10.0'),(3784,2182,'Ghoul','10.0'),(3785,2182,'Toxiros','3.5'),(3786,2182,'Pyramo','3.5'),(3787,2182,'Lazarus','3.5'),(3788,2182,'Zathroth','3.5'),(3789,2182,'Apocalypse','3.5'),(3790,2182,'Infernatil','3.5'),(3791,2182,'Bazir','3.5'),(3792,2182,'Serpent Spawn','1.33'),(3793,2182,'Orshabaal','1.33'),(3794,2182,'Necromancer','1.33'),(3795,2185,'Nightstalker','10.0'),(3796,2185,'Gozzler','10.0'),(3797,2185,'Zombie','10.0'),(3798,2185,'Toxiros','3.5'),(3799,2185,'Pyramo','3.5'),(3800,2185,'Zathroth','3.5'),(3801,2185,'Bazir','3.5'),(3802,2185,'Apocalypse','3.5'),(3803,2185,'Lazarus','3.5'),(3804,2185,'Infernatil','3.5'),(3805,2185,'Rahemos','1.44'),(3806,2185,'Warlock','0.99'),(3807,2185,'Witch','0.83'),(3808,2185,'Master Warlock','0.2'),(3809,2185,'Warlock Castle','0.2'),(3810,2185,'Draken Elite','0.2'),(3811,2185,'Warlock VIP','0.2'),(3812,2185,'Warlock Supervip','0.2'),(3813,2186,'Priestess','10.0'),(3814,2186,'Gladiator','10.0'),(3815,2186,'Beholder','10.0'),(3816,2186,'Zathroth','3.5'),(3817,2186,'Pyramo','3.5'),(3818,2186,'Toxiros','3.5'),(3819,2186,'Bazir','3.5'),(3820,2186,'Apocalypse','3.5'),(3821,2186,'Infernatil','3.5'),(3822,2186,'Lazarus','3.5'),(3823,2186,'Morgaroth','1.54'),(3824,2186,'The Ruthless Herald','1.54'),(3825,2186,'Morgaroth Supervip','1.54'),(3826,2186,'Necropharus','0.5'),(3827,2186,'Necromancer','0.11'),(3828,2188,'Gozzler','10.0'),(3829,2188,'Zombie','10.0'),(3830,2188,'Nightstalker','10.0'),(3831,2188,'Zathroth','2.5'),(3832,2188,'Pyramo','2.5'),(3833,2188,'Toxiros','2.5'),(3834,2188,'Apocalypse','2.5'),(3835,2188,'Bazir','2.5'),(3836,2188,'Infernatil','2.5'),(3837,2188,'Lazarus','2.5'),(3838,2188,'Orshabaal','1.0'),(3839,2190,'Ghoul','10.0'),(3840,2190,'Cyclops','10.0'),(3841,2190,'Crypt Shambler','10.0'),(3842,2191,'Priestess','10.0'),(3843,2191,'Gladiator','10.0'),(3844,2191,'Beholder','10.0'),(3845,2321,'Novice of the Cult','2.0'),(3846,2321,'Priestess','2.0'),(3847,2321,'Beholder','0.8'),(3848,2321,'Gladiator','0.8'),(3849,2321,'Bog Raider','0.8'),(3850,2321,'Gazer','0.8'),(3851,2376,'Human','80.0'),(3852,2376,'Pirate Marauder','15.0'),(3853,2376,'Lizard Templar','6.0'),(3854,2376,'Nomad','2.5'),(3855,2376,'Cyclops','2.5'),(3856,2376,'Undead Mine Worker','1.5'),(3857,2378,'Orc Champion','6.0'),(3858,2378,'Barbarian Bloodwalker','2.89'),(3859,2378,'Gladiator','0.8'),(3860,2378,'Beholder','0.8'),(3861,2378,'Bog Raider','0.8'),(3862,2378,'Gazer','0.8'),(3863,2379,'Ron the Ripper','100.0'),(3864,2379,'Demon','18.0'),(3865,2379,'Goblin Demon','18.0'),(3866,2379,'Skunk','10.0'),(3867,2379,'Badger','10.0'),(3868,2379,'Orchid Frog','10.0'),(3869,2380,'Skunk','10.0'),(3870,2380,'Orchid Frog','10.0'),(3871,2380,'Badger','10.0'),(3872,2380,'Troll Champion','1.8'),(3873,2381,'Blocker','13.0'),(3874,2381,'Black Knight','9.0'),(3875,2381,'Orc Champion','7.0'),(3876,2381,'Orc Berserker','6.67'),(3877,2381,'Yeti','6.67'),(3878,2381,'Barbarian Bloodwalker','2.78'),(3879,2381,'Nomad','2.5'),(3880,2381,'Cyclops','2.5'),(3881,2381,'Quara Constrictor Scout','2.22'),(3882,2381,'Cyclops Drone','2.0'),(3883,2381,'Frost Giant','1.96'),(3884,2381,'Frost Giantess','1.96'),(3885,2381,'Cyclops Smith','1.82'),(3886,2382,'Tortoise','8.0'),(3887,2384,'Penguin','3.5'),(3888,2384,'Fire Devil','3.5'),(3889,2385,'Orc','10.0'),(3890,2385,'Eternal Guardian','10.0'),(3891,2385,'Pirate Corsair','9.0'),(3892,2385,'Crypt Shambler','3.0'),(3893,2385,'Ghoul','3.0'),(3894,2385,'Pirate Buccaneer','2.06'),(3895,2386,'Minotaur','10.0'),(3896,2386,'Stalker','8.0'),(3897,2386,'Wasp','8.0'),(3898,2386,'Killer','5.0'),(3899,2386,'Dwarf','5.0'),(3900,2387,'Dwarf Guard','25.0'),(3901,2387,'Infernatil','20.0'),(3902,2387,'Zathroth','20.0'),(3903,2387,'Lazarus','20.0'),(3904,2387,'Toxiros','20.0'),(3905,2387,'Pyramo','20.0'),(3906,2387,'Demora','20.0'),(3907,2387,'Bazir','20.0'),(3908,2387,'Apocalypse','20.0'),(3909,2387,'Crazed Beggar','10.0'),(3910,2387,'Ron the Ripper','10.0'),(3911,2387,'Nightmare','7.78'),(3912,2387,'Minotaur Guard','5.0'),(3913,2387,'Fire Devil','4.0'),(3914,2387,'Penguin','4.0'),(3915,2387,'Dragon','4.0'),(3916,2387,'Quara Predator','2.0'),(3917,2387,'Behemoth','2.0'),(3918,2387,'Stonecracker','2.0'),(3919,2387,'Sharptooth','2.0'),(3920,2387,'Behemoth Supervip','2.0'),(3921,2387,'Quara Predator Scout','2.0'),(3922,2387,'Lethal Lissy','1.5'),(3923,2387,'Forest Dragon','1.0'),(3924,2387,'The Horned Fox','1.0'),(3925,2387,'Durin','0.6'),(3926,2388,'Primitive','10.0'),(3927,2388,'Wild Warrior','10.0'),(3928,2388,'The Horned Fox','9.0'),(3929,2388,'Killer','6.67'),(3930,2388,'Dwarf','6.67'),(3931,2389,'Black Knight','100.0'),(3932,2389,'Island Troll','100.0'),(3933,2389,'Blocker','30.0'),(3934,2389,'Lizard Sentinel','12.0'),(3935,2389,'Fire Devil','12.0'),(3936,2389,'Penguin','12.0'),(3937,2389,'Troll Champion','2.0'),(3938,2389,'Big Boss Trolliver','2.0'),(3939,2391,'The Count','2.3'),(3940,2391,'Paladin','1.0'),(3941,2391,'Lumenia','1.0'),(3942,2391,'Knight','1.0'),(3943,2391,'Thief','1.0'),(3944,2391,'Sorcerer','1.0'),(3945,2391,'Druid','1.0'),(3946,2391,'Bog Raider','0.8'),(3947,2391,'Beholder','0.8'),(3948,2391,'Gladiator','0.8'),(3949,2391,'Gazer','0.8'),(3950,2394,'Betrayed Wraith','14.0'),(3951,2394,'Ghoul','4.0'),(3952,2394,'Crypt Shambler','4.0'),(3953,2394,'Lizard Templar','1.5'),(3954,2395,'Bat','30.0'),(3955,2395,'Nightstalker','0.3'),(3956,2395,'Gozzler','0.3'),(3957,2397,'Elf Warlord','6.0'),(3958,2397,'Dragon','5.0'),(3959,2397,'Forest Dragon','4.0'),(3960,2397,'Quara Constrictor Scout','3.33'),(3961,2397,'Acolyte of the Cult','1.0'),(3962,2397,'Gozzler','0.2'),(3963,2397,'Nightstalker','0.2'),(3964,2398,'Undead Mine Worker','25.0'),(3965,2398,'Forest Dragon','20.0'),(3966,2398,'Smuggler Baron Silvertoe','10.0'),(3967,2398,'Skeleton','5.0'),(3968,2398,'Skeleton Warrior','5.0'),(3969,2398,'Fire Devil','3.5'),(3970,2398,'Chakoya Tribewarden','3.0'),(3971,2401,'Prince Almirith','11.0'),(3972,2401,'Koshei the Deathless','10.0'),(3973,2401,'Lich','10.0'),(3974,2401,'Barbaria','10.0'),(3975,2401,'Barbarian Brutetamer','10.0'),(3976,2401,'Dharalion','3.0'),(3977,2401,'Elf Arcanist','3.0'),(3978,2401,'Quara Hydromancer','2.86'),(3979,2401,'Orc Shaman','2.22'),(3980,2401,'Stone Golem','2.0'),(3981,2401,'Chakoya Windcaller','2.0'),(3982,2401,'Mutated Human','2.0'),(3983,2401,'Mutated Rat','2.0'),(3984,2402,'Pyramo','15.5'),(3985,2402,'Toxiros','15.5'),(3986,2402,'Zathroth','15.5'),(3987,2402,'Lazarus','15.5'),(3988,2402,'Bazir','15.5'),(3989,2402,'Apocalypse','15.5'),(3990,2402,'Infernatil','15.5'),(3991,2402,'Zugurosh','10.0'),(3992,2402,'Tortoise','5.0'),(3993,2403,'Undead Prospector','15.25'),(3994,2403,'Primitive','10.0'),(3995,2403,'Wild Warrior','10.0'),(3996,2403,'Assasin','10.0'),(3997,2403,'Barbarian Headsplitter','10.0'),(3998,2403,'Barbarian Skullhunter','10.0'),(3999,2404,'Rift Phantom','10.0'),(4000,2404,'Stalker','8.0'),(4001,2404,'Wasp','8.0'),(4002,2404,'Assasin','4.0'),(4003,2405,'Priestess','0.5'),(4004,2405,'Spit Nettle','0.5'),(4005,2405,'Winter Wolf','0.5'),(4006,2405,'Carniphila','0.5'),(4007,2405,'Novice of the Cult','0.5'),(4008,2405,'Polar Bear','0.5'),(4009,2406,'Cyclops Smith','33.33'),(4010,2406,'Frost Giant','25.0'),(4011,2406,'Frost Giantess','25.0'),(4012,2406,'Forest Dragon','25.0'),(4013,2406,'Dragon','20.0'),(4014,2406,'Necromancer','15.0'),(4015,2406,'Goblin','10.0'),(4016,2406,'Goblin Scavenger','10.0'),(4017,2406,'Goblin Leader','10.0'),(4018,2406,'Goblin Demon','9.0'),(4019,2406,'Demon','9.0'),(4020,2406,'Lizard Templar','7.0'),(4021,2406,'Skeleton','4.0'),(4022,2406,'Skeleton Warrior','4.0'),(4023,2410,'Orc Leader','100.0'),(4024,2410,'The Horned Fox','100.0'),(4025,2410,'General Murius','50.0'),(4026,2410,'Gladiator','3.0'),(4027,2410,'Beholder','3.0'),(4028,2410,'Bog Raider','3.0'),(4029,2410,'Gazer','3.0'),(4030,2410,'Adept of the Cult','2.22'),(4031,2411,'Wasp','6.0'),(4032,2411,'Stalker','6.0'),(4033,2416,'Plaguesmith','7.33'),(4034,2417,'Dwarf Guard','33.33'),(4035,2417,'Tortoise','8.0'),(4036,2417,'Blocker','7.0'),(4037,2417,'Black Knight','7.0'),(4038,2417,'Undead Minion','5.0'),(4039,2417,'Durin','4.0'),(4040,2419,'The Horned Fox','50.0'),(4041,2419,'Goshnar','12.0'),(4042,2419,'Orc Leader','10.0'),(4043,2419,'General Murius','10.0'),(4044,2419,'Smuggler','1.0'),(4045,2419,'Gang Member','1.0'),(4046,2419,'Larva','1.0'),(4047,2419,'Scarab','1.0'),(4048,2420,'Xenia','25.0'),(4049,2420,'Goblin','10.0'),(4050,2420,'Amazon','3.0'),(4051,2420,'Valkyrie','3.0'),(4052,2422,'Nomad','3.0'),(4053,2422,'Cyclops','3.0'),(4054,2422,'Penguin','0.32'),(4055,2423,'Adept of the Cult','3.33'),(4056,2423,'Nightstalker','0.3'),(4057,2423,'Gozzler','0.3'),(4058,2429,'Scarab','1.0'),(4059,2429,'Smuggler','1.0'),(4060,2429,'Gang Member','1.0'),(4061,2429,'Larva','1.0'),(4062,2437,'Wild Warrior','10.0'),(4063,2437,'Tortoise','10.0'),(4064,2437,'Bug','10.0'),(4065,2439,'Acolyte of the Cult','3.33'),(4066,2439,'Priestess','0.5'),(4067,2439,'Spit Nettle','0.5'),(4068,2439,'Winter Wolf','0.5'),(4069,2439,'Polar Bear','0.5'),(4070,2439,'Carniphila','0.5'),(4071,2439,'Novice of the Cult','0.5'),(4072,2439,'Dark Monk','0.4'),(4073,2441,'Valkyrie','3.0'),(4074,2441,'Amazon','3.0'),(4075,2442,'Marid','5.0'),(4076,2442,'Gladiator','0.8'),(4077,2442,'Beholder','0.8'),(4078,2442,'Bog Raider','0.8'),(4079,2442,'Gazer','0.8'),(4080,2448,'Yeti','10.0'),(4081,2448,'Tortoise','8.0'),(4082,2448,'Troll Champion','5.0'),(4083,2448,'Big Boss Trolliver','5.0'),(4084,2448,'Skeleton','3.5'),(4085,2448,'Skeleton Warrior','3.5'),(4086,2449,'Goblin Demon','5.0'),(4087,2449,'Chakoya Toolshaper','3.5'),(4088,2449,'Stone Golem','2.0'),(4089,2449,'Mutated Rat','2.0'),(4090,2449,'Mutated Human','2.0'),(4091,2449,'Chakoya Windcaller','2.0'),(4092,2449,'Cyclops Drone','1.82'),(4093,2450,'Priestess','0.5'),(4094,2450,'Spit Nettle','0.5'),(4095,2450,'Winter Wolf','0.5'),(4096,2450,'Carniphila','0.5'),(4097,2450,'Novice of the Cult','0.5'),(4098,2450,'Polar Bear','0.5'),(4099,2455,'Dwarf Soldier','10.0'),(4100,2455,'Forest Dragon','10.0'),(4101,2455,'Dragon','6.67'),(4102,2455,'Polar Bear','1.5'),(4103,2455,'Priestess','1.5'),(4104,2455,'Spit Nettle','1.5'),(4105,2455,'Carniphila','1.5'),(4106,2455,'Winter Wolf','1.5'),(4107,2455,'Novice of the Cult','1.5'),(4108,2455,'Adept of the Cult','1.0'),(4109,2456,'Paladin','13.0'),(4110,2456,'Lumenia','13.0'),(4111,2456,'Thief','13.0'),(4112,2456,'Sorcerer','13.0'),(4113,2456,'Knight','13.0'),(4114,2456,'Druid','13.0'),(4115,2456,'Elf Scout','10.0'),(4116,2456,'Hero','10.0'),(4117,2456,'Orc Marauder','6.0'),(4118,2456,'Tortoise','5.0'),(4119,2456,'Elf Warlord','4.0'),(4120,2458,'Orc Champion','11.0'),(4121,2458,'Valkyrie','4.0'),(4122,2458,'Amazon','4.0'),(4123,2458,'Orc Shaman','2.22'),(4124,2460,'Undead Prospector','19.25'),(4125,2460,'Stalker','10.0'),(4126,2460,'Wasp','10.0'),(4127,2460,'Barbarian Headsplitter','10.0'),(4128,2460,'Barbarian Skullhunter','10.0'),(4129,2460,'Quara Constrictor Scout','4.0'),(4130,2461,'Island Troll','20.0'),(4131,2461,'Wild Warrior','12.0'),(4132,2461,'Primitive','12.0'),(4133,2461,'Hunter','10.0'),(4134,2461,'Demon','10.0'),(4135,2461,'Random Noob','10.0'),(4136,2461,'Poacher','10.0'),(4137,2461,'Magebomb','10.0'),(4138,2461,'Goblin Demon','10.0'),(4139,2461,'Goblin Assassin','10.0'),(4140,2461,'Goblin Leader','10.0'),(4141,2461,'Goblin','10.0'),(4142,2461,'Human','10.0'),(4143,2461,'Goblin Scavenger','10.0'),(4144,2461,'Apprentice Sheng','8.0'),(4145,2461,'Minotaur Mage','8.0'),(4146,2461,'Troll Champion','1.0'),(4147,2468,'Wasp','10.0'),(4148,2468,'Stalker','10.0'),(4149,2468,'Orc Spearman','10.0'),(4150,2473,'Barbarian Headsplitter','10.0'),(4151,2473,'Gazer','1.0'),(4152,2473,'Gladiator','1.0'),(4153,2473,'Beholder','1.0'),(4154,2473,'Bog Raider','1.0'),(4155,2478,'Tarantula','20.0'),(4156,2478,'Blocker','13.0'),(4157,2478,'Goshnar','10.0'),(4158,2478,'Elf','4.0'),(4159,2478,'Beholder','1.2'),(4160,2478,'Bog Raider','1.2'),(4161,2478,'Gazer','1.2'),(4162,2478,'Gladiator','1.2'),(4163,2481,'Dwarf Soldier','10.0'),(4164,2481,'Minotaur Archer','6.67'),(4165,2481,'Smuggler','1.2'),(4166,2481,'Scarab','1.2'),(4167,2481,'Gang Member','1.2'),(4168,2481,'Larva','1.2'),(4169,2482,'Crazed Beggar','10.0'),(4170,2482,'Elf Warlord','8.0'),(4171,2490,'Black Knight','6.67'),(4172,2490,'Cyclops Smith','2.86'),(4173,2490,'Frost Giantess','2.78'),(4174,2490,'Blocker','2.0'),(4175,2490,'Goshnar','1.5'),(4176,2490,'Scarab','1.0'),(4177,2490,'Smuggler','1.0'),(4178,2490,'Larva','1.0'),(4179,2490,'Gang Member','1.0'),(4180,2509,'Cyclops Drone','33.33'),(4181,2509,'Forest Dragon','15.0'),(4182,2509,'A Fading Memory','6.67'),(4183,2509,'Amazon','3.5'),(4184,2509,'Valkyrie','3.5'),(4185,2509,'Ghoul','3.0'),(4186,2509,'Crypt Shambler','3.0'),(4187,2509,'Dragon','1.82'),(4188,2509,'Assasin','1.0'),(4189,2510,'The Horned Fox','50.0'),(4190,2510,'Tarantula','17.0'),(4191,2510,'Tortoise','6.0'),(4192,2510,'Frost Giant','5.33'),(4193,2510,'Frost Giantess','5.33'),(4194,2510,'General Murius','5.0'),(4195,2510,'Orc Leader','5.0'),(4196,2510,'Assasin','2.0'),(4197,2510,'Tortoise','0.03'),(4198,2511,'A Fading Memory','10.0'),(4199,2511,'Ghoul','3.5'),(4200,2511,'Penguin','3.5'),(4201,2511,'Crypt Shambler','3.5'),(4202,2511,'Fire Devil','3.5'),(4203,2512,'Rat','15.0'),(4204,2512,'Cave Rat','15.0'),(4205,2512,'Orc Warrior','10.0'),(4206,2512,'Troll Champion','1.5'),(4207,2513,'Durin','7.5'),(4208,2513,'Foreman Kneebiter','6.67'),(4209,2513,'Chakoya Toolshaper','3.5'),(4210,2513,'The Horned Fox','2.0'),(4211,2513,'Stone Golem','1.5'),(4212,2513,'Mutated Rat','1.5'),(4213,2513,'Mutated Human','1.5'),(4214,2513,'Chakoya Windcaller','1.5'),(4215,2513,'Assasin','1.5'),(4216,2513,'Undead Minion','1.0'),(4217,2526,'Spider','12.0'),(4218,2526,'Bug','12.0'),(4219,2541,'Tortoise','5.0'),(4220,2541,'Skeleton','3.5'),(4221,2541,'Skeleton Warrior','3.5'),(4222,2541,'Chakoya Tribewarden','0.33'),(4223,2543,'Minotaur Archer','100.0'),(4224,2543,'Dwarf Soldier','100.0'),(4225,2543,'Valkyrie','12.0'),(4226,2543,'Amazon','12.0'),(4227,2544,'Omruc','100.0'),(4228,2544,'Elf','100.0'),(4229,2544,'Elf Scout','100.0'),(4230,2544,'Elf Warlord','30.0'),(4231,2544,'Sorcerer','27.0'),(4232,2544,'Paladin','27.0'),(4233,2544,'Thief','27.0'),(4234,2544,'Lumenia','27.0'),(4235,2544,'Druid','27.0'),(4236,2544,'Knight','27.0'),(4237,2544,'Spider','25.0'),(4238,2544,'Bug','25.0'),(4239,2544,'Prince Almirith','6.0'),(4240,2566,'Undead Prospector','15.25'),(4241,2566,'Primitive','10.0'),(4242,2566,'Wild Warrior','10.0'),(4243,2566,'Assasin','10.0'),(4244,2566,'Barbarian Headsplitter','10.0'),(4245,2566,'Barbarian Skullhunter','10.0'),(4246,2642,'Dharalion','20.0'),(4247,2642,'Elf Arcanist','20.0'),(4248,2642,'Prince Almirith','13.0'),(4249,2642,'Rift Phantom','10.0'),(4250,2642,'Elf Warlord','10.0'),(4251,2642,'Target','6.67'),(4252,2642,'Trainer','6.67'),(4253,2642,'Tha Exp Carrier','6.67'),(4254,2642,'Training Monk','6.67'),(4255,2642,'Trainer Slayer','6.67'),(4256,2642,'Dark Monk','6.67'),(4257,2642,'Fernfang','6.67'),(4258,2642,'Monk','6.67'),(4259,2642,'Vip Trainer','6.67'),(4260,2642,'Cave Rat','5.0'),(4261,2642,'Rat','5.0'),(4262,2643,'Durin','40.0'),(4263,2643,'Dwarf Soldier','25.0'),(4264,2643,'Elf','25.0'),(4265,2643,'Dwarf Geomancer','20.0'),(4266,2643,'Spider','15.0'),(4267,2643,'Bug','15.0'),(4268,2643,'Witch','10.0'),(4269,2643,'Island Troll','10.0'),(4270,2643,'Troll Champion','1.0'),(4271,2644,'Priestess','0.8'),(4272,2644,'Spit Nettle','0.8'),(4273,2644,'Winter Wolf','0.8'),(4274,2644,'Carniphila','0.8'),(4275,2644,'Novice of the Cult','0.8'),(4276,2644,'Polar Bear','0.8'),(4277,2648,'The Horned Fox','15.0'),(4278,2648,'Nomad','4.0'),(4279,2648,'Cyclops','4.0'),(4280,2649,'Poacher','100.0'),(4281,2649,'Skunk','12.0'),(4282,2649,'Orchid Frog','12.0'),(4283,2649,'Badger','12.0'),(4284,2649,'Poacher','10.0'),(4285,2649,'Random Noob','10.0'),(4286,2649,'Minotaur','10.0'),(4287,2649,'Magebomb','10.0'),(4288,2649,'Killer','10.0'),(4289,2649,'Minotaur Guard','10.0'),(4290,2649,'Dwarf Geomancer','10.0'),(4291,2649,'Hunter','10.0'),(4292,2649,'Dwarf','10.0'),(4293,2649,'Vampire','8.0'),(4294,2649,'Dracula','8.0'),(4295,2649,'Apprentice Sheng','8.0'),(4296,2649,'Minotaur Mage','8.0'),(4297,2650,'Spider','5.0'),(4298,2650,'Bug','5.0'),(4299,2650,'Valkyrie','4.0'),(4300,2650,'Amazon','4.0'),(4301,2651,'Rat','20.0'),(4302,2651,'Cave Rat','20.0'),(4303,2651,'Witch','5.0'),(4304,2652,'Paladin','8.0'),(4305,2652,'Lumenia','8.0'),(4306,2652,'Thief','8.0'),(4307,2652,'Sorcerer','8.0'),(4308,2652,'Knight','8.0'),(4309,2652,'Druid','8.0'),(4310,2652,'Prince Almirith','7.0'),(4311,2652,'Gang Member','1.2'),(4312,2652,'Larva','1.2'),(4313,2652,'Scarab','1.2'),(4314,2652,'Smuggler','1.2'),(4315,2653,'Chakoya Toolshaper','3.5'),(4316,2653,'Mutated Rat','3.0'),(4317,2653,'Stone Golem','3.0'),(4318,2653,'Chakoya Windcaller','3.0'),(4319,2653,'Mutated Human','3.0'),(4320,2654,'Hand of Cursed Fate','35.0'),(4321,2654,'Lizard Snakecharmer','13.0'),(4322,2654,'Alezzo','9.0'),(4323,2654,'Enlightened of the Cult','5.0'),(4324,2654,'Ghoul','4.0'),(4325,2654,'Crypt Shambler','4.0'),(4326,2655,'Stone Golem','2.0'),(4327,2655,'Mutated Rat','2.0'),(4328,2655,'Mutated Human','2.0'),(4329,2655,'Chakoya Windcaller','2.0'),(4330,2655,'Adept of the Cult','1.43'),(4331,2655,'Pirate Ghost','0.67'),(4332,2658,'Tortoise','10.0'),(4333,2658,'Wasp','5.0'),(4334,2658,'Stalker','5.0'),(4335,2663,'Stone Golem','2.0'),(4336,2663,'Mutated Rat','2.0'),(4337,2663,'Mutated Human','2.0'),(4338,2663,'Chakoya Windcaller','2.0'),(4339,2663,'Blue Djinn','0.1'),(4340,3973,'Gazer','2.0'),(4341,3973,'Gladiator','2.0'),(4342,3973,'Beholder','2.0'),(4343,3973,'Scarab','0.8'),(4344,3973,'Smuggler','0.8'),(4345,3973,'Gang Member','0.8'),(4346,3973,'Larva','0.8'),(4347,3974,'Mutated Rat','1.5'),(4348,3974,'Stone Golem','1.5'),(4349,3974,'Chakoya Windcaller','1.5'),(4350,3974,'Mutated Human','1.5'),(4351,3975,'Lizard Templar','18.0'),(4352,3975,'Nomad','2.5'),(4353,3975,'Cyclops','2.5'),(4354,3982,'Killer Caiman','0.8'),(4355,3982,'Penguin','0.32'),(4356,4846,'Nomad','3.0'),(4357,4846,'Cyclops','3.0'),(4358,4846,'Penguin','0.32'),(4359,4847,'Nomad','3.5'),(4360,4847,'Cyclops','3.5'),(4361,5779,'Omruc','100.0'),(4362,5779,'Elf','100.0'),(4363,5779,'Elf Scout','100.0'),(4364,5779,'Elf Warlord','30.0'),(4365,5779,'Sorcerer','27.0'),(4366,5779,'Paladin','27.0'),(4367,5779,'Thief','27.0'),(4368,5779,'Lumenia','27.0'),(4369,5779,'Druid','27.0'),(4370,5779,'Knight','27.0'),(4371,5779,'Spider','25.0'),(4372,5779,'Bug','25.0'),(4373,5779,'Prince Almirith','6.0'),(4374,5858,'The Horned Fox','50.0'),(4375,5858,'Goshnar','12.0'),(4376,5858,'Orc Leader','10.0'),(4377,5858,'General Murius','10.0'),(4378,5858,'Smuggler','1.0'),(4379,5858,'Gang Member','1.0'),(4380,5858,'Larva','1.0'),(4381,5858,'Scarab','1.0'),(4382,5917,'Mutated Rat','2.0'),(4383,5917,'Stone Golem','2.0'),(4384,5917,'Chakoya Windcaller','2.0'),(4385,5917,'Mutated Human','2.0'),(4386,5917,'Pirate Ghost','0.92'),(4387,5917,'Pirate Marauder','0.92'),(4388,5924,'Priestess','0.5'),(4389,5924,'Spit Nettle','0.5'),(4390,5924,'Winter Wolf','0.5'),(4391,5924,'Carniphila','0.5'),(4392,5924,'Novice of the Cult','0.5'),(4393,5924,'Polar Bear','0.5'),(4394,6578,'Mutated Rat','1.5'),(4395,6578,'Stone Golem','1.5'),(4396,6578,'Chakoya Windcaller','1.5'),(4397,6578,'Mutated Human','1.5'),(4398,7381,'Spectre','5.0'),(4399,7381,'Scarab','1.0'),(4400,7381,'Smuggler','1.0'),(4401,7381,'Gang Member','1.0'),(4402,7381,'Larva','1.0'),(4403,7381,'Chakoya Tribewarden','0.6'),(4404,7432,'Valkyrie','3.5'),(4405,7432,'Amazon','3.5'),(4406,7457,'Barbarian Headsplitter','10.0'),(4407,7457,'Mutated Rat','2.5'),(4408,7457,'Mutated Human','2.5'),(4409,7457,'Stone Golem','2.5'),(4410,7457,'Chakoya Windcaller','2.5'),(4411,7457,'Barbaria','0.73'),(4412,7457,'Barbarian Brutetamer','0.73'),(4413,7749,'Scarab','1.0'),(4414,7749,'Smuggler','1.0'),(4415,7749,'Gang Member','1.0'),(4416,7749,'Larva','1.0'),(4417,7754,'Adept of the Cult','3.33'),(4418,7754,'Nightstalker','0.3'),(4419,7754,'Gozzler','0.3'),(4420,7758,'The Count','2.3'),(4421,7758,'Paladin','1.0'),(4422,7758,'Lumenia','1.0'),(4423,7758,'Knight','1.0'),(4424,7758,'Thief','1.0'),(4425,7758,'Sorcerer','1.0'),(4426,7758,'Druid','1.0'),(4427,7758,'Bog Raider','0.8'),(4428,7758,'Beholder','0.8'),(4429,7758,'Gladiator','0.8'),(4430,7758,'Gazer','0.8'),(4431,7768,'Scarab','1.0'),(4432,7768,'Smuggler','1.0'),(4433,7768,'Gang Member','1.0'),(4434,7768,'Larva','1.0'),(4435,7773,'Adept of the Cult','3.33'),(4436,7773,'Nightstalker','0.3'),(4437,7773,'Gozzler','0.3'),(4438,7777,'The Count','2.3'),(4439,7777,'Paladin','1.0'),(4440,7777,'Lumenia','1.0'),(4441,7777,'Knight','1.0'),(4442,7777,'Thief','1.0'),(4443,7777,'Sorcerer','1.0'),(4444,7777,'Druid','1.0'),(4445,7777,'Bog Raider','0.8'),(4446,7777,'Beholder','0.8'),(4447,7777,'Gladiator','0.8'),(4448,7777,'Gazer','0.8'),(4449,7859,'Scarab','1.0'),(4450,7859,'Smuggler','1.0'),(4451,7859,'Gang Member','1.0'),(4452,7859,'Larva','1.0'),(4453,7864,'Adept of the Cult','3.33'),(4454,7864,'Nightstalker','0.3'),(4455,7864,'Gozzler','0.3'),(4456,7868,'The Count','2.3'),(4457,7868,'Paladin','1.0'),(4458,7868,'Lumenia','1.0'),(4459,7868,'Knight','1.0'),(4460,7868,'Thief','1.0'),(4461,7868,'Sorcerer','1.0'),(4462,7868,'Druid','1.0'),(4463,7868,'Bog Raider','0.8'),(4464,7868,'Beholder','0.8'),(4465,7868,'Gladiator','0.8'),(4466,7868,'Gazer','0.8'),(4467,7874,'Scarab','1.0'),(4468,7874,'Smuggler','1.0'),(4469,7874,'Gang Member','1.0'),(4470,7874,'Larva','1.0'),(4471,7879,'Adept of the Cult','3.33'),(4472,7879,'Nightstalker','0.3'),(4473,7879,'Gozzler','0.3'),(4474,7883,'The Count','2.3'),(4475,7883,'Paladin','1.0'),(4476,7883,'Lumenia','1.0'),(4477,7883,'Knight','1.0'),(4478,7883,'Thief','1.0'),(4479,7883,'Sorcerer','1.0'),(4480,7883,'Druid','1.0'),(4481,7883,'Bog Raider','0.8'),(4482,7883,'Beholder','0.8'),(4483,7883,'Gladiator','0.8'),(4484,7883,'Gazer','0.8'),(4485,8190,'Priestess','0.6'),(4486,8190,'Spit Nettle','0.6'),(4487,8190,'Winter Wolf','0.6'),(4488,8190,'Carniphila','0.6'),(4489,8190,'Novice of the Cult','0.6'),(4490,8190,'Polar Bear','0.6'),(4491,8819,'Gozzler','1.5'),(4492,8819,'Bog Raider','1.5'),(4493,8819,'Nightstalker','1.5'),(4494,8819,'Acolyte of the Cult','1.43'),(4495,8819,'Priestess','0.6'),(4496,8819,'Spit Nettle','0.6'),(4497,8819,'Winter Wolf','0.6'),(4498,8819,'Carniphila','0.6'),(4499,8819,'Novice of the Cult','0.6'),(4500,8819,'Polar Bear','0.6'),(4501,8820,'Mutated Rat','2.0'),(4502,8820,'Stone Golem','2.0'),(4503,8820,'Chakoya Windcaller','2.0'),(4504,8820,'Mutated Human','2.0'),(4505,8872,'Gazer','1.0'),(4506,8872,'Gladiator','1.0'),(4507,8872,'Beholder','1.0'),(4508,8872,'Bog Raider','1.0'),(4509,8873,'Penguin','5.0'),(4510,8873,'Fire Devil','5.0'),(4511,8874,'Skeleton','6.0'),(4512,8874,'Skeleton Warrior','6.0'),(4513,8875,'Tortoise','10.0'),(4514,8876,'Crazed Beggar','12.0'),(4515,8900,'Bog Raider','2.0'),(4516,8900,'Nightstalker','2.0'),(4517,8900,'Gozzler','2.0'),(4518,8900,'Polar Bear','2.0'),(4519,8900,'Novice of the Cult','2.0'),(4520,8900,'Spit Nettle','2.0'),(4521,8900,'Priestess','2.0'),(4522,8900,'Winter Wolf','2.0'),(4523,8900,'Carniphila','2.0'),(4524,8900,'Acolyte of the Cult','1.79');
/*!40000 ALTER TABLE `web_item_drops` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `web_items`
--

DROP TABLE IF EXISTS `web_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `web_items` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `attack` int(11) DEFAULT 0,
  `defense` int(11) DEFAULT 0,
  `armor` int(11) DEFAULT 0,
  `weight` decimal(10,2) DEFAULT 0.00,
  `slot` varchar(50) DEFAULT 'Equipamento',
  `description` text DEFAULT NULL,
  `tier` varchar(20) DEFAULT 'tier1',
  `category` varchar(30) DEFAULT 'all',
  `id_860` int(11) DEFAULT 0,
  `id_10` int(11) DEFAULT 0,
  `attributes_desc` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_tier` (`tier`),
  KEY `idx_name` (`name`),
  KEY `idx_category` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `web_items`
--

LOCK TABLES `web_items` WRITE;
/*!40000 ALTER TABLE `web_items` DISABLE KEYS */;
INSERT INTO `web_items` VALUES (1294,'small stone',15,0,0,0.30,'Spear','','tier1','all',1294,1781,'Atk: 15, Range: 5'),(2175,'spellbook',0,15,0,58.00,'Spellbook','It shows your spells and can also shield against attack when worn.','tier1','all',2175,648,'Def: 15'),(2181,'terra rod',0,0,0,25.00,'Rod','Small stones are flying from its tip.','tier2','all',0,0,''),(2182,'snakebite rod',0,0,0,43.00,'Rod','It seems to twitch and quiver as if trying to escape your grip.','tier1','all',2182,2182,'Range: 3, Dano: 1650-1950 Earth, Mana: 30, Level: 5000'),(2183,'hailstorm rod',0,0,0,27.00,'Rod','It grants you the power of striking your foes with furious hailstorms.','tier2','all',0,0,''),(2185,'necrotic rod',0,0,0,23.00,'Rod','It was brought up from hell to deliver death.','tier1','all',2185,2185,'Range: 3, Dano: 7500-7950 Death, Mana: 1200, Level: 15000'),(2186,'moonlight rod',0,0,0,21.00,'Rod','Icecold rays of moonlight shimmer on its tip.','tier1','all',2186,2186,'Range: 3, Dano: 4200-4500 Ice, Mana: 690, Level: 10000'),(2187,'wand of inferno',0,0,0,27.00,'Wand','It unleashes the very fires of hell.','tier2','all',0,0,''),(2188,'wand of decay',0,0,0,23.00,'Wand','It is half-rotten itself and reeks terribly.','tier1','all',2188,2188,'Range: 3, Dano: 7500-7950 Death, Mana: 1200, Level: 15000'),(2189,'wand of cosmic energy',0,0,0,25.00,'Wand','The energy of a radiant star is trapped inside its globe.','tier2','all',0,0,''),(2190,'wand of vortex',0,0,0,19.00,'Wand','Surges of energy rush through the tip of this wand.','tier1','all',2190,2190,'Range: 3, Dano: 1650-1950 Energy, Mana: 30, Level: 5000'),(2191,'wand of dragonbreath',0,0,0,23.00,'Wand','Legends say that this wand holds the soul of a young dragon.','tier1','all',2191,2191,'Range: 3, Dano: 4200-4500 Fire, Mana: 690, Level: 10000'),(2321,'giant smithhammer',68,28,0,68.00,'Club','This cyclopean hammer seems to be an awesome smithing tool.','tier1','all',2321,3208,'Atk: 68, Def: 28'),(2323,'hat of the mad',0,0,37,7.00,'Helmet','You have a vague feeling that it looks somewhat silly.','tier2','all',0,0,''),(2376,'sword',42,22,0,35.00,'Sword','','tier1','all',2376,3264,'Atk: 42, Def: 22'),(2377,'two handed sword',194,57,0,70.00,'Sword','','tier2','all',0,0,''),(2378,'battle axe',65,25,0,50.00,'Axe','','tier1','all',2378,3266,'Atk: 65, Def: 25'),(2379,'dagger',15,12,0,9.50,'Sword','','tier1','all',2379,3267,'Atk: 15, Def: 12'),(2380,'hand axe',16,12,0,18.00,'Axe','','tier1','all',2380,3268,'Atk: 16, Def: 12'),(2381,'halberd',45,20,0,90.00,'Axe','','tier1','all',2381,3269,'Atk: 45, Def: 20'),(2382,'club',10,10,0,25.00,'Club','','tier1','all',2382,3270,'Atk: 10, Def: 10'),(2383,'spike sword',24,21,0,50.00,'Sword','','tier2','all',0,0,''),(2384,'rapier',32,18,0,15.00,'Sword','','tier1','all',2384,3272,'Atk: 32, Def: 18'),(2385,'sabre',35,20,0,25.00,'Sword','','tier1','all',2385,3273,'Atk: 35, Def: 20'),(2386,'axe',22,15,0,40.00,'Axe','','tier1','all',2386,3274,'Atk: 22, Def: 15'),(2387,'double axe',28,15,0,70.00,'Axe','','tier1','all',2387,3275,'Atk: 28, Def: 15'),(2388,'hatchet',12,10,0,35.00,'Axe','','tier1','all',2388,3276,'Atk: 12, Def: 10'),(2389,'spear',30,0,0,2.00,'Spear','','tier1','all',2389,3277,'Atk: 30, Range: 5'),(2391,'war hammer',65,25,0,85.00,'Club','','tier1','all',2391,3279,'Atk: 65, Def: 25'),(2394,'morning star',35,18,0,54.00,'Club','','tier1','all',2394,3282,'Atk: 35, Def: 18'),(2395,'carlin sword',65,28,0,40.00,'Sword','','tier1','all',2395,3283,'Atk: 65, Def: 28'),(2396,'ice rapier',450,85,0,15.00,'Sword','A deadly but fragile weapon.','tier2','all',0,0,''),(2397,'longsword',70,30,0,42.00,'Sword','','tier1','all',2397,3285,'Atk: 70, Def: 30'),(2398,'mace',30,18,0,28.00,'Club','','tier1','all',2398,3286,'Atk: 30, Def: 18'),(2399,'throwing star',240,0,0,2.00,'Spear','','tier2','all',0,0,''),(2401,'staff',55,22,0,38.00,'Club','','tier1','all',2401,3289,'Atk: 55, Def: 22'),(2402,'silver dagger',25,15,0,10.19,'Sword','','tier1','all',2402,3290,'Atk: 25, Def: 15'),(2403,'knife',10,10,0,4.20,'Sword','','tier1','all',2403,3291,'Atk: 10, Def: 10'),(2404,'combat knife',18,12,0,8.69,'Sword','','tier1','all',2404,3292,'Atk: 18, Def: 12'),(2405,'sickle',70,28,0,10.50,'Axe','','tier1','all',2405,3293,'Atk: 70, Def: 28'),(2406,'short sword',30,18,0,35.00,'Sword','','tier1','all',2406,3294,'Atk: 30, Def: 18'),(2407,'bright sword',137,51,0,29.00,'Sword','The blade shimmers in light blue.','tier2','all',0,0,''),(2409,'serpent sword',222,60,0,41.00,'Sword','','tier2','all',0,0,''),(2410,'throwing knife',45,0,0,5.00,'Spear','','tier1','all',2410,3298,'Atk: 45, Range: 5'),(2411,'poison dagger',22,15,0,8.80,'Sword','','tier1','all',2411,3299,'Atk: 22, Def: 15'),(2412,'katana',279,66,0,31.00,'Sword','','tier2','all',0,0,''),(2413,'broadsword',251,63,0,52.50,'Sword','','tier2','all',0,0,''),(2414,'dragon lance',416,80,0,67.00,'Axe','The extraordinary sharp blade penetrates every armor.','tier2','all',0,0,''),(2416,'crowbar',14,12,0,21.00,'Club','','tier1','all',2416,3304,'Atk: 14, Def: 12'),(2417,'battle hammer',20,15,0,68.00,'Club','','tier1','all',2417,3305,'Atk: 20, Def: 15'),(2418,'golden sickle',450,85,0,19.50,'Axe','','tier2','all',0,0,''),(2419,'scimitar',48,22,0,29.00,'Sword','','tier1','all',2419,3307,'Atk: 48, Def: 22'),(2420,'machete',38,20,0,16.50,'Sword','','tier1','all',2420,3308,'Atk: 38, Def: 20'),(2422,'iron hammer',45,20,0,66.00,'Club','','tier1','all',2422,3310,'Atk: 45, Def: 20'),(2423,'clerical mace',72,30,0,58.00,'Club','','tier1','all',2423,3311,'Atk: 72, Def: 30'),(2425,'obsidian lance',383,76,0,80.00,'Axe','','tier2','all',0,0,''),(2426,'naginata',180,52,0,80.00,'Axe','','tier2','all',0,0,''),(2427,'guardian halberd',113,44,0,110.00,'Axe','','tier2','all',0,0,''),(2428,'orcish axe',80,40,0,45.00,'Axe','','tier2','all',0,0,''),(2429,'barbarian axe',55,22,0,51.00,'Axe','','tier1','all',2429,3317,'Atk: 55, Def: 22'),(2434,'dragon hammer',80,40,0,97.00,'Club','','tier2','all',0,0,''),(2437,'cotonete',0,0,0,23.00,'Wand','','tier1','all',2437,2437,'Range: 3, Dano: 510-600 Holy, Mana: 3, Level: 1'),(2438,'epee',336,72,0,15.00,'Sword','','tier2','all',0,0,''),(2439,'daramanian mace',70,28,0,68.00,'Club','','tier1','all',2439,3327,'Atk: 70, Def: 28'),(2440,'daramanian waraxe',147,48,0,52.50,'Axe','','tier2','all',0,0,''),(2441,'daramanian axe',35,18,0,52.50,'Axe','','tier1','all',2441,3329,'Atk: 35, Def: 18'),(2442,'heavy machete',52,25,0,18.39,'Sword','','tier1','all',2442,3330,'Atk: 52, Def: 25'),(2445,'crystal mace',38,16,0,80.00,'Club','','tier2','all',0,0,''),(2447,'doublet axe',349,72,0,65.00,'Axe','','tier2','all',0,0,''),(2448,'studded club',25,15,0,35.00,'Club','','tier1','all',2448,3336,'Atk: 25, Def: 15'),(2449,'bone club',50,22,0,39.00,'Club','','tier1','all',2449,3337,'Atk: 50, Def: 22'),(2450,'bone sword',58,25,0,19.00,'Sword','','tier1','all',2450,3338,'Atk: 58, Def: 25'),(2455,'crossbow',25,0,0,40.00,'Crossbow','','tier1','all',2455,3349,'Atk: 25, Range: 5'),(2456,'bow',15,0,0,31.00,'Bow','','tier1','all',2456,3350,'Atk: 15, Range: 6'),(2457,'steel helmet',0,0,49,46.00,'Helmet','','tier2','all',0,0,''),(2458,'chain helmet',0,0,7,42.00,'Helmet','','tier1','all',2458,3352,'Arm: 7'),(2459,'iron helmet',0,0,21,30.00,'Helmet','','tier2','all',0,0,''),(2460,'brass helmet',0,0,2,27.00,'Helmet','','tier1','all',2460,3354,'Arm: 2'),(2461,'leather helmet',0,0,1,22.00,'Helmet','','tier1','all',2461,3355,'Arm: 1'),(2462,'devil helmet',0,0,53,50.00,'Helmet','','tier2','all',0,0,''),(2463,'plate armor',0,0,66,120.00,'Armor','','tier2','all',0,0,''),(2464,'chain armor',0,0,30,100.00,'Armor','','tier2','all',0,0,''),(2465,'brass armor',0,0,48,80.00,'Armor','','tier2','all',0,0,''),(2467,'leather armor',0,0,20,60.00,'Armor','','tier2','all',0,0,''),(2468,'studded legs',0,0,2,26.00,'Legs','','tier1','all',2468,3362,'Arm: 2'),(2473,'viking helmet',0,0,9,39.00,'Helmet','','tier1','all',2473,3367,'Arm: 9'),(2475,'warrior helmet',0,0,60,68.00,'Helmet','','tier2','all',0,0,''),(2478,'brass legs',0,0,5,38.00,'Legs','','tier1','all',2478,3372,'Arm: 5'),(2480,'legion helmet',0,0,25,31.00,'Helmet','','tier2','all',0,0,''),(2481,'soldier helmet',0,0,8,32.00,'Helmet','','tier1','all',2481,3375,'Arm: 8'),(2482,'studded helmet',0,0,3,24.50,'Helmet','','tier1','all',2482,3376,'Arm: 3'),(2483,'scale armor',0,0,36,105.00,'Armor','','tier2','all',0,0,''),(2484,'studded armor',0,0,25,71.00,'Armor','','tier2','all',0,0,''),(2485,'doublet',0,0,12,25.00,'Equipamento','','tier2','all',0,0,''),(2489,'dark armor',0,0,54,120.00,'Armor','','tier2','all',0,0,''),(2490,'dark helmet',0,0,7,46.00,'Helmet','','tier1','all',2490,3384,'Arm: 7'),(2491,'crown helmet',0,0,57,29.50,'Helmet','','tier2','all',0,0,''),(2509,'steel shield',0,45,0,69.00,'Shield','','tier1','all',2509,3409,'Def: 45'),(2510,'plate shield',0,25,0,65.00,'Shield','','tier1','all',2510,3410,'Def: 25'),(2511,'brass shield',0,40,0,60.00,'Shield','','tier1','all',2511,3411,'Def: 40'),(2512,'wooden shield',0,15,0,40.00,'Shield','','tier1','all',2512,3412,'Def: 15'),(2513,'battle shield',0,55,0,62.00,'Shield','','tier1','all',2513,3413,'Def: 55'),(2515,'guardian shield',0,103,0,55.00,'Shield','','tier2','all',0,0,''),(2516,'dragon shield',0,114,0,60.00,'Shield','','tier2','all',0,0,''),(2521,'dark shield',0,70,0,52.00,'Shield','','tier2','all',0,0,''),(2525,'dwarven shield',0,81,0,55.00,'Shield','','tier2','all',0,0,''),(2526,'studded shield',0,20,0,59.00,'Shield','','tier1','all',2526,3426,'Def: 20'),(2528,'tower shield',0,125,0,82.00,'Shield','','tier2','all',0,0,''),(2531,'viking shield',0,147,0,66.00,'Shield','','tier2','all',0,0,''),(2534,'vampire shield',0,160,0,38.00,'Shield','Dark powers enchant this shield.','tier2','all',0,0,''),(2540,'scarab shield',0,92,0,47.00,'Shield','','tier2','all',0,0,''),(2541,'bone shield',0,30,0,55.00,'Shield','','tier1','all',2541,3441,'Def: 30'),(2543,'bolt',20,0,0,0.80,'Ammo','','tier1','all',2543,3446,'Atk: 20'),(2544,'arrow',10,0,0,0.70,'Ammo','','tier1','all',2544,3447,'Atk: 10'),(2566,'knife',0,0,0,1.00,'Equipamento','','tier1','all',2403,3291,'Atk: 10, Def: 10'),(2642,'sandals',0,0,1,6.00,'Equipamento','','tier1','all',2642,3551,'Arm: 1'),(2643,'leather boots',0,0,2,9.00,'Boots','','tier1','all',2643,3552,'Arm: 2'),(2644,'bunny slippers',0,0,5,12.00,'Boots','','tier1','all',2644,3553,'Arm: 5'),(2645,'steel boots',0,0,40,29.00,'Boots','','tier2','all',0,0,''),(2647,'plate legs',0,0,10,50.00,'Legs','','tier2','all',0,0,''),(2648,'chain legs',0,0,4,35.00,'Legs','','tier1','all',2648,3558,'Arm: 4'),(2649,'leather legs',0,0,1,18.00,'Legs','','tier1','all',2649,3559,'Arm: 1'),(2650,'jacket',0,0,5,24.00,'Armor','','tier1','all',2650,3561,'Arm: 5'),(2651,'coat',0,0,1,27.00,'Armor','','tier1','all',2651,3562,'Arm: 1'),(2652,'green tunic',0,0,8,9.30,'Armor','','tier1','all',2652,3563,'Arm: 8'),(2653,'red tunic',0,0,6,30.00,'Armor','','tier1','all',2653,3564,'Arm: 6'),(2654,'cape',0,0,4,32.00,'Helmet','','tier1','all',2654,3565,'Arm: 4'),(2655,'red robe',0,0,7,26.00,'Armor','','tier1','all',2655,3566,'Arm: 7'),(2658,'white dress',0,0,2,24.00,'Armor','','tier1','all',2658,3569,'Arm: 2'),(2659,'ball gown',0,0,60,25.00,'Equipamento','','tier2','all',0,0,''),(2660,'ranger\'s cloak',0,0,42,48.00,'Armor','','tier2','all',0,0,''),(2663,'mystic turban',0,0,5,8.50,'Helmet','Something is strange about this turban.','tier1','all',2663,3574,'Arm: 5, Magic Level +1'),(2665,'post officers hat',0,0,4,7.00,'Helmet','This hat is the insignia of all tibian post officers.','tier1','all',0,0,''),(3961,'lich staff',450,85,0,80.00,'Club','','tier2','all',0,0,''),(3965,'hunting spear',120,0,0,22.00,'Spear','','tier2','all',0,0,''),(3967,'tribal mask',0,0,13,25.00,'Equipamento','','tier2','all',0,0,''),(3973,'tusk shield',0,65,0,69.00,'Shield','','tier1','all',3973,3443,'Def: 65'),(3974,'sentinel shield',0,60,0,49.00,'Shield','','tier1','all',3974,3444,'Def: 60'),(3975,'salamander shield',0,50,0,72.00,'Shield','','tier1','all',3975,3445,'Def: 50'),(3982,'crocodile boots',0,0,3,9.00,'Boots','','tier1','all',3982,3556,'Arm: 3'),(3983,'bast skirt',0,0,3,10.00,'Legs','','tier1','all',3983,3560,'Arm: 3'),(4846,'iron hammer',18,10,0,66.00,'Club','','tier1','all',2422,3310,'Atk: 45, Def: 20'),(4847,'spectral dress',0,0,5,10.00,'Armor','','tier1','all',4847,4836,'Arm: 5'),(5461,'helmet of the deep',0,0,2,210.00,'Helmet','','tier1','all',5461,5460,'Arm: 2'),(5779,'arrow',0,0,0,0.00,'Ammo','','tier1','all',2544,3447,'Atk: 10'),(5858,'scimitar',0,0,0,0.00,'Equipamento','','tier1','all',2419,3307,'Atk: 48, Def: 22'),(5917,'bandana',0,0,6,8.50,'Equipamento','','tier1','all',5917,5917,'Arm: 6'),(5924,'damaged steel helmet',0,0,10,46.00,'Helmet','The words \'Ramsay the Reckless\' are engraved inside. It appears to be cracked and broken.','tier1','all',5924,5924,'Arm: 10'),(6131,'tortoise shield',0,136,0,52.00,'Shield','','tier2','all',0,0,''),(6578,'party hat',0,0,5,0.00,'Helmet','','tier1','all',6578,6578,'Arm: 5'),(7363,'piercing bolt',300,0,0,0.80,'Ammo','','tier2','all',0,0,''),(7364,'sniper arrow',180,0,0,0.70,'Ammo','','tier2','all',0,0,''),(7365,'onyx arrow',90,0,0,0.70,'Ammo','','tier2','all',0,0,''),(7379,'brutetamer\'s staff',285,65,0,38.00,'Club','Barbarian women are said to use it for conjuring beasts.','tier2','all',0,0,''),(7380,'headchopper',42,20,0,45.00,'Axe','','tier2','all',0,0,''),(7381,'mammoth whopper',60,25,0,45.00,'Club','Made from a mammoth\'s legbones, it is one of the favoured weapons among barbarians.','tier1','all',7381,7381,'Atk: 60, Def: 25'),(7385,'crimson sword',165,54,0,36.00,'Sword','','tier2','all',0,0,''),(7387,'diamond sceptre',162,50,0,15.00,'Club','The beautiful jewel on the top of this sceptre is sharp enough to cut through glass.','tier2','all',0,0,''),(7389,'heroic axe',44,24,0,61.00,'Axe','','tier2','all',0,0,''),(7392,'orcish maul',42,18,0,54.00,'Club','','tier2','all',0,0,''),(7406,'blacksteel sword',42,22,0,59.00,'Sword','','tier2','all',0,0,''),(7415,'cranial basher',44,20,0,78.00,'Club','','tier2','all',0,0,''),(7419,'dreaded cleaver',422,81,0,38.00,'Axe','','tier2','all',0,0,''),(7425,'taurus mace',367,75,0,51.00,'Club','','tier2','all',0,0,''),(7426,'amber staff',326,70,0,35.00,'Club','','tier2','all',0,0,''),(7430,'dragonbone staff',244,60,0,18.00,'Club','Small flames are dancing around this strange weapon.','tier2','all',0,0,''),(7432,'furry club',40,20,0,42.00,'Club','','tier1','all',7432,7432,'Atk: 40, Def: 20'),(7434,'royal axe',315,68,0,92.00,'Axe','','tier2','all',0,0,''),(7449,'crystal sword',393,78,0,69.00,'Sword','','tier2','all',0,0,''),(7454,'glorious axe',281,64,0,95.00,'Axe','','tier2','all',0,0,''),(7457,'fur boots',0,0,4,12.00,'Boots','These boots keep your toes warm in even the iciest regions but they feel kind of heavy.','tier1','all',7457,7457,'Arm: 4'),(7458,'fur hood',0,0,45,18.00,'Equipamento','','tier2','all',0,0,''),(7459,'earmuffs',0,0,8,5.00,'Equipamento','','tier2','all',0,0,''),(7464,'fur shorts',0,0,27,15.00,'Legs','','tier2','all',0,0,''),(7497,'mining helmet',0,0,1,7.00,'Helmet','','tier2','all',0,0,''),(7744,'spike sword',24,21,0,50.00,'Sword','','tier2','all',0,0,''),(7747,'blacksteel sword',42,22,0,59.00,'Sword','','tier2','all',0,0,''),(7749,'barbarian axe',28,18,0,51.00,'Axe','','tier1','all',2429,3317,'Atk: 55, Def: 22'),(7751,'heroic axe',44,24,0,61.00,'Axe','','tier2','all',0,0,''),(7752,'headchopper',42,20,0,45.00,'Axe','','tier2','all',0,0,''),(7754,'clerical mace',28,15,0,58.00,'Club','','tier1','all',2423,3311,'Atk: 72, Def: 30'),(7755,'crystal mace',38,16,0,80.00,'Club','','tier2','all',0,0,''),(7756,'cranial basher',44,20,0,78.00,'Club','','tier2','all',0,0,''),(7757,'orcish maul',42,18,0,54.00,'Club','','tier2','all',0,0,''),(7758,'war hammer',45,10,0,85.00,'Club','','tier1','all',2391,3279,'Atk: 65, Def: 25'),(7763,'spike sword',24,21,0,50.00,'Sword','','tier2','all',0,0,''),(7766,'blacksteel sword',42,22,0,59.00,'Sword','','tier2','all',0,0,''),(7768,'barbarian axe',28,18,0,51.00,'Axe','','tier1','all',2429,3317,'Atk: 55, Def: 22'),(7770,'heroic axe',44,24,0,61.00,'Axe','','tier2','all',0,0,''),(7771,'headchopper',42,20,0,45.00,'Axe','','tier2','all',0,0,''),(7773,'clerical mace',28,15,0,58.00,'Club','','tier1','all',2423,3311,'Atk: 72, Def: 30'),(7774,'crystal mace',38,16,0,80.00,'Club','','tier2','all',0,0,''),(7775,'cranial basher',44,20,0,78.00,'Club','','tier2','all',0,0,''),(7776,'orcish maul',42,18,0,54.00,'Club','','tier2','all',0,0,''),(7777,'war hammer',45,10,0,85.00,'Club','','tier1','all',2391,3279,'Atk: 65, Def: 25'),(7854,'spike sword',24,21,0,50.00,'Sword','','tier2','all',0,0,''),(7857,'blacksteel sword',42,22,0,59.00,'Sword','','tier2','all',0,0,''),(7859,'barbarian axe',28,18,0,51.00,'Axe','','tier1','all',2429,3317,'Atk: 55, Def: 22'),(7861,'heroic axe',44,24,0,61.00,'Axe','','tier2','all',0,0,''),(7862,'headchopper',42,20,0,45.00,'Axe','','tier2','all',0,0,''),(7864,'clerical mace',28,15,0,58.00,'Club','','tier1','all',2423,3311,'Atk: 72, Def: 30'),(7865,'crystal mace',38,16,0,80.00,'Club','','tier2','all',0,0,''),(7866,'cranial basher',44,20,0,78.00,'Club','','tier2','all',0,0,''),(7867,'orcish maul',42,18,0,54.00,'Club','','tier2','all',0,0,''),(7868,'war hammer',45,10,0,85.00,'Club','','tier1','all',2391,3279,'Atk: 65, Def: 25'),(7869,'spike sword',108,48,0,50.00,'Sword','','tier2','all',0,0,''),(7872,'blacksteel sword',365,75,0,59.00,'Sword','','tier2','all',0,0,''),(7874,'barbarian axe',28,18,0,51.00,'Axe','','tier1','all',2429,3317,'Atk: 55, Def: 22'),(7876,'heroic axe',248,60,0,61.00,'Axe','','tier2','all',0,0,''),(7877,'headchopper',214,56,0,45.00,'Axe','','tier2','all',0,0,''),(7879,'clerical mace',28,15,0,58.00,'Club','','tier1','all',2423,3311,'Atk: 72, Def: 30'),(7880,'crystal mace',121,45,0,80.00,'Club','','tier2','all',0,0,''),(7881,'cranial basher',408,80,0,78.00,'Club','','tier2','all',0,0,''),(7882,'orcish maul',203,55,0,54.00,'Club','','tier2','all',0,0,''),(7883,'war hammer',45,10,0,85.00,'Club','','tier1','all',2391,3279,'Atk: 65, Def: 25'),(7884,'terra mantle',0,0,100,22.50,'Equipamento','','tier2','all',0,0,''),(7886,'terra boots',0,0,21,7.50,'Boots','','tier2','all',0,0,''),(7891,'magma boots',0,0,13,7.50,'Boots','','tier2','all',0,0,''),(7892,'glacier shoes',0,0,4,7.50,'Boots','','tier2','all',0,0,''),(7893,'lightning boots',0,0,30,7.50,'Boots','','tier2','all',0,0,''),(7895,'lightning legs',0,0,62,19.00,'Legs','','tier2','all',0,0,''),(7898,'lightning robe',0,0,79,22.50,'Armor','','tier2','all',0,0,''),(7939,'mining helmet',0,0,41,7.00,'Helmet','','tier2','all',0,0,''),(8190,'spellbook',0,0,0,0.00,'Spellbook','','tier1','all',2175,648,'Def: 15'),(8602,'jagged sword',80,45,0,18.00,'Sword','','tier2','all',0,0,''),(8819,'magician\'s robe',0,0,8,25.00,'Armor','This robe feels soft and light as a feather.','tier1','all',8819,7991,'Arm: 8, Magic Level +1'),(8820,'mage hat',0,0,4,7.50,'Helmet','','tier1','all',8820,7992,'Arm: 4, Magic Level +1'),(8849,'modified crossbow',50,0,0,35.00,'Crossbow','','tier2','all',0,0,''),(8855,'composite hornbow',60,0,0,52.00,'Bow','','tier2','all',0,0,''),(8870,'spirit cloak',0,0,72,26.50,'Armor','','tier2','all',0,0,''),(8872,'belted cape',0,0,10,35.00,'Helmet','','tier1','all',8872,8044,'Arm: 10'),(8873,'hibiscus dress',0,0,4,19.00,'Armor','','tier1','all',8873,8045,'Arm: 4'),(8874,'summer dress',0,0,3,10.00,'Armor','','tier1','all',8874,8046,'Arm: 3'),(8875,'tunic',0,0,3,15.00,'Armor','','tier1','all',8875,8047,'Arm: 3'),(8876,'girl\'s dress',0,0,2,13.00,'Armor','','tier1','all',8876,8048,'Arm: 2'),(8900,'spellbook of enlightenment',0,40,0,45.00,'Spellbook','It shows your spells and can also shield against attack when worn.','tier1','all',8900,8072,'Def: 40, Magic Level +1'),(8901,'spellbook novice',0,20,0,45.00,'Spellbook','','tier2','all',0,0,''),(8902,'spellbook of mind control',0,35,0,45.00,'Spellbook','It shows your spells and can also shield against attack when worn.','tier2','all',0,0,''),(8911,'northwind rod',0,0,0,29.00,'Rod','','tier2','all',0,0,''),(8921,'wand of draconia',0,0,0,27.00,'Wand','A York Wand.','tier2','all',0,0,''),(8923,'ranger legs',0,0,44,35.00,'Legs','','tier2','all',0,0,''),(9927,'flower wreath',0,0,33,5.00,'Equipamento','','tier2','all',0,0,'');
/*!40000 ALTER TABLE `web_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `web_lores`
--

DROP TABLE IF EXISTS `web_lores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `web_lores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `web_lores`
--

LOCK TABLES `web_lores` WRITE;
/*!40000 ALTER TABLE `web_lores` DISABLE KEYS */;
/*!40000 ALTER TABLE `web_lores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `web_monster_loot`
--

DROP TABLE IF EXISTS `web_monster_loot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `web_monster_loot` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `monster_id` int(11) NOT NULL,
  `itemid` int(11) DEFAULT 0,
  `name` varchar(100) DEFAULT NULL,
  `chance` decimal(10,2) DEFAULT 0.00,
  `countmax` int(11) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `idx_monster` (`monster_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3265 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `web_monster_loot`
--

LOCK TABLES `web_monster_loot` WRITE;
/*!40000 ALTER TABLE `web_monster_loot` DISABLE KEYS */;
INSERT INTO `web_monster_loot` VALUES (2721,301,2142,'ancient amulet',3.50,1),(2722,301,2231,'big bone',9.00,1),(2723,301,2144,'black pearl',15.00,15),(2724,301,2158,'blue gem',1.50,1),(2725,301,2195,'boots of haste',4.00,1),(2726,301,2192,'crystal ball',2.50,1),(2727,301,2125,'crystal necklace',1.50,1),(2728,301,2124,'crystal ring',5.50,1),(2729,301,2520,'demon shield',15.50,1),(2730,301,2462,'devil helmet',11.00,1),(2731,301,2387,'double axe',20.00,1),(2732,301,2434,'dragon hammer',4.50,1),(2733,301,2167,'energy ring',13.50,1),(2734,301,2432,'fire axe',17.00,1),(2735,301,2393,'giant sword',12.50,1),(2736,301,2148,'gold coin',99.90,100),(2737,301,2148,'gold coin',88.80,100),(2738,301,2148,'gold coin',77.70,100),(2739,301,2148,'gold coin',66.60,100),(2740,301,2179,'gold ring',8.00,1),(2741,301,2470,'golden legs',5.00,1),(2742,301,2033,'golden mug',7.50,1),(2743,301,2418,'golden sickle',4.50,1),(2744,301,2155,'green gem',1.50,1),(2745,301,2396,'ice rapier',7.50,1),(2746,301,2177,'life crystal',1.00,1),(2747,301,2162,'magic lightwand',11.50,1),(2748,301,2472,'magic plate armor',3.00,1),(2749,301,2514,'mastermind shield',7.50,1),(2750,301,2164,'might ring',5.00,1),(2751,301,2178,'mind stone',4.00,1),(2752,301,2186,'moonlight rod',3.50,1),(2753,301,2176,'orb',12.00,1),(2754,301,2171,'platinum amulet',4.50,1),(2755,301,2200,'protection amulet',4.50,1),(2756,301,1982,'purple tome',2.60,1),(2757,301,2214,'ring of healing',13.00,1),(2758,301,2123,'ring of the sky',3.50,1),(2759,301,2170,'silver amulet',13.00,1),(2760,301,2402,'silver dagger',15.50,1),(2761,301,2436,'skull staff',5.00,1),(2762,301,2150,'small amethyst',13.50,20),(2763,301,2145,'small diamond',9.50,5),(2764,301,2149,'small emerald',15.50,10),(2765,301,2146,'small sapphire',13.50,10),(2766,301,2182,'snakebite rod',3.50,1),(2767,301,2165,'stealth ring',9.50,1),(2768,301,2197,'stone skin amulet',4.00,1),(2769,301,2174,'strange symbol',2.50,1),(2770,301,2151,'talon',14.00,7),(2771,301,2112,'addon doll',14.50,1),(2772,301,2421,'thunder hammer',13.50,1),(2773,301,2377,'two handed sword',20.00,1),(2774,301,2185,'necrotic rod',3.50,1),(2775,301,3955,'voodoo doll',0.10,1),(2776,301,2188,'wand of decay',2.50,1),(2777,301,2143,'white pearl',12.50,15),(2778,303,2148,'gold coin',100.00,100),(2779,303,2152,'platinum coin',100.00,100),(2780,303,7438,'solar bow',3.00,1),(2781,303,2516,'dragon shield',3.00,1),(2782,303,2438,'epee',3.00,1),(2783,303,2463,'plate armor',3.00,1),(2784,303,7449,'crystal sword',0.20,1),(2785,303,2531,'viking shield',0.20,1),(2786,303,7419,'dreaded cleaver',0.20,1),(2787,304,2148,'gold coin',100.00,100),(2788,304,2152,'platinum coin',100.00,100),(2789,304,2515,'guardian shield',3.00,1),(2790,304,7434,'royal axe',3.00,1),(2791,304,2516,'dragon shield',3.00,1),(2792,304,7430,'dragonbone staff',3.00,1),(2793,304,7893,'lightning boots',0.20,1),(2794,304,2491,'crown helmet',0.20,1),(2795,304,8870,'spirit cloak',0.20,1),(2796,305,2148,'gold coin',100.00,100),(2797,305,2152,'platinum coin',100.00,40),(2798,305,2377,'two handed sword',30.00,1),(2799,305,2540,'scarab shield',30.00,1),(2800,305,8602,'jagged sword',30.00,1),(2801,305,2383,'spike sword',30.00,1),(2802,306,2148,'gold coin',100.00,100),(2803,306,2152,'platinum coin',100.00,90),(2804,306,2484,'studded armor',30.00,1),(2805,306,2521,'dark shield',30.00,1),(2806,306,3967,'tribal mask',30.00,1),(2807,306,7430,'dragonbone staff',3.00,1),(2808,306,3970,'feather headdress',3.00,1),(2809,307,2148,'gold coin',30.00,0),(2810,307,8876,'girl\'s dress',12.00,0),(2811,307,2482,'studded helmet',10.00,0),(2812,307,2387,'double axe',10.00,0),(2813,308,2148,'gold coin',40.00,0),(2814,308,3973,'tusk shield',0.80,0),(2815,308,2652,'green tunic',1.20,0),(2816,308,7381,'mammoth whopper',1.00,0),(2817,308,2419,'scimitar',1.00,0),(2818,308,2429,'barbarian axe',1.00,0),(2819,308,2490,'dark helmet',1.00,0),(2820,308,2481,'soldier helmet',1.20,0),(2821,309,2148,'gold coin',40.00,0),(2822,309,3973,'tusk shield',2.00,0),(2823,309,8872,'belted cape',1.00,0),(2824,309,2391,'war hammer',0.80,0),(2825,309,2442,'heavy machete',0.80,0),(2826,309,2378,'battle axe',0.80,0),(2827,309,2321,'giant smithhammer',0.80,0),(2828,309,2473,'viking helmet',1.00,0),(2829,309,2478,'brass legs',1.20,0),(2830,309,2410,'throwing knife',3.00,0),(2831,309,2186,'moonlight rod',10.00,0),(2832,309,2191,'wand of dragonbreath',10.00,0),(2833,310,2148,'gold coin',40.00,0),(2834,310,8900,'spellbook of enlightenment',2.00,0),(2835,310,8819,'magician\'s robe',1.50,0),(2836,310,2423,'clerical mace',0.30,0),(2837,310,2395,'carlin sword',0.30,0),(2838,310,2397,'longsword',0.20,0),(2839,310,2185,'necrotic rod',10.00,0),(2840,310,2188,'wand of decay',10.00,0),(2841,311,2148,'gold coin',35.00,0),(2842,311,2513,'battle shield',1.50,0),(2843,311,2653,'red tunic',3.00,0),(2844,311,2449,'bone club',2.00,0),(2845,311,2401,'staff',2.00,0),(2846,311,2655,'red robe',2.00,0),(2847,311,3974,'sentinel shield',1.50,0),(2848,311,8820,'mage hat',2.00,0),(2849,311,6578,'party hat',1.50,0),(2850,311,2663,'mystic turban',2.00,0),(2851,311,5917,'bandana',2.00,0),(2852,311,7457,'fur boots',2.50,0),(2853,312,2148,'gold coin',35.00,0),(2854,312,2513,'battle shield',1.50,0),(2855,312,2653,'red tunic',3.00,0),(2856,312,2449,'bone club',2.00,0),(2857,312,2401,'staff',2.00,0),(2858,312,2655,'red robe',2.00,0),(2859,312,3974,'sentinel shield',1.50,0),(2860,312,8820,'mage hat',2.00,0),(2861,312,6578,'party hat',1.50,0),(2862,312,2663,'mystic turban',2.00,0),(2863,312,5917,'bandana',2.00,0),(2864,312,7457,'fur boots',2.50,0),(2865,313,2148,'gold coin',100.00,100),(2866,313,2152,'platinum coin',100.00,90),(2867,313,2647,'plate legs',30.00,1),(2868,313,2445,'crystal mace',30.00,1),(2869,313,7365,'onyx arrow',30.00,1),(2870,313,3970,'feather headdress',3.00,1),(2871,313,2528,'tower shield',3.00,1),(2872,314,2148,'gold coin',100.00,100),(2873,314,2152,'platinum coin',100.00,100),(2874,314,2479,'strange helmet',30.00,1),(2875,314,2647,'plate legs',30.00,1),(2876,314,2383,'spike sword',30.00,1),(2877,314,7464,'fur shorts',3.00,1),(2878,314,2323,'hat of the mad',3.00,1),(2879,315,2148,'gold coin',40.00,0),(2880,315,8900,'spellbook of enlightenment',2.00,0),(2881,315,8819,'magician\'s robe',1.50,0),(2882,315,2423,'clerical mace',0.30,0),(2883,315,2395,'carlin sword',0.30,0),(2884,315,2397,'longsword',0.20,0),(2885,315,2185,'necrotic rod',10.00,0),(2886,315,2188,'wand of decay',10.00,0),(2887,316,2148,'gold coin',100.00,100),(2888,316,2152,'platinum coin',100.00,100),(2889,316,7454,'glorious axe',3.00,1),(2890,316,2438,'epee',3.00,1),(2891,316,2463,'plate armor',3.00,1),(2892,316,9927,'flower wreath',3.00,1),(2893,316,7406,'blacksteel sword',0.20,1),(2894,316,2457,'steel helmet',0.20,1),(2895,316,7897,'xas robe',0.20,1),(2896,317,3976,'worm',100.00,0),(2897,317,2148,'gold coin',100.00,0),(2898,317,1987,'bag',100.00,0),(2899,317,2381,'halberd',2.90,0),(2900,317,2398,'mace',10.00,0),(2901,317,2050,'torch',20.00,0),(2902,317,7620,'mana potion',4.00,0),(2903,317,2168,'life ring',2.00,0),(2904,317,2185,'necrotic rod',10.00,0),(2905,317,2188,'wand of decay',10.00,0),(2906,318,2148,'gold coin',30.00,0),(2907,318,2461,'leather helmet',12.00,0),(2908,318,2388,'hatchet',10.00,0),(2909,318,2403,'knife',10.00,0),(2910,319,2148,'gold coin',35.00,0),(2911,319,2509,'steel shield',3.50,0),(2912,319,2650,'jacket',4.00,0),(2913,319,7432,'furry club',3.50,0),(2914,319,2420,'machete',3.00,0),(2915,319,2441,'daramanian axe',3.00,0),(2916,319,2458,'chain helmet',4.00,0),(2917,319,2543,'bolt',12.00,0),(2918,320,2148,'gold coin',35.00,0),(2919,320,2509,'steel shield',3.50,0),(2920,320,2650,'jacket',4.00,0),(2921,320,7432,'furry club',3.50,0),(2922,320,2420,'machete',3.00,0),(2923,320,2441,'daramanian axe',3.00,0),(2924,320,2458,'chain helmet',4.00,0),(2925,320,2543,'bolt',12.00,0),(2926,321,2148,'gold coin',100.00,100),(2927,321,2152,'platinum coin',100.00,100),(2928,321,2521,'dark shield',30.00,1),(2929,321,2525,'dwarven shield',30.00,1),(2930,321,2528,'tower shield',3.00,1),(2931,321,7464,'fur shorts',3.00,1),(2932,321,2413,'broadsword',3.00,1),(2933,321,7363,'piercing bolt',0.20,1),(2934,322,2148,'gold coin',100.00,100),(2935,322,2152,'platinum coin',100.00,100),(2936,322,2528,'tower shield',3.00,1),(2937,322,7939,'mining helmet',3.00,1),(2938,322,7454,'glorious axe',3.00,1),(2939,322,7364,'sniper arrow',3.00,1),(2940,322,2399,'throwing star',0.20,1),(2941,322,2531,'viking shield',0.20,1),(2942,322,7406,'blacksteel sword',0.20,1),(2943,323,2148,'gold coin',100.00,100),(2944,323,2152,'platinum coin',100.00,100),(2945,323,2516,'dragon shield',3.00,1),(2946,323,7430,'dragonbone staff',3.00,1),(2947,323,2463,'plate armor',3.00,1),(2948,323,2660,'ranger\'s cloak',3.00,1),(2949,323,7898,'lightning robe',0.20,1),(2950,323,7425,'taurus mace',0.20,1),(2951,323,2457,'steel helmet',0.20,1),(2952,323,2187,'wand of inferno',30.00,1),(2953,323,2183,'hailstorm rod',30.00,1),(2954,324,2148,'gold coin',100.00,100),(2955,324,2152,'platinum coin',100.00,100),(2956,324,7389,'heroic axe',3.00,1),(2957,324,7939,'mining helmet',3.00,1),(2958,324,8923,'ranger legs',3.00,1),(2959,324,2413,'broadsword',3.00,1),(2960,324,2396,'ice rapier',0.20,1),(2961,324,2491,'crown helmet',0.20,1),(2962,324,7419,'dreaded cleaver',0.20,1),(2963,325,2148,'gold coin',100.00,100),(2964,325,2152,'platinum coin',100.00,40),(2965,325,2540,'scarab shield',30.00,1),(2966,325,2383,'spike sword',30.00,1),(2967,325,2525,'dwarven shield',30.00,1),(2968,325,7392,'orcish maul',30.00,1),(2969,326,2148,'gold coin',30.00,0),(2970,326,2526,'studded shield',12.00,0),(2971,326,2643,'leather boots',15.00,0),(2972,326,2650,'jacket',5.00,0),(2973,326,2544,'arrow',25.00,0),(2974,327,2148,'gold coin',100.00,100),(2975,327,2152,'platinum coin',100.00,40),(2976,327,2427,'guardian halberd',30.00,1),(2977,327,3967,'tribal mask',30.00,1),(2978,327,2428,'orcish axe',30.00,1),(2979,327,2525,'dwarven shield',30.00,1),(2980,328,2148,'gold coin',100.00,100),(2981,328,2152,'platinum coin',100.00,90),(2982,328,2426,'naginata',30.00,1),(2983,328,2409,'serpent sword',30.00,1),(2984,328,2428,'orcish axe',30.00,1),(2985,328,7891,'magma boots',3.00,1),(2986,328,2659,'ball gown',3.00,1),(2987,329,2148,'gold coin',40.00,0),(2988,329,8900,'spellbook of enlightenment',2.00,0),(2989,329,8819,'magician\'s robe',0.60,0),(2990,329,2439,'daramanian mace',0.50,0),(2991,329,2450,'bone sword',0.50,0),(2992,329,2405,'sickle',0.50,0),(2993,329,2175,'spellbook',0.60,0),(2994,329,5924,'damaged steel helmet',0.50,0),(2995,329,2644,'bunny slippers',0.80,0),(2996,329,2455,'crossbow',1.50,0),(2997,330,2148,'gold coin',100.00,100),(2998,330,2152,'platinum coin',100.00,100),(2999,330,7464,'fur shorts',3.00,1),(3000,330,7379,'brutetamer\'s staff',3.00,1),(3001,330,9927,'flower wreath',3.00,1),(3002,330,7434,'royal axe',3.00,1),(3003,330,7425,'taurus mace',0.20,1),(3004,330,7897,'xas robe',0.20,1),(3005,330,7893,'lightning boots',0.20,1),(3006,331,2148,'gold coin',40.00,0),(3007,331,3973,'tusk shield',2.00,0),(3008,331,8872,'belted cape',1.00,0),(3009,331,2391,'war hammer',0.80,0),(3010,331,2442,'heavy machete',0.80,0),(3011,331,2378,'battle axe',0.80,0),(3012,331,2321,'giant smithhammer',0.80,0),(3013,331,2473,'viking helmet',1.00,0),(3014,331,2478,'brass legs',1.20,0),(3015,331,2410,'throwing knife',3.00,0),(3016,331,2186,'moonlight rod',10.00,0),(3017,331,2191,'wand of dragonbreath',10.00,0),(3018,332,2148,'gold coin',100.00,100),(3019,332,2152,'platinum coin',100.00,100),(3020,332,9927,'flower wreath',3.00,1),(3021,332,3970,'feather headdress',3.00,1),(3022,332,7434,'royal axe',3.00,1),(3023,332,7939,'mining helmet',3.00,1),(3024,332,7419,'dreaded cleaver',0.20,1),(3025,332,2418,'golden sickle',0.20,1),(3026,332,3961,'lich staff',0.20,1),(3027,332,2187,'wand of inferno',30.00,1),(3028,332,2183,'hailstorm rod',30.00,1),(3029,333,2148,'gold coin',40.00,0),(3030,333,3973,'tusk shield',2.00,0),(3031,333,8872,'belted cape',1.00,0),(3032,333,2391,'war hammer',0.80,0),(3033,333,2442,'heavy machete',0.80,0),(3034,333,2378,'battle axe',0.80,0),(3035,333,2321,'giant smithhammer',0.80,0),(3036,333,2473,'viking helmet',1.00,0),(3037,333,2478,'brass legs',1.20,0),(3038,333,2410,'throwing knife',3.00,0),(3039,334,2148,'gold coin',40.00,0),(3040,334,8900,'spellbook of enlightenment',2.00,0),(3041,334,8819,'magician\'s robe',0.60,0),(3042,334,2439,'daramanian mace',0.50,0),(3043,334,2450,'bone sword',0.50,0),(3044,334,2405,'sickle',0.50,0),(3045,334,2175,'spellbook',0.60,0),(3046,334,5924,'damaged steel helmet',0.50,0),(3047,334,2644,'bunny slippers',0.80,0),(3048,334,2455,'crossbow',1.50,0),(3049,335,2148,'gold coin',40.00,0),(3050,335,8900,'spellbook of enlightenment',2.00,0),(3051,335,8819,'magician\'s robe',0.60,0),(3052,335,2439,'daramanian mace',0.50,0),(3053,335,2450,'bone sword',0.50,0),(3054,335,2405,'sickle',0.50,0),(3055,335,2175,'spellbook',0.60,0),(3056,335,5924,'damaged steel helmet',0.50,0),(3057,335,2644,'bunny slippers',0.80,0),(3058,335,2455,'crossbow',1.50,0),(3059,336,2148,'gold coin',100.00,100),(3060,336,2152,'platinum coin',100.00,90),(3061,336,2540,'scarab shield',30.00,1),(3062,336,2409,'serpent sword',30.00,1),(3063,336,2485,'doublet',30.00,1),(3064,336,2463,'plate armor',3.00,1),(3065,336,2413,'broadsword',3.00,1),(3066,337,2148,'gold coin',40.00,0),(3067,337,8900,'spellbook of enlightenment',2.00,0),(3068,337,8819,'magician\'s robe',1.50,0),(3069,337,2321,'giant smithhammer',0.80,0),(3070,337,2442,'heavy machete',0.80,0),(3071,337,2378,'battle axe',0.80,0),(3072,337,2391,'war hammer',0.80,0),(3073,337,8872,'belted cape',1.00,0),(3074,337,2473,'viking helmet',1.00,0),(3075,337,2478,'brass legs',1.20,0),(3076,337,2410,'throwing knife',3.00,0),(3077,338,2148,'gold coin',12.00,10),(3078,338,2667,'fish',32.00,1),(3079,338,2389,'spear',12.00,1),(3080,338,2422,'iron hammer',0.32,2),(3081,338,3982,'crocodile boots',0.32,2),(3082,338,2384,'rapier',3.50,1),(3083,338,2387,'double axe',4.00,1),(3084,338,2511,'brass shield',3.50,1),(3085,338,8873,'hibiscus dress',5.00,1),(3086,339,2148,'gold coin',100.00,100),(3087,339,2152,'platinum coin',100.00,40),(3088,339,2480,'legion helmet',30.00,1),(3089,339,2521,'dark shield',30.00,1),(3090,339,7459,'earmuffs',30.00,1),(3091,339,2467,'leather armor',30.00,1),(3092,340,2148,'gold coin',100.00,100),(3093,340,2152,'platinum coin',100.00,100),(3094,340,2483,'scale armor',30.00,1),(3095,340,7392,'orcish maul',30.00,1),(3096,340,7454,'glorious axe',3.00,1),(3097,340,2447,'doublet axe',3.00,1),(3098,340,7430,'dragonbone staff',3.00,1),(3099,340,7406,'blacksteel sword',0.20,1),(3100,341,2148,'gold coin',40.00,0),(3101,341,8900,'spellbook of enlightenment',2.00,0),(3102,341,8819,'magician\'s robe',0.60,0),(3103,341,2439,'daramanian mace',0.50,0),(3104,341,2450,'bone sword',0.50,0),(3105,341,2405,'sickle',0.50,0),(3106,341,2175,'spellbook',0.60,0),(3107,341,5924,'damaged steel helmet',0.50,0),(3108,341,2644,'bunny slippers',0.80,0),(3109,341,2455,'crossbow',1.50,0),(3110,342,2148,'gold coin',100.00,100),(3111,342,2152,'platinum coin',100.00,100),(3112,342,7459,'earmuffs',30.00,1),(3113,342,7392,'orcish maul',30.00,1),(3114,342,7458,'fur hood',3.00,1),(3115,342,7464,'fur shorts',3.00,1),(3116,342,2515,'guardian shield',3.00,1),(3117,342,2491,'crown helmet',0.20,1),(3118,343,2148,'gold coin',100.00,100),(3119,343,2152,'platinum coin',100.00,100),(3120,343,2660,'ranger\'s cloak',3.00,1),(3121,343,7389,'heroic axe',3.00,1),(3122,343,7438,'solar bow',3.00,1),(3123,343,2659,'ball gown',3.00,1),(3124,343,2425,'obsidian lance',0.20,1),(3125,343,2414,'dragon lance',0.20,1),(3126,343,2645,'steel boots',0.20,1),(3127,344,2148,'gold coin',40.00,0),(3128,344,8900,'spellbook of enlightenment',2.00,0),(3129,344,8819,'magician\'s robe',0.60,0),(3130,344,2321,'giant smithhammer',2.00,0),(3131,344,2450,'bone sword',0.50,0),(3132,344,2405,'sickle',0.50,0),(3133,344,2439,'daramanian mace',0.50,0),(3134,344,2175,'spellbook',0.60,0),(3135,344,5924,'damaged steel helmet',0.50,0),(3136,344,2644,'bunny slippers',0.80,0),(3137,344,2455,'crossbow',1.50,0),(3138,345,2148,'gold coin',35.00,0),(3139,345,2530,'copper shield',3.50,0),(3140,345,8873,'hibiscus dress',5.00,0),(3141,345,2398,'mace',3.50,0),(3142,345,2384,'rapier',3.50,0),(3143,345,2387,'double axe',4.00,0),(3144,345,2511,'brass shield',3.50,0),(3145,345,2389,'spear',12.00,0),(3146,346,2148,'gold coin',100.00,100),(3147,346,2152,'platinum coin',100.00,100),(3148,346,8602,'jagged sword',30.00,1),(3149,346,2383,'spike sword',30.00,1),(3150,346,7939,'mining helmet',3.00,1),(3151,346,2447,'doublet axe',3.00,1),(3152,346,2463,'plate armor',3.00,1),(3153,346,2418,'golden sickle',0.20,1),(3154,347,2148,'gold coin',100.00,100),(3155,347,2152,'platinum coin',100.00,100),(3156,347,7392,'orcish maul',30.00,1),(3157,347,2525,'dwarven shield',30.00,1),(3158,347,7454,'glorious axe',3.00,1),(3159,347,8901,'spellbook novice',3.00,1),(3160,347,2447,'doublet axe',3.00,1),(3161,347,7363,'piercing bolt',0.20,1),(3162,347,2189,'wand of cosmic energy',30.00,1),(3163,347,2181,'terra rod',30.00,1),(3164,348,2148,'gold coin',100.00,100),(3165,348,2152,'platinum coin',100.00,90),(3166,348,7380,'headchopper',30.00,1),(3167,348,7365,'onyx arrow',30.00,1),(3168,348,2525,'dwarven shield',30.00,1),(3169,348,2660,'ranger\'s cloak',3.00,1),(3170,348,2659,'ball gown',3.00,1),(3171,349,2148,'gold coin',100.00,100),(3172,349,2152,'platinum coin',100.00,90),(3173,349,2480,'legion helmet',30.00,1),(3174,349,2483,'scale armor',30.00,1),(3175,349,2434,'dragon hammer',30.00,1),(3176,349,2660,'ranger\'s cloak',3.00,1),(3177,349,7886,'terra boots',3.00,1),(3178,350,2148,'gold coin',100.00,100),(3179,350,2152,'platinum coin',100.00,90),(3180,350,2464,'chain armor',30.00,1),(3181,350,7385,'crimson sword',30.00,1),(3182,350,2407,'bright sword',30.00,1),(3183,350,2413,'broadsword',3.00,1),(3184,350,7939,'mining helmet',3.00,1),(3185,351,2148,'gold coin',100.00,100),(3186,351,2152,'platinum coin',100.00,90),(3187,351,2483,'scale armor',30.00,1),(3188,351,2409,'serpent sword',30.00,1),(3189,351,8602,'jagged sword',30.00,1),(3190,351,2447,'doublet axe',3.00,1),(3191,351,2465,'brass armor',3.00,1),(3192,352,2148,'gold coin',100.00,100),(3193,352,2152,'platinum coin',100.00,40),(3194,352,2521,'dark shield',30.00,1),(3195,352,2445,'crystal mace',30.00,1),(3196,352,2428,'orcish axe',30.00,1),(3197,352,7365,'onyx arrow',30.00,1),(3198,353,2148,'gold coin',100.00,100),(3199,353,2152,'platinum coin',100.00,100),(3200,353,2528,'tower shield',3.00,1),(3201,353,7364,'sniper arrow',3.00,1),(3202,353,7464,'fur shorts',3.00,1),(3203,353,2489,'dark armor',3.00,1),(3204,353,7899,'magma coat',0.20,1),(3205,353,2396,'ice rapier',0.20,1),(3206,353,7363,'piercing bolt',0.20,1),(3207,354,2148,'gold coin',35.00,0),(3208,354,3974,'sentinel shield',1.50,0),(3209,354,2655,'red robe',2.00,0),(3210,354,2401,'staff',2.00,0),(3211,354,2449,'bone club',2.00,0),(3212,354,2513,'battle shield',1.50,0),(3213,354,2653,'red tunic',3.00,0),(3214,354,8820,'mage hat',2.00,0),(3215,354,6578,'party hat',1.50,0),(3216,354,2663,'mystic turban',2.00,0),(3217,354,5917,'bandana',2.00,0),(3218,354,7457,'fur boots',2.50,0),(3219,355,2148,'gold coin',100.00,100),(3220,355,2152,'platinum coin',100.00,90),(3221,355,7385,'crimson sword',30.00,1),(3222,355,2426,'naginata',30.00,1),(3223,355,2480,'legion helmet',30.00,1),(3224,355,8901,'spellbook novice',3.00,1),(3225,355,2438,'epee',3.00,1),(3226,355,2189,'wand of cosmic energy',30.00,1),(3227,355,2181,'terra rod',30.00,1),(3228,356,2148,'gold coin',35.00,0),(3229,356,3975,'salamander shield',2.50,0),(3230,356,4847,'spectral dress',3.50,0),(3231,356,2422,'iron hammer',3.00,0),(3232,356,2376,'sword',2.50,0),(3233,356,2381,'halberd',2.50,0),(3234,356,2648,'chain legs',4.00,0),(3235,356,2182,'snakebite rod',10.00,0),(3236,356,2190,'wand of vortex',10.00,0),(3237,357,2148,'gold coin',30.00,0),(3238,357,2526,'studded shield',12.00,0),(3239,357,2643,'leather boots',15.00,0),(3240,357,2650,'jacket',5.00,0),(3241,357,2544,'arrow',25.00,0),(3242,357,2437,'cotonete',10.00,0),(3243,358,2148,'gold coin',100.00,100),(3244,358,2152,'platinum coin',100.00,40),(3245,358,2383,'spike sword',45.00,1),(3246,358,3965,'hunting spear',45.00,1),(3247,358,2427,'guardian halberd',45.00,1),(3248,358,2428,'orcish axe',45.00,1),(3249,359,2148,'gold coin',40.00,0),(3250,359,3973,'tusk shield',0.80,0),(3251,359,2652,'green tunic',1.20,0),(3252,359,7381,'mammoth whopper',1.00,0),(3253,359,2419,'scimitar',1.00,0),(3254,359,2429,'barbarian axe',1.00,0),(3255,359,2490,'dark helmet',1.00,0),(3256,359,2481,'soldier helmet',1.20,0),(3257,360,2148,'gold coin',40.00,0),(3258,360,3973,'tusk shield',0.80,0),(3259,360,2652,'green tunic',1.20,0),(3260,360,7381,'mammoth whopper',1.00,0),(3261,360,2419,'scimitar',1.00,0),(3262,360,2429,'barbarian axe',1.00,0),(3263,360,2490,'dark helmet',1.00,0),(3264,360,2481,'soldier helmet',1.20,0);
/*!40000 ALTER TABLE `web_monster_loot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `web_monsters`
--

DROP TABLE IF EXISTS `web_monsters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `web_monsters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `tier` varchar(20) DEFAULT 'tier1',
  `hp` int(11) DEFAULT 0,
  `xp` bigint(20) DEFAULT 0,
  `speed` int(11) DEFAULT 0,
  `looktype` int(11) DEFAULT 0,
  `level_range` varchar(50) DEFAULT NULL,
  `max_dano` varchar(50) DEFAULT NULL,
  `mage_hp` varchar(20) DEFAULT NULL,
  `pally_hp` varchar(20) DEFAULT NULL,
  `knight_hp` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_tier` (`tier`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=361 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `web_monsters`
--

LOCK TABLES `web_monsters` WRITE;
/*!40000 ALTER TABLE `web_monsters` DISABLE KEYS */;
INSERT INTO `web_monsters` VALUES (301,'toxiros','bosses',60000,25000,540,133,NULL,NULL,NULL,NULL,NULL),(302,'Aegis','bosses',100000,0,605,287,NULL,NULL,NULL,NULL,NULL),(303,'gnarlhound','tier2',4323200,5545400,206,341,NULL,NULL,NULL,NULL,NULL),(304,'insect swarm','tier2',4234800,5430600,100,349,NULL,NULL,NULL,NULL,NULL),(305,'sandcrawler','tier2',610400,723520,220,350,NULL,NULL,NULL,NULL,NULL),(306,'terramite','tier2',1140800,1412320,220,346,NULL,NULL,NULL,NULL,NULL),(307,'crazed beggar','tier1',7000,3150,220,153,'3500 ao 4000','550','2.9%','1.5%','1.0%'),(308,'gang member','tier1',31000,18750,220,151,'10k ao 10.5k','8.000','15.6%','7.8%','5.2%'),(309,'gladiator','tier1',25000,26250,200,131,'11k ao 11.5k','9.500','16.8%','8.4%','5.6%'),(310,'gozzler','tier1',24000,54000,200,313,'14.5k ao 15k','14.500','39.8%','19.9%','13.3%'),(311,'mutated rat','tier1',16000,14250,245,305,'8500 ao 9000','3.300','7.5%','3.8%','2.5%'),(312,'mutated human','tier1',17000,13500,245,323,'8500 ao 9000','1.045','2.4%','1.2%','0.8%'),(313,'mutated bat','tier2',2201600,2789990,345,307,NULL,NULL,NULL,NULL,NULL),(314,'mutated tiger','tier2',2113200,2675190,245,318,NULL,NULL,NULL,NULL,NULL),(315,'nightstalker','tier1',25000,56250,260,320,'14.5k ao 15k','15.000','41.2%','20.6%','13.8%'),(316,'war golem','tier2',4500000,5775000,270,326,NULL,NULL,NULL,NULL,NULL),(317,'Zombie','tier1',24000,54000,200,311,'14.5k ao 15k','14.500','39.8%','19.9%','13.3%'),(318,'primitive','tier1',1000,750,250,143,'1000 ao 1500','26','0.4%','0.2%','0.1%'),(319,'amazon','tier1',10000,9375,180,137,'7000 ao 7500','1.760','4.8%','2.4%','1.6%'),(320,'valkyrie','tier1',13000,10500,180,139,'7000 ao 7500','1.375','3.8%','1.9%','1.3%'),(321,'rotworm','tier2',2290000,2904860,180,26,NULL,NULL,NULL,NULL,NULL),(322,'kongra','tier2',3527600,4512130,184,116,NULL,NULL,NULL,NULL,NULL),(323,'merlkin','tier2',3704400,4741730,194,117,NULL,NULL,NULL,NULL,NULL),(324,'sibang','tier2',3616000,4626930,214,118,NULL,NULL,NULL,NULL,NULL),(325,'scorpion','tier2',875600,1067920,150,43,NULL,NULL,NULL,NULL,NULL),(326,'spider','tier1',200,375,152,30,'500 ao 1000','7','0.2%','0.1%','0.1%'),(327,'bear','tier2',168400,149450,350,16,NULL,NULL,NULL,NULL,NULL),(328,'panda','tier2',2024800,2560390,240,123,NULL,NULL,NULL,NULL,NULL),(329,'polar bear','tier1',28000,42000,156,42,'13.5k ao 14k','13.000','38.3%','19.2%','12.8%'),(330,'braindeath','tier2',4146400,5315800,270,256,NULL,NULL,NULL,NULL,NULL),(331,'beholder','tier1',27000,30750,150,17,'11.5k ao 12k','10.500','36.3%','18.2%','12.1%'),(332,'elder beholder','tier2',4058000,5201000,270,108,NULL,NULL,NULL,NULL,NULL),(333,'gazer','tier1',21000,28500,240,109,'11.5k ao 12k','10.000','34.6%','17.3%','11.6%'),(334,'carniphila','tier1',22000,48000,220,120,'14k ao 14.5k','13.500','18.9%','9.5%','6.3%'),(335,'spit nettle','tier1',15000,51000,0,221,'14k ao 14.5k','14.000','19.6%','9.8%','6.5%'),(336,'slime','tier2',1317600,1641920,120,19,NULL,NULL,NULL,NULL,NULL),(337,'bog raider','tier1',30000,33000,300,299,'12k ao 12.5k','11.000','17.9%','9.0%','6.0%'),(338,'penguin','tier1',8500,6750,220,250,'6000 ao 6500','1.650','5.3%','2.6%','1.8%'),(339,'terror bird','tier2',1052400,1297520,280,218,NULL,NULL,NULL,NULL,NULL),(340,'war wolf','tier2',3174000,4052930,200,3,NULL,NULL,NULL,NULL,NULL),(341,'winter wolf','tier1',20000,45000,200,52,'13.5k ao 14k','12.500','36.8%','18.5%','12.3%'),(342,'wolf','tier2',3085600,3938060,195,27,NULL,NULL,NULL,NULL,NULL),(343,'blood crab','tier2',3881200,4971330,210,200,NULL,NULL,NULL,NULL,NULL),(344,'novice of the cult','tier1',23000,39000,210,133,'13k ao 13.5k','12.000','18.1%','9.0%','6.0%'),(345,'fire devil','tier1',6000,6000,190,40,'5500 ao 6000','1.650','5.7%','2.9%','1.9%'),(346,'dworc fleshhunter','tier2',2908800,3708460,240,215,NULL,NULL,NULL,NULL,NULL),(347,'dworc voodoomaster','tier2',2997200,3823260,560,214,NULL,NULL,NULL,NULL,NULL),(348,'elephant','tier2',1494400,1871590,240,211,NULL,NULL,NULL,NULL,NULL),(349,'mammoth','tier2',1582800,1986390,240,199,NULL,NULL,NULL,NULL,NULL),(350,'lion','tier2',1759600,2215990,180,41,NULL,NULL,NULL,NULL,NULL),(351,'tiger','tier2',1406000,1756790,240,125,NULL,NULL,NULL,NULL,NULL),(352,'toad','tier2',345200,379050,240,222,NULL,NULL,NULL,NULL,NULL),(353,'gargoyle','tier2',3792800,4856530,250,95,NULL,NULL,NULL,NULL,NULL),(354,'stone golem','tier1',27000,15000,180,67,'9500 ao 10000','1.045','2.1%','1.1%','0.7%'),(355,'ghost','tier2',1848000,2330790,160,48,NULL,NULL,NULL,NULL,NULL),(356,'cyclops','tier1',20000,11625,200,22,'7500 ao 8000','3.850','9.9%','5.0%','3.3%'),(357,'bug','tier1',350,488,220,45,'500 ao 1000','32','0.8%','0.4%','0.3%'),(358,'centipede','tier2',698800,838320,195,124,NULL,NULL,NULL,NULL,NULL),(359,'larva','tier1',15000,24375,135,82,'10.5k ao 11k','6.000','22.7%','11.4%','7.6%'),(360,'scarab','tier1',28000,22500,160,83,'10.5k ao 11k','9.000','34.1%','17.1%','11.4%');
/*!40000 ALTER TABLE `web_monsters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `web_player_deaths`
--

DROP TABLE IF EXISTS `web_player_deaths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `web_player_deaths` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `level` int(11) DEFAULT 0,
  `time` int(11) DEFAULT 0,
  `killed_by` varchar(100) DEFAULT NULL,
  `is_player` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_player` (`player_id`),
  KEY `idx_killed_by` (`killed_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `web_player_deaths`
--

LOCK TABLES `web_player_deaths` WRITE;
/*!40000 ALTER TABLE `web_player_deaths` DISABLE KEYS */;
/*!40000 ALTER TABLE `web_player_deaths` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `web_player_items`
--

DROP TABLE IF EXISTS `web_player_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `web_player_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `pid` int(11) DEFAULT 0,
  `itemtype` int(11) DEFAULT 0,
  `count` int(11) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `idx_player` (`player_id`)
) ENGINE=InnoDB AUTO_INCREMENT=217 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `web_player_items`
--

LOCK TABLES `web_player_items` WRITE;
/*!40000 ALTER TABLE `web_player_items` DISABLE KEYS */;
INSERT INTO `web_player_items` VALUES (181,8,1,2461,1),(182,8,2,2173,1),(183,8,3,1988,1),(184,8,4,2651,1),(185,8,5,2175,1),(186,8,6,2437,1),(187,8,7,2649,1),(188,8,8,2642,1),(189,8,9,2124,1),(190,20,1,2461,1),(191,20,2,2173,1),(192,20,3,1988,1),(193,20,4,2651,1),(194,20,5,2512,1),(195,20,6,1294,1),(196,20,7,2649,1),(197,20,8,2642,1),(198,20,9,2124,1),(199,24,1,2461,1),(200,24,2,2173,1),(201,24,3,1988,1),(202,24,4,2651,1),(203,24,5,2512,1),(204,24,6,2376,1),(205,24,7,2649,1),(206,24,8,2642,1),(207,24,9,2124,1),(208,26,1,2461,1),(209,26,2,2173,1),(210,26,3,1988,1),(211,26,4,2651,1),(212,26,5,2175,1),(213,26,6,2388,1),(214,26,7,2649,1),(215,26,8,2642,1),(216,26,9,2124,1);
/*!40000 ALTER TABLE `web_player_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `web_players`
--

DROP TABLE IF EXISTS `web_players`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `web_players` (
  `id` int(11) NOT NULL,
  `account_id` int(11) DEFAULT 0,
  `name` varchar(32) NOT NULL,
  `level` int(11) DEFAULT 1,
  `vocation` int(11) DEFAULT 0,
  `sex` int(11) DEFAULT 0,
  `group_id` int(11) DEFAULT 1,
  `online` int(11) DEFAULT 0,
  `experience` bigint(20) DEFAULT 0,
  `maglevel` int(11) DEFAULT 0,
  `skill_fist` int(11) DEFAULT 10,
  `skill_club` int(11) DEFAULT 10,
  `skill_sword` int(11) DEFAULT 10,
  `skill_axe` int(11) DEFAULT 10,
  `skill_dist` int(11) DEFAULT 10,
  `skill_shielding` int(11) DEFAULT 10,
  `healthmax` int(11) DEFAULT 150,
  `manamax` int(11) DEFAULT 0,
  `balance` bigint(20) DEFAULT 0,
  `lastlogin` int(11) DEFAULT 0,
  `resets` int(11) DEFAULT 0,
  `guild_name` varchar(100) DEFAULT NULL,
  `guild_rank` varchar(100) DEFAULT NULL,
  `account_created` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`),
  KEY `idx_level` (`level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `web_players`
--

LOCK TABLES `web_players` WRITE;
/*!40000 ALTER TABLE `web_players` DISABLE KEYS */;
INSERT INTO `web_players` VALUES (1,1,'Account Manager',1,0,1,1,0,0,0,0,0,0,0,0,0,150,0,0,1781304485,0,NULL,NULL,0),(8,5,'[GOD] Yuri',151,1,1,6,0,55145000,6,10,10,10,10,10,10,900,4325,273039001,1782955702,0,NULL,NULL,0),(20,5,'Paladin Teste',6765,3,0,1,0,5155693903655,18,19,10,10,10,84,42,67755,101390,0,1781781495,0,NULL,NULL,0),(21,15,'Inn Witch',1533,1,0,1,0,59897438896,75,10,10,10,10,10,19,7810,45785,0,1626913884,0,NULL,NULL,0),(22,15,'Di Darkier',1515,2,0,1,0,57725337800,21,10,10,10,10,10,10,7720,45245,0,1626580548,0,NULL,NULL,0),(23,15,'Victor',15,2,1,6,0,37800,0,10,10,10,10,10,10,220,245,0,1626914227,0,NULL,NULL,0),(24,5,'Knight Teste',1488,4,1,1,0,54750157822,6,14,84,85,84,10,18,22385,7435,0,1782379834,0,NULL,NULL,0),(25,5,'Druid Tester',17134,2,1,1,0,83806786460804,14,10,10,10,10,10,13,85815,513815,0,1781518848,0,NULL,NULL,0),(26,5,'Sorcerer Teste',23234,1,1,1,0,208983398785741,65,12,10,15,10,10,18,116315,696815,100582024,1782380029,0,NULL,NULL,0);
/*!40000 ALTER TABLE `web_players` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `web_systems`
--

DROP TABLE IF EXISTS `web_systems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `web_systems` (
  `category` varchar(30) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`config`)),
  PRIMARY KEY (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `web_systems`
--

LOCK TABLES `web_systems` WRITE;
/*!40000 ALTER TABLE `web_systems` DISABLE KEYS */;
INSERT INTO `web_systems` VALUES ('foods','Alimentos Especiais (Dietas)','Aumente temporariamente seus atributos consumindo pratos cozinhados por alquimistas.','{\"dishes\":[{\"name\":\"Bolo Vulc\\u00e2nico (Vulc\\u00e3o)\",\"effect\":\"5% de chance de conjurar uma grande explos\\u00e3o de fogo (GFB) ao acertar ataques f\\u00edsicos.\"},{\"name\":\"Sopa Marinha\",\"effect\":\"Recupera 10% de toda mana m\\u00e1xima instantaneamente (Cooldown de 1 hora).\"},{\"name\":\"Salada Sagrada\",\"effect\":\"Garante 15% de resist\\u00eancia extra a ataques de dano de morte (Death Damage) por 30 minutos.\"}]}'),('mining','Sistema de Mineração Dinâmica','Colete minérios preciosos batendo com sua Pickaxe nas veias de carvão e cristal do subsolo do IceYuriots.','{\"ores\":[{\"name\":\"Coal Ore (Carv\\u00e3o)\",\"chance\":\"45%\",\"reward\":\"100 gp + Crafting Exp\"},{\"name\":\"Iron Ore (Ferro)\",\"chance\":\"25%\",\"reward\":\"Iron Bars para Tier Upgrades\"},{\"name\":\"Gold Ore (Ouro)\",\"chance\":\"10%\",\"reward\":\"Moedas de Ouro\"},{\"name\":\"Crystal Gem (Cristal)\",\"chance\":\"2.5%\",\"reward\":\"Gemas de Despertar de Armas (Awakening)\"}]}'),('pets','Pet System (Summons de Bolso)','O Pet System permite que você invoque criaturas aliadas (Mascotes de Bolso) que auxiliam em combate atacando, curando ou servindo como escudo humano (tancando). Ao usar o item correspondente, o mascote é sumonado ao seu lado. O HP máximo de cada pet aumenta progressivamente com base no seu Level e nos seus Resets acumulados!','{\"types\":[{\"name\":\"Melee Iniciante\",\"tier\":2,\"summon_item\":\"Larva Summon (ID: 11211)\",\"hp_base\":\"200.000\",\"avg_damage\":\"40.000 a 60.000\",\"role\":\"Atacante Corpo-a-Corpo\",\"function_desc\":\"Auxilia no dano f\\u00edsico constante de alvo \\u00fanico e ajuda na velocidade de limpeza de hunts iniciais.\"},{\"name\":\"Tank Iniciante\",\"tier\":2,\"summon_item\":\"Dark Monk Summon (ID: 11214)\",\"hp_base\":\"300.000\",\"avg_damage\":\"25.000 a 35.000\",\"role\":\"Defensor \\/ Provocador Inicial\",\"function_desc\":\"Ajuda a agrar e absorver o dano f\\u00edsico de criaturas mais fracas para proteger magos e arqueiros.\"},{\"name\":\"Ranged Iniciante\",\"tier\":2,\"summon_item\":\"Ranged Summon (ID: 12432)\",\"hp_base\":\"200.000\",\"avg_damage\":\"35.000 a 50.000\",\"role\":\"Atirador de Retaguarda\",\"function_desc\":\"Ataca \\u00e0 dist\\u00e2ncia com proj\\u00e9teis m\\u00e1gicos evitando combate corpo-a-corpo direto.\"},{\"name\":\"Blocker\",\"tier\":3,\"summon_item\":\"Blocker Summon (ID: 11361)\",\"hp_base\":\"1.500.000\",\"avg_damage\":\"80.000 a 120.000\",\"role\":\"Super Tanque de Boss\",\"function_desc\":\"Tanque robusto ideal para bosses m\\u00e9dios. Possui intelig\\u00eancia artificial para desafiar criaturas (Challenge).\"},{\"name\":\"Matador\",\"tier\":3,\"summon_item\":\"Killer Summon (ID: 10558)\",\"hp_base\":\"800.000\",\"avg_damage\":\"150.000 a 220.000\",\"role\":\"Atacante Burst de Alvo \\u00danico\",\"function_desc\":\"Causa alt\\u00edssimos picos de dano f\\u00edsico e sangramento persistente na criatura atacada.\"},{\"name\":\"Cat\",\"tier\":3,\"summon_item\":\"Cat Summon (ID: 11192)\",\"hp_base\":\"800.000\",\"avg_damage\":\"90.000 a 140.000\",\"role\":\"Suporte \\/ Controle de Grupo\",\"function_desc\":\"Dificulta a fuga e mobilidade de monstros \\u00e1geis aplicando lentid\\u00e3o (Paralyze) constante.\"},{\"name\":\"Parrot\",\"tier\":3,\"summon_item\":\"Terror Bird Summon (ID: 12431)\",\"hp_base\":\"800.000\",\"avg_damage\":\"100.000 a 160.000 (\\u00c1rea)\",\"role\":\"Atacante de \\u00c1rea (Wave\\/Spells)\",\"function_desc\":\"Ataca alvos m\\u00faltiplos espalhando dano de vento e furac\\u00f5es ao redor das criaturas.\"},{\"name\":\"Holy Guardian\",\"tier\":3,\"summon_item\":\"Holy Summon (ID: 10420)\",\"hp_base\":\"700.000\",\"avg_damage\":\"40.000 a 70.000\",\"role\":\"Suporte \\/ Curador Sagrado\",\"function_desc\":\"Cura periodicamente grandes fatias da vida do dono utilizando feiti\\u00e7os de luz divina.\"},{\"name\":\"Frost Guardian\",\"tier\":4,\"summon_item\":\"Cryo Summon (ID: 11493)\",\"hp_base\":\"5.000.000\",\"avg_damage\":\"300.000 a 450.000\",\"role\":\"Super Tanque Criog\\u00eanico\",\"function_desc\":\"Alt\\u00edssima durabilidade, imunidades e resist\\u00eancias gerais elevadas para hunts end-game extremas.\"},{\"name\":\"Swamp Beast\",\"tier\":4,\"summon_item\":\"Swamp Summon (ID: 6566)\",\"hp_base\":\"5.000.000\",\"avg_damage\":\"350.000 a 500.000 (\\u00c1rea)\",\"role\":\"Colosso Ofensivo \\/ Veneno\",\"function_desc\":\"Descarrega nuvens de veneno em \\u00e1rea que corroem a vida de hordas inteiras de monstros.\"},{\"name\":\"Shadow Acolyte\",\"tier\":4,\"summon_item\":\"Shadow Summon (ID: 5802)\",\"hp_base\":\"2.500.000\",\"avg_damage\":\"500.000 a 750.000\",\"role\":\"Mago Negro de Dano Extremo\",\"function_desc\":\"Lan\\u00e7a m\\u00edsseis de morte e drena energia vital dos oponentes para infligir danos absurdos.\"},{\"name\":\"Divine Sentinel\",\"tier\":4,\"summon_item\":\"Sentinel Summon (ID: 9649)\",\"hp_base\":\"2.000.000\",\"avg_damage\":\"200.000 a 350.000\",\"role\":\"Anjo Protetor Sagrado\",\"function_desc\":\"Concede escudos protetores tempor\\u00e1rios e buffs passivos de defesa f\\u00edsica e elemental para o invocador.\"},{\"name\":\"Carrasco\",\"tier\":4,\"summon_item\":\"Executioner Summon (ID: 10411)\",\"hp_base\":\"2.500.000\",\"avg_damage\":\"350.000 a 600.000\",\"role\":\"Guerreiro Carrasco \\/ Finalizador\",\"function_desc\":\"Amplifica consideravelmente o dano de seus ataques conforme a vida do inimigo diminui (Mec\\u00e2nica de Execu\\u00e7\\u00e3o).\"}]}'),('upgrades','Upgrades (Tier & Awakening)','Eleve suas armas e escudos para o nível lendário através de runas e gemas especiais.','{\"mechanics\":[{\"name\":\"Armas Despertas (Awakening)\",\"details\":\"Libera de 1 a 3 slots de atributos secund\\u00e1rios aleat\\u00f3rios (como Life Leech, Mana Leech, Critical Chance e Velocidade de Movimento).\"},{\"name\":\"Tier Upgrades (At\\u00e9 Tier 10)\",\"details\":\"Aumenta linearmente o dano e defesa base dos equipamentos utilizando min\\u00e9rios de ferro e gemas brutas obtidas em Quests di\\u00e1rias.\"}]}');
/*!40000 ALTER TABLE `web_systems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `web_tickets`
--

DROP TABLE IF EXISTS `web_tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `web_tickets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `category` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `status` varchar(20) DEFAULT 'Aberto',
  `reply` text DEFAULT NULL,
  `replied_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `web_tickets`
--

LOCK TABLES `web_tickets` WRITE;
/*!40000 ALTER TABLE `web_tickets` DISABLE KEYS */;
/*!40000 ALTER TABLE `web_tickets` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-17 20:02:18
