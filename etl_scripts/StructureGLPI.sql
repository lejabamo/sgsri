-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: 172.19.0.214    Database: db_glpi
-- ------------------------------------------------------
-- Server version	5.5.5-10.3.39-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `backup_glpi_plugin_formcreator_formanswers`
--

DROP TABLE IF EXISTS `backup_glpi_plugin_formcreator_formanswers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `backup_glpi_plugin_formcreator_formanswers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(1) NOT NULL DEFAULT 0,
  `plugin_formcreator_forms_id` int(10) unsigned NOT NULL DEFAULT 0,
  `requester_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_validator` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'User in charge of validation',
  `groups_id_validator` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'Group in charge of validation',
  `request_date` timestamp NULL DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 101,
  `comment` mediumtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plugin_formcreator_forms_id` (`plugin_formcreator_forms_id`),
  KEY `entities_id_is_recursive` (`entities_id`,`is_recursive`),
  KEY `requester_id` (`requester_id`),
  KEY `users_id_validator` (`users_id_validator`),
  KEY `groups_id_validator` (`groups_id_validator`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_agents`
--

DROP TABLE IF EXISTS `glpi_agents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_agents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `deviceid` varchar(255) NOT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `agenttypes_id` int(10) unsigned NOT NULL,
  `last_contact` timestamp NULL DEFAULT NULL,
  `version` varchar(255) DEFAULT NULL,
  `locked` tinyint(4) NOT NULL DEFAULT 0,
  `itemtype` varchar(100) NOT NULL,
  `items_id` int(10) unsigned NOT NULL,
  `useragent` varchar(255) DEFAULT NULL,
  `tag` varchar(255) DEFAULT NULL,
  `port` varchar(6) DEFAULT NULL,
  `remote_addr` varchar(255) DEFAULT NULL,
  `threads_networkdiscovery` int(11) NOT NULL DEFAULT 1 COMMENT 'Number of threads for Network discovery',
  `threads_networkinventory` int(11) NOT NULL DEFAULT 1 COMMENT 'Number of threads for Network inventory',
  `timeout_networkdiscovery` int(11) NOT NULL DEFAULT 0 COMMENT 'Network Discovery task timeout (disabled by default)',
  `timeout_networkinventory` int(11) NOT NULL DEFAULT 0 COMMENT 'Network Inventory task timeout (disabled by default)',
  `use_module_wake_on_lan` tinyint(4) NOT NULL DEFAULT 0,
  `use_module_computer_inventory` tinyint(4) NOT NULL DEFAULT 0,
  `use_module_esx_remote_inventory` tinyint(4) NOT NULL DEFAULT 0,
  `use_module_remote_inventory` tinyint(4) NOT NULL DEFAULT 0,
  `use_module_network_inventory` tinyint(4) NOT NULL DEFAULT 0,
  `use_module_network_discovery` tinyint(4) NOT NULL DEFAULT 0,
  `use_module_package_deployment` tinyint(4) NOT NULL DEFAULT 0,
  `use_module_collect_data` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceid` (`deviceid`),
  KEY `name` (`name`),
  KEY `agenttypes_id` (`agenttypes_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `item` (`itemtype`,`items_id`)
) ENGINE=InnoDB AUTO_INCREMENT=245 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_agenttypes`
--

DROP TABLE IF EXISTS `glpi_agenttypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_agenttypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_alerts`
--

DROP TABLE IF EXISTS `glpi_alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_alerts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `itemtype` varchar(100) NOT NULL,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `type` int(11) NOT NULL DEFAULT 0 COMMENT 'see define.php ALERT_* constant',
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`itemtype`,`items_id`,`type`),
  KEY `type` (`type`),
  KEY `date` (`date`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_apiclients`
--

DROP TABLE IF EXISTS `glpi_apiclients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_apiclients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 0,
  `ipv4_range_start` bigint(20) DEFAULT NULL,
  `ipv4_range_end` bigint(20) DEFAULT NULL,
  `ipv6` varchar(255) DEFAULT NULL,
  `app_token` varchar(255) DEFAULT NULL,
  `app_token_date` timestamp NULL DEFAULT NULL,
  `dolog_method` tinyint(4) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `is_active` (`is_active`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_applianceenvironments`
--

DROP TABLE IF EXISTS `glpi_applianceenvironments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_applianceenvironments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_appliances`
--

DROP TABLE IF EXISTS `glpi_appliances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_appliances` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `appliancetypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `manufacturers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `applianceenvironments_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0,
  `externalidentifier` varchar(255) DEFAULT NULL,
  `serial` varchar(255) DEFAULT NULL,
  `otherserial` varchar(255) DEFAULT NULL,
  `contact` varchar(255) DEFAULT NULL,
  `contact_num` varchar(255) DEFAULT NULL,
  `is_helpdesk_visible` tinyint(4) NOT NULL DEFAULT 1,
  `pictures` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`externalidentifier`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `name` (`name`),
  KEY `is_deleted` (`is_deleted`),
  KEY `appliancetypes_id` (`appliancetypes_id`),
  KEY `locations_id` (`locations_id`),
  KEY `manufacturers_id` (`manufacturers_id`),
  KEY `applianceenvironments_id` (`applianceenvironments_id`),
  KEY `users_id` (`users_id`),
  KEY `users_id_tech` (`users_id_tech`),
  KEY `groups_id` (`groups_id`),
  KEY `groups_id_tech` (`groups_id_tech`),
  KEY `states_id` (`states_id`),
  KEY `serial` (`serial`),
  KEY `otherserial` (`otherserial`),
  KEY `is_helpdesk_visible` (`is_helpdesk_visible`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_appliances_items`
--

DROP TABLE IF EXISTS `glpi_appliances_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_appliances_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `appliances_id` int(10) unsigned NOT NULL DEFAULT 0,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`appliances_id`,`items_id`,`itemtype`),
  KEY `item` (`itemtype`,`items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_appliances_items_relations`
--

DROP TABLE IF EXISTS `glpi_appliances_items_relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_appliances_items_relations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `appliances_items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) NOT NULL,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `appliances_items_id` (`appliances_items_id`),
  KEY `item` (`itemtype`,`items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_appliancetypes`
--

DROP TABLE IF EXISTS `glpi_appliancetypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_appliancetypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `comment` text DEFAULT NULL,
  `externalidentifier` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `externalidentifier` (`externalidentifier`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_authldapreplicates`
--

DROP TABLE IF EXISTS `glpi_authldapreplicates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_authldapreplicates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `authldaps_id` int(10) unsigned NOT NULL DEFAULT 0,
  `host` varchar(255) DEFAULT NULL,
  `port` int(11) NOT NULL DEFAULT 389,
  `name` varchar(255) DEFAULT NULL,
  `timeout` int(11) NOT NULL DEFAULT 10,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `authldaps_id` (`authldaps_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_authldaps`
--

DROP TABLE IF EXISTS `glpi_authldaps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_authldaps` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `host` varchar(255) DEFAULT NULL,
  `basedn` varchar(255) DEFAULT NULL,
  `rootdn` varchar(255) DEFAULT NULL,
  `port` int(11) NOT NULL DEFAULT 389,
  `condition` text DEFAULT NULL,
  `login_field` varchar(255) DEFAULT 'uid',
  `sync_field` varchar(255) DEFAULT NULL,
  `use_tls` tinyint(4) NOT NULL DEFAULT 0,
  `group_field` varchar(255) DEFAULT NULL,
  `group_condition` text DEFAULT NULL,
  `group_search_type` int(11) NOT NULL DEFAULT 0,
  `group_member_field` varchar(255) DEFAULT NULL,
  `email1_field` varchar(255) DEFAULT NULL,
  `realname_field` varchar(255) DEFAULT NULL,
  `firstname_field` varchar(255) DEFAULT NULL,
  `phone_field` varchar(255) DEFAULT NULL,
  `phone2_field` varchar(255) DEFAULT NULL,
  `mobile_field` varchar(255) DEFAULT NULL,
  `comment_field` varchar(255) DEFAULT NULL,
  `use_dn` tinyint(4) NOT NULL DEFAULT 1,
  `time_offset` int(11) NOT NULL DEFAULT 0 COMMENT 'in seconds',
  `deref_option` int(11) NOT NULL DEFAULT 0,
  `title_field` varchar(255) DEFAULT NULL,
  `category_field` varchar(255) DEFAULT NULL,
  `language_field` varchar(255) DEFAULT NULL,
  `entity_field` varchar(255) DEFAULT NULL,
  `entity_condition` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `is_default` tinyint(4) NOT NULL DEFAULT 0,
  `is_active` tinyint(4) NOT NULL DEFAULT 0,
  `rootdn_passwd` varchar(255) DEFAULT NULL,
  `registration_number_field` varchar(255) DEFAULT NULL,
  `email2_field` varchar(255) DEFAULT NULL,
  `email3_field` varchar(255) DEFAULT NULL,
  `email4_field` varchar(255) DEFAULT NULL,
  `location_field` varchar(255) DEFAULT NULL,
  `responsible_field` varchar(255) DEFAULT NULL,
  `pagesize` int(11) NOT NULL DEFAULT 0,
  `ldap_maxlimit` int(11) NOT NULL DEFAULT 0,
  `can_support_pagesize` tinyint(4) NOT NULL DEFAULT 0,
  `picture_field` varchar(255) DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `inventory_domain` varchar(255) DEFAULT NULL,
  `tls_certfile` text DEFAULT NULL,
  `tls_keyfile` text DEFAULT NULL,
  `use_bind` tinyint(4) NOT NULL DEFAULT 1,
  `timeout` int(11) NOT NULL DEFAULT 10,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `is_default` (`is_default`),
  KEY `is_active` (`is_active`),
  KEY `date_creation` (`date_creation`),
  KEY `sync_field` (`sync_field`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_authmails`
--

DROP TABLE IF EXISTS `glpi_authmails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_authmails` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `connect_string` varchar(255) DEFAULT NULL,
  `host` varchar(255) DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `is_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_autoupdatesystems`
--

DROP TABLE IF EXISTS `glpi_autoupdatesystems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_autoupdatesystems` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_blacklistedmailcontents`
--

DROP TABLE IF EXISTS `glpi_blacklistedmailcontents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_blacklistedmailcontents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_blacklists`
--

DROP TABLE IF EXISTS `glpi_blacklists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_blacklists` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_budgets`
--

DROP TABLE IF EXISTS `glpi_budgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_budgets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `begin_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `value` decimal(20,4) NOT NULL DEFAULT 0.0000,
  `is_template` tinyint(4) NOT NULL DEFAULT 0,
  `template_name` varchar(255) DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `budgettypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `is_recursive` (`is_recursive`),
  KEY `entities_id` (`entities_id`),
  KEY `is_deleted` (`is_deleted`),
  KEY `begin_date` (`begin_date`),
  KEY `end_date` (`end_date`),
  KEY `is_template` (`is_template`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `locations_id` (`locations_id`),
  KEY `budgettypes_id` (`budgettypes_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_budgettypes`
--

DROP TABLE IF EXISTS `glpi_budgettypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_budgettypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_businesscriticities`
--

DROP TABLE IF EXISTS `glpi_businesscriticities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_businesscriticities` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `businesscriticities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `completename` text DEFAULT NULL,
  `level` int(11) NOT NULL DEFAULT 0,
  `ancestors_cache` longtext DEFAULT NULL,
  `sons_cache` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`businesscriticities_id`,`name`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `level` (`level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_cables`
--

DROP TABLE IF EXISTS `glpi_cables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_cables` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `itemtype_endpoint_a` varchar(255) DEFAULT NULL,
  `itemtype_endpoint_b` varchar(255) DEFAULT NULL,
  `items_id_endpoint_a` int(10) unsigned NOT NULL DEFAULT 0,
  `items_id_endpoint_b` int(10) unsigned NOT NULL DEFAULT 0,
  `socketmodels_id_endpoint_a` int(10) unsigned NOT NULL DEFAULT 0,
  `socketmodels_id_endpoint_b` int(10) unsigned NOT NULL DEFAULT 0,
  `sockets_id_endpoint_a` int(10) unsigned NOT NULL DEFAULT 0,
  `sockets_id_endpoint_b` int(10) unsigned NOT NULL DEFAULT 0,
  `cablestrands_id` int(10) unsigned NOT NULL DEFAULT 0,
  `color` varchar(255) DEFAULT NULL,
  `otherserial` varchar(255) DEFAULT NULL,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `cabletypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `item_endpoint_a` (`itemtype_endpoint_a`,`items_id_endpoint_a`),
  KEY `item_endpoint_b` (`itemtype_endpoint_b`,`items_id_endpoint_b`),
  KEY `items_id_endpoint_b` (`items_id_endpoint_b`),
  KEY `items_id_endpoint_a` (`items_id_endpoint_a`),
  KEY `socketmodels_id_endpoint_a` (`socketmodels_id_endpoint_a`),
  KEY `socketmodels_id_endpoint_b` (`socketmodels_id_endpoint_b`),
  KEY `sockets_id_endpoint_a` (`sockets_id_endpoint_a`),
  KEY `sockets_id_endpoint_b` (`sockets_id_endpoint_b`),
  KEY `cablestrands_id` (`cablestrands_id`),
  KEY `states_id` (`states_id`),
  KEY `complete` (`entities_id`,`name`),
  KEY `is_recursive` (`is_recursive`),
  KEY `users_id_tech` (`users_id_tech`),
  KEY `cabletypes_id` (`cabletypes_id`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `is_deleted` (`is_deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_cablestrands`
--

DROP TABLE IF EXISTS `glpi_cablestrands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_cablestrands` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_cabletypes`
--

DROP TABLE IF EXISTS `glpi_cabletypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_cabletypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_calendars`
--

DROP TABLE IF EXISTS `glpi_calendars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_calendars` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `cache_duration` text DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_calendars_holidays`
--

DROP TABLE IF EXISTS `glpi_calendars_holidays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_calendars_holidays` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `calendars_id` int(10) unsigned NOT NULL DEFAULT 0,
  `holidays_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`calendars_id`,`holidays_id`),
  KEY `holidays_id` (`holidays_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_calendarsegments`
--

DROP TABLE IF EXISTS `glpi_calendarsegments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_calendarsegments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `calendars_id` int(10) unsigned NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `day` tinyint(4) NOT NULL DEFAULT 1 COMMENT 'numer of the day based on date(w)',
  `begin` time DEFAULT NULL,
  `end` time DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `calendars_id` (`calendars_id`),
  KEY `day` (`day`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_cartridgeitems`
--

DROP TABLE IF EXISTS `glpi_cartridgeitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_cartridgeitems` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `ref` varchar(255) DEFAULT NULL,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `cartridgeitemtypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `manufacturers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `alarm_threshold` int(11) NOT NULL DEFAULT 10,
  `stock_target` int(11) NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `pictures` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `manufacturers_id` (`manufacturers_id`),
  KEY `locations_id` (`locations_id`),
  KEY `users_id_tech` (`users_id_tech`),
  KEY `cartridgeitemtypes_id` (`cartridgeitemtypes_id`),
  KEY `is_deleted` (`is_deleted`),
  KEY `alarm_threshold` (`alarm_threshold`),
  KEY `groups_id_tech` (`groups_id_tech`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_cartridgeitems_printermodels`
--

DROP TABLE IF EXISTS `glpi_cartridgeitems_printermodels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_cartridgeitems_printermodels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cartridgeitems_id` int(10) unsigned NOT NULL DEFAULT 0,
  `printermodels_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`printermodels_id`,`cartridgeitems_id`),
  KEY `cartridgeitems_id` (`cartridgeitems_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_cartridgeitemtypes`
--

DROP TABLE IF EXISTS `glpi_cartridgeitemtypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_cartridgeitemtypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_cartridges`
--

DROP TABLE IF EXISTS `glpi_cartridges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_cartridges` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `cartridgeitems_id` int(10) unsigned NOT NULL DEFAULT 0,
  `printers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_in` date DEFAULT NULL,
  `date_use` date DEFAULT NULL,
  `date_out` date DEFAULT NULL,
  `pages` int(11) NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cartridgeitems_id` (`cartridgeitems_id`),
  KEY `printers_id` (`printers_id`),
  KEY `entities_id` (`entities_id`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_certificates`
--

DROP TABLE IF EXISTS `glpi_certificates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_certificates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `serial` varchar(255) DEFAULT NULL,
  `otherserial` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_template` tinyint(4) NOT NULL DEFAULT 0,
  `template_name` varchar(255) DEFAULT NULL,
  `certificatetypes_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_certificatetypes (id)',
  `dns_name` varchar(255) DEFAULT NULL,
  `dns_suffix` varchar(255) DEFAULT NULL,
  `users_id_tech` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_users (id)',
  `groups_id_tech` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_groups (id)',
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_locations (id)',
  `manufacturers_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_manufacturers (id)',
  `contact` varchar(255) DEFAULT NULL,
  `contact_num` varchar(255) DEFAULT NULL,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_autosign` tinyint(4) NOT NULL DEFAULT 0,
  `date_expiration` date DEFAULT NULL,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to states (id)',
  `command` text DEFAULT NULL,
  `certificate_request` text DEFAULT NULL,
  `certificate_item` text DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `is_template` (`is_template`),
  KEY `is_deleted` (`is_deleted`),
  KEY `certificatetypes_id` (`certificatetypes_id`),
  KEY `users_id_tech` (`users_id_tech`),
  KEY `groups_id_tech` (`groups_id_tech`),
  KEY `groups_id` (`groups_id`),
  KEY `users_id` (`users_id`),
  KEY `locations_id` (`locations_id`),
  KEY `manufacturers_id` (`manufacturers_id`),
  KEY `states_id` (`states_id`),
  KEY `date_creation` (`date_creation`),
  KEY `date_mod` (`date_mod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_certificates_items`
--

DROP TABLE IF EXISTS `glpi_certificates_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_certificates_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `certificates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to various tables, according to itemtype (id)',
  `itemtype` varchar(100) NOT NULL COMMENT 'see .class.php file',
  `date_creation` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`certificates_id`,`itemtype`,`items_id`),
  KEY `item` (`itemtype`,`items_id`),
  KEY `date_creation` (`date_creation`),
  KEY `date_mod` (`date_mod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_certificatetypes`
--

DROP TABLE IF EXISTS `glpi_certificatetypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_certificatetypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `name` (`name`),
  KEY `date_creation` (`date_creation`),
  KEY `date_mod` (`date_mod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_changecosts`
--

DROP TABLE IF EXISTS `glpi_changecosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_changecosts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `changes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `begin_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `actiontime` int(11) NOT NULL DEFAULT 0,
  `cost_time` decimal(20,4) NOT NULL DEFAULT 0.0000,
  `cost_fixed` decimal(20,4) NOT NULL DEFAULT 0.0000,
  `cost_material` decimal(20,4) NOT NULL DEFAULT 0.0000,
  `budgets_id` int(10) unsigned NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `changes_id` (`changes_id`),
  KEY `begin_date` (`begin_date`),
  KEY `end_date` (`end_date`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `budgets_id` (`budgets_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_changes`
--

DROP TABLE IF EXISTS `glpi_changes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_changes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 1,
  `content` longtext DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date` timestamp NULL DEFAULT NULL,
  `solvedate` timestamp NULL DEFAULT NULL,
  `closedate` timestamp NULL DEFAULT NULL,
  `time_to_resolve` timestamp NULL DEFAULT NULL,
  `users_id_recipient` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_lastupdater` int(10) unsigned NOT NULL DEFAULT 0,
  `urgency` int(11) NOT NULL DEFAULT 1,
  `impact` int(11) NOT NULL DEFAULT 1,
  `priority` int(11) NOT NULL DEFAULT 1,
  `itilcategories_id` int(10) unsigned NOT NULL DEFAULT 0,
  `impactcontent` longtext DEFAULT NULL,
  `controlistcontent` longtext DEFAULT NULL,
  `rolloutplancontent` longtext DEFAULT NULL,
  `backoutplancontent` longtext DEFAULT NULL,
  `checklistcontent` longtext DEFAULT NULL,
  `global_validation` int(11) NOT NULL DEFAULT 1,
  `validation_percent` int(11) NOT NULL DEFAULT 0,
  `actiontime` int(11) NOT NULL DEFAULT 0,
  `begin_waiting_date` timestamp NULL DEFAULT NULL,
  `waiting_duration` int(11) NOT NULL DEFAULT 0,
  `close_delay_stat` int(11) NOT NULL DEFAULT 0,
  `solve_delay_stat` int(11) NOT NULL DEFAULT 0,
  `date_creation` timestamp NULL DEFAULT NULL,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `is_deleted` (`is_deleted`),
  KEY `date` (`date`),
  KEY `closedate` (`closedate`),
  KEY `status` (`status`),
  KEY `priority` (`priority`),
  KEY `date_mod` (`date_mod`),
  KEY `itilcategories_id` (`itilcategories_id`),
  KEY `users_id_recipient` (`users_id_recipient`),
  KEY `solvedate` (`solvedate`),
  KEY `urgency` (`urgency`),
  KEY `impact` (`impact`),
  KEY `time_to_resolve` (`time_to_resolve`),
  KEY `global_validation` (`global_validation`),
  KEY `users_id_lastupdater` (`users_id_lastupdater`),
  KEY `date_creation` (`date_creation`),
  KEY `locations_id` (`locations_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_changes_groups`
--

DROP TABLE IF EXISTS `glpi_changes_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_changes_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `changes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `type` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`changes_id`,`type`,`groups_id`),
  KEY `group` (`groups_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_changes_items`
--

DROP TABLE IF EXISTS `glpi_changes_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_changes_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `changes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) DEFAULT NULL,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`changes_id`,`itemtype`,`items_id`),
  KEY `item` (`itemtype`,`items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_changes_problems`
--

DROP TABLE IF EXISTS `glpi_changes_problems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_changes_problems` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `changes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `problems_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`changes_id`,`problems_id`),
  KEY `problems_id` (`problems_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_changes_suppliers`
--

DROP TABLE IF EXISTS `glpi_changes_suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_changes_suppliers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `changes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `suppliers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `type` int(11) NOT NULL DEFAULT 1,
  `use_notification` tinyint(4) NOT NULL DEFAULT 0,
  `alternative_email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`changes_id`,`type`,`suppliers_id`),
  KEY `group` (`suppliers_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_changes_tickets`
--

DROP TABLE IF EXISTS `glpi_changes_tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_changes_tickets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `changes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `tickets_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`changes_id`,`tickets_id`),
  KEY `tickets_id` (`tickets_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_changes_users`
--

DROP TABLE IF EXISTS `glpi_changes_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_changes_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `changes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `type` int(11) NOT NULL DEFAULT 1,
  `use_notification` tinyint(4) NOT NULL DEFAULT 0,
  `alternative_email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`changes_id`,`type`,`users_id`,`alternative_email`),
  KEY `user` (`users_id`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_changetasks`
--

DROP TABLE IF EXISTS `glpi_changetasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_changetasks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) DEFAULT NULL,
  `changes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `taskcategories_id` int(10) unsigned NOT NULL DEFAULT 0,
  `state` int(11) NOT NULL DEFAULT 0,
  `date` timestamp NULL DEFAULT NULL,
  `begin` timestamp NULL DEFAULT NULL,
  `end` timestamp NULL DEFAULT NULL,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_editor` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `content` longtext DEFAULT NULL,
  `actiontime` int(11) NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `tasktemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `timeline_position` tinyint(4) NOT NULL DEFAULT 0,
  `is_private` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `changes_id` (`changes_id`),
  KEY `state` (`state`),
  KEY `users_id` (`users_id`),
  KEY `users_id_editor` (`users_id_editor`),
  KEY `users_id_tech` (`users_id_tech`),
  KEY `groups_id_tech` (`groups_id_tech`),
  KEY `date` (`date`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `begin` (`begin`),
  KEY `end` (`end`),
  KEY `taskcategories_id` (`taskcategories_id`),
  KEY `tasktemplates_id` (`tasktemplates_id`),
  KEY `is_private` (`is_private`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_changetemplatehiddenfields`
--

DROP TABLE IF EXISTS `glpi_changetemplatehiddenfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_changetemplatehiddenfields` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `changetemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `num` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`changetemplates_id`,`num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_changetemplatemandatoryfields`
--

DROP TABLE IF EXISTS `glpi_changetemplatemandatoryfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_changetemplatemandatoryfields` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `changetemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `num` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`changetemplates_id`,`num`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_changetemplatepredefinedfields`
--

DROP TABLE IF EXISTS `glpi_changetemplatepredefinedfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_changetemplatepredefinedfields` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `changetemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `num` int(11) NOT NULL DEFAULT 0,
  `value` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `changetemplates_id` (`changetemplates_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_changetemplates`
--

DROP TABLE IF EXISTS `glpi_changetemplates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_changetemplates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_changevalidations`
--

DROP TABLE IF EXISTS `glpi_changevalidations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_changevalidations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `changes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_validate` int(10) unsigned NOT NULL DEFAULT 0,
  `comment_submission` text DEFAULT NULL,
  `comment_validation` text DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 2,
  `submission_date` timestamp NULL DEFAULT NULL,
  `validation_date` timestamp NULL DEFAULT NULL,
  `timeline_position` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `users_id` (`users_id`),
  KEY `users_id_validate` (`users_id_validate`),
  KEY `changes_id` (`changes_id`),
  KEY `submission_date` (`submission_date`),
  KEY `validation_date` (`validation_date`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_clusters`
--

DROP TABLE IF EXISTS `glpi_clusters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_clusters` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `uuid` varchar(255) DEFAULT NULL,
  `version` varchar(255) DEFAULT NULL,
  `users_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to states (id)',
  `comment` text DEFAULT NULL,
  `clustertypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `autoupdatesystems_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `users_id_tech` (`users_id_tech`),
  KEY `group_id_tech` (`groups_id_tech`),
  KEY `is_deleted` (`is_deleted`),
  KEY `states_id` (`states_id`),
  KEY `clustertypes_id` (`clustertypes_id`),
  KEY `autoupdatesystems_id` (`autoupdatesystems_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `date_creation` (`date_creation`),
  KEY `date_mod` (`date_mod`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_clustertypes`
--

DROP TABLE IF EXISTS `glpi_clustertypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_clustertypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `date_creation` (`date_creation`),
  KEY `date_mod` (`date_mod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_computerantiviruses`
--

DROP TABLE IF EXISTS `glpi_computerantiviruses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_computerantiviruses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `computers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `manufacturers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `antivirus_version` varchar(255) DEFAULT NULL,
  `signature_version` varchar(255) DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_uptodate` tinyint(4) NOT NULL DEFAULT 0,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  `date_expiration` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `antivirus_version` (`antivirus_version`),
  KEY `signature_version` (`signature_version`),
  KEY `is_active` (`is_active`),
  KEY `is_uptodate` (`is_uptodate`),
  KEY `is_dynamic` (`is_dynamic`),
  KEY `is_deleted` (`is_deleted`),
  KEY `computers_id` (`computers_id`),
  KEY `date_expiration` (`date_expiration`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `manufacturers_id` (`manufacturers_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1468 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_computermodels`
--

DROP TABLE IF EXISTS `glpi_computermodels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_computermodels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `product_number` varchar(255) DEFAULT NULL,
  `weight` int(11) NOT NULL DEFAULT 0,
  `required_units` int(11) NOT NULL DEFAULT 1,
  `depth` float NOT NULL DEFAULT 1,
  `power_connections` int(11) NOT NULL DEFAULT 0,
  `power_consumption` int(11) NOT NULL DEFAULT 0,
  `is_half_rack` tinyint(4) NOT NULL DEFAULT 0,
  `picture_front` text DEFAULT NULL,
  `picture_rear` text DEFAULT NULL,
  `pictures` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `product_number` (`product_number`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_computers`
--

DROP TABLE IF EXISTS `glpi_computers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_computers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `serial` varchar(255) DEFAULT NULL,
  `otherserial` varchar(255) DEFAULT NULL,
  `contact` varchar(255) DEFAULT NULL,
  `contact_num` varchar(255) DEFAULT NULL,
  `users_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `autoupdatesystems_id` int(10) unsigned NOT NULL DEFAULT 0,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `networks_id` int(10) unsigned NOT NULL DEFAULT 0,
  `computermodels_id` int(10) unsigned NOT NULL DEFAULT 0,
  `computertypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_template` tinyint(4) NOT NULL DEFAULT 0,
  `template_name` varchar(255) DEFAULT NULL,
  `manufacturers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0,
  `ticket_tco` decimal(20,4) DEFAULT 0.0000,
  `uuid` varchar(255) DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `last_inventory_update` timestamp NULL DEFAULT NULL,
  `last_boot` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `date_mod` (`date_mod`),
  KEY `name` (`name`),
  KEY `is_template` (`is_template`),
  KEY `autoupdatesystems_id` (`autoupdatesystems_id`),
  KEY `entities_id` (`entities_id`),
  KEY `manufacturers_id` (`manufacturers_id`),
  KEY `groups_id` (`groups_id`),
  KEY `users_id` (`users_id`),
  KEY `locations_id` (`locations_id`),
  KEY `computermodels_id` (`computermodels_id`),
  KEY `networks_id` (`networks_id`),
  KEY `states_id` (`states_id`),
  KEY `users_id_tech` (`users_id_tech`),
  KEY `computertypes_id` (`computertypes_id`),
  KEY `is_deleted` (`is_deleted`),
  KEY `groups_id_tech` (`groups_id_tech`),
  KEY `is_dynamic` (`is_dynamic`),
  KEY `serial` (`serial`),
  KEY `otherserial` (`otherserial`),
  KEY `uuid` (`uuid`),
  KEY `date_creation` (`date_creation`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB AUTO_INCREMENT=216 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_computers_items`
--

DROP TABLE IF EXISTS `glpi_computers_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_computers_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to various table, according to itemtype (ID)',
  `computers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) NOT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `computers_id` (`computers_id`),
  KEY `item` (`itemtype`,`items_id`),
  KEY `is_deleted` (`is_deleted`),
  KEY `is_dynamic` (`is_dynamic`)
) ENGINE=InnoDB AUTO_INCREMENT=76009 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_computertypes`
--

DROP TABLE IF EXISTS `glpi_computertypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_computertypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_computervirtualmachines`
--

DROP TABLE IF EXISTS `glpi_computervirtualmachines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_computervirtualmachines` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `computers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `virtualmachinestates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `virtualmachinesystems_id` int(10) unsigned NOT NULL DEFAULT 0,
  `virtualmachinetypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `uuid` varchar(255) NOT NULL DEFAULT '',
  `vcpu` int(11) NOT NULL DEFAULT 0,
  `ram` int(10) unsigned DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `computers_id` (`computers_id`),
  KEY `entities_id` (`entities_id`),
  KEY `name` (`name`),
  KEY `virtualmachinestates_id` (`virtualmachinestates_id`),
  KEY `virtualmachinesystems_id` (`virtualmachinesystems_id`),
  KEY `vcpu` (`vcpu`),
  KEY `ram` (`ram`),
  KEY `is_deleted` (`is_deleted`),
  KEY `is_dynamic` (`is_dynamic`),
  KEY `uuid` (`uuid`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `virtualmachinetypes_id` (`virtualmachinetypes_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_configs`
--

DROP TABLE IF EXISTS `glpi_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_configs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `context` varchar(150) DEFAULT NULL,
  `name` varchar(150) DEFAULT NULL,
  `value` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`context`,`name`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=318 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_consumableitems`
--

DROP TABLE IF EXISTS `glpi_consumableitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_consumableitems` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `ref` varchar(255) DEFAULT NULL,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `consumableitemtypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `manufacturers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `alarm_threshold` int(11) NOT NULL DEFAULT 10,
  `stock_target` int(11) NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `otherserial` varchar(255) DEFAULT NULL,
  `pictures` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `manufacturers_id` (`manufacturers_id`),
  KEY `locations_id` (`locations_id`),
  KEY `users_id_tech` (`users_id_tech`),
  KEY `consumableitemtypes_id` (`consumableitemtypes_id`),
  KEY `is_deleted` (`is_deleted`),
  KEY `alarm_threshold` (`alarm_threshold`),
  KEY `groups_id_tech` (`groups_id_tech`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `otherserial` (`otherserial`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_consumableitemtypes`
--

DROP TABLE IF EXISTS `glpi_consumableitemtypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_consumableitemtypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_consumables`
--

DROP TABLE IF EXISTS `glpi_consumables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_consumables` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `consumableitems_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_in` date DEFAULT NULL,
  `date_out` date DEFAULT NULL,
  `itemtype` varchar(100) DEFAULT NULL,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `date_in` (`date_in`),
  KEY `date_out` (`date_out`),
  KEY `consumableitems_id` (`consumableitems_id`),
  KEY `entities_id` (`entities_id`),
  KEY `item` (`itemtype`,`items_id`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_contacts`
--

DROP TABLE IF EXISTS `glpi_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_contacts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `registration_number` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `phone2` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `fax` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `contacttypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `usertitles_id` int(10) unsigned NOT NULL DEFAULT 0,
  `address` text DEFAULT NULL,
  `postcode` varchar(255) DEFAULT NULL,
  `town` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `pictures` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `contacttypes_id` (`contacttypes_id`),
  KEY `is_deleted` (`is_deleted`),
  KEY `usertitles_id` (`usertitles_id`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_contacts_suppliers`
--

DROP TABLE IF EXISTS `glpi_contacts_suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_contacts_suppliers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `suppliers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `contacts_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`suppliers_id`,`contacts_id`),
  KEY `contacts_id` (`contacts_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_contacttypes`
--

DROP TABLE IF EXISTS `glpi_contacttypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_contacttypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_contractcosts`
--

DROP TABLE IF EXISTS `glpi_contractcosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_contractcosts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `contracts_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `begin_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `cost` decimal(20,4) NOT NULL DEFAULT 0.0000,
  `budgets_id` int(10) unsigned NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `contracts_id` (`contracts_id`),
  KEY `begin_date` (`begin_date`),
  KEY `end_date` (`end_date`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `budgets_id` (`budgets_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_contracts`
--

DROP TABLE IF EXISTS `glpi_contracts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_contracts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `num` varchar(255) DEFAULT NULL,
  `contracttypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `begin_date` date DEFAULT NULL,
  `duration` int(11) NOT NULL DEFAULT 0,
  `notice` int(11) NOT NULL DEFAULT 0,
  `periodicity` int(11) NOT NULL DEFAULT 0,
  `billing` int(11) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `accounting_number` varchar(255) DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `week_begin_hour` time NOT NULL DEFAULT '00:00:00',
  `week_end_hour` time NOT NULL DEFAULT '00:00:00',
  `saturday_begin_hour` time NOT NULL DEFAULT '00:00:00',
  `saturday_end_hour` time NOT NULL DEFAULT '00:00:00',
  `use_saturday` tinyint(4) NOT NULL DEFAULT 0,
  `sunday_begin_hour` time NOT NULL DEFAULT '00:00:00',
  `sunday_end_hour` time NOT NULL DEFAULT '00:00:00',
  `use_sunday` tinyint(4) NOT NULL DEFAULT 0,
  `max_links_allowed` int(11) NOT NULL DEFAULT 0,
  `alert` int(11) NOT NULL DEFAULT 0,
  `renewal` int(11) NOT NULL DEFAULT 0,
  `template_name` varchar(255) DEFAULT NULL,
  `is_template` tinyint(4) NOT NULL DEFAULT 0,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `begin_date` (`begin_date`),
  KEY `name` (`name`),
  KEY `contracttypes_id` (`contracttypes_id`),
  KEY `locations_id` (`locations_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `is_deleted` (`is_deleted`),
  KEY `is_template` (`is_template`),
  KEY `use_sunday` (`use_sunday`),
  KEY `use_saturday` (`use_saturday`),
  KEY `alert` (`alert`),
  KEY `states_id` (`states_id`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_contracts_items`
--

DROP TABLE IF EXISTS `glpi_contracts_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_contracts_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `contracts_id` int(10) unsigned NOT NULL DEFAULT 0,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`contracts_id`,`itemtype`,`items_id`),
  KEY `item` (`itemtype`,`items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_contracts_suppliers`
--

DROP TABLE IF EXISTS `glpi_contracts_suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_contracts_suppliers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `suppliers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `contracts_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`suppliers_id`,`contracts_id`),
  KEY `contracts_id` (`contracts_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_contracttypes`
--

DROP TABLE IF EXISTS `glpi_contracttypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_contracttypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_crontasklogs`
--

DROP TABLE IF EXISTS `glpi_crontasklogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_crontasklogs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `crontasks_id` int(10) unsigned NOT NULL,
  `crontasklogs_id` int(10) unsigned NOT NULL COMMENT 'id of ''start'' event',
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `state` int(11) NOT NULL COMMENT '0:start, 1:run, 2:stop',
  `elapsed` float NOT NULL COMMENT 'time elapsed since start',
  `volume` int(11) NOT NULL COMMENT 'for statistics',
  `content` varchar(255) DEFAULT NULL COMMENT 'message',
  PRIMARY KEY (`id`),
  KEY `date` (`date`),
  KEY `crontasks_id` (`crontasks_id`),
  KEY `crontasklogs_id_state` (`crontasklogs_id`,`state`)
) ENGINE=InnoDB AUTO_INCREMENT=17140 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_crontasks`
--

DROP TABLE IF EXISTS `glpi_crontasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_crontasks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `itemtype` varchar(100) NOT NULL,
  `name` varchar(150) NOT NULL COMMENT 'task name',
  `frequency` int(11) NOT NULL COMMENT 'second between launch',
  `param` int(11) DEFAULT NULL COMMENT 'task specify parameter',
  `state` int(11) NOT NULL DEFAULT 1 COMMENT '0:disabled, 1:waiting, 2:running',
  `mode` int(11) NOT NULL DEFAULT 1 COMMENT '1:internal, 2:external',
  `allowmode` int(11) NOT NULL DEFAULT 3 COMMENT '1:internal, 2:external, 3:both',
  `hourmin` int(11) NOT NULL DEFAULT 0,
  `hourmax` int(11) NOT NULL DEFAULT 24,
  `logs_lifetime` int(11) NOT NULL DEFAULT 30 COMMENT 'number of days',
  `lastrun` timestamp NULL DEFAULT NULL COMMENT 'last run date',
  `lastcode` int(11) DEFAULT NULL COMMENT 'last run return code',
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`itemtype`,`name`),
  KEY `name` (`name`),
  KEY `mode` (`mode`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='Task run by internal / external cron.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_dashboards_dashboards`
--

DROP TABLE IF EXISTS `glpi_dashboards_dashboards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_dashboards_dashboards` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `context` varchar(100) NOT NULL DEFAULT 'core',
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`),
  KEY `name` (`name`),
  KEY `users_id` (`users_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_dashboards_filters`
--

DROP TABLE IF EXISTS `glpi_dashboards_filters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_dashboards_filters` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dashboards_dashboards_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `filter` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dashboards_dashboards_id` (`dashboards_dashboards_id`),
  KEY `users_id` (`users_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_dashboards_items`
--

DROP TABLE IF EXISTS `glpi_dashboards_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_dashboards_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dashboards_dashboards_id` int(10) unsigned NOT NULL,
  `gridstack_id` varchar(255) NOT NULL,
  `card_id` varchar(255) NOT NULL,
  `x` int(11) DEFAULT NULL,
  `y` int(11) DEFAULT NULL,
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `card_options` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dashboards_dashboards_id` (`dashboards_dashboards_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4219 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_dashboards_rights`
--

DROP TABLE IF EXISTS `glpi_dashboards_rights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_dashboards_rights` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dashboards_dashboards_id` int(10) unsigned NOT NULL,
  `itemtype` varchar(100) NOT NULL,
  `items_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`dashboards_dashboards_id`,`itemtype`,`items_id`),
  KEY `item` (`itemtype`,`items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_databaseinstancecategories`
--

DROP TABLE IF EXISTS `glpi_databaseinstancecategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_databaseinstancecategories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_databaseinstances`
--

DROP TABLE IF EXISTS `glpi_databaseinstances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_databaseinstances` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `version` varchar(255) NOT NULL DEFAULT '',
  `port` varchar(10) NOT NULL DEFAULT '',
  `path` varchar(255) NOT NULL DEFAULT '',
  `size` int(11) NOT NULL DEFAULT 0,
  `databaseinstancetypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `databaseinstancecategories_id` int(10) unsigned NOT NULL DEFAULT 0,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `manufacturers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) NOT NULL DEFAULT '',
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_onbackup` tinyint(4) NOT NULL DEFAULT 0,
  `is_active` tinyint(4) NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_helpdesk_visible` tinyint(4) NOT NULL DEFAULT 1,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  `autoupdatesystems_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_creation` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_lastboot` timestamp NULL DEFAULT NULL,
  `date_lastbackup` timestamp NULL DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `name` (`name`),
  KEY `databaseinstancetypes_id` (`databaseinstancetypes_id`),
  KEY `databaseinstancecategories_id` (`databaseinstancecategories_id`),
  KEY `locations_id` (`locations_id`),
  KEY `manufacturers_id` (`manufacturers_id`),
  KEY `users_id_tech` (`users_id_tech`),
  KEY `groups_id_tech` (`groups_id_tech`),
  KEY `states_id` (`states_id`),
  KEY `item` (`itemtype`,`items_id`),
  KEY `is_active` (`is_active`),
  KEY `is_deleted` (`is_deleted`),
  KEY `date_creation` (`date_creation`),
  KEY `date_mod` (`date_mod`),
  KEY `is_helpdesk_visible` (`is_helpdesk_visible`),
  KEY `is_dynamic` (`is_dynamic`),
  KEY `autoupdatesystems_id` (`autoupdatesystems_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_databaseinstancetypes`
--

DROP TABLE IF EXISTS `glpi_databaseinstancetypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_databaseinstancetypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_databases`
--

DROP TABLE IF EXISTS `glpi_databases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_databases` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `size` int(11) NOT NULL DEFAULT 0,
  `databaseinstances_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_onbackup` tinyint(4) NOT NULL DEFAULT 0,
  `is_active` tinyint(4) NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  `date_creation` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_update` timestamp NULL DEFAULT NULL,
  `date_lastbackup` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `name` (`name`),
  KEY `is_active` (`is_active`),
  KEY `is_deleted` (`is_deleted`),
  KEY `is_dynamic` (`is_dynamic`),
  KEY `date_creation` (`date_creation`),
  KEY `date_mod` (`date_mod`),
  KEY `databaseinstances_id` (`databaseinstances_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_datacenters`
--

DROP TABLE IF EXISTS `glpi_datacenters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_datacenters` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `pictures` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `locations_id` (`locations_id`),
  KEY `is_deleted` (`is_deleted`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_dcrooms`
--

DROP TABLE IF EXISTS `glpi_dcrooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_dcrooms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `vis_cols` int(11) DEFAULT NULL,
  `vis_rows` int(11) DEFAULT NULL,
  `blueprint` text DEFAULT NULL,
  `datacenters_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `locations_id` (`locations_id`),
  KEY `datacenters_id` (`datacenters_id`),
  KEY `is_deleted` (`is_deleted`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_devicebatteries`
--

DROP TABLE IF EXISTS `glpi_devicebatteries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_devicebatteries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `designation` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `manufacturers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `voltage` int(11) DEFAULT NULL,
  `capacity` int(11) DEFAULT NULL,
  `devicebatterytypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `devicebatterymodels_id` int(10) unsigned DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `designation` (`designation`),
  KEY `manufacturers_id` (`manufacturers_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `devicebatterymodels_id` (`devicebatterymodels_id`),
  KEY `devicebatterytypes_id` (`devicebatterytypes_id`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_devicebatterymodels`
--

DROP TABLE IF EXISTS `glpi_devicebatterymodels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_devicebatterymodels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `product_number` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `product_number` (`product_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_devicebatterytypes`
--

DROP TABLE IF EXISTS `glpi_devicebatterytypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_devicebatterytypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_devicecameramodels`
--

DROP TABLE IF EXISTS `glpi_devicecameramodels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_devicecameramodels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `product_number` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `product_number` (`product_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_devicecameras`
--

DROP TABLE IF EXISTS `glpi_devicecameras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_devicecameras` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `designation` varchar(255) DEFAULT NULL,
  `flashunit` tinyint(4) NOT NULL DEFAULT 0,
  `lensfacing` varchar(255) DEFAULT NULL,
  `orientation` varchar(255) DEFAULT NULL,
  `focallength` varchar(255) DEFAULT NULL,
  `sensorsize` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `manufacturers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `devicecameramodels_id` int(10) unsigned DEFAULT NULL,
  `support` varchar(255) DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `designation` (`designation`),
  KEY `manufacturers_id` (`manufacturers_id`),
  KEY `devicecameramodels_id` (`devicecameramodels_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_devicecasemodels`
--

DROP TABLE IF EXISTS `glpi_devicecasemodels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_devicecasemodels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `product_number` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `product_number` (`product_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_devicecases`
--

DROP TABLE IF EXISTS `glpi_devicecases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_devicecases` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `designation` varchar(255) DEFAULT NULL,
  `devicecasetypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `manufacturers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `devicecasemodels_id` int(10) unsigned DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `designation` (`designation`),
  KEY `manufacturers_id` (`manufacturers_id`),
  KEY `devicecasetypes_id` (`devicecasetypes_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `devicecasemodels_id` (`devicecasemodels_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_devicecasetypes`
--

DROP TABLE IF EXISTS `glpi_devicecasetypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_devicecasetypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_devicecontrolmodels`
--

DROP TABLE IF EXISTS `glpi_devicecontrolmodels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_devicecontrolmodels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `product_number` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `product_number` (`product_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_devicecontrols`
--

DROP TABLE IF EXISTS `glpi_devicecontrols`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_devicecontrols` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `designation` varchar(255) DEFAULT NULL,
  `is_raid` tinyint(4) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `manufacturers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `interfacetypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `devicecontrolmodels_id` int(10) unsigned DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `designation` (`designation`),
  KEY `manufacturers_id` (`manufacturers_id`),
  KEY `interfacetypes_id` (`interfacetypes_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `devicecontrolmodels_id` (`devicecontrolmodels_id`)
) ENGINE=InnoDB AUTO_INCREMENT=371 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_devicedrivemodels`
--

DROP TABLE IF EXISTS `glpi_devicedrivemodels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_devicedrivemodels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `product_number` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `product_number` (`product_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_devicedrives`
--

DROP TABLE IF EXISTS `glpi_devicedrives`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_devicedrives` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `designation` varchar(255) DEFAULT NULL,
  `is_writer` tinyint(4) NOT NULL DEFAULT 1,
  `speed` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `manufacturers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `interfacetypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `devicedrivemodels_id` int(10) unsigned DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `designation` (`designation`),
  KEY `manufacturers_id` (`manufacturers_id`),
  KEY `interfacetypes_id` (`interfacetypes_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `devicedrivemodels_id` (`devicedrivemodels_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_devicefirmwaremodels`
--

DROP TABLE IF EXISTS `glpi_devicefirmwaremodels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_devicefirmwaremodels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `product_number` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `product_number` (`product_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_devicefirmwares`
--

DROP TABLE IF EXISTS `glpi_devicefirmwares`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_devicefirmwares` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `designation` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `manufacturers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date` date DEFAULT NULL,
  `version` varchar(255) DEFAULT NULL,
  `devicefirmwaretypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `devicefirmwaremodels_id` int(10) unsigned DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `designation` (`designation`),
  KEY `manufacturers_id` (`manufacturers_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `devicefirmwaremodels_id` (`devicefirmwaremodels_id`),
  KEY `devicefirmwaretypes_id` (`devicefirmwaretypes_id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_devicefirmwaretypes`
--

DROP TABLE IF EXISTS `glpi_devicefirmwaretypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_devicefirmwaretypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_devicegenericmodels`
--

DROP TABLE IF EXISTS `glpi_devicegenericmodels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_devicegenericmodels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `product_number` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `product_number` (`product_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_devicegenerics`
--

DROP TABLE IF EXISTS `glpi_devicegenerics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_devicegenerics` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `designation` varchar(255) DEFAULT NULL,
  `devicegenerictypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `manufacturers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0,
  `devicegenericmodels_id` int(10) unsigned DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `designation` (`designation`),
  KEY `manufacturers_id` (`manufacturers_id`),
  KEY `devicegenerictypes_id` (`devicegenerictypes_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `locations_id` (`locations_id`),
  KEY `states_id` (`states_id`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `devicegenericmodels_id` (`devicegenericmodels_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_devicegenerictypes`
--

DROP TABLE IF EXISTS `glpi_devicegenerictypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_devicegenerictypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_devicegraphiccardmodels`
--

DROP TABLE IF EXISTS `glpi_devicegraphiccardmodels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_devicegraphiccardmodels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `product_number` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `product_number` (`product_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_devicegraphiccards`
--

DROP TABLE IF EXISTS `glpi_devicegraphiccards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_devicegraphiccards` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `designation` varchar(255) DEFAULT NULL,
  `interfacetypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `manufacturers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `memory_default` int(11) NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `devicegraphiccardmodels_id` int(10) unsigned DEFAULT NULL,
  `chipset` varchar(255) DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `designation` (`designation`),
  KEY `manufacturers_id` (`manufacturers_id`),
  KEY `interfacetypes_id` (`interfacetypes_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `chipset` (`chipset`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `devicegraphiccardmodels_id` (`devicegraphiccardmodels_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_deviceharddrivemodels`
--

DROP TABLE IF EXISTS `glpi_deviceharddrivemodels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_deviceharddrivemodels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `product_number` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `product_number` (`product_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_deviceharddrives`
--

DROP TABLE IF EXISTS `glpi_deviceharddrives`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_deviceharddrives` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `designation` varchar(255) DEFAULT NULL,
  `rpm` varchar(255) DEFAULT NULL,
  `interfacetypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `cache` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `manufacturers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `capacity_default` int(11) NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `deviceharddrivemodels_id` int(10) unsigned DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `designation` (`designation`),
  KEY `manufacturers_id` (`manufacturers_id`),
  KEY `interfacetypes_id` (`interfacetypes_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `deviceharddrivemodels_id` (`deviceharddrivemodels_id`)
) ENGINE=InnoDB AUTO_INCREMENT=173 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_devicememories`
--

DROP TABLE IF EXISTS `glpi_devicememories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_devicememories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `designation` varchar(255) DEFAULT NULL,
  `frequence` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `manufacturers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `size_default` int(11) NOT NULL DEFAULT 0,
  `devicememorytypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `devicememorymodels_id` int(10) unsigned DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `designation` (`designation`),
  KEY `manufacturers_id` (`manufacturers_id`),
  KEY `devicememorytypes_id` (`devicememorytypes_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `devicememorymodels_id` (`devicememorymodels_id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_devicememorymodels`
--

DROP TABLE IF EXISTS `glpi_devicememorymodels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_devicememorymodels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `product_number` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `product_number` (`product_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_devicememorytypes`
--

DROP TABLE IF EXISTS `glpi_devicememorytypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_devicememorytypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_devicemotherboardmodels`
--

DROP TABLE IF EXISTS `glpi_devicemotherboardmodels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_devicemotherboardmodels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `product_number` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `product_number` (`product_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_devicemotherboards`
--

DROP TABLE IF EXISTS `glpi_devicemotherboards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_devicemotherboards` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `designation` varchar(255) DEFAULT NULL,
  `chipset` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `manufacturers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `devicemotherboardmodels_id` int(10) unsigned DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `designation` (`designation`),
  KEY `manufacturers_id` (`manufacturers_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `devicemotherboardmodels_id` (`devicemotherboardmodels_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_devicenetworkcardmodels`
--

DROP TABLE IF EXISTS `glpi_devicenetworkcardmodels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_devicenetworkcardmodels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `product_number` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `product_number` (`product_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_devicenetworkcards`
--

DROP TABLE IF EXISTS `glpi_devicenetworkcards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_devicenetworkcards` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `designation` varchar(255) DEFAULT NULL,
  `bandwidth` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `manufacturers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `mac_default` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `devicenetworkcardmodels_id` int(10) unsigned DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `designation` (`designation`),
  KEY `manufacturers_id` (`manufacturers_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `devicenetworkcardmodels_id` (`devicenetworkcardmodels_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_devicepcimodels`
--

DROP TABLE IF EXISTS `glpi_devicepcimodels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_devicepcimodels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `product_number` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `product_number` (`product_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_devicepcis`
--

DROP TABLE IF EXISTS `glpi_devicepcis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_devicepcis` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `designation` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `manufacturers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `devicenetworkcardmodels_id` int(10) unsigned NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `devicepcimodels_id` int(10) unsigned DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `designation` (`designation`),
  KEY `manufacturers_id` (`manufacturers_id`),
  KEY `devicenetworkcardmodels_id` (`devicenetworkcardmodels_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `devicepcimodels_id` (`devicepcimodels_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_devicepowersupplies`
--

DROP TABLE IF EXISTS `glpi_devicepowersupplies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_devicepowersupplies` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `designation` varchar(255) DEFAULT NULL,
  `power` varchar(255) DEFAULT NULL,
  `is_atx` tinyint(4) NOT NULL DEFAULT 1,
  `comment` text DEFAULT NULL,
  `manufacturers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `devicepowersupplymodels_id` int(10) unsigned DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `designation` (`designation`),
  KEY `manufacturers_id` (`manufacturers_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `devicepowersupplymodels_id` (`devicepowersupplymodels_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_devicepowersupplymodels`
--

DROP TABLE IF EXISTS `glpi_devicepowersupplymodels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_devicepowersupplymodels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `product_number` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `product_number` (`product_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_deviceprocessormodels`
--

DROP TABLE IF EXISTS `glpi_deviceprocessormodels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_deviceprocessormodels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `product_number` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `product_number` (`product_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_deviceprocessors`
--

DROP TABLE IF EXISTS `glpi_deviceprocessors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_deviceprocessors` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `designation` varchar(255) DEFAULT NULL,
  `frequence` int(11) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `manufacturers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `frequency_default` int(11) NOT NULL DEFAULT 0,
  `nbcores_default` int(11) DEFAULT NULL,
  `nbthreads_default` int(11) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `deviceprocessormodels_id` int(10) unsigned DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `designation` (`designation`),
  KEY `manufacturers_id` (`manufacturers_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `deviceprocessormodels_id` (`deviceprocessormodels_id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_devicesensormodels`
--

DROP TABLE IF EXISTS `glpi_devicesensormodels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_devicesensormodels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `product_number` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `product_number` (`product_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_devicesensors`
--

DROP TABLE IF EXISTS `glpi_devicesensors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_devicesensors` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `designation` varchar(255) DEFAULT NULL,
  `devicesensortypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `devicesensormodels_id` int(10) unsigned NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `manufacturers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `designation` (`designation`),
  KEY `manufacturers_id` (`manufacturers_id`),
  KEY `devicesensortypes_id` (`devicesensortypes_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `locations_id` (`locations_id`),
  KEY `states_id` (`states_id`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `devicesensormodels_id` (`devicesensormodels_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_devicesensortypes`
--

DROP TABLE IF EXISTS `glpi_devicesensortypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_devicesensortypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_devicesimcards`
--

DROP TABLE IF EXISTS `glpi_devicesimcards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_devicesimcards` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `designation` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `manufacturers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `voltage` int(11) DEFAULT NULL,
  `devicesimcardtypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `allow_voip` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `designation` (`designation`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `devicesimcardtypes_id` (`devicesimcardtypes_id`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `manufacturers_id` (`manufacturers_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_devicesimcardtypes`
--

DROP TABLE IF EXISTS `glpi_devicesimcardtypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_devicesimcardtypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_devicesoundcardmodels`
--

DROP TABLE IF EXISTS `glpi_devicesoundcardmodels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_devicesoundcardmodels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `product_number` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `product_number` (`product_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_devicesoundcards`
--

DROP TABLE IF EXISTS `glpi_devicesoundcards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_devicesoundcards` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `designation` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `manufacturers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `devicesoundcardmodels_id` int(10) unsigned DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `designation` (`designation`),
  KEY `manufacturers_id` (`manufacturers_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `devicesoundcardmodels_id` (`devicesoundcardmodels_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_displaypreferences`
--

DROP TABLE IF EXISTS `glpi_displaypreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_displaypreferences` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `itemtype` varchar(100) NOT NULL,
  `num` int(11) NOT NULL DEFAULT 0,
  `rank` int(11) NOT NULL DEFAULT 0,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`users_id`,`itemtype`,`num`),
  KEY `rank` (`rank`),
  KEY `num` (`num`),
  KEY `itemtype` (`itemtype`)
) ENGINE=InnoDB AUTO_INCREMENT=386 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_documentcategories`
--

DROP TABLE IF EXISTS `glpi_documentcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_documentcategories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `documentcategories_id` int(10) unsigned NOT NULL DEFAULT 0,
  `completename` text DEFAULT NULL,
  `level` int(11) NOT NULL DEFAULT 0,
  `ancestors_cache` longtext DEFAULT NULL,
  `sons_cache` longtext DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`documentcategories_id`,`name`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `level` (`level`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_documents`
--

DROP TABLE IF EXISTS `glpi_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_documents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `filename` varchar(255) DEFAULT NULL COMMENT 'for display and transfert',
  `filepath` varchar(255) DEFAULT NULL COMMENT 'file storage path',
  `documentcategories_id` int(10) unsigned NOT NULL DEFAULT 0,
  `mime` varchar(255) DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `link` varchar(255) DEFAULT NULL,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `tickets_id` int(10) unsigned NOT NULL DEFAULT 0,
  `sha1sum` char(40) DEFAULT NULL,
  `is_blacklisted` tinyint(4) NOT NULL DEFAULT 0,
  `tag` varchar(255) DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `date_mod` (`date_mod`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `tickets_id` (`tickets_id`),
  KEY `users_id` (`users_id`),
  KEY `documentcategories_id` (`documentcategories_id`),
  KEY `is_deleted` (`is_deleted`),
  KEY `sha1sum` (`sha1sum`),
  KEY `tag` (`tag`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_documents_items`
--

DROP TABLE IF EXISTS `glpi_documents_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_documents_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `documents_id` int(10) unsigned NOT NULL DEFAULT 0,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) NOT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `users_id` int(10) unsigned DEFAULT 0,
  `timeline_position` tinyint(4) NOT NULL DEFAULT 0,
  `date_creation` timestamp NULL DEFAULT NULL,
  `date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`documents_id`,`itemtype`,`items_id`,`timeline_position`),
  KEY `item` (`itemtype`,`items_id`,`entities_id`,`is_recursive`),
  KEY `users_id` (`users_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `date_creation` (`date_creation`),
  KEY `date_mod` (`date_mod`),
  KEY `date` (`date`),
  KEY `timeline_position` (`timeline_position`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_documenttypes`
--

DROP TABLE IF EXISTS `glpi_documenttypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_documenttypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `ext` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `mime` varchar(255) DEFAULT NULL,
  `is_uploadable` tinyint(4) NOT NULL DEFAULT 1,
  `date_mod` timestamp NULL DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`ext`),
  KEY `name` (`name`),
  KEY `is_uploadable` (`is_uploadable`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_domainrecords`
--

DROP TABLE IF EXISTS `glpi_domainrecords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_domainrecords` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `data` text DEFAULT NULL,
  `data_obj` text DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `domains_id` int(10) unsigned NOT NULL DEFAULT 0,
  `domainrecordtypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `ttl` int(11) NOT NULL,
  `users_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `domains_id` (`domains_id`),
  KEY `domainrecordtypes_id` (`domainrecordtypes_id`),
  KEY `users_id_tech` (`users_id_tech`),
  KEY `groups_id_tech` (`groups_id_tech`),
  KEY `date_mod` (`date_mod`),
  KEY `is_deleted` (`is_deleted`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_domainrecordtypes`
--

DROP TABLE IF EXISTS `glpi_domainrecordtypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_domainrecordtypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `fields` text DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_domainrelations`
--

DROP TABLE IF EXISTS `glpi_domainrelations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_domainrelations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_domains`
--

DROP TABLE IF EXISTS `glpi_domains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_domains` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `domaintypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_expiration` timestamp NULL DEFAULT NULL,
  `date_domaincreation` timestamp NULL DEFAULT NULL,
  `users_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `is_template` tinyint(4) NOT NULL DEFAULT 0,
  `template_name` varchar(255) DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `domaintypes_id` (`domaintypes_id`),
  KEY `users_id_tech` (`users_id_tech`),
  KEY `groups_id_tech` (`groups_id_tech`),
  KEY `date_mod` (`date_mod`),
  KEY `is_deleted` (`is_deleted`),
  KEY `is_template` (`is_template`),
  KEY `is_active` (`is_active`),
  KEY `date_expiration` (`date_expiration`),
  KEY `date_domaincreation` (`date_domaincreation`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_domains_items`
--

DROP TABLE IF EXISTS `glpi_domains_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_domains_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `domains_id` int(10) unsigned NOT NULL DEFAULT 0,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) NOT NULL,
  `domainrelations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`domains_id`,`itemtype`,`items_id`),
  KEY `domainrelations_id` (`domainrelations_id`),
  KEY `item` (`itemtype`,`items_id`),
  KEY `is_dynamic` (`is_dynamic`),
  KEY `is_deleted` (`is_deleted`)
) ENGINE=InnoDB AUTO_INCREMENT=212 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_domaintypes`
--

DROP TABLE IF EXISTS `glpi_domaintypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_domaintypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_dropdowntranslations`
--

DROP TABLE IF EXISTS `glpi_dropdowntranslations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_dropdowntranslations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) DEFAULT NULL,
  `language` varchar(10) DEFAULT NULL,
  `field` varchar(100) DEFAULT NULL,
  `value` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`itemtype`,`items_id`,`language`,`field`),
  KEY `language` (`language`),
  KEY `field` (`field`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_enclosuremodels`
--

DROP TABLE IF EXISTS `glpi_enclosuremodels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_enclosuremodels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `product_number` varchar(255) DEFAULT NULL,
  `weight` int(11) NOT NULL DEFAULT 0,
  `required_units` int(11) NOT NULL DEFAULT 1,
  `depth` float NOT NULL DEFAULT 1,
  `power_connections` int(11) NOT NULL DEFAULT 0,
  `power_consumption` int(11) NOT NULL DEFAULT 0,
  `is_half_rack` tinyint(4) NOT NULL DEFAULT 0,
  `picture_front` text DEFAULT NULL,
  `picture_rear` text DEFAULT NULL,
  `pictures` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `product_number` (`product_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_enclosures`
--

DROP TABLE IF EXISTS `glpi_enclosures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_enclosures` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `serial` varchar(255) DEFAULT NULL,
  `otherserial` varchar(255) DEFAULT NULL,
  `enclosuremodels_id` int(10) unsigned DEFAULT NULL,
  `users_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `is_template` tinyint(4) NOT NULL DEFAULT 0,
  `template_name` varchar(255) DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `orientation` tinyint(4) DEFAULT NULL,
  `power_supplies` tinyint(4) NOT NULL DEFAULT 0,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to states (id)',
  `comment` text DEFAULT NULL,
  `manufacturers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `locations_id` (`locations_id`),
  KEY `enclosuremodels_id` (`enclosuremodels_id`),
  KEY `users_id_tech` (`users_id_tech`),
  KEY `group_id_tech` (`groups_id_tech`),
  KEY `is_template` (`is_template`),
  KEY `is_deleted` (`is_deleted`),
  KEY `states_id` (`states_id`),
  KEY `manufacturers_id` (`manufacturers_id`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_entities`
--

DROP TABLE IF EXISTS `glpi_entities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_entities` (
  `id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned DEFAULT 0,
  `completename` text DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `level` int(11) NOT NULL DEFAULT 0,
  `sons_cache` longtext DEFAULT NULL,
  `ancestors_cache` longtext DEFAULT NULL,
  `registration_number` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `postcode` varchar(255) DEFAULT NULL,
  `town` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `phonenumber` varchar(255) DEFAULT NULL,
  `fax` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `admin_email` varchar(255) DEFAULT NULL,
  `admin_email_name` varchar(255) DEFAULT NULL,
  `from_email` varchar(255) DEFAULT NULL,
  `from_email_name` varchar(255) DEFAULT NULL,
  `noreply_email` varchar(255) DEFAULT NULL,
  `noreply_email_name` varchar(255) DEFAULT NULL,
  `replyto_email` varchar(255) DEFAULT NULL,
  `replyto_email_name` varchar(255) DEFAULT NULL,
  `notification_subject_tag` varchar(255) DEFAULT NULL,
  `ldap_dn` varchar(255) DEFAULT NULL,
  `tag` varchar(255) DEFAULT NULL,
  `authldaps_id` int(10) unsigned NOT NULL DEFAULT 0,
  `mail_domain` varchar(255) DEFAULT NULL,
  `entity_ldapfilter` text DEFAULT NULL,
  `mailing_signature` text DEFAULT NULL,
  `cartridges_alert_repeat` int(11) NOT NULL DEFAULT -2,
  `consumables_alert_repeat` int(11) NOT NULL DEFAULT -2,
  `use_licenses_alert` int(11) NOT NULL DEFAULT -2,
  `send_licenses_alert_before_delay` int(11) NOT NULL DEFAULT -2,
  `use_certificates_alert` int(11) NOT NULL DEFAULT -2,
  `send_certificates_alert_before_delay` int(11) NOT NULL DEFAULT -2,
  `certificates_alert_repeat_interval` int(11) NOT NULL DEFAULT -2,
  `use_contracts_alert` int(11) NOT NULL DEFAULT -2,
  `send_contracts_alert_before_delay` int(11) NOT NULL DEFAULT -2,
  `use_infocoms_alert` int(11) NOT NULL DEFAULT -2,
  `send_infocoms_alert_before_delay` int(11) NOT NULL DEFAULT -2,
  `use_reservations_alert` int(11) NOT NULL DEFAULT -2,
  `use_domains_alert` int(11) NOT NULL DEFAULT -2,
  `send_domains_alert_close_expiries_delay` int(11) NOT NULL DEFAULT -2,
  `send_domains_alert_expired_delay` int(11) NOT NULL DEFAULT -2,
  `autoclose_delay` int(11) NOT NULL DEFAULT -2,
  `autopurge_delay` int(11) NOT NULL DEFAULT -2,
  `notclosed_delay` int(11) NOT NULL DEFAULT -2,
  `calendars_strategy` tinyint(4) NOT NULL DEFAULT -2,
  `calendars_id` int(10) unsigned NOT NULL DEFAULT 0,
  `auto_assign_mode` int(11) NOT NULL DEFAULT -2,
  `tickettype` int(11) NOT NULL DEFAULT -2,
  `max_closedate` timestamp NULL DEFAULT NULL,
  `inquest_config` int(11) NOT NULL DEFAULT -2,
  `inquest_rate` int(11) NOT NULL DEFAULT 0,
  `inquest_delay` int(11) NOT NULL DEFAULT -10,
  `inquest_URL` varchar(255) DEFAULT NULL,
  `autofill_warranty_date` varchar(255) NOT NULL DEFAULT '-2',
  `autofill_use_date` varchar(255) NOT NULL DEFAULT '-2',
  `autofill_buy_date` varchar(255) NOT NULL DEFAULT '-2',
  `autofill_delivery_date` varchar(255) NOT NULL DEFAULT '-2',
  `autofill_order_date` varchar(255) NOT NULL DEFAULT '-2',
  `tickettemplates_strategy` tinyint(4) NOT NULL DEFAULT -2,
  `tickettemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `changetemplates_strategy` tinyint(4) NOT NULL DEFAULT -2,
  `changetemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `problemtemplates_strategy` tinyint(4) NOT NULL DEFAULT -2,
  `problemtemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `entities_strategy_software` tinyint(4) NOT NULL DEFAULT -2,
  `entities_id_software` int(10) unsigned NOT NULL DEFAULT 0,
  `default_contract_alert` int(11) NOT NULL DEFAULT -2,
  `default_infocom_alert` int(11) NOT NULL DEFAULT -2,
  `default_cartridges_alarm_threshold` int(11) NOT NULL DEFAULT -2,
  `default_consumables_alarm_threshold` int(11) NOT NULL DEFAULT -2,
  `delay_send_emails` int(11) NOT NULL DEFAULT -2,
  `is_notif_enable_default` int(11) NOT NULL DEFAULT -2,
  `inquest_duration` int(11) NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `autofill_decommission_date` varchar(255) NOT NULL DEFAULT '-2',
  `suppliers_as_private` int(11) NOT NULL DEFAULT -2,
  `anonymize_support_agents` int(11) NOT NULL DEFAULT -2,
  `display_users_initials` int(11) NOT NULL DEFAULT -2,
  `contracts_strategy_default` tinyint(4) NOT NULL DEFAULT -2,
  `contracts_id_default` int(10) unsigned NOT NULL DEFAULT 0,
  `enable_custom_css` int(11) NOT NULL DEFAULT -2,
  `custom_css_code` text DEFAULT NULL,
  `latitude` varchar(255) DEFAULT NULL,
  `longitude` varchar(255) DEFAULT NULL,
  `altitude` varchar(255) DEFAULT NULL,
  `transfers_strategy` tinyint(4) NOT NULL DEFAULT -2,
  `transfers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `agent_base_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`entities_id`,`name`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `tickettemplates_id` (`tickettemplates_id`),
  KEY `changetemplates_id` (`changetemplates_id`),
  KEY `problemtemplates_id` (`problemtemplates_id`),
  KEY `transfers_id` (`transfers_id`),
  KEY `authldaps_id` (`authldaps_id`),
  KEY `calendars_id` (`calendars_id`),
  KEY `entities_id_software` (`entities_id_software`),
  KEY `contracts_id_default` (`contracts_id_default`),
  KEY `level` (`level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_entities_knowbaseitems`
--

DROP TABLE IF EXISTS `glpi_entities_knowbaseitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_entities_knowbaseitems` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `knowbaseitems_id` int(10) unsigned NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `knowbaseitems_id` (`knowbaseitems_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_entities_reminders`
--

DROP TABLE IF EXISTS `glpi_entities_reminders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_entities_reminders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reminders_id` int(10) unsigned NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `reminders_id` (`reminders_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_entities_rssfeeds`
--

DROP TABLE IF EXISTS `glpi_entities_rssfeeds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_entities_rssfeeds` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rssfeeds_id` int(10) unsigned NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `rssfeeds_id` (`rssfeeds_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_events`
--

DROP TABLE IF EXISTS `glpi_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_events` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `type` varchar(255) DEFAULT NULL,
  `date` timestamp NULL DEFAULT NULL,
  `service` varchar(255) DEFAULT NULL,
  `level` int(11) NOT NULL DEFAULT 0,
  `message` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `date` (`date`),
  KEY `level` (`level`),
  KEY `item` (`type`,`items_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9313 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_fieldblacklists`
--

DROP TABLE IF EXISTS `glpi_fieldblacklists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_fieldblacklists` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `field` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL DEFAULT '',
  `itemtype` varchar(255) NOT NULL DEFAULT '',
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_fieldunicities`
--

DROP TABLE IF EXISTS `glpi_fieldunicities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_fieldunicities` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `itemtype` varchar(255) NOT NULL DEFAULT '',
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `fields` text DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 0,
  `action_refuse` tinyint(4) NOT NULL DEFAULT 0,
  `action_notify` tinyint(4) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `is_active` (`is_active`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='Stores field unicity criterias';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_filesystems`
--

DROP TABLE IF EXISTS `glpi_filesystems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_filesystems` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_fqdns`
--

DROP TABLE IF EXISTS `glpi_fqdns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_fqdns` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `fqdn` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entities_id` (`entities_id`),
  KEY `name` (`name`),
  KEY `fqdn` (`fqdn`),
  KEY `is_recursive` (`is_recursive`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_groups`
--

DROP TABLE IF EXISTS `glpi_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `ldap_field` varchar(255) DEFAULT NULL,
  `ldap_value` text DEFAULT NULL,
  `ldap_group_dn` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `completename` text DEFAULT NULL,
  `level` int(11) NOT NULL DEFAULT 0,
  `ancestors_cache` longtext DEFAULT NULL,
  `sons_cache` longtext DEFAULT NULL,
  `is_requester` tinyint(4) NOT NULL DEFAULT 1,
  `is_watcher` tinyint(4) NOT NULL DEFAULT 1,
  `is_assign` tinyint(4) NOT NULL DEFAULT 1,
  `is_task` tinyint(4) NOT NULL DEFAULT 1,
  `is_notify` tinyint(4) NOT NULL DEFAULT 1,
  `is_itemgroup` tinyint(4) NOT NULL DEFAULT 1,
  `is_usergroup` tinyint(4) NOT NULL DEFAULT 1,
  `is_manager` tinyint(4) NOT NULL DEFAULT 1,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `ldap_field` (`ldap_field`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `date_mod` (`date_mod`),
  KEY `ldap_value` (`ldap_value`(200)),
  KEY `ldap_group_dn` (`ldap_group_dn`(200)),
  KEY `groups_id` (`groups_id`),
  KEY `is_requester` (`is_requester`),
  KEY `is_watcher` (`is_watcher`),
  KEY `is_assign` (`is_assign`),
  KEY `is_notify` (`is_notify`),
  KEY `is_itemgroup` (`is_itemgroup`),
  KEY `is_usergroup` (`is_usergroup`),
  KEY `is_manager` (`is_manager`),
  KEY `date_creation` (`date_creation`),
  KEY `level` (`level`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_groups_knowbaseitems`
--

DROP TABLE IF EXISTS `glpi_groups_knowbaseitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_groups_knowbaseitems` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `knowbaseitems_id` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned DEFAULT NULL,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `no_entity_restriction` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `knowbaseitems_id` (`knowbaseitems_id`),
  KEY `groups_id` (`groups_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_groups_problems`
--

DROP TABLE IF EXISTS `glpi_groups_problems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_groups_problems` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `problems_id` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `type` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`problems_id`,`type`,`groups_id`),
  KEY `group` (`groups_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_groups_reminders`
--

DROP TABLE IF EXISTS `glpi_groups_reminders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_groups_reminders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reminders_id` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned DEFAULT NULL,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `no_entity_restriction` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `reminders_id` (`reminders_id`),
  KEY `groups_id` (`groups_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_groups_rssfeeds`
--

DROP TABLE IF EXISTS `glpi_groups_rssfeeds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_groups_rssfeeds` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rssfeeds_id` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned DEFAULT NULL,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `no_entity_restriction` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `rssfeeds_id` (`rssfeeds_id`),
  KEY `groups_id` (`groups_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_groups_tickets`
--

DROP TABLE IF EXISTS `glpi_groups_tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_groups_tickets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tickets_id` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `type` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`tickets_id`,`type`,`groups_id`),
  KEY `group` (`groups_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_groups_users`
--

DROP TABLE IF EXISTS `glpi_groups_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_groups_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  `is_manager` tinyint(4) NOT NULL DEFAULT 0,
  `is_userdelegate` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`users_id`,`groups_id`),
  KEY `groups_id` (`groups_id`),
  KEY `is_dynamic` (`is_dynamic`),
  KEY `is_manager` (`is_manager`),
  KEY `is_userdelegate` (`is_userdelegate`)
) ENGINE=InnoDB AUTO_INCREMENT=309 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_holidays`
--

DROP TABLE IF EXISTS `glpi_holidays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_holidays` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `begin_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `is_perpetual` tinyint(4) NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `begin_date` (`begin_date`),
  KEY `end_date` (`end_date`),
  KEY `is_perpetual` (`is_perpetual`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_imageformats`
--

DROP TABLE IF EXISTS `glpi_imageformats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_imageformats` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_imageresolutions`
--

DROP TABLE IF EXISTS `glpi_imageresolutions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_imageresolutions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `is_video` tinyint(4) NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `is_video` (`is_video`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_impactcompounds`
--

DROP TABLE IF EXISTS `glpi_impactcompounds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_impactcompounds` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT '',
  `color` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_impactcontexts`
--

DROP TABLE IF EXISTS `glpi_impactcontexts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_impactcontexts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `positions` mediumtext NOT NULL,
  `zoom` float NOT NULL DEFAULT 0,
  `pan_x` float NOT NULL DEFAULT 0,
  `pan_y` float NOT NULL DEFAULT 0,
  `impact_color` varchar(255) NOT NULL DEFAULT '',
  `depends_color` varchar(255) NOT NULL DEFAULT '',
  `impact_and_depends_color` varchar(255) NOT NULL DEFAULT '',
  `show_depends` tinyint(4) NOT NULL DEFAULT 1,
  `show_impact` tinyint(4) NOT NULL DEFAULT 1,
  `max_depth` int(11) NOT NULL DEFAULT 5,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_impactitems`
--

DROP TABLE IF EXISTS `glpi_impactitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_impactitems` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `itemtype` varchar(255) NOT NULL DEFAULT '',
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `parent_id` int(10) unsigned NOT NULL DEFAULT 0,
  `impactcontexts_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_slave` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`itemtype`,`items_id`),
  KEY `source` (`itemtype`,`items_id`),
  KEY `parent_id` (`parent_id`),
  KEY `impactcontexts_id` (`impactcontexts_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_impactrelations`
--

DROP TABLE IF EXISTS `glpi_impactrelations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_impactrelations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `itemtype_source` varchar(255) NOT NULL DEFAULT '',
  `items_id_source` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype_impacted` varchar(255) NOT NULL DEFAULT '',
  `items_id_impacted` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`itemtype_source`,`items_id_source`,`itemtype_impacted`,`items_id_impacted`),
  KEY `impacted_asset` (`itemtype_impacted`,`items_id_impacted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_infocoms`
--

DROP TABLE IF EXISTS `glpi_infocoms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_infocoms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) NOT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `buy_date` date DEFAULT NULL,
  `use_date` date DEFAULT NULL,
  `warranty_duration` int(11) NOT NULL DEFAULT 0,
  `warranty_info` varchar(255) DEFAULT NULL,
  `suppliers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `order_number` varchar(255) DEFAULT NULL,
  `delivery_number` varchar(255) DEFAULT NULL,
  `immo_number` varchar(255) DEFAULT NULL,
  `value` decimal(20,4) NOT NULL DEFAULT 0.0000,
  `warranty_value` decimal(20,4) NOT NULL DEFAULT 0.0000,
  `sink_time` int(11) NOT NULL DEFAULT 0,
  `sink_type` int(11) NOT NULL DEFAULT 0,
  `sink_coeff` float NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `bill` varchar(255) DEFAULT NULL,
  `budgets_id` int(10) unsigned NOT NULL DEFAULT 0,
  `alert` int(11) NOT NULL DEFAULT 0,
  `order_date` date DEFAULT NULL,
  `delivery_date` date DEFAULT NULL,
  `inventory_date` date DEFAULT NULL,
  `warranty_date` date DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `decommission_date` timestamp NULL DEFAULT NULL,
  `businesscriticities_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`itemtype`,`items_id`),
  KEY `buy_date` (`buy_date`),
  KEY `alert` (`alert`),
  KEY `budgets_id` (`budgets_id`),
  KEY `suppliers_id` (`suppliers_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `businesscriticities_id` (`businesscriticities_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_interfacetypes`
--

DROP TABLE IF EXISTS `glpi_interfacetypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_interfacetypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=336 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_ipaddresses`
--

DROP TABLE IF EXISTS `glpi_ipaddresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_ipaddresses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) NOT NULL,
  `version` tinyint(3) unsigned DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `binary_0` int(10) unsigned NOT NULL DEFAULT 0,
  `binary_1` int(10) unsigned NOT NULL DEFAULT 0,
  `binary_2` int(10) unsigned NOT NULL DEFAULT 0,
  `binary_3` int(10) unsigned NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  `mainitems_id` int(10) unsigned NOT NULL DEFAULT 0,
  `mainitemtype` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `binary` (`binary_0`,`binary_1`,`binary_2`,`binary_3`),
  KEY `is_deleted` (`is_deleted`),
  KEY `is_dynamic` (`is_dynamic`),
  KEY `item` (`itemtype`,`items_id`,`is_deleted`),
  KEY `mainitem` (`mainitemtype`,`mainitems_id`,`is_deleted`)
) ENGINE=InnoDB AUTO_INCREMENT=4449 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_ipaddresses_ipnetworks`
--

DROP TABLE IF EXISTS `glpi_ipaddresses_ipnetworks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_ipaddresses_ipnetworks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ipaddresses_id` int(10) unsigned NOT NULL DEFAULT 0,
  `ipnetworks_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`ipaddresses_id`,`ipnetworks_id`),
  KEY `ipnetworks_id` (`ipnetworks_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2383 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_ipnetworks`
--

DROP TABLE IF EXISTS `glpi_ipnetworks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_ipnetworks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `ipnetworks_id` int(10) unsigned NOT NULL DEFAULT 0,
  `completename` text DEFAULT NULL,
  `level` int(11) NOT NULL DEFAULT 0,
  `ancestors_cache` longtext DEFAULT NULL,
  `sons_cache` longtext DEFAULT NULL,
  `addressable` tinyint(4) NOT NULL DEFAULT 0,
  `version` tinyint(3) unsigned DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `address` varchar(40) DEFAULT NULL,
  `address_0` int(10) unsigned NOT NULL DEFAULT 0,
  `address_1` int(10) unsigned NOT NULL DEFAULT 0,
  `address_2` int(10) unsigned NOT NULL DEFAULT 0,
  `address_3` int(10) unsigned NOT NULL DEFAULT 0,
  `netmask` varchar(40) DEFAULT NULL,
  `netmask_0` int(10) unsigned NOT NULL DEFAULT 0,
  `netmask_1` int(10) unsigned NOT NULL DEFAULT 0,
  `netmask_2` int(10) unsigned NOT NULL DEFAULT 0,
  `netmask_3` int(10) unsigned NOT NULL DEFAULT 0,
  `gateway` varchar(40) DEFAULT NULL,
  `gateway_0` int(10) unsigned NOT NULL DEFAULT 0,
  `gateway_1` int(10) unsigned NOT NULL DEFAULT 0,
  `gateway_2` int(10) unsigned NOT NULL DEFAULT 0,
  `gateway_3` int(10) unsigned NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `network_definition` (`entities_id`,`address`,`netmask`),
  KEY `address` (`address_0`,`address_1`,`address_2`,`address_3`),
  KEY `netmask` (`netmask_0`,`netmask_1`,`netmask_2`,`netmask_3`),
  KEY `gateway` (`gateway_0`,`gateway_1`,`gateway_2`,`gateway_3`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `ipnetworks_id` (`ipnetworks_id`),
  KEY `level` (`level`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_ipnetworks_vlans`
--

DROP TABLE IF EXISTS `glpi_ipnetworks_vlans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_ipnetworks_vlans` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ipnetworks_id` int(10) unsigned NOT NULL DEFAULT 0,
  `vlans_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `link` (`ipnetworks_id`,`vlans_id`),
  KEY `vlans_id` (`vlans_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_items_clusters`
--

DROP TABLE IF EXISTS `glpi_items_clusters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_items_clusters` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `clusters_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) DEFAULT NULL,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`clusters_id`,`itemtype`,`items_id`),
  KEY `item` (`itemtype`,`items_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_items_devicebatteries`
--

DROP TABLE IF EXISTS `glpi_items_devicebatteries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_items_devicebatteries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(255) DEFAULT NULL,
  `devicebatteries_id` int(10) unsigned NOT NULL DEFAULT 0,
  `manufacturing_date` date DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `serial` varchar(255) DEFAULT NULL,
  `otherserial` varchar(255) DEFAULT NULL,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0,
  `real_capacity` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `devicebatteries_id` (`devicebatteries_id`),
  KEY `is_deleted` (`is_deleted`),
  KEY `is_dynamic` (`is_dynamic`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `serial` (`serial`),
  KEY `item` (`itemtype`,`items_id`),
  KEY `otherserial` (`otherserial`),
  KEY `locations_id` (`locations_id`),
  KEY `states_id` (`states_id`)
) ENGINE=InnoDB AUTO_INCREMENT=154 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_items_devicecameras`
--

DROP TABLE IF EXISTS `glpi_items_devicecameras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_items_devicecameras` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(255) DEFAULT NULL,
  `devicecameras_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `items_id` (`items_id`),
  KEY `devicecameras_id` (`devicecameras_id`),
  KEY `is_deleted` (`is_deleted`),
  KEY `is_dynamic` (`is_dynamic`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `locations_id` (`locations_id`),
  KEY `item` (`itemtype`,`items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_items_devicecameras_imageformats`
--

DROP TABLE IF EXISTS `glpi_items_devicecameras_imageformats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_items_devicecameras_imageformats` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `items_devicecameras_id` int(10) unsigned NOT NULL DEFAULT 0,
  `imageformats_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `items_devicecameras_id` (`items_devicecameras_id`),
  KEY `imageformats_id` (`imageformats_id`),
  KEY `is_dynamic` (`is_dynamic`),
  KEY `is_deleted` (`is_deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_items_devicecameras_imageresolutions`
--

DROP TABLE IF EXISTS `glpi_items_devicecameras_imageresolutions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_items_devicecameras_imageresolutions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `items_devicecameras_id` int(10) unsigned NOT NULL DEFAULT 0,
  `imageresolutions_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `items_devicecameras_id` (`items_devicecameras_id`),
  KEY `imageresolutions_id` (`imageresolutions_id`),
  KEY `is_dynamic` (`is_dynamic`),
  KEY `is_deleted` (`is_deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_items_devicecases`
--

DROP TABLE IF EXISTS `glpi_items_devicecases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_items_devicecases` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(255) DEFAULT NULL,
  `devicecases_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `serial` varchar(255) DEFAULT NULL,
  `otherserial` varchar(255) DEFAULT NULL,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `devicecases_id` (`devicecases_id`),
  KEY `is_deleted` (`is_deleted`),
  KEY `is_dynamic` (`is_dynamic`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `serial` (`serial`),
  KEY `item` (`itemtype`,`items_id`),
  KEY `otherserial` (`otherserial`),
  KEY `locations_id` (`locations_id`),
  KEY `states_id` (`states_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_items_devicecontrols`
--

DROP TABLE IF EXISTS `glpi_items_devicecontrols`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_items_devicecontrols` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(255) DEFAULT NULL,
  `devicecontrols_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `serial` varchar(255) DEFAULT NULL,
  `busID` varchar(255) DEFAULT NULL,
  `otherserial` varchar(255) DEFAULT NULL,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `devicecontrols_id` (`devicecontrols_id`),
  KEY `is_deleted` (`is_deleted`),
  KEY `is_dynamic` (`is_dynamic`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `serial` (`serial`),
  KEY `busID` (`busID`),
  KEY `item` (`itemtype`,`items_id`),
  KEY `otherserial` (`otherserial`),
  KEY `locations_id` (`locations_id`),
  KEY `states_id` (`states_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_items_devicedrives`
--

DROP TABLE IF EXISTS `glpi_items_devicedrives`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_items_devicedrives` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(255) DEFAULT NULL,
  `devicedrives_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `serial` varchar(255) DEFAULT NULL,
  `busID` varchar(255) DEFAULT NULL,
  `otherserial` varchar(255) DEFAULT NULL,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `devicedrives_id` (`devicedrives_id`),
  KEY `is_deleted` (`is_deleted`),
  KEY `is_dynamic` (`is_dynamic`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `serial` (`serial`),
  KEY `busID` (`busID`),
  KEY `item` (`itemtype`,`items_id`),
  KEY `otherserial` (`otherserial`),
  KEY `locations_id` (`locations_id`),
  KEY `states_id` (`states_id`)
) ENGINE=InnoDB AUTO_INCREMENT=155 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_items_devicefirmwares`
--

DROP TABLE IF EXISTS `glpi_items_devicefirmwares`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_items_devicefirmwares` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(255) DEFAULT NULL,
  `devicefirmwares_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `serial` varchar(255) DEFAULT NULL,
  `otherserial` varchar(255) DEFAULT NULL,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `devicefirmwares_id` (`devicefirmwares_id`),
  KEY `is_deleted` (`is_deleted`),
  KEY `is_dynamic` (`is_dynamic`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `serial` (`serial`),
  KEY `item` (`itemtype`,`items_id`),
  KEY `otherserial` (`otherserial`),
  KEY `locations_id` (`locations_id`),
  KEY `states_id` (`states_id`)
) ENGINE=InnoDB AUTO_INCREMENT=506 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_items_devicegenerics`
--

DROP TABLE IF EXISTS `glpi_items_devicegenerics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_items_devicegenerics` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(255) DEFAULT NULL,
  `devicegenerics_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `serial` varchar(255) DEFAULT NULL,
  `otherserial` varchar(255) DEFAULT NULL,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `devicegenerics_id` (`devicegenerics_id`),
  KEY `is_deleted` (`is_deleted`),
  KEY `is_dynamic` (`is_dynamic`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `serial` (`serial`),
  KEY `item` (`itemtype`,`items_id`),
  KEY `otherserial` (`otherserial`),
  KEY `locations_id` (`locations_id`),
  KEY `states_id` (`states_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_items_devicegraphiccards`
--

DROP TABLE IF EXISTS `glpi_items_devicegraphiccards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_items_devicegraphiccards` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(255) DEFAULT NULL,
  `devicegraphiccards_id` int(10) unsigned NOT NULL DEFAULT 0,
  `memory` int(11) NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `serial` varchar(255) DEFAULT NULL,
  `busID` varchar(255) DEFAULT NULL,
  `otherserial` varchar(255) DEFAULT NULL,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `devicegraphiccards_id` (`devicegraphiccards_id`),
  KEY `specificity` (`memory`),
  KEY `is_deleted` (`is_deleted`),
  KEY `is_dynamic` (`is_dynamic`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `serial` (`serial`),
  KEY `busID` (`busID`),
  KEY `item` (`itemtype`,`items_id`),
  KEY `otherserial` (`otherserial`),
  KEY `locations_id` (`locations_id`),
  KEY `states_id` (`states_id`)
) ENGINE=InnoDB AUTO_INCREMENT=212 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_items_deviceharddrives`
--

DROP TABLE IF EXISTS `glpi_items_deviceharddrives`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_items_deviceharddrives` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(255) DEFAULT NULL,
  `deviceharddrives_id` int(10) unsigned NOT NULL DEFAULT 0,
  `capacity` int(11) NOT NULL DEFAULT 0,
  `serial` varchar(255) DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `busID` varchar(255) DEFAULT NULL,
  `otherserial` varchar(255) DEFAULT NULL,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `deviceharddrives_id` (`deviceharddrives_id`),
  KEY `specificity` (`capacity`),
  KEY `is_deleted` (`is_deleted`),
  KEY `is_dynamic` (`is_dynamic`),
  KEY `serial` (`serial`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `busID` (`busID`),
  KEY `item` (`itemtype`,`items_id`),
  KEY `otherserial` (`otherserial`),
  KEY `locations_id` (`locations_id`),
  KEY `states_id` (`states_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5025 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_items_devicememories`
--

DROP TABLE IF EXISTS `glpi_items_devicememories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_items_devicememories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(255) DEFAULT NULL,
  `devicememories_id` int(10) unsigned NOT NULL DEFAULT 0,
  `size` int(11) NOT NULL DEFAULT 0,
  `serial` varchar(255) DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `busID` varchar(255) DEFAULT NULL,
  `otherserial` varchar(255) DEFAULT NULL,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `devicememories_id` (`devicememories_id`),
  KEY `specificity` (`size`),
  KEY `is_deleted` (`is_deleted`),
  KEY `is_dynamic` (`is_dynamic`),
  KEY `serial` (`serial`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `busID` (`busID`),
  KEY `item` (`itemtype`,`items_id`),
  KEY `otherserial` (`otherserial`),
  KEY `locations_id` (`locations_id`),
  KEY `states_id` (`states_id`)
) ENGINE=InnoDB AUTO_INCREMENT=621 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_items_devicemotherboards`
--

DROP TABLE IF EXISTS `glpi_items_devicemotherboards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_items_devicemotherboards` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(255) DEFAULT NULL,
  `devicemotherboards_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `serial` varchar(255) DEFAULT NULL,
  `otherserial` varchar(255) DEFAULT NULL,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `devicemotherboards_id` (`devicemotherboards_id`),
  KEY `is_deleted` (`is_deleted`),
  KEY `is_dynamic` (`is_dynamic`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `serial` (`serial`),
  KEY `item` (`itemtype`,`items_id`),
  KEY `otherserial` (`otherserial`),
  KEY `locations_id` (`locations_id`),
  KEY `states_id` (`states_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_items_devicenetworkcards`
--

DROP TABLE IF EXISTS `glpi_items_devicenetworkcards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_items_devicenetworkcards` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(255) DEFAULT NULL,
  `devicenetworkcards_id` int(10) unsigned NOT NULL DEFAULT 0,
  `mac` varchar(255) DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `serial` varchar(255) DEFAULT NULL,
  `busID` varchar(255) DEFAULT NULL,
  `otherserial` varchar(255) DEFAULT NULL,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `devicenetworkcards_id` (`devicenetworkcards_id`),
  KEY `specificity` (`mac`),
  KEY `is_deleted` (`is_deleted`),
  KEY `is_dynamic` (`is_dynamic`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `serial` (`serial`),
  KEY `busID` (`busID`),
  KEY `item` (`itemtype`,`items_id`),
  KEY `otherserial` (`otherserial`),
  KEY `locations_id` (`locations_id`),
  KEY `states_id` (`states_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23194 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_items_devicepcis`
--

DROP TABLE IF EXISTS `glpi_items_devicepcis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_items_devicepcis` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(255) DEFAULT NULL,
  `devicepcis_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `serial` varchar(255) DEFAULT NULL,
  `busID` varchar(255) DEFAULT NULL,
  `otherserial` varchar(255) DEFAULT NULL,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `devicepcis_id` (`devicepcis_id`),
  KEY `is_deleted` (`is_deleted`),
  KEY `is_dynamic` (`is_dynamic`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `serial` (`serial`),
  KEY `busID` (`busID`),
  KEY `item` (`itemtype`,`items_id`),
  KEY `otherserial` (`otherserial`),
  KEY `locations_id` (`locations_id`),
  KEY `states_id` (`states_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_items_devicepowersupplies`
--

DROP TABLE IF EXISTS `glpi_items_devicepowersupplies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_items_devicepowersupplies` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(255) DEFAULT NULL,
  `devicepowersupplies_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `serial` varchar(255) DEFAULT NULL,
  `otherserial` varchar(255) DEFAULT NULL,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `devicepowersupplies_id` (`devicepowersupplies_id`),
  KEY `is_deleted` (`is_deleted`),
  KEY `is_dynamic` (`is_dynamic`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `serial` (`serial`),
  KEY `item` (`itemtype`,`items_id`),
  KEY `otherserial` (`otherserial`),
  KEY `locations_id` (`locations_id`),
  KEY `states_id` (`states_id`)
) ENGINE=InnoDB AUTO_INCREMENT=99052 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_items_deviceprocessors`
--

DROP TABLE IF EXISTS `glpi_items_deviceprocessors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_items_deviceprocessors` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(255) DEFAULT NULL,
  `deviceprocessors_id` int(10) unsigned NOT NULL DEFAULT 0,
  `frequency` int(11) NOT NULL DEFAULT 0,
  `serial` varchar(255) DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  `nbcores` int(11) DEFAULT NULL,
  `nbthreads` int(11) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `busID` varchar(255) DEFAULT NULL,
  `otherserial` varchar(255) DEFAULT NULL,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `deviceprocessors_id` (`deviceprocessors_id`),
  KEY `specificity` (`frequency`),
  KEY `is_deleted` (`is_deleted`),
  KEY `is_dynamic` (`is_dynamic`),
  KEY `serial` (`serial`),
  KEY `nbcores` (`nbcores`),
  KEY `nbthreads` (`nbthreads`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `busID` (`busID`),
  KEY `item` (`itemtype`,`items_id`),
  KEY `otherserial` (`otherserial`),
  KEY `locations_id` (`locations_id`),
  KEY `states_id` (`states_id`)
) ENGINE=InnoDB AUTO_INCREMENT=259 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_items_devicesensors`
--

DROP TABLE IF EXISTS `glpi_items_devicesensors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_items_devicesensors` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(255) DEFAULT NULL,
  `devicesensors_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `serial` varchar(255) DEFAULT NULL,
  `otherserial` varchar(255) DEFAULT NULL,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `devicesensors_id` (`devicesensors_id`),
  KEY `is_deleted` (`is_deleted`),
  KEY `is_dynamic` (`is_dynamic`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `serial` (`serial`),
  KEY `item` (`itemtype`,`items_id`),
  KEY `otherserial` (`otherserial`),
  KEY `locations_id` (`locations_id`),
  KEY `states_id` (`states_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_items_devicesimcards`
--

DROP TABLE IF EXISTS `glpi_items_devicesimcards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_items_devicesimcards` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to various table, according to itemtype (id)',
  `itemtype` varchar(100) NOT NULL,
  `devicesimcards_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `serial` varchar(255) DEFAULT NULL,
  `otherserial` varchar(255) DEFAULT NULL,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `lines_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `pin` varchar(255) NOT NULL DEFAULT '',
  `pin2` varchar(255) NOT NULL DEFAULT '',
  `puk` varchar(255) NOT NULL DEFAULT '',
  `puk2` varchar(255) NOT NULL DEFAULT '',
  `msin` varchar(255) NOT NULL DEFAULT '',
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `item` (`itemtype`,`items_id`),
  KEY `devicesimcards_id` (`devicesimcards_id`),
  KEY `is_deleted` (`is_deleted`),
  KEY `is_dynamic` (`is_dynamic`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `serial` (`serial`),
  KEY `otherserial` (`otherserial`),
  KEY `states_id` (`states_id`),
  KEY `locations_id` (`locations_id`),
  KEY `lines_id` (`lines_id`),
  KEY `users_id` (`users_id`),
  KEY `groups_id` (`groups_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_items_devicesoundcards`
--

DROP TABLE IF EXISTS `glpi_items_devicesoundcards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_items_devicesoundcards` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(255) DEFAULT NULL,
  `devicesoundcards_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `serial` varchar(255) DEFAULT NULL,
  `busID` varchar(255) DEFAULT NULL,
  `otherserial` varchar(255) DEFAULT NULL,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `devicesoundcards_id` (`devicesoundcards_id`),
  KEY `is_deleted` (`is_deleted`),
  KEY `is_dynamic` (`is_dynamic`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `serial` (`serial`),
  KEY `busID` (`busID`),
  KEY `item` (`itemtype`,`items_id`),
  KEY `otherserial` (`otherserial`),
  KEY `locations_id` (`locations_id`),
  KEY `states_id` (`states_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1102 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_items_disks`
--

DROP TABLE IF EXISTS `glpi_items_disks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_items_disks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(255) DEFAULT NULL,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `device` varchar(255) DEFAULT NULL,
  `mountpoint` varchar(255) DEFAULT NULL,
  `filesystems_id` int(10) unsigned NOT NULL DEFAULT 0,
  `totalsize` bigint(20) NOT NULL DEFAULT 0,
  `freesize` bigint(20) NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  `encryption_status` int(11) NOT NULL DEFAULT 0,
  `encryption_tool` varchar(255) DEFAULT NULL,
  `encryption_algorithm` varchar(255) DEFAULT NULL,
  `encryption_type` varchar(255) DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `device` (`device`),
  KEY `mountpoint` (`mountpoint`),
  KEY `totalsize` (`totalsize`),
  KEY `freesize` (`freesize`),
  KEY `item` (`itemtype`,`items_id`),
  KEY `filesystems_id` (`filesystems_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_deleted` (`is_deleted`),
  KEY `is_dynamic` (`is_dynamic`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=8717 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_items_enclosures`
--

DROP TABLE IF EXISTS `glpi_items_enclosures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_items_enclosures` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `enclosures_id` int(10) unsigned NOT NULL,
  `itemtype` varchar(255) NOT NULL,
  `items_id` int(10) unsigned NOT NULL,
  `position` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `item` (`itemtype`,`items_id`),
  KEY `relation` (`enclosures_id`,`itemtype`,`items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_items_kanbans`
--

DROP TABLE IF EXISTS `glpi_items_kanbans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_items_kanbans` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `itemtype` varchar(100) NOT NULL,
  `items_id` int(10) unsigned DEFAULT NULL,
  `users_id` int(10) unsigned NOT NULL,
  `state` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`itemtype`,`items_id`,`users_id`),
  KEY `users_id` (`users_id`),
  KEY `date_creation` (`date_creation`),
  KEY `date_mod` (`date_mod`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_items_operatingsystems`
--

DROP TABLE IF EXISTS `glpi_items_operatingsystems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_items_operatingsystems` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(255) DEFAULT NULL,
  `operatingsystems_id` int(10) unsigned NOT NULL DEFAULT 0,
  `operatingsystemversions_id` int(10) unsigned NOT NULL DEFAULT 0,
  `operatingsystemservicepacks_id` int(10) unsigned NOT NULL DEFAULT 0,
  `operatingsystemarchitectures_id` int(10) unsigned NOT NULL DEFAULT 0,
  `operatingsystemkernelversions_id` int(10) unsigned NOT NULL DEFAULT 0,
  `license_number` varchar(255) DEFAULT NULL,
  `licenseid` varchar(255) DEFAULT NULL,
  `company` varchar(255) DEFAULT NULL,
  `owner` varchar(255) DEFAULT NULL,
  `hostid` varchar(255) DEFAULT NULL,
  `operatingsystemeditions_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `install_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`items_id`,`itemtype`,`operatingsystems_id`,`operatingsystemarchitectures_id`),
  KEY `item` (`itemtype`,`items_id`),
  KEY `operatingsystems_id` (`operatingsystems_id`),
  KEY `operatingsystemservicepacks_id` (`operatingsystemservicepacks_id`),
  KEY `operatingsystemversions_id` (`operatingsystemversions_id`),
  KEY `operatingsystemarchitectures_id` (`operatingsystemarchitectures_id`),
  KEY `operatingsystemkernelversions_id` (`operatingsystemkernelversions_id`),
  KEY `operatingsystemeditions_id` (`operatingsystemeditions_id`),
  KEY `is_deleted` (`is_deleted`),
  KEY `is_dynamic` (`is_dynamic`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `date_creation` (`date_creation`),
  KEY `date_mod` (`date_mod`)
) ENGINE=InnoDB AUTO_INCREMENT=211 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_items_problems`
--

DROP TABLE IF EXISTS `glpi_items_problems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_items_problems` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `problems_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) DEFAULT NULL,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`problems_id`,`itemtype`,`items_id`),
  KEY `item` (`itemtype`,`items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_items_projects`
--

DROP TABLE IF EXISTS `glpi_items_projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_items_projects` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `projects_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) DEFAULT NULL,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`projects_id`,`itemtype`,`items_id`),
  KEY `item` (`itemtype`,`items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_items_racks`
--

DROP TABLE IF EXISTS `glpi_items_racks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_items_racks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `racks_id` int(10) unsigned NOT NULL,
  `itemtype` varchar(255) NOT NULL,
  `items_id` int(10) unsigned NOT NULL,
  `position` int(11) NOT NULL,
  `orientation` tinyint(4) DEFAULT NULL,
  `bgcolor` varchar(7) DEFAULT NULL,
  `hpos` tinyint(4) NOT NULL DEFAULT 0,
  `is_reserved` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `item` (`itemtype`,`items_id`,`is_reserved`),
  KEY `relation` (`racks_id`,`itemtype`,`items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_items_remotemanagements`
--

DROP TABLE IF EXISTS `glpi_items_remotemanagements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_items_remotemanagements` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `itemtype` varchar(100) DEFAULT NULL,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `remoteid` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `is_dynamic` (`is_dynamic`),
  KEY `is_deleted` (`is_deleted`),
  KEY `item` (`itemtype`,`items_id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_items_softwarelicenses`
--

DROP TABLE IF EXISTS `glpi_items_softwarelicenses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_items_softwarelicenses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) NOT NULL,
  `softwarelicenses_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `item` (`itemtype`,`items_id`),
  KEY `softwarelicenses_id` (`softwarelicenses_id`),
  KEY `is_deleted` (`is_deleted`),
  KEY `is_dynamic` (`is_dynamic`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_items_softwareversions`
--

DROP TABLE IF EXISTS `glpi_items_softwareversions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_items_softwareversions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) NOT NULL,
  `softwareversions_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_deleted_item` tinyint(4) NOT NULL DEFAULT 0,
  `is_template_item` tinyint(4) NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  `date_install` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`itemtype`,`items_id`,`softwareversions_id`),
  KEY `softwareversions_id` (`softwareversions_id`),
  KEY `computers_info` (`entities_id`,`is_template_item`,`is_deleted_item`),
  KEY `is_deleted` (`is_deleted`),
  KEY `is_dynamic` (`is_dynamic`),
  KEY `is_deleted_item` (`is_deleted_item`),
  KEY `is_template_item` (`is_template_item`),
  KEY `date_install` (`date_install`)
) ENGINE=InnoDB AUTO_INCREMENT=604450 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_items_tickets`
--

DROP TABLE IF EXISTS `glpi_items_tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_items_tickets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `itemtype` varchar(255) DEFAULT NULL,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `tickets_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`itemtype`,`items_id`,`tickets_id`),
  KEY `tickets_id` (`tickets_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_itilcategories`
--

DROP TABLE IF EXISTS `glpi_itilcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_itilcategories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `itilcategories_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `completename` text DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `level` int(11) NOT NULL DEFAULT 0,
  `knowbaseitemcategories_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `code` varchar(255) DEFAULT NULL,
  `ancestors_cache` longtext DEFAULT NULL,
  `sons_cache` longtext DEFAULT NULL,
  `is_helpdeskvisible` tinyint(4) NOT NULL DEFAULT 1,
  `tickettemplates_id_incident` int(10) unsigned NOT NULL DEFAULT 0,
  `tickettemplates_id_demand` int(10) unsigned NOT NULL DEFAULT 0,
  `changetemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `problemtemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_incident` int(11) NOT NULL DEFAULT 1,
  `is_request` int(11) NOT NULL DEFAULT 1,
  `is_problem` int(11) NOT NULL DEFAULT 1,
  `is_change` tinyint(4) NOT NULL DEFAULT 1,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `knowbaseitemcategories_id` (`knowbaseitemcategories_id`),
  KEY `users_id` (`users_id`),
  KEY `groups_id` (`groups_id`),
  KEY `is_helpdeskvisible` (`is_helpdeskvisible`),
  KEY `itilcategories_id` (`itilcategories_id`),
  KEY `tickettemplates_id_incident` (`tickettemplates_id_incident`),
  KEY `tickettemplates_id_demand` (`tickettemplates_id_demand`),
  KEY `changetemplates_id` (`changetemplates_id`),
  KEY `problemtemplates_id` (`problemtemplates_id`),
  KEY `is_incident` (`is_incident`),
  KEY `is_request` (`is_request`),
  KEY `is_problem` (`is_problem`),
  KEY `is_change` (`is_change`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `level` (`level`)
) ENGINE=InnoDB AUTO_INCREMENT=246 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_itilfollowups`
--

DROP TABLE IF EXISTS `glpi_itilfollowups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_itilfollowups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `itemtype` varchar(100) NOT NULL,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date` timestamp NULL DEFAULT NULL,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_editor` int(10) unsigned NOT NULL DEFAULT 0,
  `content` longtext DEFAULT NULL,
  `is_private` tinyint(4) NOT NULL DEFAULT 0,
  `requesttypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `timeline_position` tinyint(4) NOT NULL DEFAULT 0,
  `sourceitems_id` int(10) unsigned NOT NULL DEFAULT 0,
  `sourceof_items_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `item` (`itemtype`,`items_id`),
  KEY `date` (`date`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `users_id` (`users_id`),
  KEY `users_id_editor` (`users_id_editor`),
  KEY `is_private` (`is_private`),
  KEY `requesttypes_id` (`requesttypes_id`),
  KEY `sourceitems_id` (`sourceitems_id`),
  KEY `sourceof_items_id` (`sourceof_items_id`)
) ENGINE=InnoDB AUTO_INCREMENT=541 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_itilfollowuptemplates`
--

DROP TABLE IF EXISTS `glpi_itilfollowuptemplates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_itilfollowuptemplates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_creation` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `content` mediumtext DEFAULT NULL,
  `requesttypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_private` tinyint(4) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `is_recursive` (`is_recursive`),
  KEY `requesttypes_id` (`requesttypes_id`),
  KEY `entities_id` (`entities_id`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `is_private` (`is_private`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_itils_projects`
--

DROP TABLE IF EXISTS `glpi_itils_projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_itils_projects` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `itemtype` varchar(100) NOT NULL DEFAULT '',
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `projects_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`itemtype`,`items_id`,`projects_id`),
  KEY `projects_id` (`projects_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_itilsolutions`
--

DROP TABLE IF EXISTS `glpi_itilsolutions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_itilsolutions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `itemtype` varchar(100) NOT NULL,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `solutiontypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `solutiontype_name` varchar(255) DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_approval` timestamp NULL DEFAULT NULL,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `user_name` varchar(255) DEFAULT NULL,
  `users_id_editor` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_approval` int(10) unsigned NOT NULL DEFAULT 0,
  `user_name_approval` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `itilfollowups_id` int(10) unsigned DEFAULT NULL COMMENT 'Followup reference on reject or approve a solution',
  PRIMARY KEY (`id`),
  KEY `item` (`itemtype`,`items_id`),
  KEY `solutiontypes_id` (`solutiontypes_id`),
  KEY `users_id` (`users_id`),
  KEY `users_id_editor` (`users_id_editor`),
  KEY `users_id_approval` (`users_id_approval`),
  KEY `status` (`status`),
  KEY `itilfollowups_id` (`itilfollowups_id`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_knowbaseitemcategories`
--

DROP TABLE IF EXISTS `glpi_knowbaseitemcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_knowbaseitemcategories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `knowbaseitemcategories_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `completename` text DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `level` int(11) NOT NULL DEFAULT 0,
  `sons_cache` longtext DEFAULT NULL,
  `ancestors_cache` longtext DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`entities_id`,`knowbaseitemcategories_id`,`name`),
  KEY `name` (`name`),
  KEY `is_recursive` (`is_recursive`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `knowbaseitemcategories_id` (`knowbaseitemcategories_id`),
  KEY `level` (`level`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_knowbaseitems`
--

DROP TABLE IF EXISTS `glpi_knowbaseitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_knowbaseitems` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` text DEFAULT NULL,
  `answer` longtext DEFAULT NULL,
  `is_faq` tinyint(4) NOT NULL DEFAULT 0,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `view` int(11) NOT NULL DEFAULT 0,
  `date_creation` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `begin_date` timestamp NULL DEFAULT NULL,
  `end_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `users_id` (`users_id`),
  KEY `is_faq` (`is_faq`),
  KEY `date_creation` (`date_creation`),
  KEY `date_mod` (`date_mod`),
  KEY `begin_date` (`begin_date`),
  KEY `end_date` (`end_date`),
  FULLTEXT KEY `fulltext` (`name`,`answer`),
  FULLTEXT KEY `name` (`name`),
  FULLTEXT KEY `answer` (`answer`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_knowbaseitems_comments`
--

DROP TABLE IF EXISTS `glpi_knowbaseitems_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_knowbaseitems_comments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `knowbaseitems_id` int(10) unsigned NOT NULL,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `language` varchar(10) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `parent_comment_id` int(10) unsigned DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `knowbaseitems_id` (`knowbaseitems_id`),
  KEY `parent_comment_id` (`parent_comment_id`),
  KEY `users_id` (`users_id`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_knowbaseitems_items`
--

DROP TABLE IF EXISTS `glpi_knowbaseitems_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_knowbaseitems_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `knowbaseitems_id` int(10) unsigned NOT NULL,
  `itemtype` varchar(100) NOT NULL,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_creation` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`itemtype`,`items_id`,`knowbaseitems_id`),
  KEY `knowbaseitems_id` (`knowbaseitems_id`),
  KEY `date_creation` (`date_creation`),
  KEY `date_mod` (`date_mod`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_knowbaseitems_knowbaseitemcategories`
--

DROP TABLE IF EXISTS `glpi_knowbaseitems_knowbaseitemcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_knowbaseitems_knowbaseitemcategories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `knowbaseitems_id` int(10) unsigned NOT NULL DEFAULT 0,
  `knowbaseitemcategories_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `knowbaseitems_id` (`knowbaseitems_id`),
  KEY `knowbaseitemcategories_id` (`knowbaseitemcategories_id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_knowbaseitems_profiles`
--

DROP TABLE IF EXISTS `glpi_knowbaseitems_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_knowbaseitems_profiles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `knowbaseitems_id` int(10) unsigned NOT NULL DEFAULT 0,
  `profiles_id` int(10) unsigned NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned DEFAULT NULL,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `no_entity_restriction` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `knowbaseitems_id` (`knowbaseitems_id`),
  KEY `profiles_id` (`profiles_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_knowbaseitems_revisions`
--

DROP TABLE IF EXISTS `glpi_knowbaseitems_revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_knowbaseitems_revisions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `knowbaseitems_id` int(10) unsigned NOT NULL,
  `revision` int(11) NOT NULL,
  `name` text DEFAULT NULL,
  `answer` longtext DEFAULT NULL,
  `language` varchar(10) DEFAULT NULL,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`knowbaseitems_id`,`revision`,`language`),
  KEY `revision` (`revision`),
  KEY `users_id` (`users_id`),
  KEY `date` (`date`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_knowbaseitems_users`
--

DROP TABLE IF EXISTS `glpi_knowbaseitems_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_knowbaseitems_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `knowbaseitems_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `knowbaseitems_id` (`knowbaseitems_id`),
  KEY `users_id` (`users_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_knowbaseitemtranslations`
--

DROP TABLE IF EXISTS `glpi_knowbaseitemtranslations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_knowbaseitemtranslations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `knowbaseitems_id` int(10) unsigned NOT NULL DEFAULT 0,
  `language` varchar(10) DEFAULT NULL,
  `name` text DEFAULT NULL,
  `answer` longtext DEFAULT NULL,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `item` (`knowbaseitems_id`,`language`),
  KEY `users_id` (`users_id`),
  KEY `date_creation` (`date_creation`),
  KEY `date_mod` (`date_mod`),
  FULLTEXT KEY `fulltext` (`name`,`answer`),
  FULLTEXT KEY `name` (`name`),
  FULLTEXT KEY `answer` (`answer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_lineoperators`
--

DROP TABLE IF EXISTS `glpi_lineoperators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_lineoperators` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `comment` text DEFAULT NULL,
  `mcc` int(11) DEFAULT NULL,
  `mnc` int(11) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`mcc`,`mnc`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_lines`
--

DROP TABLE IF EXISTS `glpi_lines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_lines` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `caller_num` varchar(255) NOT NULL DEFAULT '',
  `caller_name` varchar(255) NOT NULL DEFAULT '',
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `lineoperators_id` int(10) unsigned NOT NULL DEFAULT 0,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0,
  `linetypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_creation` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `is_deleted` (`is_deleted`),
  KEY `users_id` (`users_id`),
  KEY `lineoperators_id` (`lineoperators_id`),
  KEY `groups_id` (`groups_id`),
  KEY `linetypes_id` (`linetypes_id`),
  KEY `locations_id` (`locations_id`),
  KEY `states_id` (`states_id`),
  KEY `date_creation` (`date_creation`),
  KEY `date_mod` (`date_mod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_linetypes`
--

DROP TABLE IF EXISTS `glpi_linetypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_linetypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_links`
--

DROP TABLE IF EXISTS `glpi_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 1,
  `name` varchar(255) DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `data` text DEFAULT NULL,
  `open_window` tinyint(4) NOT NULL DEFAULT 1,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_links_itemtypes`
--

DROP TABLE IF EXISTS `glpi_links_itemtypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_links_itemtypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `links_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`itemtype`,`links_id`),
  KEY `links_id` (`links_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_locations`
--

DROP TABLE IF EXISTS `glpi_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_locations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `completename` text DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `level` int(11) NOT NULL DEFAULT 0,
  `ancestors_cache` longtext DEFAULT NULL,
  `sons_cache` longtext DEFAULT NULL,
  `address` text DEFAULT NULL,
  `postcode` varchar(255) DEFAULT NULL,
  `town` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `building` varchar(255) DEFAULT NULL,
  `room` varchar(255) DEFAULT NULL,
  `latitude` varchar(255) DEFAULT NULL,
  `longitude` varchar(255) DEFAULT NULL,
  `altitude` varchar(255) DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`entities_id`,`locations_id`,`name`),
  KEY `locations_id` (`locations_id`),
  KEY `name` (`name`),
  KEY `is_recursive` (`is_recursive`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `level` (`level`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_lockedfields`
--

DROP TABLE IF EXISTS `glpi_lockedfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_lockedfields` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `itemtype` varchar(100) DEFAULT NULL,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `field` varchar(50) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `is_global` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`itemtype`,`items_id`,`field`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `is_global` (`is_global`)
) ENGINE=InnoDB AUTO_INCREMENT=605 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_logs`
--

DROP TABLE IF EXISTS `glpi_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `itemtype` varchar(100) NOT NULL DEFAULT '',
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype_link` varchar(100) NOT NULL DEFAULT '',
  `linked_action` int(11) NOT NULL DEFAULT 0 COMMENT 'see define.php HISTORY_* constant',
  `user_name` varchar(255) DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `id_search_option` int(11) NOT NULL DEFAULT 0 COMMENT 'see search.constant.php for value',
  `old_value` varchar(255) DEFAULT NULL,
  `new_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `date_mod` (`date_mod`),
  KEY `itemtype_link` (`itemtype_link`),
  KEY `item` (`itemtype`,`items_id`),
  KEY `id_search_option` (`id_search_option`)
) ENGINE=InnoDB AUTO_INCREMENT=4123012 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_mailcollectors`
--

DROP TABLE IF EXISTS `glpi_mailcollectors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_mailcollectors` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `host` varchar(255) DEFAULT NULL,
  `login` varchar(255) DEFAULT NULL,
  `filesize_max` int(11) NOT NULL DEFAULT 2097152,
  `is_active` tinyint(4) NOT NULL DEFAULT 1,
  `date_mod` timestamp NULL DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `passwd` varchar(255) DEFAULT NULL,
  `accepted` varchar(255) DEFAULT NULL,
  `refused` varchar(255) DEFAULT NULL,
  `errors` int(11) NOT NULL DEFAULT 0,
  `use_mail_date` tinyint(4) NOT NULL DEFAULT 0,
  `date_creation` timestamp NULL DEFAULT NULL,
  `requester_field` int(11) NOT NULL DEFAULT 0,
  `add_cc_to_observer` tinyint(4) NOT NULL DEFAULT 0,
  `collect_only_unread` tinyint(4) NOT NULL DEFAULT 0,
  `last_collect_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `is_active` (`is_active`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `last_collect_date` (`last_collect_date`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_manuallinks`
--

DROP TABLE IF EXISTS `glpi_manuallinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_manuallinks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `url` varchar(8096) NOT NULL,
  `open_window` tinyint(4) NOT NULL DEFAULT 1,
  `icon` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(255) DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `item` (`itemtype`,`items_id`),
  KEY `items_id` (`items_id`),
  KEY `date_creation` (`date_creation`),
  KEY `date_mod` (`date_mod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_manufacturers`
--

DROP TABLE IF EXISTS `glpi_manufacturers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_manufacturers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=591 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_monitormodels`
--

DROP TABLE IF EXISTS `glpi_monitormodels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_monitormodels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `product_number` varchar(255) DEFAULT NULL,
  `weight` int(11) NOT NULL DEFAULT 0,
  `required_units` int(11) NOT NULL DEFAULT 1,
  `depth` float NOT NULL DEFAULT 1,
  `power_connections` int(11) NOT NULL DEFAULT 0,
  `power_consumption` int(11) NOT NULL DEFAULT 0,
  `is_half_rack` tinyint(4) NOT NULL DEFAULT 0,
  `picture_front` text DEFAULT NULL,
  `picture_rear` text DEFAULT NULL,
  `pictures` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `product_number` (`product_number`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_monitors`
--

DROP TABLE IF EXISTS `glpi_monitors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_monitors` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `contact` varchar(255) DEFAULT NULL,
  `contact_num` varchar(255) DEFAULT NULL,
  `users_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `serial` varchar(255) DEFAULT NULL,
  `otherserial` varchar(255) DEFAULT NULL,
  `size` decimal(5,2) NOT NULL DEFAULT 0.00,
  `have_micro` tinyint(4) NOT NULL DEFAULT 0,
  `have_speaker` tinyint(4) NOT NULL DEFAULT 0,
  `have_subd` tinyint(4) NOT NULL DEFAULT 0,
  `have_bnc` tinyint(4) NOT NULL DEFAULT 0,
  `have_dvi` tinyint(4) NOT NULL DEFAULT 0,
  `have_pivot` tinyint(4) NOT NULL DEFAULT 0,
  `have_hdmi` tinyint(4) NOT NULL DEFAULT 0,
  `have_displayport` tinyint(4) NOT NULL DEFAULT 0,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `monitortypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `monitormodels_id` int(10) unsigned NOT NULL DEFAULT 0,
  `manufacturers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_global` tinyint(4) NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_template` tinyint(4) NOT NULL DEFAULT 0,
  `template_name` varchar(255) DEFAULT NULL,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0,
  `ticket_tco` decimal(20,4) DEFAULT 0.0000,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  `autoupdatesystems_id` int(10) unsigned NOT NULL DEFAULT 0,
  `uuid` varchar(255) DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `is_template` (`is_template`),
  KEY `is_global` (`is_global`),
  KEY `entities_id` (`entities_id`),
  KEY `manufacturers_id` (`manufacturers_id`),
  KEY `groups_id` (`groups_id`),
  KEY `users_id` (`users_id`),
  KEY `locations_id` (`locations_id`),
  KEY `monitormodels_id` (`monitormodels_id`),
  KEY `states_id` (`states_id`),
  KEY `users_id_tech` (`users_id_tech`),
  KEY `monitortypes_id` (`monitortypes_id`),
  KEY `is_deleted` (`is_deleted`),
  KEY `groups_id_tech` (`groups_id_tech`),
  KEY `is_dynamic` (`is_dynamic`),
  KEY `autoupdatesystems_id` (`autoupdatesystems_id`),
  KEY `serial` (`serial`),
  KEY `otherserial` (`otherserial`),
  KEY `uuid` (`uuid`),
  KEY `date_creation` (`date_creation`),
  KEY `is_recursive` (`is_recursive`),
  KEY `date_mod` (`date_mod`)
) ENGINE=InnoDB AUTO_INCREMENT=190 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_monitortypes`
--

DROP TABLE IF EXISTS `glpi_monitortypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_monitortypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_networkaliases`
--

DROP TABLE IF EXISTS `glpi_networkaliases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_networkaliases` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `networknames_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `fqdns_id` int(10) unsigned NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entities_id` (`entities_id`),
  KEY `name` (`name`),
  KEY `networknames_id` (`networknames_id`),
  KEY `fqdns_id` (`fqdns_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_networkequipmentmodels`
--

DROP TABLE IF EXISTS `glpi_networkequipmentmodels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_networkequipmentmodels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `product_number` varchar(255) DEFAULT NULL,
  `weight` int(11) NOT NULL DEFAULT 0,
  `required_units` int(11) NOT NULL DEFAULT 1,
  `depth` float NOT NULL DEFAULT 1,
  `power_connections` int(11) NOT NULL DEFAULT 0,
  `power_consumption` int(11) NOT NULL DEFAULT 0,
  `is_half_rack` tinyint(4) NOT NULL DEFAULT 0,
  `picture_front` text DEFAULT NULL,
  `picture_rear` text DEFAULT NULL,
  `pictures` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `product_number` (`product_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_networkequipments`
--

DROP TABLE IF EXISTS `glpi_networkequipments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_networkequipments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `ram` int(10) unsigned DEFAULT NULL,
  `serial` varchar(255) DEFAULT NULL,
  `otherserial` varchar(255) DEFAULT NULL,
  `contact` varchar(255) DEFAULT NULL,
  `contact_num` varchar(255) DEFAULT NULL,
  `users_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `networks_id` int(10) unsigned NOT NULL DEFAULT 0,
  `networkequipmenttypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `networkequipmentmodels_id` int(10) unsigned NOT NULL DEFAULT 0,
  `manufacturers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_template` tinyint(4) NOT NULL DEFAULT 0,
  `template_name` varchar(255) DEFAULT NULL,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0,
  `ticket_tco` decimal(20,4) DEFAULT 0.0000,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  `uuid` varchar(255) DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `autoupdatesystems_id` int(10) unsigned NOT NULL DEFAULT 0,
  `sysdescr` text DEFAULT NULL,
  `cpu` int(11) NOT NULL DEFAULT 0,
  `uptime` varchar(255) NOT NULL DEFAULT '0',
  `last_inventory_update` timestamp NULL DEFAULT NULL,
  `snmpcredentials_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `is_template` (`is_template`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `manufacturers_id` (`manufacturers_id`),
  KEY `groups_id` (`groups_id`),
  KEY `users_id` (`users_id`),
  KEY `locations_id` (`locations_id`),
  KEY `networkequipmentmodels_id` (`networkequipmentmodels_id`),
  KEY `networks_id` (`networks_id`),
  KEY `states_id` (`states_id`),
  KEY `users_id_tech` (`users_id_tech`),
  KEY `networkequipmenttypes_id` (`networkequipmenttypes_id`),
  KEY `is_deleted` (`is_deleted`),
  KEY `date_mod` (`date_mod`),
  KEY `groups_id_tech` (`groups_id_tech`),
  KEY `is_dynamic` (`is_dynamic`),
  KEY `serial` (`serial`),
  KEY `otherserial` (`otherserial`),
  KEY `uuid` (`uuid`),
  KEY `date_creation` (`date_creation`),
  KEY `autoupdatesystems_id` (`autoupdatesystems_id`),
  KEY `snmpcredentials_id` (`snmpcredentials_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_networkequipmenttypes`
--

DROP TABLE IF EXISTS `glpi_networkequipmenttypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_networkequipmenttypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_networkinterfaces`
--

DROP TABLE IF EXISTS `glpi_networkinterfaces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_networkinterfaces` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_networknames`
--

DROP TABLE IF EXISTS `glpi_networknames`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_networknames` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `fqdns_id` int(10) unsigned NOT NULL DEFAULT 0,
  `ipnetworks_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entities_id` (`entities_id`),
  KEY `FQDN` (`name`,`fqdns_id`),
  KEY `fqdns_id` (`fqdns_id`),
  KEY `is_deleted` (`is_deleted`),
  KEY `is_dynamic` (`is_dynamic`),
  KEY `item` (`itemtype`,`items_id`,`is_deleted`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `ipnetworks_id` (`ipnetworks_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1748 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_networkportaggregates`
--

DROP TABLE IF EXISTS `glpi_networkportaggregates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_networkportaggregates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `networkports_id` int(10) unsigned NOT NULL DEFAULT 0,
  `networkports_id_list` text DEFAULT NULL COMMENT 'array of associated networkports_id',
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `networkports_id` (`networkports_id`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_networkportaliases`
--

DROP TABLE IF EXISTS `glpi_networkportaliases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_networkportaliases` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `networkports_id` int(10) unsigned NOT NULL DEFAULT 0,
  `networkports_id_alias` int(10) unsigned NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `networkports_id` (`networkports_id`),
  KEY `networkports_id_alias` (`networkports_id_alias`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_networkportconnectionlogs`
--

DROP TABLE IF EXISTS `glpi_networkportconnectionlogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_networkportconnectionlogs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date` timestamp NULL DEFAULT NULL,
  `connected` tinyint(4) NOT NULL DEFAULT 0,
  `networkports_id_source` int(10) unsigned NOT NULL DEFAULT 0,
  `networkports_id_destination` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `date` (`date`),
  KEY `networkports_id_source` (`networkports_id_source`),
  KEY `networkports_id_destination` (`networkports_id_destination`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_networkportdialups`
--

DROP TABLE IF EXISTS `glpi_networkportdialups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_networkportdialups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `networkports_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `networkports_id` (`networkports_id`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_networkportethernets`
--

DROP TABLE IF EXISTS `glpi_networkportethernets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_networkportethernets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `networkports_id` int(10) unsigned NOT NULL DEFAULT 0,
  `items_devicenetworkcards_id` int(10) unsigned NOT NULL DEFAULT 0,
  `type` varchar(10) DEFAULT '' COMMENT 'T, LX, SX',
  `speed` int(11) NOT NULL DEFAULT 10 COMMENT 'Mbit/s: 10, 100, 1000, 10000',
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `networkports_id` (`networkports_id`),
  KEY `card` (`items_devicenetworkcards_id`),
  KEY `type` (`type`),
  KEY `speed` (`speed`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=657 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_networkportfiberchannels`
--

DROP TABLE IF EXISTS `glpi_networkportfiberchannels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_networkportfiberchannels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `networkports_id` int(10) unsigned NOT NULL DEFAULT 0,
  `items_devicenetworkcards_id` int(10) unsigned NOT NULL DEFAULT 0,
  `networkportfiberchanneltypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `wwn` varchar(50) DEFAULT '',
  `speed` int(11) NOT NULL DEFAULT 10 COMMENT 'Mbit/s: 10, 100, 1000, 10000',
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `networkports_id` (`networkports_id`),
  KEY `card` (`items_devicenetworkcards_id`),
  KEY `type` (`networkportfiberchanneltypes_id`),
  KEY `wwn` (`wwn`),
  KEY `speed` (`speed`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_networkportfiberchanneltypes`
--

DROP TABLE IF EXISTS `glpi_networkportfiberchanneltypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_networkportfiberchanneltypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_networkportlocals`
--

DROP TABLE IF EXISTS `glpi_networkportlocals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_networkportlocals` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `networkports_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `networkports_id` (`networkports_id`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_networkportmetrics`
--

DROP TABLE IF EXISTS `glpi_networkportmetrics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_networkportmetrics` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `ifinbytes` bigint(20) NOT NULL DEFAULT 0,
  `ifinerrors` bigint(20) NOT NULL DEFAULT 0,
  `ifoutbytes` bigint(20) NOT NULL DEFAULT 0,
  `ifouterrors` bigint(20) NOT NULL DEFAULT 0,
  `networkports_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_creation` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`networkports_id`,`date`),
  KEY `date` (`date`),
  KEY `date_creation` (`date_creation`),
  KEY `date_mod` (`date_mod`)
) ENGINE=InnoDB AUTO_INCREMENT=4999 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_networkports`
--

DROP TABLE IF EXISTS `glpi_networkports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_networkports` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) NOT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `logical_number` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `instantiation_type` varchar(255) DEFAULT NULL,
  `mac` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `ifmtu` int(11) NOT NULL DEFAULT 0,
  `ifspeed` bigint(20) NOT NULL DEFAULT 0,
  `ifinternalstatus` varchar(255) DEFAULT NULL,
  `ifconnectionstatus` int(11) NOT NULL DEFAULT 0,
  `iflastchange` varchar(255) DEFAULT NULL,
  `ifinbytes` bigint(20) NOT NULL DEFAULT 0,
  `ifinerrors` bigint(20) NOT NULL DEFAULT 0,
  `ifoutbytes` bigint(20) NOT NULL DEFAULT 0,
  `ifouterrors` bigint(20) NOT NULL DEFAULT 0,
  `ifstatus` varchar(255) DEFAULT NULL,
  `ifdescr` varchar(255) DEFAULT NULL,
  `ifalias` varchar(255) DEFAULT NULL,
  `portduplex` varchar(255) DEFAULT NULL,
  `trunk` tinyint(4) NOT NULL DEFAULT 0,
  `lastup` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `item` (`itemtype`,`items_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `mac` (`mac`),
  KEY `is_deleted` (`is_deleted`),
  KEY `is_dynamic` (`is_dynamic`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=2745 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_networkports_networkports`
--

DROP TABLE IF EXISTS `glpi_networkports_networkports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_networkports_networkports` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `networkports_id_1` int(10) unsigned NOT NULL DEFAULT 0,
  `networkports_id_2` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`networkports_id_1`,`networkports_id_2`),
  KEY `networkports_id_2` (`networkports_id_2`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_networkports_vlans`
--

DROP TABLE IF EXISTS `glpi_networkports_vlans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_networkports_vlans` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `networkports_id` int(10) unsigned NOT NULL DEFAULT 0,
  `vlans_id` int(10) unsigned NOT NULL DEFAULT 0,
  `tagged` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`networkports_id`,`vlans_id`),
  KEY `vlans_id` (`vlans_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_networkporttypes`
--

DROP TABLE IF EXISTS `glpi_networkporttypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_networkporttypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `value_decimal` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `is_importable` tinyint(4) NOT NULL DEFAULT 0,
  `instantiation_type` varchar(255) DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `value_decimal` (`value_decimal`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `is_importable` (`is_importable`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=305 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_networkportwifis`
--

DROP TABLE IF EXISTS `glpi_networkportwifis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_networkportwifis` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `networkports_id` int(10) unsigned NOT NULL DEFAULT 0,
  `items_devicenetworkcards_id` int(10) unsigned NOT NULL DEFAULT 0,
  `wifinetworks_id` int(10) unsigned NOT NULL DEFAULT 0,
  `networkportwifis_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'only useful in case of Managed node',
  `version` varchar(20) DEFAULT NULL COMMENT 'a, a/b, a/b/g, a/b/g/n, a/b/g/n/y',
  `mode` varchar(20) DEFAULT NULL COMMENT 'ad-hoc, managed, master, repeater, secondary, monitor, auto',
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `networkports_id` (`networkports_id`),
  KEY `card` (`items_devicenetworkcards_id`),
  KEY `essid` (`wifinetworks_id`),
  KEY `version` (`version`),
  KEY `mode` (`mode`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `networkportwifis_id` (`networkportwifis_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_networks`
--

DROP TABLE IF EXISTS `glpi_networks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_networks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_notepads`
--

DROP TABLE IF EXISTS `glpi_notepads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_notepads` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `itemtype` varchar(100) DEFAULT NULL,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_creation` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_lastupdater` int(10) unsigned NOT NULL DEFAULT 0,
  `content` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `item` (`itemtype`,`items_id`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `users_id_lastupdater` (`users_id_lastupdater`),
  KEY `users_id` (`users_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_notifications`
--

DROP TABLE IF EXISTS `glpi_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_notifications` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) NOT NULL,
  `event` varchar(255) NOT NULL,
  `comment` text DEFAULT NULL,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `is_active` tinyint(4) NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `allow_response` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `itemtype` (`itemtype`),
  KEY `entities_id` (`entities_id`),
  KEY `is_active` (`is_active`),
  KEY `date_mod` (`date_mod`),
  KEY `is_recursive` (`is_recursive`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_notifications_notificationtemplates`
--

DROP TABLE IF EXISTS `glpi_notifications_notificationtemplates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_notifications_notificationtemplates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `notifications_id` int(10) unsigned NOT NULL DEFAULT 0,
  `mode` varchar(20) NOT NULL COMMENT 'See Notification_NotificationTemplate::MODE_* constants',
  `notificationtemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`notifications_id`,`mode`,`notificationtemplates_id`),
  KEY `notificationtemplates_id` (`notificationtemplates_id`),
  KEY `mode` (`mode`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_notificationtargets`
--

DROP TABLE IF EXISTS `glpi_notificationtargets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_notificationtargets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `type` int(11) NOT NULL DEFAULT 0,
  `notifications_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `items` (`type`,`items_id`),
  KEY `notifications_id` (`notifications_id`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_notificationtemplates`
--

DROP TABLE IF EXISTS `glpi_notificationtemplates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_notificationtemplates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `itemtype` varchar(100) NOT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `css` text DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `itemtype` (`itemtype`),
  KEY `date_mod` (`date_mod`),
  KEY `name` (`name`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_notificationtemplatetranslations`
--

DROP TABLE IF EXISTS `glpi_notificationtemplatetranslations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_notificationtemplatetranslations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `notificationtemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `language` varchar(10) NOT NULL DEFAULT '',
  `subject` varchar(255) NOT NULL,
  `content_text` text DEFAULT NULL,
  `content_html` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notificationtemplates_id` (`notificationtemplates_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_notimportedemails`
--

DROP TABLE IF EXISTS `glpi_notimportedemails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_notimportedemails` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `from` varchar(255) NOT NULL,
  `to` varchar(255) NOT NULL,
  `mailcollectors_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `subject` text DEFAULT NULL,
  `messageid` varchar(255) NOT NULL,
  `reason` int(11) NOT NULL DEFAULT 0,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `users_id` (`users_id`),
  KEY `mailcollectors_id` (`mailcollectors_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_objectlocks`
--

DROP TABLE IF EXISTS `glpi_objectlocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_objectlocks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `itemtype` varchar(100) NOT NULL COMMENT 'Type of locked object',
  `items_id` int(10) unsigned NOT NULL COMMENT 'RELATION to various tables, according to itemtype (ID)',
  `users_id` int(10) unsigned NOT NULL COMMENT 'id of the locker',
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `item` (`itemtype`,`items_id`),
  KEY `users_id` (`users_id`),
  KEY `date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_olalevelactions`
--

DROP TABLE IF EXISTS `glpi_olalevelactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_olalevelactions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `olalevels_id` int(10) unsigned NOT NULL DEFAULT 0,
  `action_type` varchar(255) DEFAULT NULL,
  `field` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `olalevels_id` (`olalevels_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_olalevelcriterias`
--

DROP TABLE IF EXISTS `glpi_olalevelcriterias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_olalevelcriterias` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `olalevels_id` int(10) unsigned NOT NULL DEFAULT 0,
  `criteria` varchar(255) DEFAULT NULL,
  `condition` int(11) NOT NULL DEFAULT 0 COMMENT 'see define.php PATTERN_* and REGEX_* constant',
  `pattern` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `olalevels_id` (`olalevels_id`),
  KEY `condition` (`condition`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_olalevels`
--

DROP TABLE IF EXISTS `glpi_olalevels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_olalevels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `olas_id` int(10) unsigned NOT NULL DEFAULT 0,
  `execution_time` int(11) NOT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 1,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `match` char(10) DEFAULT NULL COMMENT 'see define.php *_MATCHING constant',
  `uuid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `is_active` (`is_active`),
  KEY `olas_id` (`olas_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_olalevels_tickets`
--

DROP TABLE IF EXISTS `glpi_olalevels_tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_olalevels_tickets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tickets_id` int(10) unsigned NOT NULL DEFAULT 0,
  `olalevels_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`tickets_id`,`olalevels_id`),
  KEY `olalevels_id` (`olalevels_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_olas`
--

DROP TABLE IF EXISTS `glpi_olas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_olas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `type` int(11) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `number_time` int(11) NOT NULL,
  `use_ticket_calendar` tinyint(4) NOT NULL DEFAULT 0,
  `calendars_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `definition_time` varchar(255) DEFAULT NULL,
  `end_of_working_day` tinyint(4) NOT NULL DEFAULT 0,
  `date_creation` timestamp NULL DEFAULT NULL,
  `slms_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `calendars_id` (`calendars_id`),
  KEY `slms_id` (`slms_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_operatingsystemarchitectures`
--

DROP TABLE IF EXISTS `glpi_operatingsystemarchitectures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_operatingsystemarchitectures` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_operatingsystemeditions`
--

DROP TABLE IF EXISTS `glpi_operatingsystemeditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_operatingsystemeditions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_creation` (`date_creation`),
  KEY `date_mod` (`date_mod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_operatingsystemkernels`
--

DROP TABLE IF EXISTS `glpi_operatingsystemkernels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_operatingsystemkernels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_creation` (`date_creation`),
  KEY `date_mod` (`date_mod`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_operatingsystemkernelversions`
--

DROP TABLE IF EXISTS `glpi_operatingsystemkernelversions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_operatingsystemkernelversions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `operatingsystemkernels_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `operatingsystemkernels_id` (`operatingsystemkernels_id`),
  KEY `date_creation` (`date_creation`),
  KEY `date_mod` (`date_mod`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_operatingsystems`
--

DROP TABLE IF EXISTS `glpi_operatingsystems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_operatingsystems` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_operatingsystemservicepacks`
--

DROP TABLE IF EXISTS `glpi_operatingsystemservicepacks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_operatingsystemservicepacks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_operatingsystemversions`
--

DROP TABLE IF EXISTS `glpi_operatingsystemversions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_operatingsystemversions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_passivedcequipmentmodels`
--

DROP TABLE IF EXISTS `glpi_passivedcequipmentmodels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_passivedcequipmentmodels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `product_number` varchar(255) DEFAULT NULL,
  `weight` int(11) NOT NULL DEFAULT 0,
  `required_units` int(11) NOT NULL DEFAULT 1,
  `depth` float NOT NULL DEFAULT 1,
  `power_connections` int(11) NOT NULL DEFAULT 0,
  `power_consumption` int(11) NOT NULL DEFAULT 0,
  `is_half_rack` tinyint(4) NOT NULL DEFAULT 0,
  `picture_front` text DEFAULT NULL,
  `picture_rear` text DEFAULT NULL,
  `pictures` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `product_number` (`product_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_passivedcequipments`
--

DROP TABLE IF EXISTS `glpi_passivedcequipments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_passivedcequipments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `serial` varchar(255) DEFAULT NULL,
  `otherserial` varchar(255) DEFAULT NULL,
  `passivedcequipmentmodels_id` int(10) unsigned DEFAULT NULL,
  `passivedcequipmenttypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `is_template` tinyint(4) NOT NULL DEFAULT 0,
  `template_name` varchar(255) DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to states (id)',
  `comment` text DEFAULT NULL,
  `manufacturers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `locations_id` (`locations_id`),
  KEY `passivedcequipmentmodels_id` (`passivedcequipmentmodels_id`),
  KEY `passivedcequipmenttypes_id` (`passivedcequipmenttypes_id`),
  KEY `users_id_tech` (`users_id_tech`),
  KEY `group_id_tech` (`groups_id_tech`),
  KEY `is_template` (`is_template`),
  KEY `is_deleted` (`is_deleted`),
  KEY `states_id` (`states_id`),
  KEY `manufacturers_id` (`manufacturers_id`),
  KEY `date_creation` (`date_creation`),
  KEY `date_mod` (`date_mod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_passivedcequipmenttypes`
--

DROP TABLE IF EXISTS `glpi_passivedcequipmenttypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_passivedcequipmenttypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_pcivendors`
--

DROP TABLE IF EXISTS `glpi_pcivendors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_pcivendors` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `vendorid` varchar(4) NOT NULL,
  `deviceid` varchar(4) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`vendorid`,`deviceid`),
  KEY `deviceid` (`deviceid`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_pdumodels`
--

DROP TABLE IF EXISTS `glpi_pdumodels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_pdumodels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `product_number` varchar(255) DEFAULT NULL,
  `weight` int(11) NOT NULL DEFAULT 0,
  `required_units` int(11) NOT NULL DEFAULT 1,
  `depth` float NOT NULL DEFAULT 1,
  `power_connections` int(11) NOT NULL DEFAULT 0,
  `max_power` int(11) NOT NULL DEFAULT 0,
  `is_half_rack` tinyint(4) NOT NULL DEFAULT 0,
  `picture_front` text DEFAULT NULL,
  `picture_rear` text DEFAULT NULL,
  `pictures` text DEFAULT NULL,
  `is_rackable` tinyint(4) NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `is_rackable` (`is_rackable`),
  KEY `product_number` (`product_number`),
  KEY `date_creation` (`date_creation`),
  KEY `date_mod` (`date_mod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_pdus`
--

DROP TABLE IF EXISTS `glpi_pdus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_pdus` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `serial` varchar(255) DEFAULT NULL,
  `otherserial` varchar(255) DEFAULT NULL,
  `pdumodels_id` int(10) unsigned DEFAULT NULL,
  `users_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `is_template` tinyint(4) NOT NULL DEFAULT 0,
  `template_name` varchar(255) DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to states (id)',
  `comment` text DEFAULT NULL,
  `manufacturers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `pdutypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `locations_id` (`locations_id`),
  KEY `pdumodels_id` (`pdumodels_id`),
  KEY `users_id_tech` (`users_id_tech`),
  KEY `group_id_tech` (`groups_id_tech`),
  KEY `is_template` (`is_template`),
  KEY `is_deleted` (`is_deleted`),
  KEY `states_id` (`states_id`),
  KEY `manufacturers_id` (`manufacturers_id`),
  KEY `pdutypes_id` (`pdutypes_id`),
  KEY `date_creation` (`date_creation`),
  KEY `date_mod` (`date_mod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_pdus_plugs`
--

DROP TABLE IF EXISTS `glpi_pdus_plugs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_pdus_plugs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugs_id` int(10) unsigned NOT NULL DEFAULT 0,
  `pdus_id` int(10) unsigned NOT NULL DEFAULT 0,
  `number_plugs` int(11) DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plugs_id` (`plugs_id`),
  KEY `pdus_id` (`pdus_id`),
  KEY `date_creation` (`date_creation`),
  KEY `date_mod` (`date_mod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_pdus_racks`
--

DROP TABLE IF EXISTS `glpi_pdus_racks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_pdus_racks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `racks_id` int(10) unsigned NOT NULL DEFAULT 0,
  `pdus_id` int(10) unsigned NOT NULL DEFAULT 0,
  `side` int(11) DEFAULT 0,
  `position` int(11) NOT NULL,
  `bgcolor` varchar(7) DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `racks_id` (`racks_id`),
  KEY `pdus_id` (`pdus_id`),
  KEY `date_creation` (`date_creation`),
  KEY `date_mod` (`date_mod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_pdutypes`
--

DROP TABLE IF EXISTS `glpi_pdutypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_pdutypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `name` (`name`),
  KEY `date_creation` (`date_creation`),
  KEY `date_mod` (`date_mod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_pendingreasons`
--

DROP TABLE IF EXISTS `glpi_pendingreasons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_pendingreasons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `followup_frequency` int(11) NOT NULL DEFAULT 0,
  `followups_before_resolution` int(11) NOT NULL DEFAULT 0,
  `itilfollowuptemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `solutiontemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `itilfollowuptemplates_id` (`itilfollowuptemplates_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `solutiontemplates_id` (`solutiontemplates_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_pendingreasons_items`
--

DROP TABLE IF EXISTS `glpi_pendingreasons_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_pendingreasons_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pendingreasons_id` int(10) unsigned NOT NULL DEFAULT 0,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) NOT NULL DEFAULT '',
  `followup_frequency` int(11) NOT NULL DEFAULT 0,
  `followups_before_resolution` int(11) NOT NULL DEFAULT 0,
  `bump_count` int(11) NOT NULL DEFAULT 0,
  `last_bump_date` timestamp NULL DEFAULT NULL,
  `previous_status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`items_id`,`itemtype`),
  KEY `pendingreasons_id` (`pendingreasons_id`),
  KEY `item` (`itemtype`,`items_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_peripheralmodels`
--

DROP TABLE IF EXISTS `glpi_peripheralmodels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_peripheralmodels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `product_number` varchar(255) DEFAULT NULL,
  `weight` int(11) NOT NULL DEFAULT 0,
  `required_units` int(11) NOT NULL DEFAULT 1,
  `depth` float NOT NULL DEFAULT 1,
  `power_connections` int(11) NOT NULL DEFAULT 0,
  `power_consumption` int(11) NOT NULL DEFAULT 0,
  `is_half_rack` tinyint(4) NOT NULL DEFAULT 0,
  `picture_front` text DEFAULT NULL,
  `picture_rear` text DEFAULT NULL,
  `pictures` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `product_number` (`product_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_peripherals`
--

DROP TABLE IF EXISTS `glpi_peripherals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_peripherals` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `contact` varchar(255) DEFAULT NULL,
  `contact_num` varchar(255) DEFAULT NULL,
  `users_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `serial` varchar(255) DEFAULT NULL,
  `otherserial` varchar(255) DEFAULT NULL,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `peripheraltypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `peripheralmodels_id` int(10) unsigned NOT NULL DEFAULT 0,
  `brand` varchar(255) DEFAULT NULL,
  `manufacturers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_global` tinyint(4) NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_template` tinyint(4) NOT NULL DEFAULT 0,
  `template_name` varchar(255) DEFAULT NULL,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0,
  `ticket_tco` decimal(20,4) DEFAULT 0.0000,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  `autoupdatesystems_id` int(10) unsigned NOT NULL DEFAULT 0,
  `uuid` varchar(255) DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `is_template` (`is_template`),
  KEY `is_global` (`is_global`),
  KEY `entities_id` (`entities_id`),
  KEY `manufacturers_id` (`manufacturers_id`),
  KEY `groups_id` (`groups_id`),
  KEY `users_id` (`users_id`),
  KEY `locations_id` (`locations_id`),
  KEY `peripheralmodels_id` (`peripheralmodels_id`),
  KEY `states_id` (`states_id`),
  KEY `users_id_tech` (`users_id_tech`),
  KEY `peripheraltypes_id` (`peripheraltypes_id`),
  KEY `is_deleted` (`is_deleted`),
  KEY `date_mod` (`date_mod`),
  KEY `groups_id_tech` (`groups_id_tech`),
  KEY `is_dynamic` (`is_dynamic`),
  KEY `autoupdatesystems_id` (`autoupdatesystems_id`),
  KEY `serial` (`serial`),
  KEY `otherserial` (`otherserial`),
  KEY `uuid` (`uuid`),
  KEY `date_creation` (`date_creation`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB AUTO_INCREMENT=447 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_peripheraltypes`
--

DROP TABLE IF EXISTS `glpi_peripheraltypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_peripheraltypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_phonemodels`
--

DROP TABLE IF EXISTS `glpi_phonemodels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_phonemodels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `product_number` varchar(255) DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `picture_front` text DEFAULT NULL,
  `picture_rear` text DEFAULT NULL,
  `pictures` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `product_number` (`product_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_phonepowersupplies`
--

DROP TABLE IF EXISTS `glpi_phonepowersupplies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_phonepowersupplies` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_phones`
--

DROP TABLE IF EXISTS `glpi_phones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_phones` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `contact` varchar(255) DEFAULT NULL,
  `contact_num` varchar(255) DEFAULT NULL,
  `users_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `serial` varchar(255) DEFAULT NULL,
  `otherserial` varchar(255) DEFAULT NULL,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `phonetypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `phonemodels_id` int(10) unsigned NOT NULL DEFAULT 0,
  `brand` varchar(255) DEFAULT NULL,
  `phonepowersupplies_id` int(10) unsigned NOT NULL DEFAULT 0,
  `number_line` varchar(255) DEFAULT NULL,
  `have_headset` tinyint(4) NOT NULL DEFAULT 0,
  `have_hp` tinyint(4) NOT NULL DEFAULT 0,
  `manufacturers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_global` tinyint(4) NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_template` tinyint(4) NOT NULL DEFAULT 0,
  `template_name` varchar(255) DEFAULT NULL,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0,
  `ticket_tco` decimal(20,4) DEFAULT 0.0000,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  `autoupdatesystems_id` int(10) unsigned NOT NULL DEFAULT 0,
  `uuid` varchar(255) DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `last_inventory_update` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `is_template` (`is_template`),
  KEY `is_global` (`is_global`),
  KEY `entities_id` (`entities_id`),
  KEY `manufacturers_id` (`manufacturers_id`),
  KEY `groups_id` (`groups_id`),
  KEY `users_id` (`users_id`),
  KEY `locations_id` (`locations_id`),
  KEY `phonemodels_id` (`phonemodels_id`),
  KEY `phonepowersupplies_id` (`phonepowersupplies_id`),
  KEY `states_id` (`states_id`),
  KEY `users_id_tech` (`users_id_tech`),
  KEY `phonetypes_id` (`phonetypes_id`),
  KEY `is_deleted` (`is_deleted`),
  KEY `date_mod` (`date_mod`),
  KEY `groups_id_tech` (`groups_id_tech`),
  KEY `is_dynamic` (`is_dynamic`),
  KEY `autoupdatesystems_id` (`autoupdatesystems_id`),
  KEY `serial` (`serial`),
  KEY `otherserial` (`otherserial`),
  KEY `uuid` (`uuid`),
  KEY `date_creation` (`date_creation`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_phonetypes`
--

DROP TABLE IF EXISTS `glpi_phonetypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_phonetypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_planningeventcategories`
--

DROP TABLE IF EXISTS `glpi_planningeventcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_planningeventcategories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `color` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_planningexternalevents`
--

DROP TABLE IF EXISTS `glpi_planningexternalevents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_planningexternalevents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) DEFAULT NULL,
  `planningexternaleventtemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 1,
  `date` timestamp NULL DEFAULT NULL,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_guests` text DEFAULT NULL,
  `groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `text` text DEFAULT NULL,
  `begin` timestamp NULL DEFAULT NULL,
  `end` timestamp NULL DEFAULT NULL,
  `rrule` text DEFAULT NULL,
  `state` int(11) NOT NULL DEFAULT 0,
  `planningeventcategories_id` int(10) unsigned NOT NULL DEFAULT 0,
  `background` tinyint(4) NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `name` (`name`),
  KEY `planningexternaleventtemplates_id` (`planningexternaleventtemplates_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `date` (`date`),
  KEY `begin` (`begin`),
  KEY `end` (`end`),
  KEY `users_id` (`users_id`),
  KEY `groups_id` (`groups_id`),
  KEY `state` (`state`),
  KEY `planningeventcategories_id` (`planningeventcategories_id`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_planningexternaleventtemplates`
--

DROP TABLE IF EXISTS `glpi_planningexternaleventtemplates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_planningexternaleventtemplates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `text` mediumtext DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `duration` int(11) NOT NULL DEFAULT 0,
  `before_time` int(11) NOT NULL DEFAULT 0,
  `rrule` text DEFAULT NULL,
  `state` int(11) NOT NULL DEFAULT 0,
  `planningeventcategories_id` int(10) unsigned NOT NULL DEFAULT 0,
  `background` tinyint(4) NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `state` (`state`),
  KEY `planningeventcategories_id` (`planningeventcategories_id`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_planningrecalls`
--

DROP TABLE IF EXISTS `glpi_planningrecalls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_planningrecalls` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) NOT NULL,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `before_time` int(11) NOT NULL DEFAULT -10,
  `when` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`itemtype`,`items_id`,`users_id`),
  KEY `users_id` (`users_id`),
  KEY `before_time` (`before_time`),
  KEY `when` (`when`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_accounts_accounts`
--

DROP TABLE IF EXISTS `glpi_plugin_accounts_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_accounts_accounts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `login` varchar(255) DEFAULT NULL,
  `encrypted_password` varchar(255) DEFAULT NULL,
  `others` varchar(255) DEFAULT NULL,
  `plugin_accounts_accounttypes_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_accounts_accounttypes (id)',
  `plugin_accounts_accountstates_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_accounts_accountstates (id)',
  `date_creation` timestamp NULL DEFAULT NULL,
  `date_expiration` timestamp NULL DEFAULT NULL,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_users (id)',
  `groups_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_groups (id)',
  `users_id_tech` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_users (id)',
  `groups_id_tech` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_groups (id)',
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_locations (id)',
  `is_helpdesk_visible` int(10) unsigned NOT NULL DEFAULT 1,
  `date_mod` timestamp NULL DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `plugin_accounts_accounttypes_id` (`plugin_accounts_accounttypes_id`),
  KEY `plugin_accounts_accountstates_id` (`plugin_accounts_accountstates_id`),
  KEY `users_id` (`users_id`),
  KEY `groups_id` (`groups_id`),
  KEY `users_id_tech` (`users_id_tech`),
  KEY `groups_id_tech` (`groups_id_tech`),
  KEY `date_mod` (`date_mod`),
  KEY `is_helpdesk_visible` (`is_helpdesk_visible`),
  KEY `is_deleted` (`is_deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_accounts_accounts_items`
--

DROP TABLE IF EXISTS `glpi_plugin_accounts_accounts_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_accounts_accounts_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_accounts_accounts_id` int(10) unsigned NOT NULL DEFAULT 0,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to various tables, according to itemtype (id)',
  `itemtype` varchar(100) NOT NULL COMMENT 'see .class.php file',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`plugin_accounts_accounts_id`,`itemtype`,`items_id`),
  KEY `FK_device` (`items_id`,`itemtype`),
  KEY `item` (`itemtype`,`items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_accounts_accountstates`
--

DROP TABLE IF EXISTS `glpi_plugin_accounts_accountstates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_accounts_accountstates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_accounts_accounttypes`
--

DROP TABLE IF EXISTS `glpi_plugin_accounts_accounttypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_accounts_accounttypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_accounts_aeskeys`
--

DROP TABLE IF EXISTS `glpi_plugin_accounts_aeskeys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_accounts_aeskeys` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `plugin_accounts_hashes_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `plugin_accounts_hashes_id` (`plugin_accounts_hashes_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_accounts_configs`
--

DROP TABLE IF EXISTS `glpi_plugin_accounts_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_accounts_configs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `delay_expired` varchar(50) NOT NULL DEFAULT '30',
  `delay_whichexpire` varchar(50) NOT NULL DEFAULT '30',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_accounts_hashes`
--

DROP TABLE IF EXISTS `glpi_plugin_accounts_hashes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_accounts_hashes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `hash` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entities_id` (`entities_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_accounts_notificationstates`
--

DROP TABLE IF EXISTS `glpi_plugin_accounts_notificationstates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_accounts_notificationstates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_accounts_accountstates_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_accounts_accountstates (id)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_activity_configs`
--

DROP TABLE IF EXISTS `glpi_plugin_activity_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_activity_configs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `entities_id` int(10) unsigned NOT NULL,
  `use_mandaydisplay` tinyint(4) DEFAULT 0,
  `use_integerschedules` tinyint(4) DEFAULT 0,
  `use_planningeventsubcategories` tinyint(4) DEFAULT 0,
  `is_recursive` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_activity_holidaycounts`
--

DROP TABLE IF EXISTS `glpi_plugin_activity_holidaycounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_activity_holidaycounts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `date_mod` timestamp NULL DEFAULT NULL,
  `count` decimal(20,1) NOT NULL DEFAULT 0.0,
  `plugin_activity_holidayperiods_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_activity_holidaytypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `users_id` (`users_id`),
  KEY `plugin_activity_holidayperiods_id` (`plugin_activity_holidayperiods_id`),
  KEY `plugin_activity_holidaytypes_id` (`plugin_activity_holidaytypes_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_activity_holidayperiods`
--

DROP TABLE IF EXISTS `glpi_plugin_activity_holidayperiods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_activity_holidayperiods` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `short_name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `begin` timestamp NULL DEFAULT NULL,
  `end` timestamp NULL DEFAULT NULL,
  `archived` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_activity_holidays`
--

DROP TABLE IF EXISTS `glpi_plugin_activity_holidays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_activity_holidays` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `date_mod` timestamp NULL DEFAULT NULL,
  `begin` timestamp NULL DEFAULT NULL,
  `end` timestamp NULL DEFAULT NULL,
  `is_planned` tinyint(4) NOT NULL DEFAULT 0,
  `global_validation` tinyint(4) NOT NULL DEFAULT 0 COMMENT '1 -&gt; NONE ; 2 -&gt; Waiting ; 3 -&gt; accepted ; 4 -&gt; rejected',
  `comment` text DEFAULT NULL,
  `actiontime` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_activity_holidaytypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `allDay` tinyint(4) NOT NULL DEFAULT 0,
  `validation_percent` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_activity_holidayperiods_id` int(10) unsigned DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `users_id` (`users_id`),
  KEY `plugin_activity_holidaytypes_id` (`plugin_activity_holidaytypes_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_activity_holidaytypes`
--

DROP TABLE IF EXISTS `glpi_plugin_activity_holidaytypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_activity_holidaytypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `comment` text DEFAULT NULL,
  `short_name` varchar(255) DEFAULT NULL,
  `mandatory_comment` tinyint(4) NOT NULL DEFAULT 0,
  `auto_validated` tinyint(4) DEFAULT 0,
  `is_holiday` tinyint(4) DEFAULT 1,
  `is_sickness` tinyint(4) DEFAULT 0,
  `is_part_time` tinyint(4) DEFAULT 0,
  `is_holiday_counter` tinyint(4) DEFAULT 0,
  `is_period` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_activity_holidayvalidations`
--

DROP TABLE IF EXISTS `glpi_plugin_activity_holidayvalidations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_activity_holidayvalidations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_activity_holidays_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_validate` int(10) unsigned NOT NULL DEFAULT 0,
  `comment_validation` text DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 2 COMMENT '1 -&gt; NONE ; 2 -&gt; Waiting ; 3 -&gt; accepted ; 4 -&gt; rejected',
  `submission_date` timestamp NULL DEFAULT NULL,
  `validation_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `users_id_validate` (`users_id_validate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_activity_options`
--

DROP TABLE IF EXISTS `glpi_plugin_activity_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_activity_options` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `principal_client` varchar(255) NOT NULL DEFAULT '',
  `cra_footer` text DEFAULT NULL,
  `used_mail_for_holidays` varchar(255) NOT NULL DEFAULT '',
  `use_type_as_name` tinyint(4) DEFAULT 0,
  `use_hour_on_cra` tinyint(4) DEFAULT 0,
  `use_timerepartition` tinyint(4) DEFAULT 0,
  `use_mandaydisplay` tinyint(4) DEFAULT 0,
  `use_pairs` tinyint(4) DEFAULT 0,
  `use_integerschedules` tinyint(4) DEFAULT 0,
  `use_groupmanager` tinyint(4) DEFAULT 0,
  `use_planningeventsubcategories` tinyint(4) DEFAULT 0,
  `default_validation_percent` int(10) unsigned NOT NULL DEFAULT 0,
  `is_cra_default` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `use_project` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `use_weekend` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `is_cra_default_project` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_activity_planningeventsubcategories`
--

DROP TABLE IF EXISTS `glpi_plugin_activity_planningeventsubcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_activity_planningeventsubcategories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_activity_planningexternalevents`
--

DROP TABLE IF EXISTS `glpi_plugin_activity_planningexternalevents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_activity_planningexternalevents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `is_oncra` tinyint(4) DEFAULT 1,
  `planningexternalevents_id` int(10) unsigned NOT NULL,
  `planningeventsubcategories_id` int(10) unsigned DEFAULT NULL,
  `actiontime` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `is_oncra` (`is_oncra`),
  KEY `planningeventsubcategories_id` (`planningeventsubcategories_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_activity_preferences`
--

DROP TABLE IF EXISTS `glpi_plugin_activity_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_activity_preferences` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_validate` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_activity_projecttasks`
--

DROP TABLE IF EXISTS `glpi_plugin_activity_projecttasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_activity_projecttasks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `is_oncra` tinyint(4) DEFAULT 1,
  `projecttasks_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `is_oncra` (`is_oncra`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_activity_snapshots`
--

DROP TABLE IF EXISTS `glpi_plugin_activity_snapshots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_activity_snapshots` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `documents_id` int(10) unsigned NOT NULL,
  `date` timestamp NULL DEFAULT NULL,
  `month` int(10) unsigned NOT NULL,
  `year` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_activity_tickettasks`
--

DROP TABLE IF EXISTS `glpi_plugin_activity_tickettasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_activity_tickettasks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `is_oncra` tinyint(4) DEFAULT 1,
  `tickettasks_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `is_oncra` (`is_oncra`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_actualtime_configs`
--

DROP TABLE IF EXISTS `glpi_plugin_actualtime_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_actualtime_configs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `displayinfofor` smallint(6) NOT NULL DEFAULT 0,
  `showtimerpopup` tinyint(4) NOT NULL DEFAULT 1,
  `showtimerinbox` tinyint(4) NOT NULL DEFAULT 1,
  `autoopenrunning` tinyint(4) NOT NULL DEFAULT 0,
  `autoupdate_duration` tinyint(4) NOT NULL DEFAULT 0,
  `planned_task` tinyint(4) NOT NULL DEFAULT 0,
  `multiple_day` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_actualtime_tasks`
--

DROP TABLE IF EXISTS `glpi_plugin_actualtime_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_actualtime_tasks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `itemtype` varchar(255) NOT NULL,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `actual_begin` timestamp NULL DEFAULT NULL,
  `actual_end` timestamp NULL DEFAULT NULL,
  `users_id` int(10) unsigned NOT NULL,
  `actual_actiontime` int(10) unsigned NOT NULL DEFAULT 0,
  `origin_start` int(10) unsigned NOT NULL,
  `origin_end` int(10) unsigned NOT NULL DEFAULT 0,
  `override_begin` timestamp NULL DEFAULT NULL,
  `override_end` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `item` (`itemtype`,`items_id`),
  KEY `users_id` (`users_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_additionalalerts_configs`
--

DROP TABLE IF EXISTS `glpi_plugin_additionalalerts_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_additionalalerts_configs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `use_infocom_alert` tinyint(4) NOT NULL DEFAULT 0,
  `use_ink_alert` tinyint(4) NOT NULL DEFAULT 0,
  `delay_ticket_alert` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_additionalalerts_infocomalerts`
--

DROP TABLE IF EXISTS `glpi_plugin_additionalalerts_infocomalerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_additionalalerts_infocomalerts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `use_infocom_alert` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_additionalalerts_inkalerts`
--

DROP TABLE IF EXISTS `glpi_plugin_additionalalerts_inkalerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_additionalalerts_inkalerts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `use_ink_alert` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_additionalalerts_inkprinterstates`
--

DROP TABLE IF EXISTS `glpi_plugin_additionalalerts_inkprinterstates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_additionalalerts_inkprinterstates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_states (id)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_additionalalerts_inkthresholds`
--

DROP TABLE IF EXISTS `glpi_plugin_additionalalerts_inkthresholds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_additionalalerts_inkthresholds` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cartridges_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_cartridgeitems (id)',
  `threshold` int(10) unsigned NOT NULL DEFAULT 10,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_additionalalerts_notificationtypes`
--

DROP TABLE IF EXISTS `glpi_plugin_additionalalerts_notificationtypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_additionalalerts_notificationtypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `types_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_computertypes (id)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_additionalalerts_ticketunresolveds`
--

DROP TABLE IF EXISTS `glpi_plugin_additionalalerts_ticketunresolveds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_additionalalerts_ticketunresolveds` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `delay_ticket_alert` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_addressing_addressings`
--

DROP TABLE IF EXISTS `glpi_plugin_addressing_addressings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_addressing_addressings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `use_as_filter` tinyint(4) NOT NULL DEFAULT 0,
  `networks_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_networks (id)',
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_locations (id)',
  `fqdns_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_fqdns (id)',
  `vlans_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_vlans (id)',
  `begin_ip` varchar(255) DEFAULT NULL,
  `end_ip` varchar(255) DEFAULT NULL,
  `alloted_ip` tinyint(4) NOT NULL DEFAULT 0,
  `double_ip` tinyint(4) NOT NULL DEFAULT 0,
  `free_ip` tinyint(4) NOT NULL DEFAULT 0,
  `reserved_ip` tinyint(4) NOT NULL DEFAULT 0,
  `use_ping` tinyint(4) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `networks_id` (`networks_id`),
  KEY `is_deleted` (`is_deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_addressing_configs`
--

DROP TABLE IF EXISTS `glpi_plugin_addressing_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_addressing_configs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `alloted_ip` tinyint(4) NOT NULL DEFAULT 0,
  `double_ip` tinyint(4) NOT NULL DEFAULT 0,
  `free_ip` tinyint(4) NOT NULL DEFAULT 0,
  `reserved_ip` tinyint(4) NOT NULL DEFAULT 0,
  `use_ping` tinyint(4) NOT NULL DEFAULT 0,
  `used_system` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_addressing_filters`
--

DROP TABLE IF EXISTS `glpi_plugin_addressing_filters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_addressing_filters` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_addressing_addressings_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `begin_ip` varchar(255) DEFAULT NULL,
  `end_ip` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entities_id` (`entities_id`),
  KEY `plugin_addressing_addressings_id` (`plugin_addressing_addressings_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_addressing_ipcomments`
--

DROP TABLE IF EXISTS `glpi_plugin_addressing_ipcomments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_addressing_ipcomments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_addressing_addressings_id` int(10) unsigned NOT NULL DEFAULT 0,
  `ipname` varchar(255) DEFAULT NULL,
  `comments` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plugin_addressing_addressings_id` (`plugin_addressing_addressings_id`),
  KEY `ipname` (`ipname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_addressing_pinginfos`
--

DROP TABLE IF EXISTS `glpi_plugin_addressing_pinginfos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_addressing_pinginfos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_addressing_addressings_id` int(10) unsigned NOT NULL DEFAULT 0,
  `ipname` varchar(255) DEFAULT NULL,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to various tables, according to itemtype (id)',
  `itemtype` varchar(100) DEFAULT NULL COMMENT 'see .class.php file',
  `ping_response` tinyint(4) NOT NULL DEFAULT 0,
  `ping_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plugin_addressing_addressings_id` (`plugin_addressing_addressings_id`),
  KEY `ipname` (`ipname`),
  KEY `ping_response` (`ping_response`),
  KEY `ping_date` (`ping_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_archibp_criticities`
--

DROP TABLE IF EXISTS `glpi_plugin_archibp_criticities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_archibp_criticities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `comment` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `glpi_plugin_archibp_criticities_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_archibp_profiles`
--

DROP TABLE IF EXISTS `glpi_plugin_archibp_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_archibp_profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `profiles_id` int(11) NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_profiles (id)',
  `archibp` char(1) DEFAULT NULL,
  `open_ticket` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `profiles_id` (`profiles_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_archibp_tasks`
--

DROP TABLE IF EXISTS `glpi_plugin_archibp_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_archibp_tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(11) NOT NULL DEFAULT 0,
  `is_recursive` tinyint(1) NOT NULL DEFAULT 0,
  `plugin_archibp_tasks_id` int(11) NOT NULL DEFAULT 0,
  `completename` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `level` int(11) NOT NULL DEFAULT 0,
  `sons_cache` longtext DEFAULT NULL,
  `ancestors_cache` longtext DEFAULT NULL,
  `plugin_archibp_tasktypes_id` int(11) NOT NULL DEFAULT 0 COMMENT 'BP type : Manual, ...',
  `plugin_archibp_taskstates_id` int(11) NOT NULL DEFAULT 0 COMMENT 'Active, Future, ...',
  `plugin_archibp_criticities_id` int(11) NOT NULL DEFAULT 0 COMMENT 'BP criticality : Normal, Important, ...',
  `plugin_archibp_swcomponents_id` int(11) NOT NULL DEFAULT 0 COMMENT 'from archisw',
  `plugin_archibp_tasktargets_id` int(11) NOT NULL DEFAULT 0 COMMENT 'Target user segments (department A, B, A+B, ...)',
  `transactioncode` text DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `users_id` int(11) NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_users (id)',
  `groups_id` int(11) NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_groups (id)',
  `date_mod` timestamp NULL DEFAULT NULL,
  `is_helpdesk_visible` int(11) NOT NULL DEFAULT 1,
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`plugin_archibp_tasks_id`,`name`),
  KEY `plugin_archibp_tasktypes_id` (`plugin_archibp_tasktypes_id`),
  KEY `plugin_archibp_taskstates_id` (`plugin_archibp_taskstates_id`),
  KEY `plugin_archibp_criticities_id` (`plugin_archibp_criticities_id`),
  KEY `plugin_archibp_swcomponents_id` (`plugin_archibp_swcomponents_id`),
  KEY `plugin_archibp_tasktargets_id` (`plugin_archibp_tasktargets_id`),
  KEY `users_id` (`users_id`),
  KEY `groups_id` (`groups_id`),
  KEY `date_mod` (`date_mod`),
  KEY `is_helpdesk_visible` (`is_helpdesk_visible`),
  KEY `is_deleted` (`is_deleted`),
  KEY `plugin_archibp_tasks_id` (`plugin_archibp_tasks_id`)
) ENGINE=InnoDB AUTO_INCREMENT=756 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_archibp_tasks_items`
--

DROP TABLE IF EXISTS `glpi_plugin_archibp_tasks_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_archibp_tasks_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plugin_archibp_tasks_id` int(11) NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_archibp_tasks (id)',
  `items_id` int(11) NOT NULL DEFAULT 0 COMMENT 'RELATION to various tables, according to itemtype (id)',
  `itemtype` varchar(100) NOT NULL COMMENT 'see .class.php file',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`plugin_archibp_tasks_id`,`items_id`,`itemtype`),
  KEY `FK_device` (`items_id`,`itemtype`),
  KEY `item` (`itemtype`,`items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_archibp_tasktypes`
--

DROP TABLE IF EXISTS `glpi_plugin_archibp_tasktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_archibp_tasktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `comment` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `glpi_plugin_archibp_tasktypes_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_archidata_dataelementcardinalities`
--

DROP TABLE IF EXISTS `glpi_plugin_archidata_dataelementcardinalities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_archidata_dataelementcardinalities` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_archidata_dataelementclassifications`
--

DROP TABLE IF EXISTS `glpi_plugin_archidata_dataelementclassifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_archidata_dataelementclassifications` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_archidata_dataelements`
--

DROP TABLE IF EXISTS `glpi_plugin_archidata_dataelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_archidata_dataelements` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(11) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(1) NOT NULL DEFAULT 0,
  `plugin_archidata_dataelements_id` int(11) unsigned NOT NULL DEFAULT 0,
  `completename` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `level` int(11) unsigned NOT NULL DEFAULT 0,
  `sons_cache` longtext DEFAULT NULL,
  `ancestors_cache` longtext DEFAULT NULL,
  `plugin_archidata_dataelementtypes_id` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'dataelement type : Boolean, Text, ...',
  `plugin_archidata_dataelementcardinalities_id` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'dataelement cardinality : 0, 0 or more, ...',
  `plugin_archidata_dataelementclassifications_id` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'dataelement classification : public, restricted, confidential, ...',
  `plugin_archidata_masterswcomponents_id` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'master swcomponent',
  `address` varchar(255) DEFAULT NULL COMMENT 'dataelement URL',
  `users_id` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_users (id)',
  `groups_id` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_groups (id)',
  `date_mod` timestamp NULL DEFAULT NULL,
  `is_helpdesk_visible` int(11) unsigned NOT NULL DEFAULT 1,
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`plugin_archidata_dataelements_id`,`name`),
  KEY `plugin_archidata_dataelementcardinalities_id` (`plugin_archidata_dataelementcardinalities_id`),
  KEY `plugin_archidata_dataelementtypes_id` (`plugin_archidata_dataelementtypes_id`),
  KEY `users_id` (`users_id`),
  KEY `groups_id` (`groups_id`),
  KEY `plugin_archidata_masterswcomponents_id` (`plugin_archidata_masterswcomponents_id`),
  KEY `date_mod` (`date_mod`),
  KEY `is_helpdesk_visible` (`is_helpdesk_visible`),
  KEY `is_deleted` (`is_deleted`),
  KEY `plugin_archidata_dataelements_id` (`plugin_archidata_dataelements_id`)
) ENGINE=InnoDB AUTO_INCREMENT=756 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_archidata_dataelements_items`
--

DROP TABLE IF EXISTS `glpi_plugin_archidata_dataelements_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_archidata_dataelements_items` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_archidata_dataelements_id` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_archidata_dataelements (id)',
  `items_id` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to various tables, according to itemtype (id)',
  `itemtype` varchar(100) NOT NULL COMMENT 'see .class.php file',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`plugin_archidata_dataelements_id`,`items_id`,`itemtype`),
  KEY `FK_device` (`items_id`,`itemtype`),
  KEY `item` (`itemtype`,`items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_archidata_dataelementtypes`
--

DROP TABLE IF EXISTS `glpi_plugin_archidata_dataelementtypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_archidata_dataelementtypes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `comment` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `glpi_plugin_archidata_dataelementtype_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_archifun_funcareas`
--

DROP TABLE IF EXISTS `glpi_plugin_archifun_funcareas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_archifun_funcareas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(11) NOT NULL DEFAULT 0,
  `is_recursive` tinyint(1) NOT NULL DEFAULT 0,
  `plugin_archifun_funcareas_id` int(11) NOT NULL DEFAULT 0,
  `completename` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `level` int(11) NOT NULL DEFAULT 0,
  `sons_cache` longtext DEFAULT NULL,
  `ancestors_cache` longtext DEFAULT NULL,
  `users_id` int(11) NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_users (id)',
  `groups_id` int(11) NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_groups (id)',
  `date_mod` timestamp NULL DEFAULT NULL,
  `is_helpdesk_visible` int(11) NOT NULL DEFAULT 1,
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`plugin_archifun_funcareas_id`,`name`),
  KEY `users_id` (`users_id`),
  KEY `groups_id` (`groups_id`),
  KEY `date_mod` (`date_mod`),
  KEY `is_helpdesk_visible` (`is_helpdesk_visible`),
  KEY `is_deleted` (`is_deleted`),
  KEY `plugin_archifun_funcareas_id` (`plugin_archifun_funcareas_id`)
) ENGINE=InnoDB AUTO_INCREMENT=756 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_archifun_funcareas_items`
--

DROP TABLE IF EXISTS `glpi_plugin_archifun_funcareas_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_archifun_funcareas_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plugin_archifun_funcareas_id` int(11) NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_archifun_funcareas (id)',
  `items_id` int(11) NOT NULL DEFAULT 0 COMMENT 'RELATION to various tables, according to itemtype (id)',
  `itemtype` varchar(100) NOT NULL COMMENT 'see .class.php file',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`plugin_archifun_funcareas_id`,`items_id`,`itemtype`),
  KEY `FK_device` (`items_id`,`itemtype`),
  KEY `item` (`itemtype`,`items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_archimap_configs`
--

DROP TABLE IF EXISTS `glpi_plugin_archimap_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_archimap_configs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(45) NOT NULL,
  `key` varchar(45) NOT NULL,
  `value` mediumtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`type`,`key`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_archimap_graphlevels`
--

DROP TABLE IF EXISTS `glpi_plugin_archimap_graphlevels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_archimap_graphlevels` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `comment` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `glpi_plugin_archimap_graphlevel_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_archimap_graphs`
--

DROP TABLE IF EXISTS `glpi_plugin_archimap_graphs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_archimap_graphs` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Internal ID',
  `entities_id` int(11) NOT NULL DEFAULT 0,
  `is_recursive` tinyint(1) NOT NULL DEFAULT 0,
  `name` varchar(45) NOT NULL COMMENT 'flow name (or code)',
  `plugin_archimap_graphtypes_id` int(11) NOT NULL DEFAULT 0 COMMENT 'graph type : collaboration, technical, ...',
  `plugin_archimap_graphstates_id` int(11) NOT NULL DEFAULT 0 COMMENT 'graph status : in progress, validated ...',
  `graphstatedate` timestamp NULL DEFAULT NULL COMMENT 'validity date of graph status',
  `shortdescription` varchar(100) DEFAULT NULL,
  `longdescription` tinytext DEFAULT NULL,
  `graph` mediumtext DEFAULT NULL,
  `groups_id` int(11) NOT NULL DEFAULT 0 COMMENT 'graph owner',
  `users_id` int(11) NOT NULL DEFAULT 0 COMMENT 'graph maintainer',
  `is_helpdesk_visible` int(11) NOT NULL DEFAULT 1,
  `date_mod` timestamp NULL DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `plugin_archimap_graphtypes_id` (`plugin_archimap_graphtypes_id`),
  KEY `plugin_archimap_graphstates_id` (`plugin_archimap_graphstates_id`),
  KEY `groups_id` (`groups_id`),
  KEY `users_id` (`users_id`),
  KEY `is_helpdesk_visible` (`is_helpdesk_visible`),
  KEY `is_deleted` (`is_deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_archimap_graphs_items`
--

DROP TABLE IF EXISTS `glpi_plugin_archimap_graphs_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_archimap_graphs_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plugin_archimap_graphs_id` int(11) NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_archimap_graph (id)',
  `items_id` int(11) NOT NULL DEFAULT 0 COMMENT 'RELATION to various tables, according to itemtype (id)',
  `itemtype` varchar(100) NOT NULL COMMENT 'see .class.php file',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`plugin_archimap_graphs_id`,`items_id`,`itemtype`),
  KEY `FK_device` (`items_id`,`itemtype`),
  KEY `item` (`itemtype`,`items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_archimap_graphstates`
--

DROP TABLE IF EXISTS `glpi_plugin_archimap_graphstates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_archimap_graphstates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `comment` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `glpi_plugin_archimap_graphstate_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_archimap_graphtypes`
--

DROP TABLE IF EXISTS `glpi_plugin_archimap_graphtypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_archimap_graphtypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `comment` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `glpi_plugin_archimap_graphtype_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_archisw_configswdatatypes`
--

DROP TABLE IF EXISTS `glpi_plugin_archisw_configswdatatypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_archisw_configswdatatypes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `plugin_archisw_configswdatatypes_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_archisw_configswdbfieldtypes`
--

DROP TABLE IF EXISTS `glpi_plugin_archisw_configswdbfieldtypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_archisw_configswdbfieldtypes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `plugin_archisw_configswdbfieldtypes_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_archisw_configswfieldgroups`
--

DROP TABLE IF EXISTS `glpi_plugin_archisw_configswfieldgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_archisw_configswfieldgroups` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `comment` varchar(45) DEFAULT NULL,
  `sortorder` tinyint(3) unsigned NOT NULL,
  `is_visible` tinyint(3) unsigned NOT NULL COMMENT '0=False/1=True',
  PRIMARY KEY (`id`),
  UNIQUE KEY `plugin_archisw_configswfieldgroups_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_archisw_configswhaligns`
--

DROP TABLE IF EXISTS `glpi_plugin_archisw_configswhaligns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_archisw_configswhaligns` (
  `id` int(11) unsigned NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `plugin_archisw_configswhaligns_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_archisw_configswlinks`
--

DROP TABLE IF EXISTS `glpi_plugin_archisw_configswlinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_archisw_configswlinks` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `has_dropdown` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT '0=False/1=True',
  `is_entity_limited` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT '0=False/1=True',
  `is_tree_dropdown` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT '0=False/1=True',
  `as_view_on` varchar(255) DEFAULT NULL COMMENT 'empty or table name',
  `viewlimit` varchar(255) DEFAULT NULL COMMENT 'empty or where clause (without where reserved word)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `plugin_archisw_configswlinks_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_archisw_configsws`
--

DROP TABLE IF EXISTS `glpi_plugin_archisw_configsws`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_archisw_configsws` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `plugin_archisw_configswfieldgroups_id` int(11) unsigned NOT NULL,
  `row` tinyint(3) unsigned NOT NULL,
  `plugin_archisw_configswhaligns_id` int(11) unsigned NOT NULL COMMENT 'Left/Center/Right column or Full line',
  `plugin_archisw_configswdbfieldtypes_id` int(11) unsigned NOT NULL,
  `plugin_archisw_configswdatatypes_id` int(11) unsigned NOT NULL,
  `nosearch` char(1) NOT NULL COMMENT '0=False/1=True',
  `massiveaction` char(1) NOT NULL COMMENT '0=False/1=True',
  `forcegroupby` char(1) NOT NULL COMMENT '0=False/1=True',
  `is_linked` tinyint(3) unsigned NOT NULL COMMENT '0=False/1=True',
  `plugin_archisw_configswlinks_id` int(11) unsigned DEFAULT NULL,
  `linkfield` varchar(255) DEFAULT NULL,
  `joinparams` varchar(255) DEFAULT NULL,
  `description` varchar(45) NOT NULL,
  `is_readonly` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT '0=False/1=True',
  `is_deleted` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT '0=False/1=True',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`plugin_archisw_configswfieldgroups_id`,`row`,`plugin_archisw_configswhaligns_id`),
  UNIQUE KEY `plugin_archisw_configsws_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_archisw_labeltranslations`
--

DROP TABLE IF EXISTS `glpi_plugin_archisw_labeltranslations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_archisw_labeltranslations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `items_id` int(10) unsigned NOT NULL,
  `language` varchar(5) NOT NULL,
  `label` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`items_id`,`language`),
  KEY `items_id` (`items_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_archisw_standards`
--

DROP TABLE IF EXISTS `glpi_plugin_archisw_standards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_archisw_standards` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `comment` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `plugin_archisw_standards_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_archisw_swcomponentdbs`
--

DROP TABLE IF EXISTS `glpi_plugin_archisw_swcomponentdbs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_archisw_swcomponentdbs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_archisw_swcomponentinstances`
--

DROP TABLE IF EXISTS `glpi_plugin_archisw_swcomponentinstances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_archisw_swcomponentinstances` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_archisw_swcomponentlicenses`
--

DROP TABLE IF EXISTS `glpi_plugin_archisw_swcomponentlicenses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_archisw_swcomponentlicenses` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_archisw_swcomponents`
--

DROP TABLE IF EXISTS `glpi_plugin_archisw_swcomponents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_archisw_swcomponents` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(11) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(1) NOT NULL DEFAULT 0,
  `plugin_archisw_swcomponents_id` int(11) unsigned NOT NULL DEFAULT 0,
  `shortname` varchar(20) DEFAULT NULL,
  `completename` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `level` int(11) unsigned NOT NULL DEFAULT 0,
  `sons_cache` longtext DEFAULT NULL,
  `ancestors_cache` longtext DEFAULT NULL,
  `plugin_archisw_swcomponenttypes_id` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'swcomponent type : Custom Development, Commercial Off The Shelf, ...',
  `plugin_archisw_swcomponentstates_id` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'swcomponent status : in development, in use ...',
  `statedate` timestamp NULL DEFAULT NULL COMMENT 'validity date of swcomponent status',
  `plugin_archisw_swcomponenttechnics_id` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_webapplications_webapplicationtechnics (id)',
  `users_id` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_users (id)',
  `groups_id` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_groups (id)',
  `suppliers_id` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_suppliers (id)',
  `manufacturers_id` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_manufacturers (id)',
  `locations_id` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_locations (id)',
  `version` varchar(255) DEFAULT NULL,
  `startyear` varchar(8) DEFAULT NULL COMMENT 'year of starting in production',
  `plugin_archisw_swcomponentusers_id` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'number of users',
  `plugin_archisw_swcomponentslas_id` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Service Level Agreement',
  `plugin_archisw_swcomponentdbs_id` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Data repository',
  `plugin_archisw_swcomponentinstances_id` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Instances typology (dev+qa+prod, qa+prod, ...)',
  `plugin_archisw_swcomponenttargets_id` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Target user segments (department A, B, A+B, ...)',
  `plugin_archisw_swcomponentlicenses_id` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'License type (Named user, ...)',
  `plugin_archisw_standards_id` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Standard status (Standard, Not standard, ...)',
  `address` varchar(255) DEFAULT NULL,
  `address_qa` varchar(255) DEFAULT NULL,
  `health_check` varchar(255) DEFAULT NULL,
  `repo` varchar(255) DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `is_helpdesk_visible` int(11) unsigned NOT NULL DEFAULT 1,
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`plugin_archisw_swcomponents_id`,`name`),
  KEY `plugin_archisw_swcomponenttechnics_id` (`plugin_archisw_swcomponenttechnics_id`),
  KEY `plugin_archisw_swcomponenttypes_id` (`plugin_archisw_swcomponenttypes_id`),
  KEY `plugin_archisw_swcomponentstates_id` (`plugin_archisw_swcomponentstates_id`),
  KEY `plugin_archisw_swcomponentusers_id` (`plugin_archisw_swcomponentusers_id`),
  KEY `plugin_archisw_swcomponentslas_id` (`plugin_archisw_swcomponentslas_id`),
  KEY `plugin_archisw_swcomponentdbs_id` (`plugin_archisw_swcomponentdbs_id`),
  KEY `plugin_archisw_swcomponentinstances_id` (`plugin_archisw_swcomponentinstances_id`),
  KEY `plugin_archisw_swcomponenttargets_id` (`plugin_archisw_swcomponenttargets_id`),
  KEY `plugin_archisw_swcomponentlicenses_id` (`plugin_archisw_swcomponentlicenses_id`),
  KEY `users_id` (`users_id`),
  KEY `groups_id` (`groups_id`),
  KEY `suppliers_id` (`suppliers_id`),
  KEY `manufacturers_id` (`manufacturers_id`),
  KEY `locations_id` (`locations_id`),
  KEY `plugin_archisw_standards_id` (`plugin_archisw_standards_id`),
  KEY `date_mod` (`date_mod`),
  KEY `is_helpdesk_visible` (`is_helpdesk_visible`),
  KEY `is_deleted` (`is_deleted`),
  KEY `plugin_archisw_swcomponents_id` (`plugin_archisw_swcomponents_id`)
) ENGINE=InnoDB AUTO_INCREMENT=756 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_archisw_swcomponents_itemroles`
--

DROP TABLE IF EXISTS `glpi_plugin_archisw_swcomponents_itemroles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_archisw_swcomponents_itemroles` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `itemtype` varchar(100) NOT NULL COMMENT 'see .class.php file',
  `name` varchar(45) NOT NULL,
  `comment` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`itemtype`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_archisw_swcomponents_items`
--

DROP TABLE IF EXISTS `glpi_plugin_archisw_swcomponents_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_archisw_swcomponents_items` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_archisw_swcomponents_id` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_archisw_swcomponents (id)',
  `items_id` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to various tables, according to itemtype (id)',
  `itemtype` varchar(100) NOT NULL COMMENT 'see .class.php file',
  `plugin_archisw_swcomponents_itemroles_id` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'role of the relation (f.i Dev, QA, Prod, ...)',
  `comment` text DEFAULT NULL COMMENT 'comment about the relation',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`plugin_archisw_swcomponents_id`,`items_id`,`itemtype`,`plugin_archisw_swcomponents_itemroles_id`),
  KEY `FK_device` (`items_id`,`itemtype`),
  KEY `item` (`itemtype`,`items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_archisw_swcomponentslas`
--

DROP TABLE IF EXISTS `glpi_plugin_archisw_swcomponentslas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_archisw_swcomponentslas` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_archisw_swcomponentstates`
--

DROP TABLE IF EXISTS `glpi_plugin_archisw_swcomponentstates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_archisw_swcomponentstates` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `comment` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `glpi_plugin_archisw_swcomponentstates_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_archisw_swcomponenttargets`
--

DROP TABLE IF EXISTS `glpi_plugin_archisw_swcomponenttargets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_archisw_swcomponenttargets` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_archisw_swcomponenttechnics`
--

DROP TABLE IF EXISTS `glpi_plugin_archisw_swcomponenttechnics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_archisw_swcomponenttechnics` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_archisw_swcomponenttypes`
--

DROP TABLE IF EXISTS `glpi_plugin_archisw_swcomponenttypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_archisw_swcomponenttypes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(11) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(1) NOT NULL DEFAULT 0,
  `name` varchar(45) NOT NULL,
  `plugin_archisw_swcomponenttypes_id` int(11) unsigned NOT NULL DEFAULT 0,
  `completename` text DEFAULT NULL,
  `comment` varchar(45) DEFAULT NULL,
  `level` int(11) unsigned NOT NULL DEFAULT 0,
  `sons_cache` longtext DEFAULT NULL,
  `ancestors_cache` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `glpi_plugin_archisw_swcomponenttype_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_archisw_swcomponentusers`
--

DROP TABLE IF EXISTS `glpi_plugin_archisw_swcomponentusers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_archisw_swcomponentusers` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_badges_badges`
--

DROP TABLE IF EXISTS `glpi_plugin_badges_badges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_badges_badges` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `serial` varchar(255) DEFAULT NULL,
  `plugin_badges_badgetypes_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_badges_badgetypes (id)',
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_locations (id)',
  `date_affectation` timestamp NULL DEFAULT NULL,
  `date_expiration` timestamp NULL DEFAULT NULL,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_states (id)',
  `users_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_users (id)',
  `is_helpdesk_visible` int(10) unsigned NOT NULL DEFAULT 1,
  `date_mod` timestamp NULL DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `notepad` longtext DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_bookable` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `plugin_badges_badgetypes_id` (`plugin_badges_badgetypes_id`),
  KEY `locations_id` (`locations_id`),
  KEY `date_expiration` (`date_expiration`),
  KEY `states_id` (`states_id`),
  KEY `users_id` (`users_id`),
  KEY `is_helpdesk_visible` (`is_helpdesk_visible`),
  KEY `is_deleted` (`is_deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_badges_badgetypes`
--

DROP TABLE IF EXISTS `glpi_plugin_badges_badgetypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_badges_badgetypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_badges_configs`
--

DROP TABLE IF EXISTS `glpi_plugin_badges_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_badges_configs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `delay_expired` varchar(50) NOT NULL DEFAULT '30',
  `delay_whichexpire` varchar(50) NOT NULL DEFAULT '30',
  `delay_returnexpire` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_badges_notificationstates`
--

DROP TABLE IF EXISTS `glpi_plugin_badges_notificationstates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_badges_notificationstates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_states (id)',
  PRIMARY KEY (`id`),
  KEY `states_id` (`states_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_badges_requests`
--

DROP TABLE IF EXISTS `glpi_plugin_badges_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_badges_requests` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `badges_id` int(10) unsigned NOT NULL DEFAULT 0,
  `requesters_id` int(10) unsigned NOT NULL DEFAULT 0,
  `visitor_firstname` varchar(255) DEFAULT NULL,
  `visitor_realname` varchar(255) DEFAULT NULL,
  `visitor_society` varchar(255) DEFAULT NULL,
  `affectation_date` timestamp NULL DEFAULT NULL,
  `return_date` timestamp NULL DEFAULT NULL,
  `is_affected` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `badges_id` (`badges_id`),
  KEY `requesters_id` (`requesters_id`),
  KEY `is_affected` (`is_affected`),
  KEY `affectation_date` (`affectation_date`),
  KEY `return_date` (`return_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_barcode_configs`
--

DROP TABLE IF EXISTS `glpi_plugin_barcode_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_barcode_configs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_barcode_configs_types`
--

DROP TABLE IF EXISTS `glpi_plugin_barcode_configs_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_barcode_configs_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(20) DEFAULT NULL,
  `size` varchar(20) DEFAULT NULL,
  `orientation` varchar(9) DEFAULT NULL,
  `marginTop` int(11) DEFAULT NULL,
  `marginBottom` int(11) DEFAULT NULL,
  `marginLeft` int(11) DEFAULT NULL,
  `marginRight` int(11) DEFAULT NULL,
  `marginHorizontal` int(11) DEFAULT NULL,
  `marginVertical` int(11) DEFAULT NULL,
  `maxCodeWidth` int(11) DEFAULT NULL,
  `maxCodeHeight` int(11) DEFAULT NULL,
  `txtSize` int(11) DEFAULT NULL,
  `txtSpacing` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_behaviors_configs`
--

DROP TABLE IF EXISTS `glpi_plugin_behaviors_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_behaviors_configs` (
  `id` int(10) unsigned NOT NULL,
  `use_requester_item_group` tinyint(4) NOT NULL DEFAULT 0,
  `use_requester_user_group` tinyint(4) NOT NULL DEFAULT 0,
  `is_ticketsolutiontype_mandatory` tinyint(4) NOT NULL DEFAULT 0,
  `is_ticketsolution_mandatory` tinyint(4) NOT NULL DEFAULT 0,
  `is_ticketcategory_mandatory` tinyint(4) NOT NULL DEFAULT 0,
  `is_ticketcategory_mandatory_on_assign` tinyint(4) NOT NULL DEFAULT 0,
  `is_tickettaskcategory_mandatory` tinyint(4) NOT NULL DEFAULT 0,
  `is_tickettech_mandatory` tinyint(4) NOT NULL DEFAULT 0,
  `is_tickettechgroup_mandatory` tinyint(4) NOT NULL DEFAULT 0,
  `is_ticketrealtime_mandatory` tinyint(4) NOT NULL DEFAULT 0,
  `is_ticketlocation_mandatory` tinyint(4) NOT NULL DEFAULT 0,
  `is_requester_mandatory` tinyint(4) NOT NULL DEFAULT 0,
  `is_ticketdate_locked` tinyint(4) NOT NULL DEFAULT 0,
  `use_assign_user_group` tinyint(4) NOT NULL DEFAULT 0,
  `use_assign_user_group_update` tinyint(4) NOT NULL DEFAULT 0,
  `ticketsolved_updatetech` tinyint(4) NOT NULL DEFAULT 0,
  `tickets_id_format` varchar(15) DEFAULT NULL,
  `changes_id_format` varchar(15) DEFAULT NULL,
  `is_problemsolutiontype_mandatory` tinyint(4) NOT NULL DEFAULT 0,
  `remove_from_ocs` tinyint(4) NOT NULL DEFAULT 0,
  `add_notif` tinyint(4) NOT NULL DEFAULT 0,
  `use_lock` tinyint(4) NOT NULL DEFAULT 0,
  `single_tech_mode` int(10) unsigned NOT NULL DEFAULT 0,
  `myasset` tinyint(4) NOT NULL DEFAULT 0,
  `groupasset` tinyint(4) NOT NULL DEFAULT 0,
  `clone` tinyint(4) NOT NULL DEFAULT 0,
  `addfup_updatetech` tinyint(4) NOT NULL DEFAULT 0,
  `is_tickettasktodo` tinyint(4) NOT NULL DEFAULT 0,
  `is_problemtasktodo` tinyint(4) NOT NULL DEFAULT 0,
  `is_changetasktodo` tinyint(4) NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_borgbase_borgbases`
--

DROP TABLE IF EXISTS `glpi_plugin_borgbase_borgbases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_borgbase_borgbases` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `borg_id` varchar(8) NOT NULL,
  `borg_name` varchar(255) NOT NULL,
  `computer_id` int(10) unsigned DEFAULT NULL,
  `alertDays` int(11) DEFAULT NULL,
  `borg_version` varchar(255) DEFAULT NULL,
  `is_encrypted` varchar(255) DEFAULT NULL,
  `region` varchar(255) DEFAULT NULL,
  `createdAt` varchar(255) DEFAULT NULL,
  `lastModified` varchar(255) DEFAULT NULL,
  `compactionInterval` varchar(255) DEFAULT NULL,
  `compactionIntervalUnit` varchar(255) DEFAULT NULL,
  `compactionHour` varchar(255) DEFAULT NULL,
  `compactionHourTimezone` varchar(255) DEFAULT NULL,
  `repoPath` varchar(255) DEFAULT NULL,
  `currentUsage` varchar(255) DEFAULT '0',
  `date_creation` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_mod` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_borgbase_configs`
--

DROP TABLE IF EXISTS `glpi_plugin_borgbase_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_borgbase_configs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `server` varchar(512) NOT NULL DEFAULT '',
  `apikey` varchar(640) NOT NULL DEFAULT '',
  `match` tinyint(1) NOT NULL DEFAULT 0,
  `debug` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_borgbase_relations`
--

DROP TABLE IF EXISTS `glpi_plugin_borgbase_relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_borgbase_relations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(255) DEFAULT NULL,
  `plugin_borgbase_borgbases_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `items_id` (`items_id`),
  KEY `itemtype` (`itemtype`,`items_id`),
  KEY `plugin_borgbase_borgbases_id` (`plugin_borgbase_borgbases_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_centreon_hosts`
--

DROP TABLE IF EXISTS `glpi_plugin_centreon_hosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_centreon_hosts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `itemtype` varchar(100) NOT NULL,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `centreon_id` int(10) NOT NULL,
  `centreon_type` varchar(100) DEFAULT 'host',
  PRIMARY KEY (`id`),
  KEY `items_id` (`items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_cmdb_cifields`
--

DROP TABLE IF EXISTS `glpi_plugin_cmdb_cifields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_cmdb_cifields` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT '',
  `typefield` int(10) unsigned NOT NULL,
  `plugin_cmdb_citypes_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `plugin_cmdb_citypes_id` (`plugin_cmdb_citypes_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_cmdb_cis`
--

DROP TABLE IF EXISTS `glpi_plugin_cmdb_cis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_cmdb_cis` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT '',
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `plugin_cmdb_citypes_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `plugin_cmdb_citypes_id` (`plugin_cmdb_citypes_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_cmdb_citypes`
--

DROP TABLE IF EXISTS `glpi_plugin_cmdb_citypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_cmdb_citypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT '',
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `is_imported` tinyint(4) NOT NULL DEFAULT 0,
  `fields` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `is_imported` (`is_imported`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_cmdb_citypes_documents`
--

DROP TABLE IF EXISTS `glpi_plugin_cmdb_citypes_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_cmdb_citypes_documents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_cmdb_citypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `types_id` int(10) unsigned NOT NULL DEFAULT 0,
  `documents_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `plugin_cmdb_citypes_id` (`plugin_cmdb_citypes_id`),
  KEY `types_id` (`types_id`),
  KEY `documents_id` (`documents_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_cmdb_civalues`
--

DROP TABLE IF EXISTS `glpi_plugin_cmdb_civalues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_cmdb_civalues` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `value` varchar(255) DEFAULT '',
  `itemtype` varchar(255) NOT NULL,
  `items_id` int(10) unsigned NOT NULL,
  `plugin_cmdb_cifields_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `items_id` (`items_id`),
  KEY `plugin_cmdb_cifields_id` (`plugin_cmdb_cifields_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_cmdb_criticities`
--

DROP TABLE IF EXISTS `glpi_plugin_cmdb_criticities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_cmdb_criticities` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `businesscriticities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `color` varchar(255) DEFAULT NULL,
  `level` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `businesscriticities_id` (`businesscriticities_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_cmdb_criticities_items`
--

DROP TABLE IF EXISTS `glpi_plugin_cmdb_criticities_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_cmdb_criticities_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `itemtype` varchar(100) NOT NULL COMMENT 'see .class.php file',
  `items_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to various tables, according to itemtype (id)',
  `plugin_cmdb_criticities_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `item` (`itemtype`,`items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_cmdb_operationprocesses`
--

DROP TABLE IF EXISTS `glpi_plugin_cmdb_operationprocesses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_cmdb_operationprocesses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT '',
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `plugin_cmdb_operationprocessstates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_users (id)',
  `users_id_tech` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_users (id)',
  `groups_id_tech` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_groups (id)',
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_locations (id)',
  `date_creation` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_helpdesk_visible` int(10) unsigned NOT NULL DEFAULT 1,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `users_id_tech` (`users_id_tech`),
  KEY `groups_id_tech` (`groups_id_tech`),
  KEY `locations_id` (`locations_id`),
  KEY `is_deleted` (`is_deleted`),
  KEY `is_helpdesk_visible` (`is_helpdesk_visible`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_cmdb_operationprocesses_items`
--

DROP TABLE IF EXISTS `glpi_plugin_cmdb_operationprocesses_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_cmdb_operationprocesses_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_cmdb_operationprocesses_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_cmdb_operationprocesses (id)',
  `items_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to various tables, according to itemtype (id)',
  `itemtype` varchar(100) NOT NULL COMMENT 'see .class.php file',
  PRIMARY KEY (`id`),
  KEY `plugin_cmdb_operationprocesses_id` (`plugin_cmdb_operationprocesses_id`),
  KEY `item` (`itemtype`,`items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_cmdb_operationprocessstates`
--

DROP TABLE IF EXISTS `glpi_plugin_cmdb_operationprocessstates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_cmdb_operationprocessstates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT '',
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_connections_configs`
--

DROP TABLE IF EXISTS `glpi_plugin_connections_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_connections_configs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `delay_expired` varchar(50) NOT NULL DEFAULT '30',
  `delay_whichexpire` varchar(50) NOT NULL DEFAULT '30',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_connections_connectionrates`
--

DROP TABLE IF EXISTS `glpi_plugin_connections_connectionrates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_connections_connectionrates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_connections_connections`
--

DROP TABLE IF EXISTS `glpi_plugin_connections_connections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_connections_connections` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `plugin_connections_connectiontypes_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_connections_connectiontypes (id)',
  `plugin_connections_connectionrates_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_connections_connectionrates (id)',
  `plugin_connections_guaranteedconnectionrates_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_connections_connectionratesguaranteed (id)',
  `bytes` varchar(255) NOT NULL DEFAULT '',
  `users_id_tech` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_users (id)',
  `groups_id_tech` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_groups (id)',
  `suppliers_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_suppliers (id)',
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_locations (id)',
  `comment` text DEFAULT NULL,
  `notepad` longtext DEFAULT NULL,
  `others` varchar(255) DEFAULT NULL,
  `is_helpdesk_visible` int(10) unsigned NOT NULL DEFAULT 1,
  `date_mod` timestamp NULL DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `plugin_connections_connectiontypes_id` (`plugin_connections_connectiontypes_id`),
  KEY `plugin_connections_connectionrates_id` (`plugin_connections_connectionrates_id`),
  KEY `plugin_connections_guaranteedconnectionrates_id` (`plugin_connections_guaranteedconnectionrates_id`),
  KEY `users_id_tech` (`users_id_tech`),
  KEY `groups_id_tech` (`groups_id_tech`),
  KEY `suppliers_id` (`suppliers_id`),
  KEY `date_mod` (`date_mod`),
  KEY `is_helpdesk_visible` (`is_helpdesk_visible`),
  KEY `is_deleted` (`is_deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_connections_connections_items`
--

DROP TABLE IF EXISTS `glpi_plugin_connections_connections_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_connections_connections_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_connections_connections_id` int(10) unsigned NOT NULL DEFAULT 0,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to various tables, according to itemtype (id)',
  `itemtype` varchar(100) NOT NULL COMMENT 'see .class.php file',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`plugin_connections_connections_id`,`itemtype`,`items_id`),
  KEY `FK_device` (`items_id`,`itemtype`),
  KEY `item` (`itemtype`,`items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_connections_connectiontypes`
--

DROP TABLE IF EXISTS `glpi_plugin_connections_connectiontypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_connections_connectiontypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_connections_guaranteedconnectionrates`
--

DROP TABLE IF EXISTS `glpi_plugin_connections_guaranteedconnectionrates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_connections_guaranteedconnectionrates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_consumables_fields`
--

DROP TABLE IF EXISTS `glpi_plugin_consumables_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_consumables_fields` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `consumableitems_id` int(10) unsigned NOT NULL DEFAULT 0,
  `order_ref` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`consumableitems_id`,`order_ref`),
  KEY `consumableitems_id` (`consumableitems_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_consumables_options`
--

DROP TABLE IF EXISTS `glpi_plugin_consumables_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_consumables_options` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `consumableitems_id` int(10) unsigned NOT NULL DEFAULT 0,
  `groups` longtext DEFAULT NULL,
  `max_cart` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_consumables_profiles`
--

DROP TABLE IF EXISTS `glpi_plugin_consumables_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_consumables_profiles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `profiles_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_profiles (id)',
  `consumables` char(1) DEFAULT NULL,
  `consumables_request` char(1) DEFAULT NULL,
  `consumables_for_all` char(1) DEFAULT NULL,
  `consumables_for_group` char(1) DEFAULT NULL,
  `validate` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `profiles_id` (`profiles_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_consumables_requests`
--

DROP TABLE IF EXISTS `glpi_plugin_consumables_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_consumables_requests` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `consumableitems_id` int(10) unsigned NOT NULL DEFAULT 0,
  `consumableitemtypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `requesters_id` int(10) unsigned NOT NULL DEFAULT 0,
  `validators_id` int(10) unsigned NOT NULL DEFAULT 0,
  `give_itemtype` varchar(255) DEFAULT NULL,
  `give_items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `status` int(10) unsigned NOT NULL DEFAULT 2,
  `number` int(10) unsigned NOT NULL DEFAULT 0,
  `end_date` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `consumableitems_id` (`consumableitems_id`),
  KEY `requesters_id` (`requesters_id`),
  KEY `validators_id` (`validators_id`),
  KEY `date_mod` (`date_mod`),
  KEY `end_date` (`end_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_costs_configs`
--

DROP TABLE IF EXISTS `glpi_plugin_costs_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_costs_configs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `taskdescription` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_costs_entities`
--

DROP TABLE IF EXISTS `glpi_plugin_costs_entities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_costs_entities` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `fixed_cost` float NOT NULL DEFAULT 0,
  `time_cost` float NOT NULL DEFAULT 0,
  `cost_private` tinyint(4) NOT NULL DEFAULT 0,
  `auto_cost` tinyint(4) NOT NULL DEFAULT 0,
  `inheritance` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `entities_id` (`entities_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_costs_entities_profiles`
--

DROP TABLE IF EXISTS `glpi_plugin_costs_entities_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_costs_entities_profiles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `profiles_id` int(10) unsigned NOT NULL DEFAULT 0,
  `fixed_cost` float NOT NULL DEFAULT 0,
  `time_cost` float NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`entities_id`,`profiles_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_costs_tasks`
--

DROP TABLE IF EXISTS `glpi_plugin_costs_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_costs_tasks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tasks_id` int(10) unsigned NOT NULL,
  `costs_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `tasks_id` (`tasks_id`),
  KEY `costs_id` (`costs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_costs_tickets`
--

DROP TABLE IF EXISTS `glpi_plugin_costs_tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_costs_tickets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tickets_id` int(10) unsigned NOT NULL,
  `billable` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `tickets_id` (`tickets_id`),
  KEY `billable` (`billable`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_databaseinventory_computergroupdynamics`
--

DROP TABLE IF EXISTS `glpi_plugin_databaseinventory_computergroupdynamics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_databaseinventory_computergroupdynamics` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_databaseinventory_computergroups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `search` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plugin_databaseinventory_computergroups_id` (`plugin_databaseinventory_computergroups_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_databaseinventory_computergroups`
--

DROP TABLE IF EXISTS `glpi_plugin_databaseinventory_computergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_databaseinventory_computergroups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_creation` (`date_creation`),
  KEY `date_mod` (`date_mod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_databaseinventory_computergroupstatics`
--

DROP TABLE IF EXISTS `glpi_plugin_databaseinventory_computergroupstatics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_databaseinventory_computergroupstatics` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_databaseinventory_computergroups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `computers_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `computers_id` (`computers_id`),
  KEY `plugin_databaseinventory_computergroups_id` (`plugin_databaseinventory_computergroups_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_databaseinventory_contactlogs`
--

DROP TABLE IF EXISTS `glpi_plugin_databaseinventory_contactlogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_databaseinventory_contactlogs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `agents_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_databaseinventory_credentials_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_databaseinventory_databaseparams_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `agents_id` (`agents_id`),
  KEY `plugin_databaseinventory_credentials_id` (`plugin_databaseinventory_credentials_id`),
  KEY `plugin_databaseinventory_databaseparams_id` (`plugin_databaseinventory_databaseparams_id`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_databaseinventory_credentials`
--

DROP TABLE IF EXISTS `glpi_plugin_databaseinventory_credentials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_databaseinventory_credentials` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `login` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `socket` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `port` int(11) NOT NULL DEFAULT 0,
  `plugin_databaseinventory_credentialtypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_creation` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `login` (`login`),
  KEY `password` (`password`),
  KEY `socket` (`socket`),
  KEY `port` (`port`),
  KEY `plugin_databaseinventory_credentialtypes_id` (`plugin_databaseinventory_credentialtypes_id`),
  KEY `date_creation` (`date_creation`),
  KEY `date_mod` (`date_mod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_databaseinventory_credentialtypes`
--

DROP TABLE IF EXISTS `glpi_plugin_databaseinventory_credentialtypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_databaseinventory_credentialtypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_databaseinventory_databaseparams`
--

DROP TABLE IF EXISTS `glpi_plugin_databaseinventory_databaseparams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_databaseinventory_databaseparams` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 0,
  `partial_inventory` tinyint(4) NOT NULL DEFAULT 0,
  `execution_delay` int(11) NOT NULL DEFAULT 0,
  `date_creation` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `is_active` (`is_active`),
  KEY `partial_inventory` (`partial_inventory`),
  KEY `date_creation` (`date_creation`),
  KEY `date_mod` (`date_mod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_databaseinventory_databaseparams_computergroups`
--

DROP TABLE IF EXISTS `glpi_plugin_databaseinventory_databaseparams_computergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_databaseinventory_databaseparams_computergroups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_databaseinventory_databaseparams_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_databaseinventory_computergroups_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`plugin_databaseinventory_computergroups_id`,`plugin_databaseinventory_databaseparams_id`),
  KEY `plugin_databaseinventory_databaseparams_id` (`plugin_databaseinventory_databaseparams_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_databaseinventory_databaseparams_credentials`
--

DROP TABLE IF EXISTS `glpi_plugin_databaseinventory_databaseparams_credentials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_databaseinventory_databaseparams_credentials` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_databaseinventory_databaseparams_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_databaseinventory_credentials_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`plugin_databaseinventory_databaseparams_id`,`plugin_databaseinventory_credentials_id`),
  KEY `plugin_databaseinventory_credentials_id` (`plugin_databaseinventory_credentials_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_dataflows_dataflows`
--

DROP TABLE IF EXISTS `glpi_plugin_dataflows_dataflows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_dataflows_dataflows` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Internal ID',
  `entities_id` int(11) NOT NULL DEFAULT 0,
  `is_recursive` tinyint(1) NOT NULL DEFAULT 0,
  `name` varchar(45) NOT NULL COMMENT 'flow name (or code)',
  `plugin_dataflows_flowgroups_id` int(11) NOT NULL DEFAULT 0 COMMENT 'group name for similar flows ',
  `shortdescription` varchar(100) DEFAULT NULL,
  `longdescription` text DEFAULT NULL,
  `plugin_dataflows_types_id` int(11) NOT NULL DEFAULT 0 COMMENT 'flow type : low, medium, high ...',
  `plugin_dataflows_indicators_id` int(11) NOT NULL DEFAULT 0 COMMENT 'flow indicators : undocumented, documented ...',
  `plugin_dataflows_states_id` int(11) NOT NULL DEFAULT 0 COMMENT 'flow status : active, closed, in development ...',
  `statedate` timestamp NULL DEFAULT NULL COMMENT 'validity date of flow status',
  `plugin_dataflows_servicelevels_id` int(11) NOT NULL DEFAULT 0,
  `plugin_dataflows_modes_id` int(11) NOT NULL DEFAULT 0,
  `plugin_dataflows_patterns_id` int(11) NOT NULL DEFAULT 0,
  `plugin_dataflows_fromswcomponents_id` int(11) NOT NULL DEFAULT 0 COMMENT 'from swcomponent',
  `plugin_dataflows_toswcomponents_id` int(11) NOT NULL DEFAULT 0 COMMENT 'to swcomponent',
  `plugin_dataflows_fromexternal` varchar(100) DEFAULT NULL COMMENT 'from external address',
  `plugin_dataflows_toexternal` varchar(100) DEFAULT NULL COMMENT 'to external address',
  `plugin_dataflows_fromcredentials_id` int(11) NOT NULL DEFAULT 0,
  `plugin_dataflows_tocredentials_id` int(11) NOT NULL DEFAULT 0,
  `plugin_dataflows_fromauthtypes_id` int(11) NOT NULL DEFAULT 0 COMMENT 'source authentication type',
  `plugin_dataflows_toauthtypes_id` int(11) NOT NULL DEFAULT 0 COMMENT 'destination authentication type',
  `plugin_dataflows_triggertypes_id` int(11) NOT NULL DEFAULT 0,
  `triggerformat` varchar(100) DEFAULT NULL,
  `plugin_dataflows_transferfreqs_id` int(11) NOT NULL DEFAULT 0,
  `plugin_dataflows_transfertimetables_id` int(11) NOT NULL DEFAULT 0,
  `plugin_dataflows_holidayactions_id` int(11) NOT NULL DEFAULT 0,
  `transfervolume` varchar(45) DEFAULT NULL,
  `transferpriority` varchar(45) DEFAULT NULL,
  `plugin_dataflows_transferprotocols_id` int(11) NOT NULL DEFAULT 0,
  `plugin_dataflows_sourceconnectors_id` int(11) NOT NULL DEFAULT 0,
  `extractmethod` tinytext DEFAULT NULL,
  `srcformat` tinytext DEFAULT NULL,
  `plugin_dataflows_srcstructuretypes_id` int(11) NOT NULL DEFAULT 0 COMMENT 'source structure type',
  `srcstructure` mediumtext DEFAULT NULL,
  `plugin_dataflows_srcuris_id` int(11) NOT NULL DEFAULT 0,
  `plugin_dataflows_srcuri` varchar(100) DEFAULT NULL,
  `plugin_dataflows_srcpreprocs_id` int(11) NOT NULL DEFAULT 0,
  `plugin_dataflows_destinationconnectors_id` int(11) NOT NULL DEFAULT 0,
  `loadmethod` tinytext DEFAULT NULL,
  `destformat` tinytext DEFAULT NULL,
  `plugin_dataflows_deststructuretypes_id` int(11) NOT NULL DEFAULT 0 COMMENT 'destination structure type',
  `deststructure` mediumtext DEFAULT NULL,
  `plugin_dataflows_desturis_id` int(11) NOT NULL DEFAULT 0,
  `plugin_dataflows_desturi` varchar(100) DEFAULT NULL,
  `plugin_dataflows_destpostprocs_id` int(11) NOT NULL DEFAULT 0,
  `plugin_dataflows_errorhandlings_id` int(11) NOT NULL DEFAULT 0,
  `mappingdocurl` varchar(255) DEFAULT NULL,
  `technicaldocurl` varchar(255) DEFAULT NULL,
  `groups_id` int(11) NOT NULL DEFAULT 0 COMMENT 'data owner',
  `plugin_dataflows_othergroups_id` int(11) NOT NULL DEFAULT 0 COMMENT 'other group',
  `plugin_dataflows_supportgroups_id` int(11) NOT NULL DEFAULT 0 COMMENT 'other group',
  `users_id` int(11) NOT NULL DEFAULT 0 COMMENT 'technical maintainer',
  `plugin_dataflows_otherusers_id` int(11) NOT NULL DEFAULT 0 COMMENT 'other user',
  `is_helpdesk_visible` int(11) NOT NULL DEFAULT 1,
  `date_mod` timestamp NULL DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `flowname_UNIQUE` (`name`,`plugin_dataflows_transferprotocols_id`),
  KEY `entities_id` (`entities_id`),
  KEY `plugin_dataflows_flowgroups_id` (`plugin_dataflows_flowgroups_id`),
  KEY `plugin_dataflows_types_id` (`plugin_dataflows_types_id`),
  KEY `plugin_dataflows_indicators_id` (`plugin_dataflows_indicators_id`),
  KEY `plugin_dataflows_states_id` (`plugin_dataflows_states_id`),
  KEY `plugin_dataflows_servicelevels_id` (`plugin_dataflows_servicelevels_id`),
  KEY `plugin_dataflows_modes_id` (`plugin_dataflows_modes_id`),
  KEY `plugin_dataflows_patterns_id` (`plugin_dataflows_patterns_id`),
  KEY `plugin_dataflows_fromswcomponents_id` (`plugin_dataflows_fromswcomponents_id`),
  KEY `plugin_dataflows_toswcomponents_id` (`plugin_dataflows_toswcomponents_id`),
  KEY `plugin_dataflows_fromcredentials_id` (`plugin_dataflows_fromcredentials_id`),
  KEY `plugin_dataflows_tocredentials_id` (`plugin_dataflows_tocredentials_id`),
  KEY `plugin_dataflows_fromauthtypes_id` (`plugin_dataflows_fromauthtypes_id`),
  KEY `plugin_dataflows_toauthtypes_id` (`plugin_dataflows_toauthtypes_id`),
  KEY `plugin_dataflows_triggertypes_id` (`plugin_dataflows_triggertypes_id`),
  KEY `plugin_dataflows_transferfreqs_id` (`plugin_dataflows_transferfreqs_id`),
  KEY `plugin_dataflows_transfertimetables_id` (`plugin_dataflows_transfertimetables_id`),
  KEY `plugin_dataflows_holidayactions_id` (`plugin_dataflows_holidayactions_id`),
  KEY `plugin_dataflows_transferprotocols_id` (`plugin_dataflows_transferprotocols_id`),
  KEY `plugin_dataflows_sourceconnectors_id` (`plugin_dataflows_sourceconnectors_id`),
  KEY `plugin_dataflows_srcuris_id` (`plugin_dataflows_srcuris_id`),
  KEY `plugin_dataflows_srcstructuretypes_id` (`plugin_dataflows_srcstructuretypes_id`),
  KEY `plugin_dataflows_srcpreprocs_id` (`plugin_dataflows_srcpreprocs_id`),
  KEY `plugin_dataflows_destinationconnectors_id` (`plugin_dataflows_destinationconnectors_id`),
  KEY `plugin_dataflows_desturis_id` (`plugin_dataflows_desturis_id`),
  KEY `plugin_dataflows_deststructuretypes_id` (`plugin_dataflows_deststructuretypes_id`),
  KEY `plugin_dataflows_destpostprocs_id` (`plugin_dataflows_destpostprocs_id`),
  KEY `plugin_dataflows_errorhandlings_id` (`plugin_dataflows_errorhandlings_id`),
  KEY `groups_id` (`groups_id`),
  KEY `users_id` (`users_id`),
  KEY `plugin_dataflows_othergroups_id` (`plugin_dataflows_othergroups_id`),
  KEY `plugin_dataflows_supportgroups_id` (`plugin_dataflows_supportgroups_id`),
  KEY `plugin_dataflows_otherusers_id` (`plugin_dataflows_otherusers_id`),
  KEY `is_helpdesk_visible` (`is_helpdesk_visible`),
  KEY `is_deleted` (`is_deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_dataflows_dataflows_items`
--

DROP TABLE IF EXISTS `glpi_plugin_dataflows_dataflows_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_dataflows_dataflows_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plugin_dataflows_dataflows_id` int(11) NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_dataflows_dataflows (id)',
  `items_id` int(11) NOT NULL DEFAULT 0 COMMENT 'RELATION to various tables, according to itemtype (id)',
  `itemtype` varchar(100) NOT NULL COMMENT 'see .class.php file',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`plugin_dataflows_dataflows_id`,`items_id`,`itemtype`),
  KEY `FK_device` (`items_id`,`itemtype`),
  KEY `item` (`itemtype`,`items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `glpi_plugin_dataflows_destinationconnectors`
--

DROP TABLE IF EXISTS `glpi_plugin_dataflows_destinationconnectors`;
/*!50001 DROP VIEW IF EXISTS `glpi_plugin_dataflows_destinationconnectors`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `glpi_plugin_dataflows_destinationconnectors` AS SELECT 
 1 AS `id`,
 1 AS `name`,
 1 AS `comment`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `glpi_plugin_dataflows_flowgroups`
--

DROP TABLE IF EXISTS `glpi_plugin_dataflows_flowgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_dataflows_flowgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `comment` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `glpi_plugin_dataflows_flowgroup_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `glpi_plugin_dataflows_fromcredentials`
--

DROP TABLE IF EXISTS `glpi_plugin_dataflows_fromcredentials`;
/*!50001 DROP VIEW IF EXISTS `glpi_plugin_dataflows_fromcredentials`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `glpi_plugin_dataflows_fromcredentials` AS SELECT 
 1 AS `id`,
 1 AS `name`,
 1 AS `comment`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `glpi_plugin_dataflows_indicators`
--

DROP TABLE IF EXISTS `glpi_plugin_dataflows_indicators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_dataflows_indicators` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `comment` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `glpi_plugin_dataflows_indicators_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_dataflows_modes`
--

DROP TABLE IF EXISTS `glpi_plugin_dataflows_modes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_dataflows_modes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `comment` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `glpi_plugin_dataflows_mode_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_dataflows_patterns`
--

DROP TABLE IF EXISTS `glpi_plugin_dataflows_patterns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_dataflows_patterns` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `comment` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `glpi_plugin_dataflows_pattern_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_dataflows_servicelevels`
--

DROP TABLE IF EXISTS `glpi_plugin_dataflows_servicelevels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_dataflows_servicelevels` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `comment` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `glpi_plugin_dataflows_servicelevel_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_dataflows_sourceconnectors`
--

DROP TABLE IF EXISTS `glpi_plugin_dataflows_sourceconnectors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_dataflows_sourceconnectors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `comment` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `glpi_plugin_dataflows_sourceconnector_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_dataflows_states`
--

DROP TABLE IF EXISTS `glpi_plugin_dataflows_states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_dataflows_states` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `comment` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `glpi_plugin_dataflows_states_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `glpi_plugin_dataflows_tocredentials`
--

DROP TABLE IF EXISTS `glpi_plugin_dataflows_tocredentials`;
/*!50001 DROP VIEW IF EXISTS `glpi_plugin_dataflows_tocredentials`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `glpi_plugin_dataflows_tocredentials` AS SELECT 
 1 AS `id`,
 1 AS `name`,
 1 AS `comment`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `glpi_plugin_dataflows_transferprotocols`
--

DROP TABLE IF EXISTS `glpi_plugin_dataflows_transferprotocols`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_dataflows_transferprotocols` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `comment` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `glpi_plugin_dataflows_transferprotocol_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_dataflows_types`
--

DROP TABLE IF EXISTS `glpi_plugin_dataflows_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_dataflows_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `comment` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `glpi_plugin_dataflows_types_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_datainjection_infos`
--

DROP TABLE IF EXISTS `glpi_plugin_datainjection_infos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_datainjection_infos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `models_id` int(10) unsigned NOT NULL,
  `itemtype` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL,
  `is_mandatory` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_datainjection_mappings`
--

DROP TABLE IF EXISTS `glpi_plugin_datainjection_mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_datainjection_mappings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `models_id` int(10) unsigned NOT NULL,
  `itemtype` varchar(255) NOT NULL DEFAULT '',
  `rank` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  `is_mandatory` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_datainjection_modelcsvs`
--

DROP TABLE IF EXISTS `glpi_plugin_datainjection_modelcsvs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_datainjection_modelcsvs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `models_id` int(10) unsigned NOT NULL,
  `itemtype` varchar(255) NOT NULL DEFAULT '',
  `delimiter` varchar(1) NOT NULL DEFAULT ';',
  `is_header_present` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_datainjection_models`
--

DROP TABLE IF EXISTS `glpi_plugin_datainjection_models`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_datainjection_models` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `filetype` varchar(255) NOT NULL DEFAULT 'csv',
  `itemtype` varchar(255) NOT NULL DEFAULT '',
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `behavior_add` tinyint(4) NOT NULL DEFAULT 1,
  `behavior_update` tinyint(4) NOT NULL DEFAULT 0,
  `can_add_dropdown` tinyint(4) NOT NULL DEFAULT 0,
  `can_overwrite_if_not_empty` int(11) NOT NULL DEFAULT 1,
  `is_private` tinyint(4) NOT NULL DEFAULT 1,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `users_id` int(10) unsigned NOT NULL,
  `date_format` varchar(11) NOT NULL DEFAULT 'yyyy-mm-dd',
  `float_format` tinyint(4) NOT NULL DEFAULT 0,
  `port_unicity` tinyint(4) NOT NULL DEFAULT 0,
  `step` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_escalade_configs`
--

DROP TABLE IF EXISTS `glpi_plugin_escalade_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_escalade_configs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `remove_group` int(11) NOT NULL,
  `show_history` int(11) NOT NULL,
  `task_history` int(11) NOT NULL,
  `remove_tech` int(11) NOT NULL,
  `solve_return_group` int(11) NOT NULL,
  `reassign_group_from_cat` int(11) NOT NULL,
  `reassign_tech_from_cat` int(11) NOT NULL,
  `cloneandlink_ticket` int(11) NOT NULL,
  `close_linkedtickets` int(11) NOT NULL,
  `assign_me_as_observer` int(11) NOT NULL,
  `use_assign_user_group` int(11) NOT NULL,
  `use_assign_user_group_creation` int(11) NOT NULL,
  `use_assign_user_group_modification` int(11) NOT NULL,
  `remove_delete_requester_user_btn` tinyint(4) NOT NULL DEFAULT 1,
  `remove_delete_watcher_user_btn` tinyint(4) NOT NULL DEFAULT 1,
  `remove_delete_assign_user_btn` tinyint(4) NOT NULL DEFAULT 0,
  `remove_delete_requester_group_btn` tinyint(4) NOT NULL DEFAULT 1,
  `remove_delete_watcher_group_btn` tinyint(4) NOT NULL DEFAULT 1,
  `remove_delete_assign_group_btn` tinyint(4) NOT NULL DEFAULT 0,
  `remove_delete_assign_supplier_btn` tinyint(4) NOT NULL DEFAULT 1,
  `use_filter_assign_group` int(11) NOT NULL,
  `ticket_last_status` int(11) DEFAULT NULL,
  `remove_requester` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_escalade_groups_groups`
--

DROP TABLE IF EXISTS `glpi_plugin_escalade_groups_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_escalade_groups_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `groups_id_source` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id_destination` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_escalade_histories`
--

DROP TABLE IF EXISTS `glpi_plugin_escalade_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_escalade_histories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tickets_id` int(10) unsigned NOT NULL,
  `groups_id` int(10) unsigned NOT NULL,
  `counter` int(11) NOT NULL DEFAULT 0,
  `date_mod` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `groups_id_previous` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `tickets_id` (`tickets_id`),
  KEY `groups_id` (`groups_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_escalade_users`
--

DROP TABLE IF EXISTS `glpi_plugin_escalade_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_escalade_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `users_id` int(10) unsigned NOT NULL,
  `use_filter_assign_group` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `users_id` (`users_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_fields_containerdisplayconditions`
--

DROP TABLE IF EXISTS `glpi_plugin_fields_containerdisplayconditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_fields_containerdisplayconditions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_fields_containers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) DEFAULT NULL,
  `search_option` varchar(255) DEFAULT NULL,
  `condition` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `is_visible` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `plugin_fields_containers_id_itemtype` (`plugin_fields_containers_id`,`itemtype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_fields_containers`
--

DROP TABLE IF EXISTS `glpi_plugin_fields_containers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_fields_containers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `itemtypes` longtext DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `subtype` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `is_active` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `entities_id` (`entities_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_fields_fields`
--

DROP TABLE IF EXISTS `glpi_plugin_fields_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_fields_fields` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `plugin_fields_containers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `ranking` int(11) NOT NULL DEFAULT 0,
  `default_value` longtext DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 1,
  `is_readonly` tinyint(4) NOT NULL DEFAULT 1,
  `mandatory` tinyint(4) NOT NULL DEFAULT 0,
  `multiple` tinyint(4) NOT NULL DEFAULT 0,
  `allowed_values` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plugin_fields_containers_id` (`plugin_fields_containers_id`),
  KEY `is_active` (`is_active`),
  KEY `is_readonly` (`is_readonly`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_fields_labeltranslations`
--

DROP TABLE IF EXISTS `glpi_plugin_fields_labeltranslations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_fields_labeltranslations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `itemtype` varchar(30) NOT NULL,
  `items_id` int(10) unsigned NOT NULL,
  `language` varchar(5) NOT NULL,
  `label` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`itemtype`,`items_id`,`language`),
  KEY `itemtype` (`itemtype`),
  KEY `items_id` (`items_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_fields_oficinafielddropdowns`
--

DROP TABLE IF EXISTS `glpi_plugin_fields_oficinafielddropdowns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_fields_oficinafielddropdowns` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `completename` text DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `plugin_fields_oficinafielddropdowns_id` int(10) unsigned DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `ancestors_cache` text DEFAULT NULL,
  `sons_cache` text DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `plugin_fields_oficinafielddropdowns_id` (`plugin_fields_oficinafielddropdowns_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_fields_profiles`
--

DROP TABLE IF EXISTS `glpi_plugin_fields_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_fields_profiles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `profiles_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_fields_containers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `right` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `profiles_id` (`profiles_id`),
  KEY `plugin_fields_containers_id` (`plugin_fields_containers_id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_fields_statusoverrides`
--

DROP TABLE IF EXISTS `glpi_plugin_fields_statusoverrides`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_fields_statusoverrides` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_fields_fields_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) DEFAULT NULL,
  `states` varchar(255) DEFAULT NULL,
  `is_readonly` tinyint(4) NOT NULL DEFAULT 1,
  `mandatory` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `plugin_fields_fields_id` (`plugin_fields_fields_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_fields_ticketoficinas`
--

DROP TABLE IF EXISTS `glpi_plugin_fields_ticketoficinas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_fields_ticketoficinas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `items_id` int(10) unsigned NOT NULL,
  `itemtype` varchar(255) DEFAULT 'Ticket',
  `plugin_fields_containers_id` int(10) unsigned NOT NULL DEFAULT 6,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_fields_oficinafielddropdowns_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `itemtype_item_container` (`itemtype`,`items_id`,`plugin_fields_containers_id`),
  KEY `entities_id` (`entities_id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_financialreports_configs`
--

DROP TABLE IF EXISTS `glpi_plugin_financialreports_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_financialreports_configs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_states (id)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_financialreports_parameters`
--

DROP TABLE IF EXISTS `glpi_plugin_financialreports_parameters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_financialreports_parameters` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `computers_otherserial` varchar(255) DEFAULT NULL,
  `notebooks_otherserial` varchar(255) DEFAULT NULL,
  `servers_otherserial` varchar(255) DEFAULT NULL,
  `monitors_otherserial` varchar(255) DEFAULT NULL,
  `printers_otherserial` varchar(255) DEFAULT NULL,
  `peripherals_otherserial` varchar(255) DEFAULT NULL,
  `networkequipments_otherserial` varchar(255) DEFAULT NULL,
  `phones_otherserial` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_formcreator_answers`
--

DROP TABLE IF EXISTS `glpi_plugin_formcreator_answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_formcreator_answers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_formcreator_formanswers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_formcreator_questions_id` int(10) unsigned NOT NULL DEFAULT 0,
  `answer` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plugin_formcreator_formanswers_id` (`plugin_formcreator_formanswers_id`),
  KEY `plugin_formcreator_questions_id` (`plugin_formcreator_questions_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_formcreator_categories`
--

DROP TABLE IF EXISTS `glpi_plugin_formcreator_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_formcreator_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `comment` mediumtext DEFAULT NULL,
  `completename` varchar(255) DEFAULT NULL,
  `plugin_formcreator_categories_id` int(10) unsigned NOT NULL DEFAULT 0,
  `level` int(11) NOT NULL DEFAULT 1,
  `sons_cache` longtext DEFAULT NULL,
  `ancestors_cache` longtext DEFAULT NULL,
  `knowbaseitemcategories_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `knowbaseitemcategories_id` (`knowbaseitemcategories_id`),
  KEY `plugin_formcreator_categories_id` (`plugin_formcreator_categories_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_formcreator_conditions`
--

DROP TABLE IF EXISTS `glpi_plugin_formcreator_conditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_formcreator_conditions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `itemtype` varchar(255) NOT NULL DEFAULT '' COMMENT 'itemtype of the item affected by the condition',
  `items_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'item ID of the item affected by the condition',
  `plugin_formcreator_questions_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'question to test for the condition',
  `show_condition` int(11) NOT NULL DEFAULT 0,
  `show_value` mediumtext DEFAULT NULL,
  `show_logic` int(11) NOT NULL DEFAULT 1,
  `order` int(11) NOT NULL DEFAULT 1,
  `uuid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `item` (`itemtype`,`items_id`),
  KEY `plugin_formcreator_questions_id` (`plugin_formcreator_questions_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_formcreator_entityconfigs`
--

DROP TABLE IF EXISTS `glpi_plugin_formcreator_entityconfigs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_formcreator_entityconfigs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `replace_helpdesk` int(11) NOT NULL DEFAULT -2,
  `default_form_list_mode` int(11) NOT NULL DEFAULT -2,
  `sort_order` int(11) NOT NULL DEFAULT -2,
  `is_kb_separated` int(11) NOT NULL DEFAULT -2,
  `is_search_visible` int(11) NOT NULL DEFAULT -2,
  `is_dashboard_visible` int(11) NOT NULL DEFAULT -2,
  `is_header_visible` int(11) NOT NULL DEFAULT -2,
  `is_search_issue_visible` int(11) NOT NULL DEFAULT -2,
  `tile_design` int(11) NOT NULL DEFAULT -2,
  `header` text DEFAULT NULL,
  `service_catalog_home` int(11) NOT NULL DEFAULT -2,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`entities_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_formcreator_forms`
--

DROP TABLE IF EXISTS `glpi_plugin_formcreator_forms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_formcreator_forms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(1) NOT NULL DEFAULT 0,
  `icon` varchar(255) NOT NULL DEFAULT '',
  `icon_color` varchar(255) NOT NULL DEFAULT '',
  `background_color` varchar(255) NOT NULL DEFAULT '',
  `access_rights` tinyint(1) NOT NULL DEFAULT 1,
  `description` varchar(255) DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  `plugin_formcreator_categories_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 0,
  `language` varchar(255) NOT NULL DEFAULT '',
  `helpdesk_home` tinyint(1) NOT NULL DEFAULT 0,
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0,
  `validation_required` tinyint(1) NOT NULL DEFAULT 0,
  `usage_count` int(11) NOT NULL DEFAULT 0,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `is_captcha_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `show_rule` int(11) NOT NULL DEFAULT 1 COMMENT 'Conditions setting to show the submit button',
  `formanswer_name` varchar(255) NOT NULL DEFAULT '',
  `is_visible` tinyint(4) NOT NULL DEFAULT 1,
  `uuid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entities_id` (`entities_id`),
  KEY `plugin_formcreator_categories_id` (`plugin_formcreator_categories_id`),
  FULLTEXT KEY `Search` (`name`,`description`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_formcreator_forms_groups`
--

DROP TABLE IF EXISTS `glpi_plugin_formcreator_forms_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_formcreator_forms_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_formcreator_forms_id` int(10) unsigned NOT NULL,
  `groups_id` int(10) unsigned NOT NULL,
  `uuid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`plugin_formcreator_forms_id`,`groups_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_formcreator_forms_languages`
--

DROP TABLE IF EXISTS `glpi_plugin_formcreator_forms_languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_formcreator_forms_languages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_formcreator_forms_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `uuid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_formcreator_forms_profiles`
--

DROP TABLE IF EXISTS `glpi_plugin_formcreator_forms_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_formcreator_forms_profiles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_formcreator_forms_id` int(10) unsigned NOT NULL DEFAULT 0,
  `profiles_id` int(10) unsigned NOT NULL DEFAULT 0,
  `uuid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`plugin_formcreator_forms_id`,`profiles_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_formcreator_forms_users`
--

DROP TABLE IF EXISTS `glpi_plugin_formcreator_forms_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_formcreator_forms_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_formcreator_forms_id` int(10) unsigned NOT NULL,
  `users_id` int(10) unsigned NOT NULL,
  `uuid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`plugin_formcreator_forms_id`,`users_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_formcreator_forms_validators`
--

DROP TABLE IF EXISTS `glpi_plugin_formcreator_forms_validators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_formcreator_forms_validators` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_formcreator_forms_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(255) NOT NULL DEFAULT '',
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `uuid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`plugin_formcreator_forms_id`,`itemtype`,`items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_formcreator_issues`
--

DROP TABLE IF EXISTS `glpi_plugin_formcreator_issues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_formcreator_issues` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `display_id` varchar(255) NOT NULL,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(255) NOT NULL DEFAULT '',
  `status` varchar(255) NOT NULL DEFAULT '',
  `date_creation` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(1) NOT NULL DEFAULT 0,
  `requester_id` int(10) unsigned NOT NULL DEFAULT 0,
  `comment` longtext DEFAULT NULL,
  `users_id_recipient` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `item` (`itemtype`,`items_id`),
  KEY `entities_id` (`entities_id`),
  KEY `requester_id` (`requester_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_formcreator_items_targettickets`
--

DROP TABLE IF EXISTS `glpi_plugin_formcreator_items_targettickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_formcreator_items_targettickets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_formcreator_targettickets_id` int(10) unsigned NOT NULL DEFAULT 0,
  `link` int(11) NOT NULL DEFAULT 0,
  `itemtype` varchar(255) NOT NULL DEFAULT '',
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `uuid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plugin_formcreator_targettickets_id` (`plugin_formcreator_targettickets_id`),
  KEY `item` (`itemtype`,`items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_formcreator_questiondependencies`
--

DROP TABLE IF EXISTS `glpi_plugin_formcreator_questiondependencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_formcreator_questiondependencies` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_formcreator_questions_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_formcreator_questions_id_2` int(10) unsigned NOT NULL DEFAULT 0,
  `fieldname` varchar(255) DEFAULT NULL,
  `uuid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plugin_formcreator_questions_id` (`plugin_formcreator_questions_id`),
  KEY `plugin_formcreator_questions_id_2` (`plugin_formcreator_questions_id_2`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_formcreator_questionranges`
--

DROP TABLE IF EXISTS `glpi_plugin_formcreator_questionranges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_formcreator_questionranges` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_formcreator_questions_id` int(10) unsigned NOT NULL DEFAULT 0,
  `range_min` varchar(255) DEFAULT NULL,
  `range_max` varchar(255) DEFAULT NULL,
  `fieldname` varchar(255) DEFAULT NULL,
  `uuid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plugin_formcreator_questions_id` (`plugin_formcreator_questions_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_formcreator_questionregexes`
--

DROP TABLE IF EXISTS `glpi_plugin_formcreator_questionregexes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_formcreator_questionregexes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_formcreator_questions_id` int(10) unsigned NOT NULL DEFAULT 0,
  `regex` mediumtext DEFAULT NULL,
  `fieldname` varchar(255) DEFAULT NULL,
  `uuid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plugin_formcreator_questions_id` (`plugin_formcreator_questions_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_formcreator_questions`
--

DROP TABLE IF EXISTS `glpi_plugin_formcreator_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_formcreator_questions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `plugin_formcreator_sections_id` int(10) unsigned NOT NULL DEFAULT 0,
  `fieldtype` varchar(30) NOT NULL DEFAULT 'text',
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `show_empty` tinyint(1) NOT NULL DEFAULT 0,
  `default_values` mediumtext DEFAULT NULL,
  `itemtype` varchar(255) NOT NULL DEFAULT '' COMMENT 'itemtype used for glpi objects and dropdown question types',
  `values` mediumtext DEFAULT NULL,
  `description` mediumtext DEFAULT NULL,
  `row` int(11) NOT NULL DEFAULT 0,
  `col` int(11) NOT NULL DEFAULT 0,
  `width` int(11) NOT NULL DEFAULT 0,
  `show_rule` int(11) NOT NULL DEFAULT 1,
  `uuid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plugin_formcreator_sections_id` (`plugin_formcreator_sections_id`),
  FULLTEXT KEY `Search` (`name`,`description`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_formcreator_sections`
--

DROP TABLE IF EXISTS `glpi_plugin_formcreator_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_formcreator_sections` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `plugin_formcreator_forms_id` int(10) unsigned NOT NULL DEFAULT 0,
  `order` int(11) NOT NULL DEFAULT 0,
  `show_rule` int(11) NOT NULL DEFAULT 1,
  `uuid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plugin_formcreator_forms_id` (`plugin_formcreator_forms_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_formcreator_targetchanges`
--

DROP TABLE IF EXISTS `glpi_plugin_formcreator_targetchanges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_formcreator_targetchanges` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `plugin_formcreator_forms_id` int(10) unsigned NOT NULL DEFAULT 0,
  `target_name` varchar(255) NOT NULL DEFAULT '',
  `content` longtext DEFAULT NULL,
  `impactcontent` longtext DEFAULT NULL,
  `controlistcontent` longtext DEFAULT NULL,
  `rolloutplancontent` longtext DEFAULT NULL,
  `backoutplancontent` longtext DEFAULT NULL,
  `checklistcontent` longtext DEFAULT NULL,
  `due_date_rule` int(11) NOT NULL DEFAULT 1,
  `due_date_question` int(10) unsigned NOT NULL DEFAULT 0,
  `due_date_value` tinyint(4) DEFAULT NULL,
  `due_date_period` int(11) NOT NULL DEFAULT 0,
  `urgency_rule` int(11) NOT NULL DEFAULT 1,
  `urgency_question` int(10) unsigned NOT NULL DEFAULT 0,
  `validation_followup` tinyint(1) NOT NULL DEFAULT 1,
  `destination_entity` int(11) NOT NULL DEFAULT 1,
  `destination_entity_value` int(10) unsigned NOT NULL DEFAULT 0,
  `tag_type` int(11) NOT NULL DEFAULT 1,
  `tag_questions` varchar(255) NOT NULL DEFAULT '',
  `tag_specifics` varchar(255) NOT NULL DEFAULT '',
  `category_rule` int(11) NOT NULL DEFAULT 1,
  `category_question` int(10) unsigned NOT NULL DEFAULT 0,
  `commonitil_validation_rule` int(11) NOT NULL DEFAULT 1,
  `commonitil_validation_question` varchar(255) DEFAULT NULL,
  `show_rule` int(11) NOT NULL DEFAULT 1,
  `sla_rule` int(11) NOT NULL DEFAULT 1,
  `sla_question_tto` int(10) unsigned NOT NULL DEFAULT 0,
  `sla_question_ttr` int(10) unsigned NOT NULL DEFAULT 0,
  `ola_rule` int(11) NOT NULL DEFAULT 1,
  `ola_question_tto` int(10) unsigned NOT NULL DEFAULT 0,
  `ola_question_ttr` int(10) unsigned NOT NULL DEFAULT 0,
  `uuid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_formcreator_targetproblems`
--

DROP TABLE IF EXISTS `glpi_plugin_formcreator_targetproblems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_formcreator_targetproblems` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `plugin_formcreator_forms_id` int(10) unsigned NOT NULL DEFAULT 0,
  `target_name` varchar(255) NOT NULL DEFAULT '',
  `problemtemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `content` longtext DEFAULT NULL,
  `impactcontent` longtext DEFAULT NULL,
  `causecontent` longtext DEFAULT NULL,
  `symptomcontent` longtext DEFAULT NULL,
  `urgency_rule` int(11) NOT NULL DEFAULT 1,
  `urgency_question` int(10) unsigned NOT NULL DEFAULT 0,
  `destination_entity` int(11) NOT NULL DEFAULT 1,
  `destination_entity_value` int(10) unsigned NOT NULL DEFAULT 0,
  `tag_type` int(11) NOT NULL DEFAULT 1,
  `tag_questions` varchar(255) NOT NULL DEFAULT '',
  `tag_specifics` varchar(255) NOT NULL DEFAULT '',
  `category_rule` int(11) NOT NULL DEFAULT 1,
  `category_question` int(10) unsigned NOT NULL DEFAULT 0,
  `show_rule` int(11) NOT NULL DEFAULT 1,
  `uuid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `problemtemplates_id` (`problemtemplates_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_formcreator_targets_actors`
--

DROP TABLE IF EXISTS `glpi_plugin_formcreator_targets_actors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_formcreator_targets_actors` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `itemtype` varchar(255) DEFAULT NULL,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `actor_role` int(11) NOT NULL DEFAULT 1,
  `actor_type` int(11) NOT NULL DEFAULT 1,
  `actor_value` int(10) unsigned NOT NULL DEFAULT 0,
  `use_notification` tinyint(1) NOT NULL DEFAULT 1,
  `uuid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `item` (`itemtype`,`items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_formcreator_targettickets`
--

DROP TABLE IF EXISTS `glpi_plugin_formcreator_targettickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_formcreator_targettickets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `plugin_formcreator_forms_id` int(10) unsigned NOT NULL DEFAULT 0,
  `target_name` varchar(255) NOT NULL DEFAULT '',
  `type_question` int(10) unsigned NOT NULL DEFAULT 0,
  `source_rule` int(11) NOT NULL DEFAULT 0,
  `source_question` int(11) NOT NULL DEFAULT 0,
  `type_rule` int(11) NOT NULL DEFAULT 0,
  `tickettemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `content` longtext DEFAULT NULL,
  `due_date_rule` int(11) NOT NULL DEFAULT 1,
  `due_date_question` int(10) unsigned NOT NULL DEFAULT 0,
  `due_date_value` tinyint(4) DEFAULT NULL,
  `due_date_period` int(11) NOT NULL DEFAULT 0,
  `urgency_rule` int(11) NOT NULL DEFAULT 1,
  `urgency_question` int(10) unsigned NOT NULL DEFAULT 0,
  `validation_followup` tinyint(1) NOT NULL DEFAULT 1,
  `destination_entity` int(11) NOT NULL DEFAULT 1,
  `destination_entity_value` int(10) unsigned NOT NULL DEFAULT 0,
  `tag_type` int(11) NOT NULL DEFAULT 1,
  `tag_questions` varchar(255) NOT NULL DEFAULT '',
  `tag_specifics` varchar(255) NOT NULL DEFAULT '',
  `category_rule` int(11) NOT NULL DEFAULT 1,
  `category_question` int(10) unsigned NOT NULL DEFAULT 0,
  `associate_rule` int(11) NOT NULL DEFAULT 1,
  `associate_question` int(10) unsigned NOT NULL DEFAULT 0,
  `location_rule` int(11) NOT NULL DEFAULT 1,
  `location_question` int(10) unsigned NOT NULL DEFAULT 0,
  `commonitil_validation_rule` int(11) NOT NULL DEFAULT 1,
  `commonitil_validation_question` varchar(255) DEFAULT NULL,
  `show_rule` int(11) NOT NULL DEFAULT 1,
  `sla_rule` int(11) NOT NULL DEFAULT 1,
  `sla_question_tto` int(10) unsigned NOT NULL DEFAULT 0,
  `sla_question_ttr` int(10) unsigned NOT NULL DEFAULT 0,
  `ola_rule` int(11) NOT NULL DEFAULT 1,
  `ola_question_tto` int(10) unsigned NOT NULL DEFAULT 0,
  `ola_question_ttr` int(10) unsigned NOT NULL DEFAULT 0,
  `uuid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tickettemplates_id` (`tickettemplates_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_gappessentials_configs`
--

DROP TABLE IF EXISTS `glpi_plugin_gappessentials_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_gappessentials_configs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `requesttypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_gdrive_configs`
--

DROP TABLE IF EXISTS `glpi_plugin_gdrive_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_gdrive_configs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `developer_key` varchar(250) NOT NULL DEFAULT 'xxxxxxxYYYYYYYY-12345678',
  `client_id` varchar(250) NOT NULL DEFAULT '1234567890-abcdefghijklmnopqrstuvwxyz.apps.googleusercontent.com',
  `app_id` varchar(50) NOT NULL DEFAULT '1234567890',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_genericobject_typefamilies`
--

DROP TABLE IF EXISTS `glpi_plugin_genericobject_typefamilies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_genericobject_typefamilies` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_genericobject_types`
--

DROP TABLE IF EXISTS `glpi_plugin_genericobject_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_genericobject_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(255) DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `use_global_search` tinyint(4) NOT NULL DEFAULT 0,
  `use_unicity` tinyint(4) NOT NULL DEFAULT 0,
  `use_history` tinyint(4) NOT NULL DEFAULT 0,
  `use_infocoms` tinyint(4) NOT NULL DEFAULT 0,
  `use_contracts` tinyint(4) NOT NULL DEFAULT 0,
  `use_documents` tinyint(4) NOT NULL DEFAULT 0,
  `use_tickets` tinyint(4) NOT NULL DEFAULT 0,
  `use_links` tinyint(4) NOT NULL DEFAULT 0,
  `use_loans` tinyint(4) NOT NULL DEFAULT 0,
  `use_network_ports` tinyint(4) NOT NULL DEFAULT 0,
  `use_direct_connections` tinyint(4) NOT NULL DEFAULT 0,
  `use_plugin_datainjection` tinyint(4) NOT NULL DEFAULT 0,
  `use_plugin_pdf` tinyint(4) NOT NULL DEFAULT 0,
  `use_plugin_order` tinyint(4) NOT NULL DEFAULT 0,
  `use_plugin_uninstall` tinyint(4) NOT NULL DEFAULT 0,
  `use_plugin_geninventorynumber` tinyint(4) NOT NULL DEFAULT 0,
  `use_menu_entry` tinyint(4) NOT NULL DEFAULT 0,
  `use_projects` tinyint(4) NOT NULL DEFAULT 0,
  `linked_itemtypes` text DEFAULT NULL,
  `plugin_genericobject_typefamilies_id` int(10) unsigned NOT NULL DEFAULT 0,
  `use_itemdevices` tinyint(4) NOT NULL DEFAULT 0,
  `impact_icon` varchar(255) DEFAULT NULL,
  `use_notepad` tinyint(4) NOT NULL DEFAULT 0,
  `use_plugin_simcard` tinyint(4) NOT NULL DEFAULT 0,
  `use_plugin_treeview` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_geninventorynumber_configfields`
--

DROP TABLE IF EXISTS `glpi_plugin_geninventorynumber_configfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_geninventorynumber_configfields` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_geninventorynumber_configs_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(255) DEFAULT '',
  `template` varchar(255) DEFAULT '',
  `is_active` tinyint(4) NOT NULL DEFAULT 0,
  `use_index` tinyint(4) NOT NULL DEFAULT 0,
  `index` bigint(20) NOT NULL DEFAULT 0,
  `date_last_generated` timestamp NULL DEFAULT NULL,
  `auto_reset_method` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_geninventorynumber_configs`
--

DROP TABLE IF EXISTS `glpi_plugin_geninventorynumber_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_geninventorynumber_configs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT '',
  `is_active` tinyint(4) NOT NULL DEFAULT 0,
  `index` int(11) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `date_last_generated` timestamp NULL DEFAULT NULL,
  `auto_reset_method` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_geststock_configs`
--

DROP TABLE IF EXISTS `glpi_plugin_geststock_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_geststock_configs` (
  `id` int(11) NOT NULL,
  `entities_id_stock` int(11) DEFAULT NULL,
  `stock_status` int(11) DEFAULT NULL,
  `transit_status` int(11) DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `users_id` int(11) DEFAULT NULL,
  `criterion` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `users_id` (`users_id`),
  KEY `entities_id_stock` (`entities_id_stock`),
  KEY `stock_status` (`stock_status`),
  KEY `transit_status` (`transit_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_geststock_followups`
--

DROP TABLE IF EXISTS `glpi_plugin_geststock_followups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_geststock_followups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plugin_geststock_reservations_id` int(11) DEFAULT NULL,
  `plugin_geststock_reservations_items_id` int(11) DEFAULT NULL,
  `locations_id_old` int(11) DEFAULT NULL,
  `locations_id_new` int(11) DEFAULT NULL,
  `users_id` int(11) DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plugin_geststock_reservations_id` (`plugin_geststock_reservations_id`),
  KEY `plugin_geststock_reservations_items_id` (`plugin_geststock_reservations_items_id`),
  KEY `locations_id_old` (`locations_id_old`),
  KEY `locations_id_new` (`locations_id_new`),
  KEY `users_id` (`users_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_geststock_reservations`
--

DROP TABLE IF EXISTS `glpi_plugin_geststock_reservations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_geststock_reservations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `users_id` int(11) DEFAULT NULL,
  `entities_id_deliv` int(11) DEFAULT NULL,
  `locations_id` int(11) DEFAULT NULL,
  `tickets_id` int(11) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `comment` text DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0,
  `date_reserv` timestamp NULL DEFAULT NULL,
  `date_whished` timestamp NULL DEFAULT NULL,
  `receipt_date` timestamp NULL DEFAULT NULL,
  `date_tova` timestamp NULL DEFAULT NULL,
  `number_tova` varchar(255) DEFAULT NULL,
  `type_tova` int(11) DEFAULT NULL,
  `number_package` int(11) DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`entities_id_deliv`,`tickets_id`),
  KEY `users_id` (`users_id`),
  KEY `entities_id_deliv` (`entities_id_deliv`),
  KEY `locations_id` (`locations_id`),
  KEY `tickets_id` (`tickets_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_geststock_reservations_items`
--

DROP TABLE IF EXISTS `glpi_plugin_geststock_reservations_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_geststock_reservations_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plugin_geststock_reservations_id` int(11) DEFAULT NULL,
  `itemtype` varchar(100) NOT NULL,
  `models_id` int(11) NOT NULL DEFAULT 0,
  `nbrereserv` int(11) DEFAULT NULL,
  `locations_id_stock` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`plugin_geststock_reservations_id`,`models_id`,`itemtype`,`locations_id_stock`),
  KEY `plugin_geststock_reservations_id` (`plugin_geststock_reservations_id`),
  KEY `item` (`itemtype`,`models_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_geststock_reservations_items_numbers`
--

DROP TABLE IF EXISTS `glpi_plugin_geststock_reservations_items_numbers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_geststock_reservations_items_numbers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plugin_geststock_reservations_items_id` int(11) DEFAULT NULL,
  `itemtype` varchar(100) DEFAULT NULL,
  `models_id` int(11) DEFAULT NULL,
  `locations_id_stock` int(11) DEFAULT NULL,
  `otherserial` text DEFAULT NULL,
  `users_id` int(11) DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plugin_geststock_reservations_items_id` (`plugin_geststock_reservations_items_id`),
  KEY `users_id` (`users_id`),
  KEY `item` (`itemtype`,`models_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_geststock_specifications`
--

DROP TABLE IF EXISTS `glpi_plugin_geststock_specifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_geststock_specifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `models_id` int(11) NOT NULL DEFAULT 0,
  `itemtype` varchar(100) NOT NULL,
  `length` int(11) DEFAULT NULL,
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `weight` decimal(6,3) NOT NULL DEFAULT 0.000,
  `volume` float DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`models_id`,`itemtype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_glpiinventory_agentmodules`
--

DROP TABLE IF EXISTS `glpi_plugin_glpiinventory_agentmodules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_glpiinventory_agentmodules` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `modulename` varchar(255) DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 0,
  `exceptions` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `modulename` (`modulename`),
  KEY `is_active` (`is_active`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_glpiinventory_collects`
--

DROP TABLE IF EXISTS `glpi_plugin_glpiinventory_collects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_glpiinventory_collects` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `type` varchar(255) DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_glpiinventory_collects_files`
--

DROP TABLE IF EXISTS `glpi_plugin_glpiinventory_collects_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_glpiinventory_collects_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `plugin_glpiinventory_collects_id` int(10) unsigned NOT NULL DEFAULT 0,
  `dir` varchar(255) DEFAULT NULL,
  `limit` int(11) NOT NULL DEFAULT 50,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `filter_regex` varchar(255) DEFAULT NULL,
  `filter_sizeequals` int(11) NOT NULL DEFAULT 0,
  `filter_sizegreater` int(11) NOT NULL DEFAULT 0,
  `filter_sizelower` int(11) NOT NULL DEFAULT 0,
  `filter_checksumsha512` varchar(255) DEFAULT NULL,
  `filter_checksumsha2` varchar(255) DEFAULT NULL,
  `filter_name` varchar(255) DEFAULT NULL,
  `filter_iname` varchar(255) DEFAULT NULL,
  `filter_is_file` tinyint(4) NOT NULL DEFAULT 1,
  `filter_is_dir` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_glpiinventory_collects_files_contents`
--

DROP TABLE IF EXISTS `glpi_plugin_glpiinventory_collects_files_contents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_glpiinventory_collects_files_contents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `computers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_glpiinventory_collects_files_id` int(10) unsigned NOT NULL DEFAULT 0,
  `pathfile` text DEFAULT NULL,
  `size` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_glpiinventory_collects_registries`
--

DROP TABLE IF EXISTS `glpi_plugin_glpiinventory_collects_registries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_glpiinventory_collects_registries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `plugin_glpiinventory_collects_id` int(10) unsigned NOT NULL DEFAULT 0,
  `hive` varchar(255) DEFAULT NULL,
  `path` text DEFAULT NULL,
  `key` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_glpiinventory_collects_registries_contents`
--

DROP TABLE IF EXISTS `glpi_plugin_glpiinventory_collects_registries_contents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_glpiinventory_collects_registries_contents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `computers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_glpiinventory_collects_registries_id` int(10) unsigned NOT NULL DEFAULT 0,
  `key` varchar(255) DEFAULT NULL,
  `value` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `computers_id` (`computers_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_glpiinventory_collects_wmis`
--

DROP TABLE IF EXISTS `glpi_plugin_glpiinventory_collects_wmis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_glpiinventory_collects_wmis` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `plugin_glpiinventory_collects_id` int(10) unsigned NOT NULL DEFAULT 0,
  `moniker` varchar(255) DEFAULT NULL,
  `class` varchar(255) DEFAULT NULL,
  `properties` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_glpiinventory_collects_wmis_contents`
--

DROP TABLE IF EXISTS `glpi_plugin_glpiinventory_collects_wmis_contents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_glpiinventory_collects_wmis_contents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `computers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_glpiinventory_collects_wmis_id` int(10) unsigned NOT NULL DEFAULT 0,
  `property` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_glpiinventory_configs`
--

DROP TABLE IF EXISTS `glpi_plugin_glpiinventory_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_glpiinventory_configs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_glpiinventory_credentialips`
--

DROP TABLE IF EXISTS `glpi_plugin_glpiinventory_credentialips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_glpiinventory_credentialips` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_glpiinventory_credentials_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `comment` text DEFAULT NULL,
  `ip` varchar(255) NOT NULL DEFAULT '',
  `date_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_glpiinventory_credentials`
--

DROP TABLE IF EXISTS `glpi_plugin_glpiinventory_credentials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_glpiinventory_credentials` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `username` varchar(255) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL DEFAULT '',
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `itemtype` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_glpiinventory_deployfiles`
--

DROP TABLE IF EXISTS `glpi_plugin_glpiinventory_deployfiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_glpiinventory_deployfiles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `mimetype` varchar(255) NOT NULL,
  `filesize` bigint(20) NOT NULL,
  `comment` text DEFAULT NULL,
  `sha512` char(128) NOT NULL,
  `shortsha512` char(6) NOT NULL,
  `entities_id` int(10) unsigned NOT NULL,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `shortsha512` (`shortsha512`),
  KEY `entities_id` (`entities_id`),
  KEY `date_mod` (`date_mod`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_glpiinventory_deploygroups`
--

DROP TABLE IF EXISTS `glpi_plugin_glpiinventory_deploygroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_glpiinventory_deploygroups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `comment` text DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_glpiinventory_deploygroups_dynamicdatas`
--

DROP TABLE IF EXISTS `glpi_plugin_glpiinventory_deploygroups_dynamicdatas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_glpiinventory_deploygroups_dynamicdatas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_glpiinventory_deploygroups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `fields_array` text DEFAULT NULL,
  `can_update_group` tinyint(4) NOT NULL DEFAULT 0,
  `computers_id_cache` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plugin_glpiinventory_deploygroups_id` (`plugin_glpiinventory_deploygroups_id`),
  KEY `can_update_group` (`can_update_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_glpiinventory_deploygroups_staticdatas`
--

DROP TABLE IF EXISTS `glpi_plugin_glpiinventory_deploygroups_staticdatas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_glpiinventory_deploygroups_staticdatas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_glpiinventory_deploygroups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) DEFAULT NULL,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `plugin_glpiinventory_deploygroups_id` (`plugin_glpiinventory_deploygroups_id`),
  KEY `items_id` (`items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_glpiinventory_deploymirrors`
--

DROP TABLE IF EXISTS `glpi_plugin_glpiinventory_deploymirrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_glpiinventory_deploymirrors` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL DEFAULT '',
  `locations_id` int(10) unsigned NOT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_active` (`is_active`),
  KEY `is_recursive` (`is_recursive`),
  KEY `date_mod` (`date_mod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_glpiinventory_deploypackages`
--

DROP TABLE IF EXISTS `glpi_plugin_glpiinventory_deploypackages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_glpiinventory_deploypackages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `comment` text DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `uuid` varchar(255) DEFAULT NULL,
  `json` longtext DEFAULT NULL,
  `plugin_glpiinventory_deploygroups_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `entities_id` (`entities_id`),
  KEY `date_mod` (`date_mod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_glpiinventory_deploypackages_entities`
--

DROP TABLE IF EXISTS `glpi_plugin_glpiinventory_deploypackages_entities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_glpiinventory_deploypackages_entities` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_glpiinventory_deploypackages_id` int(10) unsigned NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `plugin_glpiinventory_deploypackages_id` (`plugin_glpiinventory_deploypackages_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_glpiinventory_deploypackages_groups`
--

DROP TABLE IF EXISTS `glpi_plugin_glpiinventory_deploypackages_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_glpiinventory_deploypackages_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_glpiinventory_deploypackages_id` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `plugin_glpiinventory_deploypackages_id` (`plugin_glpiinventory_deploypackages_id`),
  KEY `groups_id` (`groups_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_glpiinventory_deploypackages_profiles`
--

DROP TABLE IF EXISTS `glpi_plugin_glpiinventory_deploypackages_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_glpiinventory_deploypackages_profiles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_glpiinventory_deploypackages_id` int(10) unsigned NOT NULL DEFAULT 0,
  `profiles_id` int(10) unsigned NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `plugin_glpiinventory_deploypackages_id` (`plugin_glpiinventory_deploypackages_id`),
  KEY `profiles_id` (`profiles_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_glpiinventory_deploypackages_users`
--

DROP TABLE IF EXISTS `glpi_plugin_glpiinventory_deploypackages_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_glpiinventory_deploypackages_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_glpiinventory_deploypackages_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `plugin_glpiinventory_deploypackages_id` (`plugin_glpiinventory_deploypackages_id`),
  KEY `users_id` (`users_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_glpiinventory_deployuserinteractiontemplates`
--

DROP TABLE IF EXISTS `glpi_plugin_glpiinventory_deployuserinteractiontemplates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_glpiinventory_deployuserinteractiontemplates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `date_creation` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `json` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_glpiinventory_inventorycomputerstats`
--

DROP TABLE IF EXISTS `glpi_plugin_glpiinventory_inventorycomputerstats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_glpiinventory_inventorycomputerstats` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `day` smallint(6) NOT NULL DEFAULT 0,
  `hour` tinyint(4) NOT NULL DEFAULT 0,
  `counter` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8761 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_glpiinventory_ipranges`
--

DROP TABLE IF EXISTS `glpi_plugin_glpiinventory_ipranges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_glpiinventory_ipranges` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `ip_start` varchar(255) DEFAULT NULL,
  `ip_end` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entities_id` (`entities_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_glpiinventory_ipranges_snmpcredentials`
--

DROP TABLE IF EXISTS `glpi_plugin_glpiinventory_ipranges_snmpcredentials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_glpiinventory_ipranges_snmpcredentials` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_glpiinventory_ipranges_id` int(10) unsigned NOT NULL DEFAULT 0,
  `snmpcredentials_id` int(10) unsigned NOT NULL DEFAULT 0,
  `rank` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `unicity` (`plugin_glpiinventory_ipranges_id`,`snmpcredentials_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_glpiinventory_statediscoveries`
--

DROP TABLE IF EXISTS `glpi_plugin_glpiinventory_statediscoveries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_glpiinventory_statediscoveries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_glpiinventory_taskjob_id` int(10) unsigned NOT NULL DEFAULT 0,
  `agents_id` int(10) unsigned NOT NULL DEFAULT 0,
  `start_time` timestamp NULL DEFAULT NULL,
  `end_time` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `threads` int(11) NOT NULL DEFAULT 0,
  `nb_ip` int(11) NOT NULL DEFAULT 0,
  `nb_found` int(11) NOT NULL DEFAULT 0,
  `nb_error` int(11) NOT NULL DEFAULT 0,
  `nb_exists` int(11) NOT NULL DEFAULT 0,
  `nb_import` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_glpiinventory_taskjoblogs`
--

DROP TABLE IF EXISTS `glpi_plugin_glpiinventory_taskjoblogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_glpiinventory_taskjoblogs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_glpiinventory_taskjobstates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date` timestamp NULL DEFAULT NULL,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) DEFAULT NULL,
  `state` int(11) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plugin_glpiinventory_taskjobstates_id` (`plugin_glpiinventory_taskjobstates_id`,`state`),
  KEY `item` (`itemtype`,`items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_glpiinventory_taskjobs`
--

DROP TABLE IF EXISTS `glpi_plugin_glpiinventory_taskjobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_glpiinventory_taskjobs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_glpiinventory_tasks_id` int(10) unsigned NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `method` varchar(255) DEFAULT NULL,
  `targets` text DEFAULT NULL,
  `actors` text DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `rescheduled_taskjob_id` int(10) unsigned NOT NULL DEFAULT 0,
  `statuscomments` text DEFAULT NULL,
  `enduser` text DEFAULT NULL,
  `restrict_to_task_entity` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `plugin_glpiinventory_tasks_id` (`plugin_glpiinventory_tasks_id`),
  KEY `entities_id` (`entities_id`),
  KEY `method` (`method`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_glpiinventory_taskjobstates`
--

DROP TABLE IF EXISTS `glpi_plugin_glpiinventory_taskjobstates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_glpiinventory_taskjobstates` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_glpiinventory_taskjobs_id` int(10) unsigned NOT NULL DEFAULT 0,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) DEFAULT NULL,
  `state` int(11) NOT NULL DEFAULT 0,
  `agents_id` int(10) unsigned NOT NULL DEFAULT 0,
  `specificity` text DEFAULT NULL,
  `uniqid` varchar(255) DEFAULT NULL,
  `date_start` timestamp NULL DEFAULT NULL,
  `nb_retry` int(11) NOT NULL DEFAULT 0,
  `max_retry` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `plugin_glpiinventory_taskjobs_id` (`plugin_glpiinventory_taskjobs_id`),
  KEY `agents_id` (`agents_id`),
  KEY `uniqid` (`uniqid`,`state`),
  KEY `agents_id_state` (`agents_id`,`state`),
  KEY `plugin_glpiinventory_agents_items_states` (`agents_id`,`plugin_glpiinventory_taskjobs_id`,`items_id`,`itemtype`,`id`,`state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_glpiinventory_tasks`
--

DROP TABLE IF EXISTS `glpi_plugin_glpiinventory_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_glpiinventory_tasks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 0,
  `datetime_start` timestamp NULL DEFAULT NULL,
  `datetime_end` timestamp NULL DEFAULT NULL,
  `plugin_glpiinventory_timeslots_prep_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_glpiinventory_timeslots_exec_id` int(10) unsigned NOT NULL DEFAULT 0,
  `last_agent_wakeup` timestamp NULL DEFAULT NULL,
  `wakeup_agent_counter` int(11) NOT NULL DEFAULT 0,
  `wakeup_agent_time` int(11) NOT NULL DEFAULT 0,
  `reprepare_if_successful` tinyint(4) NOT NULL DEFAULT 1,
  `is_deploy_on_demand` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `entities_id` (`entities_id`),
  KEY `plugin_glpiinventory_timeslots_prep_id` (`plugin_glpiinventory_timeslots_prep_id`),
  KEY `plugin_glpiinventory_timeslots_exec_id` (`plugin_glpiinventory_timeslots_exec_id`),
  KEY `is_active` (`is_active`),
  KEY `reprepare_if_successful` (`reprepare_if_successful`),
  KEY `is_deploy_on_demand` (`is_deploy_on_demand`),
  KEY `wakeup_agent_counter` (`wakeup_agent_counter`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_glpiinventory_timeslotentries`
--

DROP TABLE IF EXISTS `glpi_plugin_glpiinventory_timeslotentries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_glpiinventory_timeslotentries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_glpiinventory_timeslots_id` int(10) unsigned NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `day` tinyint(4) NOT NULL DEFAULT 1,
  `begin` int(11) DEFAULT NULL,
  `end` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plugin_glpiinventory_calendars_id` (`plugin_glpiinventory_timeslots_id`),
  KEY `day` (`day`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_glpiinventory_timeslots`
--

DROP TABLE IF EXISTS `glpi_plugin_glpiinventory_timeslots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_glpiinventory_timeslots` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_glpisaml_configs`
--

DROP TABLE IF EXISTS `glpi_plugin_glpisaml_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_glpisaml_configs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `conf_domain` varchar(255) DEFAULT NULL,
  `conf_icon` varchar(50) NOT NULL,
  `enforce_sso` tinyint(4) NOT NULL DEFAULT 0,
  `proxied` tinyint(4) NOT NULL DEFAULT 0,
  `strict` tinyint(4) NOT NULL DEFAULT 0,
  `debug` tinyint(4) NOT NULL DEFAULT 0,
  `user_jit` tinyint(4) NOT NULL DEFAULT 0,
  `sp_certificate` text NOT NULL,
  `sp_private_key` text NOT NULL,
  `sp_nameid_format` varchar(128) NOT NULL,
  `idp_entity_id` varchar(128) NOT NULL,
  `idp_single_sign_on_service` varchar(128) NOT NULL,
  `idp_single_logout_service` varchar(128) NOT NULL,
  `idp_certificate` text NOT NULL,
  `requested_authn_context` text NOT NULL,
  `requested_authn_context_comparison` varchar(25) NOT NULL,
  `security_nameidencrypted` tinyint(4) NOT NULL DEFAULT 0,
  `security_authnrequestssigned` tinyint(4) NOT NULL DEFAULT 0,
  `security_logoutrequestsigned` tinyint(4) NOT NULL DEFAULT 0,
  `security_logoutresponsesigned` tinyint(4) NOT NULL DEFAULT 0,
  `compress_requests` tinyint(4) NOT NULL DEFAULT 0,
  `compress_responses` tinyint(4) NOT NULL DEFAULT 0,
  `validate_xml` tinyint(4) NOT NULL DEFAULT 0,
  `validate_destination` tinyint(4) NOT NULL DEFAULT 0,
  `lowercase_url_encoding` tinyint(4) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `date_creation` timestamp NULL DEFAULT current_timestamp(),
  `date_mod` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_glpisaml_excludes`
--

DROP TABLE IF EXISTS `glpi_plugin_glpisaml_excludes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_glpisaml_excludes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `ClientAgent` text NOT NULL,
  `ExcludePath` text NOT NULL,
  `action` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_glpisaml_loginstates`
--

DROP TABLE IF EXISTS `glpi_plugin_glpisaml_loginstates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_glpisaml_loginstates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userId` int(10) unsigned NOT NULL,
  `userName` varchar(255) DEFAULT NULL,
  `sessionId` varchar(255) NOT NULL,
  `sessionName` varchar(255) NOT NULL,
  `glpiAuthed` tinyint(3) unsigned DEFAULT NULL,
  `samlAuthed` tinyint(3) unsigned DEFAULT NULL,
  `loginTime` timestamp NOT NULL DEFAULT current_timestamp(),
  `lastClickTime` timestamp NOT NULL DEFAULT current_timestamp(),
  `location` text NOT NULL,
  `enforceLogoff` tinyint(3) unsigned DEFAULT NULL,
  `excludedPath` text DEFAULT NULL,
  `idpId` int(11) DEFAULT NULL,
  `serverParams` text DEFAULT NULL,
  `requestParams` text DEFAULT NULL,
  `loggedOff` tinyint(3) unsigned DEFAULT NULL,
  `phase` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3778 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_itilcategorygroups_categories`
--

DROP TABLE IF EXISTS `glpi_plugin_itilcategorygroups_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_itilcategorygroups_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `is_active` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT '',
  `comment` text DEFAULT NULL,
  `date_mod` date DEFAULT NULL,
  `itilcategories_id` int(10) unsigned NOT NULL DEFAULT 0,
  `view_all_lvl1` tinyint(4) NOT NULL DEFAULT 0,
  `view_all_lvl2` tinyint(4) NOT NULL DEFAULT 0,
  `view_all_lvl3` tinyint(4) NOT NULL DEFAULT 0,
  `view_all_lvl4` tinyint(4) NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 1,
  `is_incident` tinyint(4) NOT NULL DEFAULT 1,
  `is_request` tinyint(4) NOT NULL DEFAULT 1,
  `is_groups_restriction` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `entities_id` (`entities_id`),
  KEY `itilcategories_id` (`itilcategories_id`),
  KEY `is_incident` (`is_incident`),
  KEY `is_request` (`is_request`),
  KEY `is_recursive` (`is_recursive`),
  KEY `date_mod` (`date_mod`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_itilcategorygroups_categories_groups`
--

DROP TABLE IF EXISTS `glpi_plugin_itilcategorygroups_categories_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_itilcategorygroups_categories_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_itilcategorygroups_categories_id` int(10) unsigned NOT NULL DEFAULT 0,
  `level` tinyint(4) NOT NULL DEFAULT 0,
  `itilcategories_id` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_lvl_unicity` (`plugin_itilcategorygroups_categories_id`,`level`,`groups_id`),
  KEY `plugin_itilcategorygroups_categories_id` (`plugin_itilcategorygroups_categories_id`),
  KEY `level` (`level`),
  KEY `itilcategories_id` (`itilcategories_id`),
  KEY `groups_id` (`groups_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_itilcategorygroups_groups_levels`
--

DROP TABLE IF EXISTS `glpi_plugin_itilcategorygroups_groups_levels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_itilcategorygroups_groups_levels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `groups_id` int(10) unsigned NOT NULL,
  `lvl` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `groups_id` (`groups_id`),
  KEY `lvl` (`lvl`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_jamf_computers`
--

DROP TABLE IF EXISTS `glpi_plugin_jamf_computers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_jamf_computers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `glpi_plugin_jamf_devices_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `glpi_plugin_jamf_devices_id` (`glpi_plugin_jamf_devices_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_jamf_computersoftwares`
--

DROP TABLE IF EXISTS `glpi_plugin_jamf_computersoftwares`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_jamf_computersoftwares` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `softwares_id` int(11) NOT NULL,
  `bundle_id` varchar(255) NOT NULL,
  `itunes_store_url` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_jamf_devices`
--

DROP TABLE IF EXISTS `glpi_plugin_jamf_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_jamf_devices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jamf_type` varchar(100) DEFAULT 'MobileDevice',
  `jamf_items_id` int(11) NOT NULL DEFAULT -1,
  `items_id` int(11) NOT NULL,
  `itemtype` varchar(100) NOT NULL,
  `udid` varchar(100) NOT NULL,
  `last_inventory` timestamp NULL DEFAULT NULL,
  `entry_date` timestamp NULL DEFAULT NULL,
  `enroll_date` timestamp NULL DEFAULT NULL,
  `import_date` timestamp NULL DEFAULT NULL,
  `sync_date` timestamp NULL DEFAULT NULL,
  `managed` tinyint(1) NOT NULL DEFAULT 0,
  `supervised` tinyint(1) NOT NULL DEFAULT 0,
  `activation_lock_enabled` tinyint(1) DEFAULT 0,
  `model_identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`itemtype`,`items_id`),
  KEY `udid` (`udid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_jamf_extensionattributes`
--

DROP TABLE IF EXISTS `glpi_plugin_jamf_extensionattributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_jamf_extensionattributes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jamf_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'MobileDevice',
  `jamf_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `data_type` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`jamf_type`,`jamf_id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_jamf_extfields`
--

DROP TABLE IF EXISTS `glpi_plugin_jamf_extfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_jamf_extfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `itemtype` varchar(100) NOT NULL,
  `items_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `value` varchar(255) DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`itemtype`,`items_id`),
  KEY `item` (`itemtype`,`items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_jamf_imports`
--

DROP TABLE IF EXISTS `glpi_plugin_jamf_imports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_jamf_imports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jamf_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'MobileDevice',
  `jamf_items_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(100) NOT NULL,
  `udid` varchar(100) DEFAULT NULL,
  `date_discover` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_jamf_items_extensionattributes`
--

DROP TABLE IF EXISTS `glpi_plugin_jamf_items_extensionattributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_jamf_items_extensionattributes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `itemtype` varchar(100) NOT NULL,
  `items_id` int(11) NOT NULL,
  `glpi_plugin_jamf_extensionattributes_id` int(11) NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`itemtype`,`items_id`,`glpi_plugin_jamf_extensionattributes_id`),
  KEY `item` (`itemtype`,`items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_jamf_mobiledevices`
--

DROP TABLE IF EXISTS `glpi_plugin_jamf_mobiledevices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_jamf_mobiledevices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shared` varchar(100) NOT NULL DEFAULT '',
  `cloud_backup_enabled` tinyint(1) DEFAULT 0,
  `lost_mode_enabled` varchar(255) DEFAULT 'Unknown',
  `lost_mode_enforced` tinyint(1) DEFAULT 0,
  `lost_mode_enable_date` timestamp NULL DEFAULT NULL,
  `lost_mode_message` varchar(255) DEFAULT NULL,
  `lost_mode_phone` varchar(100) DEFAULT NULL,
  `lost_location_latitude` varchar(100) DEFAULT '',
  `lost_location_longitude` varchar(100) DEFAULT '',
  `lost_location_altitude` varchar(100) DEFAULT '',
  `lost_location_speed` varchar(100) DEFAULT '',
  `lost_location_date` timestamp NULL DEFAULT NULL,
  `glpi_plugin_jamf_devices_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_jamf_mobiledevicesoftwares`
--

DROP TABLE IF EXISTS `glpi_plugin_jamf_mobiledevicesoftwares`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_jamf_mobiledevicesoftwares` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `softwares_id` int(11) NOT NULL,
  `bundle_id` varchar(255) NOT NULL,
  `itunes_store_url` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_jamf_users_jssaccounts`
--

DROP TABLE IF EXISTS `glpi_plugin_jamf_users_jssaccounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_jamf_users_jssaccounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `users_id` int(11) NOT NULL,
  `jssaccounts_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_jsaddons_jsaddons`
--

DROP TABLE IF EXISTS `glpi_plugin_jsaddons_jsaddons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_jsaddons_jsaddons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 0,
  `date_creation` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `key` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_manageentities_businesscontacts`
--

DROP TABLE IF EXISTS `glpi_plugin_manageentities_businesscontacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_manageentities_businesscontacts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_users (id)',
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_default` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`users_id`,`entities_id`),
  KEY `users_id` (`users_id`),
  KEY `entities_id` (`entities_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_manageentities_companies`
--

DROP TABLE IF EXISTS `glpi_plugin_manageentities_companies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_manageentities_companies` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL COMMENT 'address of the company shown on CRI',
  `entity_id` text DEFAULT NULL,
  `recursive` int(10) unsigned DEFAULT 0,
  `logo_id` int(10) unsigned DEFAULT 0 COMMENT 'RELATION to glpi_documents',
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `logo_id` (`logo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_manageentities_configs`
--

DROP TABLE IF EXISTS `glpi_plugin_manageentities_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_manageentities_configs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `backup` int(10) unsigned NOT NULL DEFAULT 0,
  `documentcategories_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_documentcategories (id)',
  `useprice` tinyint(4) NOT NULL DEFAULT 1 COMMENT 'default for yes',
  `hourorday` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'default for day',
  `hourbyday` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'if hourorday == 0 then must be different of 0',
  `needvalidationforcri` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'only CRI with validated ticket are taking into account for consumption calculation',
  `use_publictask` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'default for no',
  `allow_same_periods` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'allow interventions on the same interval of dates',
  `contract_states` text DEFAULT NULL,
  `business_id` text DEFAULT NULL,
  `choice_intervention` int(10) unsigned DEFAULT NULL,
  `comment` tinyint(4) NOT NULL DEFAULT 1 COMMENT 'display comments in the CRI',
  `non_accomplished_tasks` tinyint(4) NOT NULL DEFAULT 0,
  `get_pdf_cri` tinyint(4) NOT NULL DEFAULT 0,
  `ticket_state` int(10) unsigned NOT NULL DEFAULT 3,
  `default_duration` varchar(255) DEFAULT NULL,
  `default_time_am` varchar(255) DEFAULT NULL,
  `default_time_pm` varchar(255) DEFAULT NULL,
  `disable_date_header` tinyint(4) NOT NULL DEFAULT 0,
  `company_address` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `documentcategories_id` (`documentcategories_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_manageentities_contacts`
--

DROP TABLE IF EXISTS `glpi_plugin_manageentities_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_manageentities_contacts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `contacts_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_contacts (id)',
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_default` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`entities_id`),
  KEY `entities_id` (`entities_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_manageentities_contractdays`
--

DROP TABLE IF EXISTS `glpi_plugin_manageentities_contractdays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_manageentities_contractdays` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `plugin_manageentities_critypes_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_manageentities_critypes (id)',
  `contracts_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_contracts (id)',
  `plugin_manageentities_contractstates_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_manageentities_contractstates (id)',
  `contract_type` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'for the contract type (hour, intervention, unlimited or not)',
  `begin_date` timestamp NULL DEFAULT NULL,
  `end_date` timestamp NULL DEFAULT NULL,
  `nbday` decimal(20,2) DEFAULT 0.00,
  `report` decimal(20,2) DEFAULT 0.00,
  `charged` tinyint(4) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entities_id` (`entities_id`),
  KEY `contracts_id` (`contracts_id`),
  KEY `plugin_manageentities_critypes_id` (`plugin_manageentities_critypes_id`),
  KEY `plugin_manageentities_contractstates_id` (`plugin_manageentities_contractstates_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_manageentities_contracts`
--

DROP TABLE IF EXISTS `glpi_plugin_manageentities_contracts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_manageentities_contracts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `contracts_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_contracts (id)',
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_default` tinyint(4) NOT NULL DEFAULT 0,
  `management` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'for the management mode (quarterly or annual or not)',
  `contract_type` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'for the contract type (hour, intervention, unlimited or not)',
  `date_signature` timestamp NULL DEFAULT NULL,
  `date_renewal` timestamp NULL DEFAULT NULL,
  `contract_added` tinyint(4) NOT NULL DEFAULT 0,
  `show_on_global_gantt` tinyint(4) NOT NULL DEFAULT 0,
  `refacturable_costs` tinyint(4) NOT NULL DEFAULT 0,
  `moving_management` tinyint(4) NOT NULL DEFAULT 0,
  `duration_moving` decimal(20,2) NOT NULL DEFAULT 0.00 COMMENT 'Duration of moving',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`contracts_id`,`entities_id`),
  KEY `contracts_id` (`contracts_id`),
  KEY `entities_id` (`entities_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_manageentities_contractstates`
--

DROP TABLE IF EXISTS `glpi_plugin_manageentities_contractstates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_manageentities_contractstates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 0,
  `is_closed` tinyint(4) NOT NULL DEFAULT 0,
  `color` varchar(7) DEFAULT '#F2F2F2',
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `is_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_manageentities_cridetails`
--

DROP TABLE IF EXISTS `glpi_plugin_manageentities_cridetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_manageentities_cridetails` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date` timestamp NULL DEFAULT NULL,
  `documents_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_documents (id)',
  `plugin_manageentities_contractdays_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_manageentities_critypes_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_manageentities_critypes (id)',
  `withcontract` int(10) unsigned NOT NULL DEFAULT 0,
  `contracts_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_contracts (id)',
  `realtime` decimal(20,2) DEFAULT 0.00,
  `technicians` varchar(255) DEFAULT NULL,
  `tickets_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_tickets (id)',
  `number_moving` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'Number of movements',
  PRIMARY KEY (`id`),
  KEY `entities_id` (`entities_id`),
  KEY `documents_id` (`documents_id`),
  KEY `plugin_manageentities_critypes_id` (`plugin_manageentities_critypes_id`),
  KEY `plugin_manageentities_contractdays_id` (`plugin_manageentities_contractdays_id`),
  KEY `tickets_id` (`tickets_id`),
  KEY `contracts_id` (`contracts_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_manageentities_criprices`
--

DROP TABLE IF EXISTS `glpi_plugin_manageentities_criprices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_manageentities_criprices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_manageentities_critypes_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_manageentities_critypes (id)',
  `plugin_manageentities_contractdays_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_manageentities_contractdays (id)',
  `price` decimal(20,4) NOT NULL DEFAULT 0.0000,
  `is_default` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `entities_id` (`entities_id`),
  KEY `plugin_manageentities_critypes_id` (`plugin_manageentities_critypes_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_manageentities_critechnicians`
--

DROP TABLE IF EXISTS `glpi_plugin_manageentities_critechnicians`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_manageentities_critechnicians` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tickets_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_tickets (id)',
  `users_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_users (id)',
  PRIMARY KEY (`id`),
  KEY `tickets_id` (`tickets_id`),
  KEY `users_id` (`users_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_manageentities_critypes`
--

DROP TABLE IF EXISTS `glpi_plugin_manageentities_critypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_manageentities_critypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_manageentities_entitylogos`
--

DROP TABLE IF EXISTS `glpi_plugin_manageentities_entitylogos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_manageentities_entitylogos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `logos_id` int(10) unsigned DEFAULT 0 COMMENT 'RELATION to glpi_documents',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_manageentities_interventionskateholders`
--

DROP TABLE IF EXISTS `glpi_plugin_manageentities_interventionskateholders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_manageentities_interventionskateholders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_users (id)',
  `number_affected_days` double NOT NULL DEFAULT 0 COMMENT 'Number of days affected to the user to an intervention',
  `plugin_manageentities_contractdays_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_manageentities_contractdays (id)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_manageentities_preferences`
--

DROP TABLE IF EXISTS `glpi_plugin_manageentities_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_manageentities_preferences` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_users (id)',
  `show_on_load` int(10) unsigned NOT NULL DEFAULT 0,
  `contract_states` text DEFAULT NULL,
  `business_id` text DEFAULT NULL,
  `companies_id` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `users_id` (`users_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_manageentities_taskcategories`
--

DROP TABLE IF EXISTS `glpi_plugin_manageentities_taskcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_manageentities_taskcategories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `taskcategories_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to  glpi_taskcategories (id)',
  `is_usedforcount` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `taskcategories_id` (`taskcategories_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_manufacturersimports_configs`
--

DROP TABLE IF EXISTS `glpi_plugin_manufacturersimports_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_manufacturersimports_configs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `supplier_url` varchar(255) DEFAULT NULL,
  `manufacturers_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_manufacturers (id)',
  `suppliers_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_suppliers (id)',
  `warranty_duration` int(10) unsigned NOT NULL DEFAULT 0,
  `document_adding` int(10) unsigned NOT NULL DEFAULT 0,
  `documentcategories_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_documentcategories (id)',
  `comment_adding` int(10) unsigned NOT NULL DEFAULT 0,
  `supplier_key` varchar(255) DEFAULT NULL,
  `supplier_secret` varchar(255) DEFAULT NULL,
  `token_url` varchar(255) DEFAULT NULL,
  `warranty_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `manufacturers_id` (`manufacturers_id`),
  KEY `suppliers_id` (`suppliers_id`),
  KEY `documentcategories_id` (`documentcategories_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_manufacturersimports_logs`
--

DROP TABLE IF EXISTS `glpi_plugin_manufacturersimports_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_manufacturersimports_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `import_status` int(10) unsigned NOT NULL DEFAULT 0,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to various tables, according to itemtype (id)',
  `itemtype` varchar(100) NOT NULL COMMENT 'see .class.php file',
  `documents_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_documents (id)',
  `date_import` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`import_status`,`items_id`,`itemtype`),
  KEY `FK_device` (`items_id`,`itemtype`),
  KEY `item` (`itemtype`,`items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_metabase_profilerights`
--

DROP TABLE IF EXISTS `glpi_plugin_metabase_profilerights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_metabase_profilerights` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `profiles_id` int(10) unsigned NOT NULL,
  `dashboard_uuid` int(11) NOT NULL,
  `rights` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `profiles_id_dashboard_uuid` (`profiles_id`,`dashboard_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_metademands_basketlines`
--

DROP TABLE IF EXISTS `glpi_plugin_metademands_basketlines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_metademands_basketlines` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_metademands_metademands_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_metademands_fields_id` int(10) unsigned NOT NULL DEFAULT 0,
  `line` int(11) NOT NULL DEFAULT 0,
  `name` varchar(150) DEFAULT NULL,
  `value` text DEFAULT NULL,
  `value2` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`plugin_metademands_metademands_id`,`plugin_metademands_fields_id`,`line`,`name`,`users_id`),
  KEY `users_id` (`users_id`),
  KEY `plugin_metademands_metademands_id` (`plugin_metademands_metademands_id`),
  KEY `plugin_metademands_fields_id` (`plugin_metademands_fields_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_metademands_basketobjects`
--

DROP TABLE IF EXISTS `glpi_plugin_metademands_basketobjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_metademands_basketobjects` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `reference` varchar(255) DEFAULT NULL,
  `plugin_metademands_basketobjecttypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `plugin_metademands_basketobjecttypes_id` (`plugin_metademands_basketobjecttypes_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_metademands_basketobjecttranslations`
--

DROP TABLE IF EXISTS `glpi_plugin_metademands_basketobjecttranslations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_metademands_basketobjecttranslations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) DEFAULT NULL,
  `field` varchar(100) DEFAULT NULL,
  `language` varchar(5) DEFAULT NULL,
  `value` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_metademands_basketobjecttypes`
--

DROP TABLE IF EXISTS `glpi_plugin_metademands_basketobjecttypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_metademands_basketobjecttypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_metademands_basketobjecttypetranslations`
--

DROP TABLE IF EXISTS `glpi_plugin_metademands_basketobjecttypetranslations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_metademands_basketobjecttypetranslations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) DEFAULT NULL,
  `language` varchar(5) DEFAULT NULL,
  `field` varchar(100) DEFAULT NULL,
  `value` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_metademands_conditions`
--

DROP TABLE IF EXISTS `glpi_plugin_metademands_conditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_metademands_conditions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_metademands_fields_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_metademands_metademands_id` int(10) unsigned NOT NULL DEFAULT 0,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `item` varchar(255) DEFAULT NULL,
  `check_value` varchar(255) DEFAULT NULL,
  `show_logic` int(11) NOT NULL DEFAULT 1,
  `show_condition` int(11) NOT NULL DEFAULT 0,
  `order` int(11) NOT NULL DEFAULT 0,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plugin_metademands_fields_id` (`plugin_metademands_fields_id`),
  KEY `plugin_metademands_metademands_id` (`plugin_metademands_metademands_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_metademands_configs`
--

DROP TABLE IF EXISTS `glpi_plugin_metademands_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_metademands_configs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `simpleticket_to_metademand` tinyint(4) DEFAULT 0,
  `parent_ticket_tag` varchar(255) DEFAULT NULL,
  `son_ticket_tag` varchar(255) DEFAULT NULL,
  `create_pdf` tinyint(4) DEFAULT 0,
  `show_requester_informations` tinyint(4) DEFAULT 0,
  `childs_parent_content` tinyint(4) DEFAULT 0,
  `display_type` tinyint(4) DEFAULT 1,
  `display_buttonlist_servicecatalog` tinyint(4) DEFAULT 1,
  `title_servicecatalog` varchar(255) DEFAULT NULL,
  `comment_servicecatalog` text DEFAULT NULL,
  `fa_servicecatalog` varchar(100) NOT NULL DEFAULT 'fas fa-share-alt',
  `languageTech` varchar(100) DEFAULT NULL,
  `use_draft` tinyint(4) DEFAULT 0,
  `show_form_changes` tinyint(4) NOT NULL DEFAULT 0,
  `add_groups_with_regex` tinyint(4) NOT NULL DEFAULT 0,
  `icon_request` varchar(255) DEFAULT NULL,
  `icon_incident` varchar(255) DEFAULT NULL,
  `icon_problem` varchar(255) DEFAULT NULL,
  `icon_change` varchar(255) DEFAULT NULL,
  `see_top` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_metademands_configsteps`
--

DROP TABLE IF EXISTS `glpi_plugin_metademands_configsteps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_metademands_configsteps` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_metademands_metademands_id` int(10) unsigned NOT NULL DEFAULT 0,
  `see_blocks_as_tab` tinyint(4) NOT NULL DEFAULT 0,
  `link_user_block` tinyint(4) NOT NULL DEFAULT 0,
  `multiple_link_groups_blocks` tinyint(4) NOT NULL DEFAULT 0,
  `add_user_as_requester` tinyint(4) NOT NULL DEFAULT 0,
  `supervisor_validation` tinyint(4) NOT NULL DEFAULT 0,
  `step_by_step_interface` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `plugin_metademands_metademands_id` (`plugin_metademands_metademands_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_metademands_drafts`
--

DROP TABLE IF EXISTS `glpi_plugin_metademands_drafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_metademands_drafts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '0',
  `plugin_metademands_metademands_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `plugin_metademands_metademands_id` (`plugin_metademands_metademands_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_metademands_drafts_values`
--

DROP TABLE IF EXISTS `glpi_plugin_metademands_drafts_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_metademands_drafts_values` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_metademands_drafts_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_metademands_fields_id` int(10) unsigned NOT NULL DEFAULT 0,
  `value` text NOT NULL,
  `value2` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `plugin_metademands_drafts_id` (`plugin_metademands_drafts_id`),
  KEY `plugin_metademands_fields_id` (`plugin_metademands_fields_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_metademands_fieldcustomvalues`
--

DROP TABLE IF EXISTS `glpi_plugin_metademands_fieldcustomvalues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_metademands_fieldcustomvalues` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_metademands_fields_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '0',
  `is_default` int(11) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `rank` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `plugin_metademands_fields_id` (`plugin_metademands_fields_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_metademands_fieldoptions`
--

DROP TABLE IF EXISTS `glpi_plugin_metademands_fieldoptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_metademands_fieldoptions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_metademands_fields_id` int(10) unsigned NOT NULL DEFAULT 0,
  `check_value` int(11) NOT NULL DEFAULT 0,
  `plugin_metademands_tasks_id` int(10) unsigned NOT NULL DEFAULT 0,
  `fields_link` int(10) unsigned NOT NULL DEFAULT 0,
  `hidden_link` int(10) unsigned NOT NULL DEFAULT 0,
  `hidden_block` int(10) unsigned NOT NULL DEFAULT 0,
  `hidden_block_same_block` tinyint(4) NOT NULL DEFAULT 0,
  `users_id_validate` int(10) unsigned NOT NULL DEFAULT 0,
  `childs_blocks` varchar(255) NOT NULL DEFAULT '[]',
  `checkbox_value` int(10) unsigned NOT NULL DEFAULT 0,
  `checkbox_id` int(10) unsigned NOT NULL DEFAULT 0,
  `parent_field_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `plugin_metademands_fields_id` (`plugin_metademands_fields_id`),
  KEY `plugin_metademands_tasks_id` (`plugin_metademands_tasks_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_metademands_fieldparameters`
--

DROP TABLE IF EXISTS `glpi_plugin_metademands_fieldparameters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_metademands_fieldparameters` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_metademands_fields_id` int(10) unsigned NOT NULL DEFAULT 0,
  `custom` text DEFAULT NULL,
  `default` text DEFAULT NULL,
  `hide_title` tinyint(4) NOT NULL DEFAULT 0,
  `is_mandatory` int(11) NOT NULL DEFAULT 0,
  `max_upload` int(11) NOT NULL DEFAULT 0,
  `regex` varchar(255) NOT NULL DEFAULT '',
  `color` varchar(255) DEFAULT NULL,
  `row_display` tinyint(4) DEFAULT 0,
  `is_basket` tinyint(4) DEFAULT 0,
  `display_type` int(11) DEFAULT 0,
  `used_by_ticket` int(11) NOT NULL DEFAULT 0,
  `used_by_child` tinyint(4) DEFAULT 0,
  `link_to_user` int(11) DEFAULT 0,
  `default_use_id_requester` int(10) unsigned DEFAULT 0,
  `default_use_id_requester_supervisor` int(10) unsigned DEFAULT 0,
  `use_future_date` tinyint(4) DEFAULT 0,
  `use_date_now` tinyint(4) DEFAULT 0,
  `additional_number_day` int(11) DEFAULT 0,
  `informations_to_display` varchar(255) NOT NULL DEFAULT '[]',
  `use_richtext` tinyint(4) NOT NULL DEFAULT 1,
  `icon` varchar(255) DEFAULT NULL,
  `readonly` tinyint(4) DEFAULT 0,
  `hidden` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `plugin_metademands_fields_id` (`plugin_metademands_fields_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_metademands_fields`
--

DROP TABLE IF EXISTS `glpi_plugin_metademands_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_metademands_fields` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` int(11) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `rank` int(11) NOT NULL DEFAULT 0,
  `order` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `label2` text DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `item` varchar(255) DEFAULT NULL,
  `plugin_metademands_fields_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_metademands_metademands_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_creation` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plugin_metademands_fields_id` (`plugin_metademands_fields_id`),
  KEY `plugin_metademands_metademands_id` (`plugin_metademands_metademands_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_metademands_fieldtranslations`
--

DROP TABLE IF EXISTS `glpi_plugin_metademands_fieldtranslations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_metademands_fieldtranslations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) DEFAULT NULL,
  `language` varchar(5) DEFAULT NULL,
  `field` varchar(100) DEFAULT NULL,
  `value` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_metademands_forms`
--

DROP TABLE IF EXISTS `glpi_plugin_metademands_forms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_metademands_forms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '0',
  `plugin_metademands_metademands_id` int(10) unsigned NOT NULL DEFAULT 0,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) DEFAULT NULL,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `is_model` tinyint(4) NOT NULL DEFAULT 0,
  `resources_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `plugin_metademands_metademands_id` (`plugin_metademands_metademands_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_metademands_forms_values`
--

DROP TABLE IF EXISTS `glpi_plugin_metademands_forms_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_metademands_forms_values` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_metademands_forms_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_metademands_fields_id` int(10) unsigned NOT NULL DEFAULT 0,
  `value` text NOT NULL,
  `value2` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `plugin_metademands_forms_id` (`plugin_metademands_forms_id`),
  KEY `plugin_metademands_fields_id` (`plugin_metademands_fields_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_metademands_freetablefields`
--

DROP TABLE IF EXISTS `glpi_plugin_metademands_freetablefields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_metademands_freetablefields` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_metademands_fields_id` int(10) unsigned NOT NULL DEFAULT 0,
  `internal_name` varchar(255) NOT NULL DEFAULT '0',
  `type` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL DEFAULT '0',
  `dropdown_values` text DEFAULT NULL,
  `is_mandatory` int(11) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `rank` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `plugin_metademands_fields_id` (`plugin_metademands_fields_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_metademands_groupconfigs`
--

DROP TABLE IF EXISTS `glpi_plugin_metademands_groupconfigs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_metademands_groupconfigs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `visibility` int(11) NOT NULL DEFAULT 0,
  `plugin_metademands_metademands_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `plugin_metademands_metademands_id` (`plugin_metademands_metademands_id`),
  KEY `entities_id` (`entities_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_metademands_groups`
--

DROP TABLE IF EXISTS `glpi_plugin_metademands_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_metademands_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_metademands_metademands_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `plugin_metademands_metademands_id` (`plugin_metademands_metademands_id`),
  KEY `entities_id` (`entities_id`),
  KEY `groups_id` (`groups_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_metademands_interticketfollowups`
--

DROP TABLE IF EXISTS `glpi_plugin_metademands_interticketfollowups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_metademands_interticketfollowups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tickets_id` int(10) unsigned NOT NULL DEFAULT 0,
  `targets_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date` timestamp NULL DEFAULT NULL,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_editor` int(10) unsigned NOT NULL DEFAULT 0,
  `content` longtext DEFAULT NULL,
  `is_private` tinyint(4) NOT NULL DEFAULT 0,
  `requesttypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `timeline_position` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_metademands_mailtasks`
--

DROP TABLE IF EXISTS `glpi_plugin_metademands_mailtasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_metademands_mailtasks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `content` text DEFAULT NULL,
  `users_id_recipient` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id_recipient` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_metademands_tasks_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itilcategories_id` int(10) unsigned NOT NULL DEFAULT 0,
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plugin_metademands_tasks_id` (`plugin_metademands_tasks_id`),
  KEY `users_id_recipient` (`users_id_recipient`),
  KEY `groups_id_recipient` (`groups_id_recipient`),
  KEY `itilcategories_id` (`itilcategories_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_metademands_metademands`
--

DROP TABLE IF EXISTS `glpi_plugin_metademands_metademands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_metademands_metademands` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` int(11) NOT NULL DEFAULT 0,
  `is_template` tinyint(4) NOT NULL DEFAULT 0,
  `template_name` varchar(255) DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 1,
  `maintenance_mode` tinyint(4) NOT NULL DEFAULT 0,
  `can_update` tinyint(4) NOT NULL DEFAULT 0,
  `can_clone` tinyint(4) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `object_to_create` varchar(255) DEFAULT NULL,
  `type` int(11) NOT NULL DEFAULT 0,
  `itilcategories_id` text NOT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `is_order` tinyint(4) DEFAULT 0,
  `create_one_ticket` tinyint(4) NOT NULL DEFAULT 0,
  `force_create_tasks` tinyint(4) NOT NULL DEFAULT 0,
  `date_creation` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `validation_subticket` tinyint(4) NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `hide_no_field` tinyint(4) DEFAULT 0,
  `hide_title` tinyint(4) DEFAULT 0,
  `title_color` varchar(255) DEFAULT '#000000',
  `background_color` varchar(255) DEFAULT '#FFFFFF',
  `step_by_step_mode` tinyint(4) NOT NULL DEFAULT 0,
  `show_rule` tinyint(4) NOT NULL DEFAULT 1,
  `initial_requester_childs_tickets` tinyint(4) NOT NULL DEFAULT 1,
  `is_basket` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `is_template` (`is_template`),
  KEY `is_deleted` (`is_deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_metademands_metademands_resources`
--

DROP TABLE IF EXISTS `glpi_plugin_metademands_metademands_resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_metademands_metademands_resources` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_resources_contracttypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_metademands_metademands_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `entities_id` (`entities_id`),
  KEY `plugin_resources_contracttypes_id` (`plugin_resources_contracttypes_id`),
  KEY `plugin_metademands_metademands_id` (`plugin_metademands_metademands_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_metademands_metademandtasks`
--

DROP TABLE IF EXISTS `glpi_plugin_metademands_metademandtasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_metademands_metademandtasks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_metademands_metademands_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_metademands_tasks_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `plugin_metademands_metademands_id` (`plugin_metademands_metademands_id`),
  KEY `entities_id` (`entities_id`),
  KEY `plugin_metademands_tasks_id` (`plugin_metademands_tasks_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_metademands_metademandtranslations`
--

DROP TABLE IF EXISTS `glpi_plugin_metademands_metademandtranslations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_metademands_metademandtranslations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) DEFAULT NULL,
  `language` varchar(5) DEFAULT NULL,
  `field` varchar(100) DEFAULT NULL,
  `value` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_metademands_metademandvalidations`
--

DROP TABLE IF EXISTS `glpi_plugin_metademands_metademandvalidations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_metademands_metademandvalidations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tickets_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_metademands_metademands_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `validate` tinyint(4) NOT NULL DEFAULT 0,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `tickets_to_create` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `users_id` (`users_id`),
  KEY `tickets_id` (`tickets_id`),
  KEY `plugin_metademands_metademands_id` (`plugin_metademands_metademands_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_metademands_pluginfields`
--

DROP TABLE IF EXISTS `glpi_plugin_metademands_pluginfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_metademands_pluginfields` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_fields_fields_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_metademands_fields_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_metademands_metademands_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `plugin_fields_fields_id` (`plugin_fields_fields_id`),
  KEY `plugin_metademands_fields_id` (`plugin_metademands_fields_id`),
  KEY `plugin_metademands_metademands_id` (`plugin_metademands_metademands_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_metademands_stepforms`
--

DROP TABLE IF EXISTS `glpi_plugin_metademands_stepforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_metademands_stepforms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '0',
  `plugin_metademands_metademands_id` int(10) unsigned NOT NULL DEFAULT 0,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id_dest` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_dest` int(10) unsigned NOT NULL DEFAULT 0,
  `date` timestamp NULL DEFAULT NULL,
  `reminder_date` timestamp NULL DEFAULT NULL,
  `block_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `plugin_metademands_metademands_id` (`plugin_metademands_metademands_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_metademands_stepforms_actors`
--

DROP TABLE IF EXISTS `glpi_plugin_metademands_stepforms_actors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_metademands_stepforms_actors` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_metademands_stepforms_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `plugin_metademands_stepforms_id` (`plugin_metademands_stepforms_id`),
  KEY `users_id` (`users_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_metademands_stepforms_values`
--

DROP TABLE IF EXISTS `glpi_plugin_metademands_stepforms_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_metademands_stepforms_values` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_metademands_stepforms_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_metademands_fields_id` int(10) unsigned NOT NULL DEFAULT 0,
  `value` text DEFAULT NULL,
  `value2` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plugin_metademands_stepforms_id` (`plugin_metademands_stepforms_id`),
  KEY `plugin_metademands_fields_id` (`plugin_metademands_fields_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_metademands_steps`
--

DROP TABLE IF EXISTS `glpi_plugin_metademands_steps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_metademands_steps` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_metademands_metademands_id` int(10) unsigned NOT NULL DEFAULT 0,
  `block_id` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `only_by_supervisor` tinyint(4) NOT NULL DEFAULT 0,
  `reminder_delay` text DEFAULT NULL,
  `message` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plugin_metademands_metademands_id` (`plugin_metademands_metademands_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_metademands_tasks`
--

DROP TABLE IF EXISTS `glpi_plugin_metademands_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_metademands_tasks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `completename` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` int(11) NOT NULL DEFAULT 0,
  `level` int(11) NOT NULL DEFAULT 0,
  `type` int(11) NOT NULL DEFAULT 0,
  `ancestors_cache` text DEFAULT NULL,
  `sons_cache` text DEFAULT NULL,
  `plugin_metademands_tasks_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_metademands_metademands_id` int(10) unsigned NOT NULL DEFAULT 0,
  `block_use` varchar(255) NOT NULL DEFAULT '[]',
  `useBlock` tinyint(4) NOT NULL DEFAULT 1,
  `formatastable` tinyint(4) NOT NULL DEFAULT 1,
  `block_parent_ticket_resolution` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `plugin_metademands_metademands_id` (`plugin_metademands_metademands_id`),
  KEY `plugin_metademands_tasks_id` (`plugin_metademands_tasks_id`),
  KEY `entities_id` (`entities_id`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_metademands_ticketfields`
--

DROP TABLE IF EXISTS `glpi_plugin_metademands_ticketfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_metademands_ticketfields` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `num` int(11) DEFAULT NULL,
  `value` text DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` int(11) NOT NULL DEFAULT 0,
  `is_mandatory` int(11) NOT NULL DEFAULT 0,
  `is_deletable` int(11) NOT NULL DEFAULT 1,
  `plugin_metademands_metademands_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `entities_id` (`entities_id`),
  KEY `plugin_metademands_metademands_id` (`plugin_metademands_metademands_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_metademands_tickets_fields`
--

DROP TABLE IF EXISTS `glpi_plugin_metademands_tickets_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_metademands_tickets_fields` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `value` text DEFAULT NULL,
  `value2` text DEFAULT NULL,
  `tickets_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_metademands_fields_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `plugin_metademands_fields_id` (`plugin_metademands_fields_id`),
  KEY `tickets_id` (`tickets_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_metademands_tickets_metademands`
--

DROP TABLE IF EXISTS `glpi_plugin_metademands_tickets_metademands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_metademands_tickets_metademands` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_metademands_metademands_id` int(10) unsigned NOT NULL DEFAULT 0,
  `tickets_id` int(10) unsigned NOT NULL DEFAULT 0,
  `parent_tickets_id` int(10) unsigned NOT NULL DEFAULT 0,
  `tickettemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `plugin_metademands_metademands_id` (`plugin_metademands_metademands_id`),
  KEY `tickets_id` (`tickets_id`),
  KEY `parent_tickets_id` (`parent_tickets_id`),
  KEY `tickettemplates_id` (`tickettemplates_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_metademands_tickets_tasks`
--

DROP TABLE IF EXISTS `glpi_plugin_metademands_tickets_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_metademands_tickets_tasks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_metademands_tasks_id` int(10) unsigned NOT NULL DEFAULT 0,
  `level` int(11) NOT NULL DEFAULT 0,
  `tickets_id` int(10) unsigned NOT NULL DEFAULT 0,
  `parent_tickets_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `plugin_metademands_tasks_id` (`plugin_metademands_tasks_id`),
  KEY `tickets_id` (`tickets_id`),
  KEY `parent_tickets_id` (`parent_tickets_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_metademands_tickettasks`
--

DROP TABLE IF EXISTS `glpi_plugin_metademands_tickettasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_metademands_tickettasks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `content` text DEFAULT NULL,
  `itilcategories_id` int(10) unsigned DEFAULT 0,
  `type` int(11) NOT NULL DEFAULT 0,
  `status` varchar(255) DEFAULT NULL,
  `actiontime` int(11) NOT NULL DEFAULT 0,
  `requesttypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id_assign` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_assign` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id_requester` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_requester` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id_observer` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_observer` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_metademands_tasks_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `plugin_metademands_tasks_id` (`plugin_metademands_tasks_id`),
  KEY `itilcategories_id` (`itilcategories_id`),
  KEY `groups_id_assign` (`groups_id_assign`),
  KEY `users_id_assign` (`users_id_assign`),
  KEY `groups_id_requester` (`groups_id_requester`),
  KEY `users_id_requester` (`users_id_requester`),
  KEY `groups_id_observer` (`groups_id_observer`),
  KEY `users_id_observer` (`users_id_observer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_mfa_configs`
--

DROP TABLE IF EXISTS `glpi_plugin_mfa_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_mfa_configs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `local` tinyint(4) NOT NULL DEFAULT 1,
  `mail` tinyint(4) NOT NULL DEFAULT 0,
  `ldap` tinyint(4) NOT NULL DEFAULT 0,
  `external` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_mfa_mfas`
--

DROP TABLE IF EXISTS `glpi_plugin_mfa_mfas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_mfa_mfas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `code` varchar(255) DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_moreticket_closetickets`
--

DROP TABLE IF EXISTS `glpi_plugin_moreticket_closetickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_moreticket_closetickets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tickets_id` int(10) unsigned NOT NULL,
  `date` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `requesters_id` int(10) unsigned NOT NULL DEFAULT 0,
  `documents_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `tickets_id` (`tickets_id`),
  KEY `documents_id` (`documents_id`),
  KEY `requesters_id` (`requesters_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_moreticket_configs`
--

DROP TABLE IF EXISTS `glpi_plugin_moreticket_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_moreticket_configs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `use_waiting` tinyint(4) NOT NULL DEFAULT 0,
  `use_solution` tinyint(4) NOT NULL DEFAULT 0,
  `close_informations` tinyint(4) NOT NULL DEFAULT 0,
  `solution_status` text DEFAULT NULL,
  `waitingtype_mandatory` tinyint(4) NOT NULL DEFAULT 0,
  `date_report_mandatory` tinyint(4) NOT NULL DEFAULT 0,
  `solutiontype_mandatory` tinyint(4) NOT NULL DEFAULT 0,
  `close_followup` tinyint(4) NOT NULL DEFAULT 0,
  `waitingreason_mandatory` tinyint(4) NOT NULL DEFAULT 0,
  `urgency_justification` tinyint(4) NOT NULL DEFAULT 0,
  `urgency_ids` text DEFAULT NULL,
  `use_duration_solution` tinyint(4) NOT NULL DEFAULT 0,
  `is_mandatory_solution` tinyint(4) NOT NULL DEFAULT 0,
  `use_question` tinyint(4) NOT NULL DEFAULT 0,
  `add_save_button` tinyint(4) NOT NULL DEFAULT 0,
  `day_sending` int(1) NOT NULL DEFAULT 0,
  `day_closing` int(1) NOT NULL DEFAULT 0,
  `update_after_document` tinyint(4) NOT NULL DEFAULT 0,
  `update_after_approval` tinyint(4) NOT NULL DEFAULT 0,
  `followup_text` text DEFAULT NULL,
  `closing_with_problem` int(1) NOT NULL DEFAULT 1,
  `add_followup_stop_waiting` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_moreticket_notificationtickets`
--

DROP TABLE IF EXISTS `glpi_plugin_moreticket_notificationtickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_moreticket_notificationtickets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tickets_id` int(10) unsigned NOT NULL,
  `users_id_lastupdater` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_moreticket_urgencytickets`
--

DROP TABLE IF EXISTS `glpi_plugin_moreticket_urgencytickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_moreticket_urgencytickets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tickets_id` int(10) unsigned NOT NULL,
  `justification` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_moreticket_waitingtickets`
--

DROP TABLE IF EXISTS `glpi_plugin_moreticket_waitingtickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_moreticket_waitingtickets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tickets_id` int(10) unsigned NOT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `date_suspension` timestamp NULL DEFAULT NULL,
  `date_report` timestamp NULL DEFAULT NULL,
  `date_end_suspension` timestamp NULL DEFAULT NULL,
  `plugin_moreticket_waitingtypes_id` int(10) unsigned DEFAULT NULL,
  `status` int(10) unsigned NOT NULL DEFAULT 2,
  PRIMARY KEY (`id`),
  KEY `date_suspension` (`date_suspension`),
  KEY `tickets_id` (`tickets_id`),
  KEY `plugin_moreticket_waitingtypes_id` (`plugin_moreticket_waitingtypes_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_moreticket_waitingtypes`
--

DROP TABLE IF EXISTS `glpi_plugin_moreticket_waitingtypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_moreticket_waitingtypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `plugin_moreticket_waitingtypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `completename` text DEFAULT NULL,
  `level` int(10) unsigned NOT NULL DEFAULT 0,
  `ancestors_cache` longtext DEFAULT NULL,
  `sons_cache` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `unicity` (`plugin_moreticket_waitingtypes_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_mreporting_configs`
--

DROP TABLE IF EXISTS `glpi_plugin_mreporting_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_mreporting_configs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `classname` varchar(255) DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 0,
  `is_notified` tinyint(4) NOT NULL DEFAULT 1,
  `show_graph` tinyint(4) NOT NULL DEFAULT 0,
  `show_area` tinyint(4) NOT NULL DEFAULT 0,
  `spline` tinyint(4) NOT NULL DEFAULT 0,
  `show_label` varchar(10) DEFAULT NULL,
  `flip_data` tinyint(4) NOT NULL DEFAULT 0,
  `unit` varchar(10) DEFAULT NULL,
  `default_delay` varchar(10) DEFAULT NULL,
  `condition` varchar(255) DEFAULT NULL,
  `graphtype` varchar(255) DEFAULT 'SVG',
  PRIMARY KEY (`id`),
  KEY `is_active` (`is_active`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_mreporting_dashboards`
--

DROP TABLE IF EXISTS `glpi_plugin_mreporting_dashboards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_mreporting_dashboards` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `users_id` int(10) unsigned NOT NULL,
  `reports_id` int(10) unsigned NOT NULL,
  `configuration` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_mreporting_notifications`
--

DROP TABLE IF EXISTS `glpi_plugin_mreporting_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_mreporting_notifications` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `notepad` longtext DEFAULT NULL,
  `date_envoie` date DEFAULT NULL,
  `notice` int(10) unsigned NOT NULL DEFAULT 0,
  `alert` int(10) unsigned NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_mreporting_preferences`
--

DROP TABLE IF EXISTS `glpi_plugin_mreporting_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_mreporting_preferences` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `template` varchar(255) DEFAULT NULL,
  `selectors` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `users_id` (`users_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_mreporting_profiles`
--

DROP TABLE IF EXISTS `glpi_plugin_mreporting_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_mreporting_profiles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `profiles_id` int(10) unsigned NOT NULL DEFAULT 0,
  `reports` int(11) NOT NULL DEFAULT 0,
  `right` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `profiles_id_reports` (`profiles_id`,`reports`)
) ENGINE=InnoDB AUTO_INCREMENT=425 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_mydashboard_alerts`
--

DROP TABLE IF EXISTS `glpi_plugin_mydashboard_alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_mydashboard_alerts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reminders_id` int(10) unsigned NOT NULL,
  `impact` tinyint(4) NOT NULL,
  `type` tinyint(4) NOT NULL,
  `is_public` tinyint(4) NOT NULL,
  `itilcategories_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_mydashboard_configs`
--

DROP TABLE IF EXISTS `glpi_plugin_mydashboard_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_mydashboard_configs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `enable_fullscreen` tinyint(4) NOT NULL DEFAULT 1,
  `display_menu` tinyint(4) NOT NULL DEFAULT 1,
  `replace_central` int(10) unsigned NOT NULL DEFAULT 0,
  `google_api_key` varchar(255) DEFAULT NULL,
  `impact_1` varchar(200) NOT NULL DEFAULT '#228b22',
  `impact_2` varchar(200) NOT NULL DEFAULT '#fff03a',
  `impact_3` varchar(200) NOT NULL DEFAULT '#ffa500',
  `impact_4` varchar(200) NOT NULL DEFAULT '#cd5c5c',
  `impact_5` varchar(200) NOT NULL DEFAULT '#8b0000',
  `levelCat` int(10) unsigned NOT NULL DEFAULT 2,
  `title_alerts_widget` varchar(255) DEFAULT NULL,
  `title_maintenances_widget` varchar(255) DEFAULT NULL,
  `title_informations_widget` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_mydashboard_configtranslations`
--

DROP TABLE IF EXISTS `glpi_plugin_mydashboard_configtranslations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_mydashboard_configtranslations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) DEFAULT NULL,
  `language` varchar(5) DEFAULT NULL,
  `field` varchar(100) DEFAULT NULL,
  `value` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_mydashboard_customswidgets`
--

DROP TABLE IF EXISTS `glpi_plugin_mydashboard_customswidgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_mydashboard_customswidgets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `comment` text DEFAULT NULL,
  `content` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_mydashboard_dashboards`
--

DROP TABLE IF EXISTS `glpi_plugin_mydashboard_dashboards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_mydashboard_dashboards` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `grid` longtext DEFAULT NULL,
  `profiles_id` int(10) unsigned NOT NULL DEFAULT 0,
  `grid_statesave` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_mydashboard_groupprofiles`
--

DROP TABLE IF EXISTS `glpi_plugin_mydashboard_groupprofiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_mydashboard_groupprofiles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `groups_id` varchar(255) NOT NULL DEFAULT '[]',
  `profiles_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_mydashboard_itilalerts`
--

DROP TABLE IF EXISTS `glpi_plugin_mydashboard_itilalerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_mydashboard_itilalerts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reminders_id` int(10) unsigned NOT NULL DEFAULT 0,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) NOT NULL COMMENT 'see .class.php file',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_mydashboard_preferences`
--

DROP TABLE IF EXISTS `glpi_plugin_mydashboard_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_mydashboard_preferences` (
  `id` int(10) unsigned NOT NULL COMMENT 'RELATION to glpi_users(id)',
  `automatic_refresh` tinyint(4) NOT NULL DEFAULT 0,
  `automatic_refresh_delay` int(10) unsigned NOT NULL DEFAULT 10,
  `nb_widgets_width` int(10) unsigned NOT NULL DEFAULT 3,
  `replace_central` tinyint(4) NOT NULL DEFAULT 0,
  `prefered_group` varchar(255) NOT NULL DEFAULT '[]',
  `prefered_entity` int(10) unsigned NOT NULL DEFAULT 0,
  `edit_mode` tinyint(4) NOT NULL DEFAULT 0,
  `drag_mode` tinyint(4) NOT NULL DEFAULT 0,
  `requester_prefered_group` varchar(255) NOT NULL DEFAULT '[]',
  `color_palette` varchar(50) NOT NULL DEFAULT '',
  `prefered_type` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_mydashboard_preferenceuserblacklists`
--

DROP TABLE IF EXISTS `glpi_plugin_mydashboard_preferenceuserblacklists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_mydashboard_preferenceuserblacklists` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `users_id` int(10) unsigned NOT NULL COMMENT 'RELATION to glpi_users(id)',
  `plugin_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_mydashboard_profileauthorizedwidgets`
--

DROP TABLE IF EXISTS `glpi_plugin_mydashboard_profileauthorizedwidgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_mydashboard_profileauthorizedwidgets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `profiles_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_profiles (id)',
  `widgets_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_mydashboard_widgets (id)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_mydashboard_stockticketindicators`
--

DROP TABLE IF EXISTS `glpi_plugin_mydashboard_stockticketindicators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_mydashboard_stockticketindicators` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `year` int(10) unsigned NOT NULL,
  `week` int(10) unsigned NOT NULL,
  `nbTickets` int(10) unsigned NOT NULL,
  `indicator_id` int(10) unsigned NOT NULL,
  `groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_mydashboard_stocktickets`
--

DROP TABLE IF EXISTS `glpi_plugin_mydashboard_stocktickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_mydashboard_stocktickets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `nbstocktickets` int(10) unsigned NOT NULL,
  `entities_id` int(10) unsigned NOT NULL,
  `groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_mydashboard_stockwidgets`
--

DROP TABLE IF EXISTS `glpi_plugin_mydashboard_stockwidgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_mydashboard_stockwidgets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL,
  `states` longtext DEFAULT NULL,
  `itemtype` varchar(100) NOT NULL COMMENT 'see .class.php file',
  `icon` varchar(255) NOT NULL,
  `types` longtext DEFAULT NULL,
  `alarm_threshold` int(10) unsigned NOT NULL DEFAULT 5,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_mydashboard_userwidgets`
--

DROP TABLE IF EXISTS `glpi_plugin_mydashboard_userwidgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_mydashboard_userwidgets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `users_id` int(10) unsigned NOT NULL COMMENT 'RELATION to glpi_users(id)',
  `profiles_id` int(10) unsigned NOT NULL DEFAULT 0,
  `widgets_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `users_id` (`users_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_mydashboard_widgets`
--

DROP TABLE IF EXISTS `glpi_plugin_mydashboard_widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_mydashboard_widgets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_news_alerts`
--

DROP TABLE IF EXISTS `glpi_plugin_news_alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_news_alerts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_mod` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `name` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `date_start` timestamp NULL DEFAULT NULL,
  `date_end` timestamp NULL DEFAULT NULL,
  `type` int(11) NOT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_displayed_onlogin` tinyint(4) NOT NULL,
  `is_displayed_oncentral` tinyint(4) NOT NULL,
  `display_dates` tinyint(4) NOT NULL DEFAULT 1,
  `background_color` varchar(255) NOT NULL DEFAULT 'white',
  `text_color` varchar(255) NOT NULL DEFAULT 'dark',
  `emphasis_color` varchar(255) NOT NULL DEFAULT 'dark',
  `size` varchar(255) NOT NULL DEFAULT 'medium',
  `icon` varchar(255) NOT NULL,
  `entities_id` int(10) unsigned NOT NULL,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 1,
  `is_displayed_onhelpdesk` tinyint(4) NOT NULL DEFAULT 0,
  `date_creation` date DEFAULT NULL,
  `is_close_allowed` tinyint(4) NOT NULL DEFAULT 0,
  `is_active` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `date_creation` (`date_creation`),
  KEY `is_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_news_alerts_targets`
--

DROP TABLE IF EXISTS `glpi_plugin_news_alerts_targets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_news_alerts_targets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_news_alerts_id` int(10) unsigned NOT NULL,
  `itemtype` varchar(255) NOT NULL,
  `items_id` int(10) unsigned NOT NULL,
  `all_items` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `alert_itemtype_items_id` (`plugin_news_alerts_id`,`itemtype`,`items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_news_alerts_users`
--

DROP TABLE IF EXISTS `glpi_plugin_news_alerts_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_news_alerts_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_news_alerts_id` int(10) unsigned NOT NULL,
  `users_id` int(10) unsigned NOT NULL,
  `state` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `state_for_user` (`plugin_news_alerts_id`,`users_id`,`state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_oauthimap_applications`
--

DROP TABLE IF EXISTS `glpi_plugin_oauthimap_applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_oauthimap_applications` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `provider` varchar(255) NOT NULL,
  `client_id` text NOT NULL,
  `client_secret` text NOT NULL,
  `tenant_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `is_active` (`is_active`),
  KEY `date_creation` (`date_creation`),
  KEY `date_mod` (`date_mod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_oauthimap_authorizations`
--

DROP TABLE IF EXISTS `glpi_plugin_oauthimap_authorizations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_oauthimap_authorizations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_oauthimap_applications_id` int(10) unsigned NOT NULL DEFAULT 0,
  `code` text DEFAULT NULL,
  `token` text DEFAULT NULL,
  `refresh_token` text DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`plugin_oauthimap_applications_id`,`email`),
  KEY `plugin_oauthimap_applications_id` (`plugin_oauthimap_applications_id`),
  KEY `date_creation` (`date_creation`),
  KEY `date_mod` (`date_mod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_onetimesecret_configs`
--

DROP TABLE IF EXISTS `glpi_plugin_onetimesecret_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_onetimesecret_configs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `server` varchar(255) NOT NULL DEFAULT 'onetimesecret.com',
  `email` varchar(255) NOT NULL DEFAULT '',
  `apikey` varchar(255) NOT NULL DEFAULT '',
  `lifetime` int(11) NOT NULL DEFAULT 24,
  `debug` tinyint(1) NOT NULL DEFAULT 1,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_onetimesecret_links`
--

DROP TABLE IF EXISTS `glpi_plugin_onetimesecret_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_onetimesecret_links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `secret` varchar(255) NOT NULL DEFAULT '',
  `ttl` int(11) NOT NULL DEFAULT 24,
  `passphrase` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_order_accountsections`
--

DROP TABLE IF EXISTS `glpi_plugin_order_accountsections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_order_accountsections` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_order_analyticnatures`
--

DROP TABLE IF EXISTS `glpi_plugin_order_analyticnatures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_order_analyticnatures` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_order_bills`
--

DROP TABLE IF EXISTS `glpi_plugin_order_bills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_order_bills` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT '',
  `number` varchar(255) DEFAULT '',
  `billdate` timestamp NULL DEFAULT NULL,
  `validationdate` timestamp NULL DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `plugin_order_billstates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `value` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `plugin_order_billtypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `suppliers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_order_orders_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_validation` int(10) unsigned NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` int(11) NOT NULL DEFAULT 0,
  `notepad` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_order_billstates`
--

DROP TABLE IF EXISTS `glpi_plugin_order_billstates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_order_billstates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_order_billtypes`
--

DROP TABLE IF EXISTS `glpi_plugin_order_billtypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_order_billtypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_order_configs`
--

DROP TABLE IF EXISTS `glpi_plugin_order_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_order_configs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `use_validation` tinyint(4) NOT NULL DEFAULT 0,
  `use_supplier_satisfaction` tinyint(4) NOT NULL DEFAULT 0,
  `use_supplier_informations` tinyint(4) NOT NULL DEFAULT 0,
  `use_supplier_infos` tinyint(4) NOT NULL DEFAULT 1,
  `generate_order_pdf` tinyint(4) NOT NULL DEFAULT 0,
  `copy_documents` tinyint(4) NOT NULL DEFAULT 0,
  `default_taxes` int(11) NOT NULL DEFAULT 0,
  `generate_assets` int(11) NOT NULL DEFAULT 0,
  `generated_name` varchar(255) DEFAULT NULL,
  `generated_serial` varchar(255) DEFAULT NULL,
  `generated_otherserial` varchar(255) DEFAULT NULL,
  `default_asset_states_id` int(10) unsigned NOT NULL DEFAULT 0,
  `tickettemplates_id_delivery` int(10) unsigned NOT NULL DEFAULT 0,
  `order_status_draft` int(11) NOT NULL DEFAULT 1,
  `order_status_waiting_approval` int(11) NOT NULL DEFAULT 2,
  `order_status_approved` int(11) NOT NULL DEFAULT 3,
  `order_status_partially_delivred` int(11) NOT NULL DEFAULT 4,
  `order_status_completly_delivered` int(11) NOT NULL DEFAULT 5,
  `order_status_canceled` int(11) NOT NULL DEFAULT 6,
  `order_status_paid` int(11) NOT NULL DEFAULT 7,
  `order_analyticnature_display` int(11) NOT NULL DEFAULT 0,
  `order_analyticnature_mandatory` int(11) NOT NULL DEFAULT 0,
  `order_accountsection_display` int(11) NOT NULL DEFAULT 0,
  `order_accountsection_mandatory` int(11) NOT NULL DEFAULT 0,
  `shoudbedelivered_color` char(20) DEFAULT '#ff5555',
  `documentcategories_id` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id_author` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id_recipient` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_recipient` int(10) unsigned NOT NULL DEFAULT 0,
  `add_location` tinyint(4) NOT NULL DEFAULT 0,
  `add_bill_details` tinyint(4) NOT NULL DEFAULT 0,
  `add_immobilization_number` tinyint(4) NOT NULL DEFAULT 0,
  `hide_inactive_budgets` tinyint(4) NOT NULL DEFAULT 0,
  `rename_documents` tinyint(4) NOT NULL DEFAULT 0,
  `transmit_budget_change` tinyint(4) NOT NULL DEFAULT 0,
  `use_free_reference` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_order_deliverystates`
--

DROP TABLE IF EXISTS `glpi_plugin_order_deliverystates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_order_deliverystates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_order_documentcategories`
--

DROP TABLE IF EXISTS `glpi_plugin_order_documentcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_order_documentcategories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `documentcategories_id` int(10) unsigned NOT NULL DEFAULT 0,
  `documentcategories_prefix` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`documentcategories_id`,`documentcategories_prefix`),
  KEY `documentcategories_id` (`documentcategories_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_order_orderpayments`
--

DROP TABLE IF EXISTS `glpi_plugin_order_orderpayments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_order_orderpayments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_order_orders`
--

DROP TABLE IF EXISTS `glpi_plugin_order_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_order_orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_template` tinyint(4) NOT NULL DEFAULT 0,
  `template_name` varchar(255) DEFAULT NULL,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `num_order` varchar(255) DEFAULT NULL,
  `budgets_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_budgets (id)',
  `plugin_order_ordertaxes_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_order_ordertaxes (id)',
  `plugin_order_orderpayments_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_order_orderpayments (id)',
  `order_date` date DEFAULT NULL,
  `duedate` date DEFAULT NULL,
  `deliverydate` date DEFAULT NULL,
  `is_late` tinyint(4) NOT NULL DEFAULT 0,
  `suppliers_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_suppliers (id)',
  `contacts_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_contacts (id)',
  `plugin_order_accountsections_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to plugin_order_accountsections (id)',
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_locations (id)',
  `plugin_order_orderstates_id` int(10) unsigned NOT NULL DEFAULT 1,
  `plugin_order_billstates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `port_price` float NOT NULL DEFAULT 0,
  `global_discount` float NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `notepad` longtext DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_delivery` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id_delivery` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_order_ordertypes_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_order_ordertypes (id)',
  `date_mod` timestamp NULL DEFAULT NULL,
  `is_helpdesk_visible` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `plugin_order_ordertaxes_id` (`plugin_order_ordertaxes_id`),
  KEY `plugin_order_orderpayments_id` (`plugin_order_orderpayments_id`),
  KEY `states_id` (`plugin_order_orderstates_id`),
  KEY `suppliers_id` (`suppliers_id`),
  KEY `contacts_id` (`contacts_id`),
  KEY `plugin_order_accountsections_id` (`plugin_order_accountsections_id`),
  KEY `locations_id` (`locations_id`),
  KEY `is_late` (`is_late`),
  KEY `is_template` (`is_template`),
  KEY `is_deleted` (`is_deleted`),
  KEY `date_mod` (`date_mod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_order_orders_items`
--

DROP TABLE IF EXISTS `glpi_plugin_order_orders_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_order_orders_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `plugin_order_orders_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_order_orders (id)',
  `itemtype` varchar(100) NOT NULL COMMENT 'see .class.php file',
  `items_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to various tables, according to itemtype (id)',
  `plugin_order_references_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_order_references (id)',
  `plugin_order_deliverystates_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_order_deliverystates (id)',
  `plugin_order_ordertaxes_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_order_ordertaxes (id)',
  `plugin_order_analyticnatures_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to plugin_order_analyticnatures (id)',
  `delivery_number` varchar(255) DEFAULT NULL,
  `delivery_comment` text DEFAULT NULL,
  `price_taxfree` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `price_discounted` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `discount` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `price_ati` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `states_id` int(10) unsigned NOT NULL DEFAULT 1,
  `delivery_date` date DEFAULT NULL,
  `plugin_order_bills_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_order_billstates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_device` (`items_id`,`itemtype`),
  KEY `entities_id` (`entities_id`),
  KEY `item` (`itemtype`,`items_id`),
  KEY `plugin_order_references_id` (`plugin_order_references_id`),
  KEY `plugin_order_deliverystates_id` (`plugin_order_deliverystates_id`),
  KEY `plugin_order_analyticnatures_id` (`plugin_order_analyticnatures_id`),
  KEY `states_id` (`states_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_order_orders_suppliers`
--

DROP TABLE IF EXISTS `glpi_plugin_order_orders_suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_order_orders_suppliers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `plugin_order_orders_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_order_orders (id)',
  `suppliers_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_suppliers (id)',
  `num_quote` varchar(255) DEFAULT NULL,
  `num_order` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plugin_order_orders_id` (`plugin_order_orders_id`),
  KEY `entities_id` (`entities_id`),
  KEY `suppliers_id` (`suppliers_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_order_orderstates`
--

DROP TABLE IF EXISTS `glpi_plugin_order_orderstates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_order_orderstates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_order_ordertaxes`
--

DROP TABLE IF EXISTS `glpi_plugin_order_ordertaxes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_order_ordertaxes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_order_ordertypes`
--

DROP TABLE IF EXISTS `glpi_plugin_order_ordertypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_order_ordertypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_order_others`
--

DROP TABLE IF EXISTS `glpi_plugin_order_others`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_order_others` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `plugin_order_othertypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `plugin_order_othertypes_id` (`plugin_order_othertypes_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_order_othertypes`
--

DROP TABLE IF EXISTS `glpi_plugin_order_othertypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_order_othertypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_order_preferences`
--

DROP TABLE IF EXISTS `glpi_plugin_order_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_order_preferences` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `template` varchar(255) DEFAULT NULL,
  `sign` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `users_id` (`users_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_order_referencefrees`
--

DROP TABLE IF EXISTS `glpi_plugin_order_referencefrees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_order_referencefrees` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `plugin_order_orders_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_order_orders (id)',
  `name` varchar(255) DEFAULT NULL,
  `manufacturers_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_manufacturers (id)',
  `manufacturers_reference` varchar(255) NOT NULL DEFAULT '',
  `itemtype` varchar(100) NOT NULL COMMENT 'see .class.php file',
  `templates_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to various tables, according to itemtype (id)',
  `comment` text DEFAULT NULL,
  `price_taxfree` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `price_discounted` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `discount` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `price_ati` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `states_id` int(10) unsigned NOT NULL DEFAULT 1,
  `delivery_date` date DEFAULT NULL,
  `plugin_order_ordertaxes_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_order_ordertaxes (id)',
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_active` tinyint(4) NOT NULL DEFAULT 1,
  `notepad` longtext DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `manufacturers_id` (`manufacturers_id`),
  KEY `templates_id` (`templates_id`),
  KEY `plugin_order_ordertaxes_id` (`plugin_order_ordertaxes_id`),
  KEY `states_id` (`states_id`),
  KEY `is_active` (`is_active`),
  KEY `is_deleted` (`is_deleted`),
  KEY `date_mod` (`date_mod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_order_references`
--

DROP TABLE IF EXISTS `glpi_plugin_order_references`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_order_references` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `manufacturers_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_manufacturers (id)',
  `manufacturers_reference` varchar(255) NOT NULL DEFAULT '',
  `types_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to various tables, according to itemtypes tables (id)',
  `models_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to various tables, according to itemmodels tables (id)',
  `itemtype` varchar(100) NOT NULL COMMENT 'see .class.php file',
  `templates_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to various tables, according to itemtype (id)',
  `comment` text DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_active` tinyint(4) NOT NULL DEFAULT 1,
  `notepad` longtext DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `manufacturers_id` (`manufacturers_id`),
  KEY `types_id` (`types_id`),
  KEY `models_id` (`models_id`),
  KEY `templates_id` (`templates_id`),
  KEY `is_active` (`is_active`),
  KEY `is_deleted` (`is_deleted`),
  KEY `date_mod` (`date_mod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_order_references_suppliers`
--

DROP TABLE IF EXISTS `glpi_plugin_order_references_suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_order_references_suppliers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `plugin_order_references_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_order_references (id)',
  `suppliers_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_suppliers (id)',
  `price_taxfree` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `reference_code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entities_id` (`entities_id`),
  KEY `plugin_order_references_id` (`plugin_order_references_id`),
  KEY `suppliers_id` (`suppliers_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_order_surveysuppliers`
--

DROP TABLE IF EXISTS `glpi_plugin_order_surveysuppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_order_surveysuppliers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `plugin_order_orders_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_order_orders (id)',
  `suppliers_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_suppliers (id)',
  `answer1` int(11) NOT NULL DEFAULT 0,
  `answer2` int(11) NOT NULL DEFAULT 0,
  `answer3` int(11) NOT NULL DEFAULT 0,
  `answer4` int(11) NOT NULL DEFAULT 0,
  `answer5` int(11) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plugin_order_orders_id` (`plugin_order_orders_id`),
  KEY `entities_id` (`entities_id`),
  KEY `suppliers_id` (`suppliers_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_pdf_configs`
--

DROP TABLE IF EXISTS `glpi_plugin_pdf_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_pdf_configs` (
  `id` int(10) unsigned NOT NULL,
  `currency` varchar(15) DEFAULT NULL,
  `add_text` varchar(255) DEFAULT NULL,
  `use_branding_logo` tinyint(1) DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_pdf_preferences`
--

DROP TABLE IF EXISTS `glpi_plugin_pdf_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_pdf_preferences` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `users_id` int(10) unsigned NOT NULL COMMENT 'RELATION to glpi_users (id)',
  `itemtype` varchar(100) NOT NULL COMMENT 'see define.php *_TYPE constant',
  `tabref` varchar(255) NOT NULL COMMENT 'ref of tab to display, or plugname_#, or option name',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_positions_configs`
--

DROP TABLE IF EXISTS `glpi_plugin_positions_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_positions_configs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `use_view_all_object` tinyint(4) NOT NULL DEFAULT 0,
  `default_width` int(10) unsigned NOT NULL DEFAULT 25,
  `default_height` int(10) unsigned NOT NULL DEFAULT 30,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_positions_imageitems`
--

DROP TABLE IF EXISTS `glpi_plugin_positions_imageitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_positions_imageitems` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) NOT NULL COMMENT 'see .class.php file',
  `img` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_positions_infos`
--

DROP TABLE IF EXISTS `glpi_plugin_positions_infos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_positions_infos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `itemtype` varchar(100) NOT NULL COMMENT 'see .class.php file',
  `fields` text NOT NULL,
  `comment` text DEFAULT NULL,
  `notepad` longtext DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_positions_positions`
--

DROP TABLE IF EXISTS `glpi_plugin_positions_positions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_positions_positions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to table glpi_locations',
  `items_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to various tables, according to itemtype (id)',
  `itemtype` varchar(100) NOT NULL COMMENT 'see .class.php file',
  `x_coordinates` int(11) NOT NULL DEFAULT 0,
  `y_coordinates` int(11) NOT NULL DEFAULT 0,
  `width` int(10) unsigned NOT NULL DEFAULT 25,
  `height` int(10) unsigned NOT NULL DEFAULT 30,
  `tooltip` varchar(255) DEFAULT NULL,
  `color` varchar(255) DEFAULT NULL,
  `outline` varchar(255) DEFAULT NULL,
  `outlineWidth` int(10) unsigned NOT NULL DEFAULT 1,
  `shape` varchar(255) DEFAULT NULL,
  `hideLabel` tinyint(4) NOT NULL DEFAULT 0,
  `hideTooltip` tinyint(4) NOT NULL DEFAULT 0,
  `rotate` int(10) unsigned NOT NULL DEFAULT 0,
  `pattern` varchar(255) DEFAULT NULL,
  `labelSize` decimal(11,2) NOT NULL DEFAULT 1.00,
  `notepad` longtext DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `date_mod` (`date_mod`),
  KEY `is_deleted` (`is_deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_printercounters_additionals_datas`
--

DROP TABLE IF EXISTS `glpi_plugin_printercounters_additionals_datas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_printercounters_additionals_datas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `sub_type` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `plugin_printercounters_items_recordmodels_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`plugin_printercounters_items_recordmodels_id`,`sub_type`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_printercounters_billingmodels`
--

DROP TABLE IF EXISTS `glpi_plugin_printercounters_billingmodels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_printercounters_billingmodels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `application_date` timestamp NULL DEFAULT NULL,
  `plugin_printercounters_recordmodels_id` int(10) unsigned NOT NULL DEFAULT 0,
  `contracts_id` int(10) unsigned NOT NULL DEFAULT 0,
  `budgets_id` int(10) unsigned NOT NULL DEFAULT 0,
  `suppliers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plugin_printercounters_recordmodels_id` (`plugin_printercounters_recordmodels_id`),
  KEY `contracts_id` (`contracts_id`),
  KEY `budgets_id` (`budgets_id`),
  KEY `suppliers_id` (`suppliers_id`),
  KEY `entities_id` (`entities_id`),
  KEY `application_date` (`application_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_printercounters_budgets`
--

DROP TABLE IF EXISTS `glpi_plugin_printercounters_budgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_printercounters_budgets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned DEFAULT NULL,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `amount` int(10) unsigned NOT NULL DEFAULT 0,
  `begin_date` timestamp NULL DEFAULT NULL,
  `end_date` timestamp NULL DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entities_id` (`entities_id`),
  KEY `begin_date` (`begin_date`),
  KEY `end_date` (`end_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_printercounters_configs`
--

DROP TABLE IF EXISTS `glpi_plugin_printercounters_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_printercounters_configs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nb_errors_ticket` int(10) unsigned NOT NULL DEFAULT 10,
  `nb_errors_delay_ticket` int(10) unsigned NOT NULL DEFAULT 864000,
  `no_record_delay_ticket` int(10) unsigned NOT NULL DEFAULT 864000,
  `items_status` longtext DEFAULT NULL,
  `tickets_category` int(10) unsigned NOT NULL DEFAULT 0,
  `tickets_content` text DEFAULT NULL,
  `add_item_group` char(1) DEFAULT NULL,
  `add_item_user` char(1) DEFAULT NULL,
  `disable_autosearch` tinyint(4) NOT NULL DEFAULT 0,
  `set_first_record` tinyint(4) NOT NULL DEFAULT 0,
  `enable_toner_alert` tinyint(4) NOT NULL DEFAULT 0,
  `toner_alert_repeat` int(10) unsigned NOT NULL DEFAULT 0,
  `toner_treshold` int(10) unsigned NOT NULL DEFAULT 0,
  `max_error_counter` int(10) unsigned NOT NULL DEFAULT 3,
  `enable_error_handler` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_printercounters_counters`
--

DROP TABLE IF EXISTS `glpi_plugin_printercounters_counters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_printercounters_counters` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `value` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_printercounters_countertypes_recordmodels_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_printercounters_records_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `plugin_printercounters_countertypes_recordmodels_id` (`plugin_printercounters_countertypes_recordmodels_id`),
  KEY `plugin_printercounters_records_id` (`plugin_printercounters_records_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_printercounters_countertypes`
--

DROP TABLE IF EXISTS `glpi_plugin_printercounters_countertypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_printercounters_countertypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` int(10) unsigned NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entities_id` (`entities_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_printercounters_countertypes_recordmodels`
--

DROP TABLE IF EXISTS `glpi_plugin_printercounters_countertypes_recordmodels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_printercounters_countertypes_recordmodels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `oid` varchar(255) DEFAULT NULL,
  `oid_type` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_printercounters_recordmodels_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_printercounters_countertypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`plugin_printercounters_recordmodels_id`,`plugin_printercounters_countertypes_id`),
  KEY `oid_type` (`oid_type`),
  KEY `plugin_printercounters_recordmodels_id` (`plugin_printercounters_recordmodels_id`),
  KEY `plugin_printercounters_countertypes_id` (`plugin_printercounters_countertypes_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_printercounters_items_billingmodels`
--

DROP TABLE IF EXISTS `glpi_plugin_printercounters_items_billingmodels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_printercounters_items_billingmodels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `itemtype` varchar(255) DEFAULT NULL,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_printercounters_billingmodels_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `plugin_printercounters_billingmodels_id` (`plugin_printercounters_billingmodels_id`),
  KEY `items_id` (`items_id`),
  KEY `itemtype` (`itemtype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_printercounters_items_recordmodels`
--

DROP TABLE IF EXISTS `glpi_plugin_printercounters_items_recordmodels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_printercounters_items_recordmodels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nb_retries` int(10) unsigned NOT NULL DEFAULT 0,
  `max_timeout` int(10) unsigned NOT NULL DEFAULT 5,
  `enable_automatic_record` tinyint(4) NOT NULL DEFAULT 0,
  `periodicity` int(10) unsigned NOT NULL DEFAULT 86400,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(255) DEFAULT NULL,
  `active_mutex` timestamp NULL DEFAULT NULL,
  `process_id` int(10) unsigned NOT NULL DEFAULT 0,
  `global_tco` decimal(20,4) DEFAULT 0.0000,
  `plugin_printercounters_recordmodels_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_printercounters_snmpauthentications_id` int(10) unsigned NOT NULL DEFAULT 0,
  `status` int(10) unsigned NOT NULL DEFAULT 0,
  `error_counter` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`plugin_printercounters_recordmodels_id`,`items_id`,`itemtype`),
  KEY `plugin_printercounters_recordmodels_id` (`plugin_printercounters_recordmodels_id`),
  KEY `plugin_printercounters_snmpauthentications_id` (`plugin_printercounters_snmpauthentications_id`),
  KEY `items_id` (`items_id`),
  KEY `itemtype` (`itemtype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_printercounters_items_tickets`
--

DROP TABLE IF EXISTS `glpi_plugin_printercounters_items_tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_printercounters_items_tickets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `itemtype` varchar(255) DEFAULT NULL,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `events_type` int(10) unsigned NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `tickets_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `tickets_id` (`tickets_id`),
  KEY `items_id` (`items_id`),
  KEY `itemtype` (`itemtype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_printercounters_pagecosts`
--

DROP TABLE IF EXISTS `glpi_plugin_printercounters_pagecosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_printercounters_pagecosts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cost` decimal(6,5) NOT NULL DEFAULT 0.00000,
  `plugin_printercounters_billingmodels_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_printercounters_countertypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `plugin_printercounters_billingmodels_id` (`plugin_printercounters_billingmodels_id`),
  KEY `plugin_printercounters_countertypes_id` (`plugin_printercounters_countertypes_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_printercounters_recordmodels`
--

DROP TABLE IF EXISTS `glpi_plugin_printercounters_recordmodels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_printercounters_recordmodels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `mac_address_conformity` tinyint(4) NOT NULL DEFAULT 0,
  `sysdescr_conformity` tinyint(4) NOT NULL DEFAULT 0,
  `serial_conformity` tinyint(4) NOT NULL DEFAULT 0,
  `enable_toner_level` tinyint(4) NOT NULL DEFAULT 0,
  `enable_printer_info` tinyint(4) NOT NULL DEFAULT 0,
  `is_template` tinyint(4) NOT NULL DEFAULT 0,
  `template_name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entities_id` (`entities_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_printercounters_records`
--

DROP TABLE IF EXISTS `glpi_plugin_printercounters_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_printercounters_records` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date` timestamp NULL DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `result` int(10) unsigned NOT NULL DEFAULT 0,
  `state` int(10) unsigned NOT NULL DEFAULT 0,
  `record_type` int(10) unsigned NOT NULL DEFAULT 0,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `last_recordmodels_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_printercounters_items_recordmodels_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `plugin_printercounters_items_recordmodels_id` (`plugin_printercounters_items_recordmodels_id`),
  KEY `date` (`date`),
  KEY `result` (`result`),
  KEY `state` (`state`),
  KEY `record_type` (`record_type`),
  KEY `last_recordmodels_id` (`last_recordmodels_id`),
  KEY `locations_id` (`locations_id`),
  KEY `entities_id` (`entities_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_printercounters_snmpauthentications`
--

DROP TABLE IF EXISTS `glpi_plugin_printercounters_snmpauthentications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_printercounters_snmpauthentications` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `is_default` tinyint(4) NOT NULL DEFAULT 0,
  `version` int(10) unsigned NOT NULL DEFAULT 0,
  `community` varchar(255) DEFAULT 'public',
  `community_write` varchar(255) DEFAULT 'private',
  `authentication_encrypt` int(10) unsigned NOT NULL DEFAULT 0,
  `data_encrypt` int(10) unsigned NOT NULL DEFAULT 0,
  `user` varchar(255) DEFAULT NULL,
  `authentication_password` varchar(255) DEFAULT NULL,
  `data_password` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entities_id` (`entities_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_printercounters_snmpsets`
--

DROP TABLE IF EXISTS `glpi_plugin_printercounters_snmpsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_printercounters_snmpsets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `set_location` tinyint(4) NOT NULL DEFAULT 1,
  `set_contact` tinyint(4) NOT NULL DEFAULT 1,
  `set_name` tinyint(4) NOT NULL DEFAULT 1,
  `contact` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`entities_id`),
  KEY `entities_id` (`entities_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_printercounters_sysdescrs`
--

DROP TABLE IF EXISTS `glpi_plugin_printercounters_sysdescrs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_printercounters_sysdescrs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sysdescr` varchar(255) DEFAULT NULL,
  `plugin_printercounters_recordmodels_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `plugin_printercounters_recordmodels_id` (`plugin_printercounters_recordmodels_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_purchaserequest_configs`
--

DROP TABLE IF EXISTS `glpi_plugin_purchaserequest_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_purchaserequest_configs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_general_service_manager` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_purchaserequest_purchaserequests`
--

DROP TABLE IF EXISTS `glpi_plugin_purchaserequest_purchaserequests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_purchaserequest_purchaserequests` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `itemtype` varchar(255) NOT NULL,
  `types_id` int(10) unsigned NOT NULL DEFAULT 0,
  `due_date` timestamp NULL DEFAULT NULL,
  `users_id_validate` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_creator` int(10) unsigned NOT NULL DEFAULT 0,
  `status` int(10) unsigned NOT NULL DEFAULT 0,
  `comment_validation` text DEFAULT NULL,
  `tickets_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_order_orders_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_purchaserequest_purchaserequeststates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `processing_date` timestamp NULL DEFAULT NULL,
  `invoice_customer` tinyint(4) NOT NULL DEFAULT 0,
  `amount` decimal(20,4) NOT NULL DEFAULT 0.0000,
  PRIMARY KEY (`id`),
  KEY `users_id` (`users_id`),
  KEY `groups_id` (`groups_id`),
  KEY `users_id_validate` (`users_id_validate`),
  KEY `users_id_creator` (`users_id_creator`),
  KEY `tickets_id` (`tickets_id`),
  KEY `is_deleted` (`is_deleted`),
  KEY `date_mod` (`date_mod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_purchaserequest_purchaserequeststates`
--

DROP TABLE IF EXISTS `glpi_plugin_purchaserequest_purchaserequeststates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_purchaserequest_purchaserequeststates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_purchaserequest_thresholds`
--

DROP TABLE IF EXISTS `glpi_plugin_purchaserequest_thresholds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_purchaserequest_thresholds` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `itemtype` varchar(255) DEFAULT NULL,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `thresholds` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_purchaserequest_validations`
--

DROP TABLE IF EXISTS `glpi_plugin_purchaserequest_validations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_purchaserequest_validations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_purchaserequest_purchaserequests_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_validate` int(10) unsigned NOT NULL DEFAULT 0,
  `status` int(10) unsigned NOT NULL DEFAULT 0,
  `comment_validation` text DEFAULT NULL,
  `submission_date` timestamp NULL DEFAULT NULL,
  `validation_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_releases_changes_releases`
--

DROP TABLE IF EXISTS `glpi_plugin_releases_changes_releases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_releases_changes_releases` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_releases_releases_id` int(10) unsigned NOT NULL,
  `changes_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_releases_deploytasks`
--

DROP TABLE IF EXISTS `glpi_plugin_releases_deploytasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_releases_deploytasks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `plugin_releases_releases_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_releases_typedeploytasks_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_releases_risks_id` int(10) unsigned NOT NULL DEFAULT 0,
  `state` int(10) unsigned NOT NULL DEFAULT 1,
  `date` timestamp NULL DEFAULT NULL,
  `begin` timestamp NULL DEFAULT NULL,
  `end` timestamp NULL DEFAULT NULL,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_editor` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `content` longtext DEFAULT NULL,
  `actiontime` int(10) unsigned NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `plugin_releases_deploytasktemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `timeline_position` tinyint(4) NOT NULL DEFAULT 0,
  `plugin_releases_deploytasks_id` int(10) unsigned NOT NULL DEFAULT 0,
  `level` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_releases_deploytasktemplates`
--

DROP TABLE IF EXISTS `glpi_plugin_releases_deploytasktemplates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_releases_deploytasktemplates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `plugin_releases_releasetemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_releases_typedeploytasks_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_releases_risks_id` int(10) unsigned NOT NULL DEFAULT 0,
  `state` int(10) unsigned NOT NULL DEFAULT 1,
  `date` timestamp NULL DEFAULT NULL,
  `begin` timestamp NULL DEFAULT NULL,
  `end` timestamp NULL DEFAULT NULL,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_editor` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `content` longtext DEFAULT NULL,
  `actiontime` int(10) unsigned NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `plugin_releases_deploytasktemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `timeline_position` tinyint(4) NOT NULL DEFAULT 0,
  `level` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_releases_groups_releases`
--

DROP TABLE IF EXISTS `glpi_plugin_releases_groups_releases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_releases_groups_releases` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_releases_releases_id` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `type` int(10) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`plugin_releases_releases_id`,`type`,`groups_id`),
  KEY `group` (`groups_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_releases_groups_releasetemplates`
--

DROP TABLE IF EXISTS `glpi_plugin_releases_groups_releasetemplates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_releases_groups_releasetemplates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_releases_releasetemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `type` int(10) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`plugin_releases_releasetemplates_id`,`type`,`groups_id`),
  KEY `group` (`groups_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_releases_releases`
--

DROP TABLE IF EXISTS `glpi_plugin_releases_releases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_releases_releases` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  `date` timestamp NULL DEFAULT NULL,
  `users_id_recipient` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_lastupdater` int(10) unsigned NOT NULL DEFAULT 0,
  `date_preproduction` timestamp NULL DEFAULT NULL,
  `date_production` timestamp NULL DEFAULT NULL,
  `begin_waiting_date` timestamp NULL DEFAULT NULL,
  `service_shutdown` tinyint(4) NOT NULL DEFAULT 0,
  `service_shutdown_details` longtext DEFAULT NULL,
  `hour_type` tinyint(4) NOT NULL DEFAULT 0,
  `communication` tinyint(4) NOT NULL DEFAULT 0,
  `communication_type` varchar(255) NOT NULL DEFAULT 'ALL',
  `target` longtext DEFAULT NULL,
  `status` int(10) unsigned NOT NULL DEFAULT 7,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `date_end` timestamp NULL DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `is_deleted` (`is_deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_releases_releases_items`
--

DROP TABLE IF EXISTS `glpi_plugin_releases_releases_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_releases_releases_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_releases_releases_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) DEFAULT NULL,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`plugin_releases_releases_id`,`itemtype`,`items_id`),
  KEY `item` (`itemtype`,`items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_releases_releases_suppliers`
--

DROP TABLE IF EXISTS `glpi_plugin_releases_releases_suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_releases_releases_suppliers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_releases_releases_id` int(10) unsigned NOT NULL DEFAULT 0,
  `suppliers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `type` int(10) unsigned NOT NULL DEFAULT 1,
  `use_notification` tinyint(4) NOT NULL DEFAULT 1,
  `alternative_email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`plugin_releases_releases_id`,`type`,`suppliers_id`),
  KEY `group` (`suppliers_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_releases_releases_users`
--

DROP TABLE IF EXISTS `glpi_plugin_releases_releases_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_releases_releases_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_releases_releases_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `type` int(10) unsigned NOT NULL DEFAULT 1,
  `use_notification` tinyint(4) NOT NULL DEFAULT 0,
  `alternative_email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`plugin_releases_releases_id`,`type`,`users_id`),
  KEY `group` (`users_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_releases_releasetemplates`
--

DROP TABLE IF EXISTS `glpi_plugin_releases_releasetemplates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_releases_releasetemplates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  `date_preproduction` timestamp NULL DEFAULT NULL,
  `date_production` timestamp NULL DEFAULT NULL,
  `service_shutdown` tinyint(4) NOT NULL DEFAULT 0,
  `service_shutdown_details` longtext DEFAULT NULL,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `hour_type` tinyint(4) NOT NULL DEFAULT 0,
  `communication` tinyint(4) NOT NULL DEFAULT 0,
  `communication_type` varchar(255) NOT NULL DEFAULT 'ALL',
  `target` longtext DEFAULT NULL,
  `status` int(10) unsigned NOT NULL DEFAULT 7,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `plugin_releases_releasetemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `is_deleted` (`is_deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_releases_releasetemplates_items`
--

DROP TABLE IF EXISTS `glpi_plugin_releases_releasetemplates_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_releases_releasetemplates_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_releases_releasetemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) DEFAULT NULL,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`plugin_releases_releasetemplates_id`,`itemtype`,`items_id`),
  KEY `item` (`itemtype`,`items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_releases_releasetemplates_suppliers`
--

DROP TABLE IF EXISTS `glpi_plugin_releases_releasetemplates_suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_releases_releasetemplates_suppliers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_releases_releasetemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `suppliers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `type` int(10) unsigned NOT NULL DEFAULT 1,
  `use_notification` tinyint(4) NOT NULL DEFAULT 1,
  `alternative_email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`plugin_releases_releasetemplates_id`,`type`,`suppliers_id`),
  KEY `group` (`suppliers_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_releases_releasetemplates_users`
--

DROP TABLE IF EXISTS `glpi_plugin_releases_releasetemplates_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_releases_releasetemplates_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_releases_releasetemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `type` int(10) unsigned NOT NULL DEFAULT 1,
  `use_notification` tinyint(4) NOT NULL DEFAULT 0,
  `alternative_email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`plugin_releases_releasetemplates_id`,`type`,`users_id`),
  KEY `group` (`users_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_releases_reviews`
--

DROP TABLE IF EXISTS `glpi_plugin_releases_reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_releases_reviews` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `plugin_releases_releases_id` int(10) unsigned NOT NULL DEFAULT 0,
  `real_date_release` timestamp NULL DEFAULT NULL,
  `conforming_realization` tinyint(4) NOT NULL DEFAULT 0,
  `incident` tinyint(4) NOT NULL DEFAULT 0,
  `incident_description` longtext DEFAULT NULL,
  `date_lock` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_releases_risks`
--

DROP TABLE IF EXISTS `glpi_plugin_releases_risks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_releases_risks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_releases_releases_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_releases_typerisks_id` int(10) unsigned NOT NULL DEFAULT 0,
  `state` int(10) unsigned NOT NULL DEFAULT 1,
  `name` varchar(255) DEFAULT NULL,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_editor` int(10) unsigned NOT NULL DEFAULT 0,
  `content` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_releases_risktemplates`
--

DROP TABLE IF EXISTS `glpi_plugin_releases_risktemplates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_releases_risktemplates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_releases_releasetemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_releases_typerisks_id` int(10) unsigned NOT NULL DEFAULT 0,
  `state` int(10) unsigned NOT NULL DEFAULT 1,
  `name` varchar(255) DEFAULT NULL,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_editor` int(10) unsigned NOT NULL DEFAULT 0,
  `content` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_releases_rollbacks`
--

DROP TABLE IF EXISTS `glpi_plugin_releases_rollbacks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_releases_rollbacks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_releases_releases_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `state` int(10) unsigned NOT NULL DEFAULT 1,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_editor` int(10) unsigned NOT NULL DEFAULT 0,
  `content` longtext DEFAULT NULL,
  `plugin_releases_rollbacktemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_releases_rollbacktemplates`
--

DROP TABLE IF EXISTS `glpi_plugin_releases_rollbacktemplates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_releases_rollbacktemplates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_releases_releasetemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `state` int(10) unsigned NOT NULL DEFAULT 1,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_editor` int(10) unsigned NOT NULL DEFAULT 0,
  `content` longtext DEFAULT NULL,
  `plugin_releases_rollbacktemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_releases_tests`
--

DROP TABLE IF EXISTS `glpi_plugin_releases_tests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_releases_tests` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_releases_releases_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_releases_typetests_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_releases_risks_id` int(10) unsigned NOT NULL DEFAULT 0,
  `state` int(10) unsigned NOT NULL DEFAULT 1,
  `name` varchar(255) DEFAULT NULL,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_editor` int(10) unsigned NOT NULL DEFAULT 0,
  `content` longtext DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_releases_testtemplates`
--

DROP TABLE IF EXISTS `glpi_plugin_releases_testtemplates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_releases_testtemplates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_releases_releasetemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_releases_typetests_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_releases_risks_id` int(10) unsigned NOT NULL DEFAULT 0,
  `state` int(10) unsigned NOT NULL DEFAULT 1,
  `name` varchar(255) DEFAULT NULL,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_editor` int(10) unsigned NOT NULL DEFAULT 0,
  `content` longtext DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_releases_typedeploytasks`
--

DROP TABLE IF EXISTS `glpi_plugin_releases_typedeploytasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_releases_typedeploytasks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `plugin_releases_typedeploytasks_id` int(10) unsigned NOT NULL DEFAULT 0,
  `completename` text DEFAULT NULL,
  `level` int(10) unsigned NOT NULL DEFAULT 0,
  `ancestors_cache` longtext DEFAULT NULL,
  `sons_cache` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_releases_typerisks`
--

DROP TABLE IF EXISTS `glpi_plugin_releases_typerisks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_releases_typerisks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `plugin_releases_typerisks_id` int(10) unsigned NOT NULL DEFAULT 0,
  `completename` text DEFAULT NULL,
  `level` int(10) unsigned NOT NULL DEFAULT 0,
  `ancestors_cache` longtext DEFAULT NULL,
  `sons_cache` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_releases_typetests`
--

DROP TABLE IF EXISTS `glpi_plugin_releases_typetests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_releases_typetests` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `plugin_releases_typetests_id` int(10) unsigned NOT NULL DEFAULT 0,
  `completename` text DEFAULT NULL,
  `level` int(10) unsigned NOT NULL DEFAULT 0,
  `ancestors_cache` longtext DEFAULT NULL,
  `sons_cache` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_actionprofiles`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_actionprofiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_actionprofiles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `actions_id` varchar(255) NOT NULL DEFAULT '0',
  `profiles_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_adconfigs`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_adconfigs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_adconfigs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `auth_id` int(10) unsigned NOT NULL DEFAULT 0,
  `login` varchar(255) DEFAULT '',
  `password` varchar(255) DEFAULT '',
  `creation_categories_id` text NOT NULL,
  `modification_categories_id` text NOT NULL,
  `deletion_categories_id` text NOT NULL,
  `logAD` varchar(255) DEFAULT '',
  `nameAD` varchar(255) DEFAULT '',
  `phoneAD` varchar(255) DEFAULT NULL,
  `companyAD` varchar(255) DEFAULT '',
  `departmentAD` varchar(255) DEFAULT '',
  `firstnameAD` varchar(255) DEFAULT '',
  `mailAD` varchar(255) DEFAULT '',
  `contractEndAD` varchar(255) DEFAULT '',
  `contractTypeAD` varchar(255) DEFAULT '',
  `ouDesactivateUserAD` varchar(255) DEFAULT '',
  `ouUser` varchar(255) DEFAULT '',
  `cellPhoneAD` varchar(255) DEFAULT '',
  `roleAD` varchar(255) DEFAULT '',
  `serviceAD` varchar(255) DEFAULT '',
  `locationAD` varchar(255) DEFAULT '',
  `first_form` int(10) unsigned NOT NULL DEFAULT 0,
  `second_form` int(10) unsigned NOT NULL DEFAULT 0,
  `mail_prefix` int(10) unsigned NOT NULL DEFAULT 0,
  `mail_suffix` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_budgets`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_budgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_budgets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `plugin_resources_professions_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_resources_professions (id)',
  `plugin_resources_ranks_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_resources_ranks (id)',
  `plugin_resources_budgettypes_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_resources_budgettypes (id)',
  `plugin_resources_budgetvolumes_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_resources_budgetvolumes (id)',
  `begin_date` timestamp NULL DEFAULT NULL,
  `end_date` timestamp NULL DEFAULT NULL,
  `volume` int(10) unsigned NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `plugin_resources_professions_id` (`plugin_resources_professions_id`),
  KEY `plugin_resources_ranks_id` (`plugin_resources_ranks_id`),
  KEY `plugin_resources_budgettypes_id` (`plugin_resources_budgettypes_id`),
  KEY `plugin_resources_budgetvolumes_id` (`plugin_resources_budgetvolumes_id`),
  KEY `date_mod` (`date_mod`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_budgettypes`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_budgettypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_budgettypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_budgetvolumes`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_budgetvolumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_budgetvolumes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_businessunits`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_businessunits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_businessunits` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_candidateorigins`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_candidateorigins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_candidateorigins` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_checklistconfigs`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_checklistconfigs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_checklistconfigs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `tag` tinyint(4) NOT NULL DEFAULT 0,
  `address` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `itemtype` varchar(255) DEFAULT '',
  `items` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_checklists`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_checklists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_checklists` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_resources_resources_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_resources_resources (id)',
  `plugin_resources_tasks_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_resources_tasks (id)',
  `plugin_resources_contracttypes_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_resources_contracttypes (id)',
  `checklist_type` int(10) unsigned NOT NULL DEFAULT 0,
  `tag` tinyint(4) NOT NULL DEFAULT 0,
  `is_checked` tinyint(4) NOT NULL DEFAULT 0,
  `address` varchar(255) DEFAULT NULL,
  `rank` smallint(6) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `plugin_resources_resources_id` (`plugin_resources_resources_id`),
  KEY `plugin_resources_tasks_id` (`plugin_resources_tasks_id`),
  KEY `plugin_resources_contracttypes_id` (`plugin_resources_contracttypes_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_choiceitems`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_choiceitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_choiceitems` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `plugin_resources_choiceitems_id` int(10) unsigned NOT NULL DEFAULT 0,
  `completename` text DEFAULT NULL,
  `level` int(10) unsigned NOT NULL DEFAULT 0,
  `ancestors_cache` longtext DEFAULT NULL,
  `sons_cache` longtext DEFAULT NULL,
  `is_helpdesk_visible` int(10) unsigned NOT NULL DEFAULT 1,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`entities_id`,`plugin_resources_choiceitems_id`,`name`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `plugin_resources_choiceitems_id` (`plugin_resources_choiceitems_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_choices`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_choices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_choices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_resources_resources_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_resources_resources (id)',
  `plugin_resources_choiceitems_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_resources_choiceitems (id)',
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plugin_resources_resources_id` (`plugin_resources_resources_id`),
  KEY `plugin_resources_choiceitems_id` (`plugin_resources_choiceitems_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_clients`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `security_compliance` tinyint(4) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `security_and` tinyint(4) NOT NULL DEFAULT 0,
  `security_fifour` tinyint(4) NOT NULL DEFAULT 0,
  `security_gisf` tinyint(4) NOT NULL DEFAULT 0,
  `security_cfi` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_confighabilitations`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_confighabilitations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_confighabilitations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `action` tinyint(4) NOT NULL DEFAULT 0,
  `plugin_metademands_metademands_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `entities_id` (`entities_id`),
  KEY `plugin_metademands_metademands_id` (`plugin_metademands_metademands_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_configs`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_configs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `security_display` tinyint(4) NOT NULL DEFAULT 0,
  `security_compliance` tinyint(4) NOT NULL DEFAULT 0,
  `import_external_datas` tinyint(4) NOT NULL DEFAULT 0,
  `resource_manager` varchar(255) NOT NULL DEFAULT '',
  `sales_manager` varchar(255) NOT NULL DEFAULT '',
  `create_ticket_departure` tinyint(4) NOT NULL DEFAULT 0,
  `categories_id` int(10) unsigned NOT NULL DEFAULT 0,
  `mandatory_checklist` tinyint(4) NOT NULL DEFAULT 0,
  `mandatory_adcreation` tinyint(4) NOT NULL DEFAULT 0,
  `plugin_resources_resourcetemplates_id` int(10) unsigned DEFAULT 0,
  `plugin_resources_resourcestates_id_arrival` int(10) unsigned DEFAULT 0,
  `plugin_resources_resourcestates_id_departure` int(10) unsigned DEFAULT 0,
  `reaffect_checklist_change` tinyint(4) NOT NULL DEFAULT 1,
  `allow_without_contract` int(10) unsigned NOT NULL DEFAULT 0,
  `use_service_department_ad` tinyint(4) NOT NULL DEFAULT 0,
  `use_secondary_service` tinyint(4) NOT NULL DEFAULT 0,
  `use_meta_for_changes` int(10) unsigned NOT NULL DEFAULT 0,
  `use_meta_for_leave` int(10) unsigned NOT NULL DEFAULT 0,
  `remove_habilitation_on_update` int(10) unsigned NOT NULL DEFAULT 0,
  `display_habilitations_txt` int(10) unsigned NOT NULL DEFAULT 0,
  `hide_view_commercial_resource` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_contractnatures`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_contractnatures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_contractnatures` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_contracttypeprofiles`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_contracttypeprofiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_contracttypeprofiles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_resources_contracttypes_id` varchar(255) NOT NULL DEFAULT '0',
  `profiles_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_contracttypes`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_contracttypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_contracttypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `use_employee_wizard` tinyint(4) NOT NULL DEFAULT 1,
  `use_need_wizard` tinyint(4) NOT NULL DEFAULT 1,
  `use_picture_wizard` tinyint(4) NOT NULL DEFAULT 1,
  `use_habilitation_wizard` tinyint(4) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `use_second_matricule` tinyint(4) NOT NULL DEFAULT 0,
  `use_second_list_employer` tinyint(4) NOT NULL DEFAULT 0,
  `use_resignation_form` tinyint(4) NOT NULL DEFAULT 0,
  `use_entrance_information` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_costs`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_costs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_costs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `plugin_resources_professions_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_resources_professions (id)',
  `plugin_resources_ranks_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_resources_ranks (id)',
  `begin_date` timestamp NULL DEFAULT NULL,
  `end_date` timestamp NULL DEFAULT NULL,
  `cost` decimal(10,2) NOT NULL DEFAULT 0.00,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `plugin_resources_professions_id` (`plugin_resources_professions_id`),
  KEY `plugin_resources_ranks_id` (`plugin_resources_ranks_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_degreegroups`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_degreegroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_degreegroups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_departments`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_departments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_resources_employers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_departments_services`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_departments_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_departments_services` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_resources_departments_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_resources_services_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_destinations`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_destinations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_destinations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_employees`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_employees` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_resources_resources_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_resources_resources (id)',
  `plugin_resources_employers_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_resources_employers (id)',
  `plugin_resources_clients_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_resources_clients (id)',
  PRIMARY KEY (`id`),
  KEY `plugin_resources_resources_id` (`plugin_resources_resources_id`),
  KEY `plugin_resources_employers_id` (`plugin_resources_employers_id`),
  KEY `plugin_resources_clients_id` (`plugin_resources_clients_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_employers`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_employers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_employers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `short_name` varchar(255) DEFAULT NULL,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_locations (id)',
  `plugin_resources_employers_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_resources_employers (id)',
  `code` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `completename` text DEFAULT NULL,
  `level` int(10) unsigned NOT NULL DEFAULT 0,
  `ancestors_cache` longtext DEFAULT NULL,
  `sons_cache` longtext DEFAULT NULL,
  `second_list` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `locations_id` (`locations_id`),
  KEY `plugin_resources_employers_id` (`plugin_resources_employers_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_employments`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_employments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_employments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `plugin_resources_resources_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_resources_resources (id)',
  `plugin_resources_professions_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_resources_professions (id)',
  `plugin_resources_ranks_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_resources_resources_ranks (id)',
  `plugin_resources_employmentstates_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_resources_employmentstates (id)',
  `plugin_resources_employers_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_resources_employers (id)',
  `ratio_employment_budget` decimal(10,2) NOT NULL DEFAULT 0.00,
  `begin_date` timestamp NULL DEFAULT NULL,
  `end_date` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `plugin_resources_resources_id` (`plugin_resources_resources_id`),
  KEY `plugin_resources_professions_id` (`plugin_resources_professions_id`),
  KEY `plugin_resources_ranks_id` (`plugin_resources_ranks_id`),
  KEY `plugin_resources_employmentstates_id` (`plugin_resources_employmentstates_id`),
  KEY `plugin_resources_employers_id` (`plugin_resources_employers_id`),
  KEY `entities_id` (`entities_id`),
  KEY `date_mod` (`date_mod`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_employmentstates`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_employmentstates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_employmentstates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `short_name` varchar(255) DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 0,
  `is_leaving_state` tinyint(4) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `is_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_functions`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_functions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_functions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_habilitationlevels`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_habilitationlevels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_habilitationlevels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `number` tinyint(4) NOT NULL DEFAULT 0,
  `is_mandatory_creating_resource` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_habilitations`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_habilitations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_habilitations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `plugin_resources_habilitations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_resources_habilitationlevels_id` int(10) unsigned NOT NULL DEFAULT 0,
  `completename` text DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `level` int(10) unsigned NOT NULL DEFAULT 0,
  `ancestors_cache` longtext DEFAULT NULL,
  `sons_cache` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `plugin_resources_habilitations_id` (`plugin_resources_habilitations_id`),
  KEY `plugin_resources_habilitationlevels_id` (`plugin_resources_habilitationlevels_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_importcolumns`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_importcolumns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_importcolumns` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `resource_column` int(10) unsigned NOT NULL,
  `is_identifier` tinyint(4) NOT NULL DEFAULT 0,
  `plugin_resources_imports_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_importresourcedatas`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_importresourcedatas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_importresourcedatas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `plugin_resources_importresources_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_resources_importcolumns_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_importresources`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_importresources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_importresources` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_creation` timestamp NULL DEFAULT NULL,
  `plugin_resources_imports_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_imports`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_imports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_imports` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `date_creation` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_leavingdetails`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_leavingdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_leavingdetails` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_leavinginformations`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_leavinginformations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_leavinginformations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_resources_resources_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_resources_clients_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_resources_destinations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_resources_workprofiles_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_resources_resignationreasons_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `interview_date` timestamp NULL DEFAULT NULL,
  `resignation_date` timestamp NULL DEFAULT NULL,
  `wished_leaving_date` timestamp NULL DEFAULT NULL,
  `effective_leaving_date` timestamp NULL DEFAULT NULL,
  `pay_gap` tinyint(4) NOT NULL DEFAULT 0,
  `mission_lost` tinyint(4) NOT NULL DEFAULT 0,
  `company_name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_leavingreasons`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_leavingreasons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_leavingreasons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_linkads`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_linkads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_linkads` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_resources_resources_id` int(10) unsigned NOT NULL DEFAULT 0,
  `auth_id` int(10) unsigned NOT NULL DEFAULT 0,
  `login` varchar(255) DEFAULT NULL,
  `mail` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `service` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `cellphone` varchar(255) DEFAULT NULL,
  `action_done` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity2` (`plugin_resources_resources_id`),
  UNIQUE KEY `unicity` (`login`),
  KEY `login` (`login`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_linkmetademands`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_linkmetademands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_linkmetademands` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_metademands_fields_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_metademands_metademands_id` int(10) unsigned NOT NULL DEFAULT 0,
  `check_value` text DEFAULT NULL,
  `checklist_in` text DEFAULT NULL,
  `checklist_out` text DEFAULT NULL,
  `habilitation` text DEFAULT NULL,
  `is_leaving_resource` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`plugin_metademands_fields_id`),
  KEY `plugin_metademands_fields_id` (`plugin_metademands_fields_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_notifications`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_notifications` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_resources_resources_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_resources_resources (id)',
  `date_mod` timestamp NULL DEFAULT NULL,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `users_id` (`users_id`),
  KEY `date_mod` (`date_mod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_professioncategories`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_professioncategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_professioncategories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_professionlines`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_professionlines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_professionlines` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_professions`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_professions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_professions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `short_name` varchar(255) DEFAULT NULL,
  `plugin_resources_professionlines_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_resources_professionlines (id)',
  `plugin_resources_professioncategories_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_resources_professioncategories (id)',
  `is_active` tinyint(4) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `begin_date` timestamp NULL DEFAULT NULL,
  `end_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `plugin_resources_professionlines_id` (`plugin_resources_professionlines_id`),
  KEY `plugin_resources_professioncategories_id` (`plugin_resources_professioncategories_id`),
  KEY `is_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_ranks`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_ranks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_ranks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `short_name` varchar(255) DEFAULT NULL,
  `plugin_resources_professions_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_resources_professions (id)',
  `is_active` tinyint(4) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `begin_date` timestamp NULL DEFAULT NULL,
  `end_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `plugin_resources_professions_id` (`plugin_resources_professions_id`),
  KEY `is_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_recruitingsources`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_recruitingsources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_recruitingsources` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_reportconfigs`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_reportconfigs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_reportconfigs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_resources_resources_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_resources_resources (id)',
  `send_report_notif` tinyint(4) NOT NULL DEFAULT 1,
  `send_other_notif` tinyint(4) NOT NULL DEFAULT 0,
  `send_transfer_notif` tinyint(4) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `information` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plugin_resources_resources_id` (`plugin_resources_resources_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_resignationreasons`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_resignationreasons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_resignationreasons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_resourcebadges`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_resourcebadges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_resourcebadges` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_metademands_metademands_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `entities_id` (`entities_id`),
  KEY `plugin_metademands_metademands_id` (`plugin_metademands_metademands_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_resourcehabilitations`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_resourcehabilitations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_resourcehabilitations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_resources_resources_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_resources_habilitations_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `plugin_resources_resources_id` (`plugin_resources_resources_id`),
  KEY `glpi_plugin_resources_habilitations_id` (`plugin_resources_habilitations_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_resourceholidays`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_resourceholidays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_resourceholidays` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_resources_resources_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_resources_resources (id)',
  `date_begin` timestamp NULL DEFAULT NULL,
  `date_end` timestamp NULL DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plugin_resources_resources_id` (`plugin_resources_resources_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_resourceimports`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_resourceimports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_resourceimports` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `plugin_resources_resources_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_resourcerestings`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_resourcerestings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_resourcerestings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_resources_resources_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_resources_resources (id)',
  `date_begin` timestamp NULL DEFAULT NULL,
  `date_end` timestamp NULL DEFAULT NULL,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_locations (id)',
  `at_home` tinyint(4) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plugin_resources_resources_id` (`plugin_resources_resources_id`),
  KEY `locations_id` (`locations_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_resources`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_resources` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `plugin_resources_contracttypes_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_resources_contracttypes (id)',
  `users_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_users (id)',
  `users_id_sales` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_users (id)',
  `users_id_recipient` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_users (id)',
  `date_declaration` timestamp NULL DEFAULT NULL,
  `date_begin` timestamp NULL DEFAULT NULL,
  `date_end` timestamp NULL DEFAULT NULL,
  `quota` decimal(10,4) NOT NULL DEFAULT 1.0000,
  `plugin_resources_departments_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_resources_departments (id)',
  `plugin_resources_resourcestates_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_resources_resourcestates (id)',
  `plugin_resources_resourcesituations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_resources_contractnatures_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_resources_ranks_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_resources_resourcespecialities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_locations (id)',
  `is_leaving` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_resources_workprofiles_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_resources_leavingreasons_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_declaration_leaving` timestamp NULL DEFAULT NULL,
  `date_agreement_candidate` timestamp NULL DEFAULT NULL,
  `date_of_last_contract_type` timestamp NULL DEFAULT NULL,
  `date_of_last_location` timestamp NULL DEFAULT NULL,
  `users_id_recipient_leaving` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_users (id)',
  `picture` varchar(100) DEFAULT NULL,
  `is_helpdesk_visible` int(10) unsigned NOT NULL DEFAULT 1,
  `date_mod` timestamp NULL DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `is_template` tinyint(4) NOT NULL DEFAULT 0,
  `template_name` varchar(255) DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `sensitize_security` tinyint(4) NOT NULL DEFAULT 0,
  `read_chart` tinyint(4) NOT NULL DEFAULT 0,
  `contract_type_change` tinyint(4) NOT NULL DEFAULT 0,
  `reconversion` tinyint(4) NOT NULL DEFAULT 0,
  `plugin_resources_roles_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_resources_roles (id)',
  `matricule` varchar(255) NOT NULL DEFAULT '',
  `plugin_resources_functions_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_resources_teams_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_resources_services_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_resources_degreegroups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_resources_recruitingsources_id` int(10) unsigned NOT NULL DEFAULT 0,
  `last_contract_type` int(10) unsigned NOT NULL DEFAULT 0,
  `last_location` int(10) unsigned NOT NULL DEFAULT 0,
  `yearsexperience` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_resources_candidateorigins_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_resources_workprofiles_id_entrance` int(10) unsigned NOT NULL DEFAULT 0,
  `matricule_second` varchar(255) DEFAULT NULL,
  `secondary_services` varchar(255) DEFAULT NULL,
  `gender` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `users_id` (`users_id`),
  KEY `users_id_sales` (`users_id_sales`),
  KEY `users_id_recipient` (`users_id_recipient`),
  KEY `locations_id` (`locations_id`),
  KEY `is_leaving` (`is_leaving`),
  KEY `users_id_recipient_leaving` (`users_id_recipient_leaving`),
  KEY `date_mod` (`date_mod`),
  KEY `is_helpdesk_visible` (`is_helpdesk_visible`),
  KEY `is_deleted` (`is_deleted`),
  KEY `is_template` (`is_template`),
  KEY `plugin_resources_contracttypes_id` (`plugin_resources_contracttypes_id`),
  KEY `plugin_resources_departments_id` (`plugin_resources_departments_id`),
  KEY `plugin_resources_resourcestates_id` (`plugin_resources_resourcestates_id`),
  KEY `plugin_resources_resourcesituations_id` (`plugin_resources_resourcesituations_id`),
  KEY `plugin_resources_contractnatures_id` (`plugin_resources_contractnatures_id`),
  KEY `plugin_resources_ranks_id` (`plugin_resources_ranks_id`),
  KEY `plugin_resources_resourcespecialities_id` (`plugin_resources_resourcespecialities_id`),
  KEY `plugin_resources_leavingreasons_id` (`plugin_resources_leavingreasons_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_resources_changes`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_resources_changes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_resources_changes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `actions_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itilcategories_id` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entities_id` (`entities_id`),
  KEY `itilcategories_id` (`itilcategories_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_resources_items`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_resources_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_resources_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_resources_resources_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_resources_resources (id)',
  `items_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to various table, according to itemtype (id)',
  `itemtype` varchar(100) NOT NULL COMMENT 'see .class.php file',
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`plugin_resources_resources_id`,`itemtype`,`items_id`),
  KEY `FK_device` (`items_id`,`itemtype`),
  KEY `item` (`itemtype`,`items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_resourcesituations`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_resourcesituations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_resourcesituations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `short_name` varchar(255) DEFAULT NULL,
  `is_contract_linked` tinyint(4) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `is_contract_linked` (`is_contract_linked`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_resourcespecialities`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_resourcespecialities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_resourcespecialities` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `plugin_resources_ranks_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_resources_ranks (id)',
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `plugin_resources_ranks_id` (`plugin_resources_ranks_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_resourcestates`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_resourcestates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_resourcestates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_roles`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_roles_services`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_roles_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_roles_services` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_resources_roles_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_resources_services_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_services`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_services` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_taskplannings`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_taskplannings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_taskplannings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_resources_tasks_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_resources_tasks (id)',
  `begin` timestamp NULL DEFAULT NULL,
  `end` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `begin` (`begin`),
  KEY `end` (`end`),
  KEY `plugin_resources_tasks_id` (`plugin_resources_tasks_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_tasks`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_tasks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `plugin_resources_resources_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_resources_resources (id)',
  `plugin_resources_tasktypes_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_resources_tasktypes (id)',
  `users_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_users (id)',
  `groups_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_groups (id)',
  `actiontime` int(10) unsigned NOT NULL DEFAULT 0,
  `is_finished` tinyint(4) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `plugin_resources_resources_id` (`plugin_resources_resources_id`),
  KEY `plugin_resources_tasktypes_id` (`plugin_resources_tasktypes_id`),
  KEY `users_id` (`users_id`),
  KEY `groups_id` (`groups_id`),
  KEY `is_finished` (`is_finished`),
  KEY `is_deleted` (`is_deleted`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_tasks_items`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_tasks_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_tasks_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_resources_tasks_id` int(10) unsigned NOT NULL DEFAULT 0,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to various table, according to itemtype (id)',
  `itemtype` varchar(100) NOT NULL COMMENT 'see .class.php file',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`plugin_resources_tasks_id`,`itemtype`,`items_id`),
  KEY `FK_device` (`items_id`,`itemtype`),
  KEY `item` (`itemtype`,`items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_tasktypes`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_tasktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_tasktypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_teams`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_teams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_teams` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_substitute` int(10) unsigned NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_ticketcategories`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_ticketcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_ticketcategories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ticketcategories_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_ticketcategories (id)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_transferentities`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_transferentities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_transferentities` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `entities_id` (`entities_id`),
  KEY `groups_id` (`groups_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_resources_workprofiles`
--

DROP TABLE IF EXISTS `glpi_plugin_resources_workprofiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_resources_workprofiles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_roundrobin_rr_assignments`
--

DROP TABLE IF EXISTS `glpi_plugin_roundrobin_rr_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_roundrobin_rr_assignments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `itilcategories_id` int(11) DEFAULT NULL,
  `is_active` int(1) DEFAULT 0,
  `last_assignment_index` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_itilcategories_uq` (`itilcategories_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_roundrobin_rr_options`
--

DROP TABLE IF EXISTS `glpi_plugin_roundrobin_rr_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_roundrobin_rr_options` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `auto_assign_group` int(1) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_satisfaction_reminders`
--

DROP TABLE IF EXISTS `glpi_plugin_satisfaction_reminders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_satisfaction_reminders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` int(10) unsigned NOT NULL DEFAULT 0,
  `tickets_id` int(10) unsigned NOT NULL,
  `date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`tickets_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_satisfaction_surveyanswers`
--

DROP TABLE IF EXISTS `glpi_plugin_satisfaction_surveyanswers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_satisfaction_surveyanswers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `answer` text DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `plugin_satisfaction_surveys_id` int(10) unsigned NOT NULL,
  `ticketsatisfactions_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_satisfaction_surveyquestions`
--

DROP TABLE IF EXISTS `glpi_plugin_satisfaction_surveyquestions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_satisfaction_surveyquestions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_satisfaction_surveys_id` int(10) unsigned NOT NULL,
  `name` text DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `number` int(10) unsigned NOT NULL DEFAULT 0,
  `default_value` int(10) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_satisfaction_surveyreminders`
--

DROP TABLE IF EXISTS `glpi_plugin_satisfaction_surveyreminders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_satisfaction_surveyreminders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_satisfaction_surveys_id` int(10) unsigned NOT NULL,
  `name` text DEFAULT NULL,
  `duration_type` int(10) unsigned NOT NULL,
  `duration` int(10) unsigned NOT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_satisfaction_surveys`
--

DROP TABLE IF EXISTS `glpi_plugin_satisfaction_surveys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_satisfaction_surveys` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `is_active` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `reminders_days` int(10) unsigned NOT NULL DEFAULT 30,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_satisfaction_surveytranslations`
--

DROP TABLE IF EXISTS `glpi_plugin_satisfaction_surveytranslations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_satisfaction_surveytranslations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_satisfaction_surveys_id` int(10) unsigned NOT NULL DEFAULT 0,
  `glpi_plugin_satisfaction_surveyquestions_id` int(10) unsigned NOT NULL DEFAULT 0,
  `language` varchar(5) DEFAULT NULL,
  `value` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`plugin_satisfaction_surveys_id`,`glpi_plugin_satisfaction_surveyquestions_id`,`language`),
  KEY `typeid` (`plugin_satisfaction_surveys_id`,`glpi_plugin_satisfaction_surveyquestions_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_sccm_configs`
--

DROP TABLE IF EXISTS `glpi_plugin_sccm_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_sccm_configs` (
  `id` int(10) unsigned NOT NULL,
  `sccmdb_host` varchar(255) DEFAULT NULL,
  `sccmdb_dbname` varchar(255) DEFAULT NULL,
  `sccmdb_user` varchar(255) DEFAULT NULL,
  `sccmdb_password` varchar(255) DEFAULT NULL,
  `inventory_server_url` varchar(255) DEFAULT NULL,
  `active_sync` tinyint(4) NOT NULL DEFAULT 0,
  `verify_ssl_cert` tinyint(4) NOT NULL DEFAULT 0,
  `use_auth_ntlm` tinyint(4) NOT NULL DEFAULT 0,
  `unrestricted_auth` tinyint(4) NOT NULL DEFAULT 0,
  `use_auth_info` tinyint(4) NOT NULL DEFAULT 0,
  `auth_info` varchar(255) DEFAULT NULL,
  `is_password_sodium_encrypted` tinyint(4) NOT NULL DEFAULT 1,
  `use_lasthwscan` tinyint(4) NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_statecheck_ruleactions`
--

DROP TABLE IF EXISTS `glpi_plugin_statecheck_ruleactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_statecheck_ruleactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plugin_statecheck_rules_id` int(11) NOT NULL DEFAULT 0,
  `action_type` varchar(255) DEFAULT NULL COMMENT 'VALUE IN (assign, regex_result, append_regex_result, affectbyip, affectbyfqdn, affectbymac)',
  `field` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plugin_statecheck_rules_id` (`plugin_statecheck_rules_id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_statecheck_rulecriterias`
--

DROP TABLE IF EXISTS `glpi_plugin_statecheck_rulecriterias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_statecheck_rulecriterias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plugin_statecheck_rules_id` int(11) NOT NULL DEFAULT 0,
  `criteria` varchar(255) DEFAULT NULL,
  `condition` int(11) NOT NULL DEFAULT 0 COMMENT 'see define.php PATTERN_* and REGEX_* constant',
  `pattern` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plugin_statecheck_rules_id` (`plugin_statecheck_rules_id`),
  KEY `condition` (`condition`)
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_statecheck_rules`
--

DROP TABLE IF EXISTS `glpi_plugin_statecheck_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_statecheck_rules` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Internal ID',
  `entities_id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `plugin_statecheck_tables_id` int(11) NOT NULL DEFAULT 0,
  `plugin_statecheck_targetstates_id` int(11) NOT NULL DEFAULT 0,
  `ranking` int(11) NOT NULL DEFAULT 0,
  `match` char(10) DEFAULT NULL COMMENT 'see define.php *_MATCHING constant',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_active_warn_popup` tinyint(1) NOT NULL DEFAULT 1,
  `comment` text DEFAULT NULL,
  `successnotifications_id` int(11) NOT NULL DEFAULT 0 COMMENT 'notification in case of success',
  `failurenotifications_id` int(11) NOT NULL DEFAULT 0 COMMENT 'notification in case of failure',
  `date_mod` timestamp NULL DEFAULT NULL,
  `is_recursive` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `entities_id` (`entities_id`),
  KEY `plugin_statecheck_tables_id` (`plugin_statecheck_tables_id`),
  KEY `plugin_statecheck_targetstates_id` (`plugin_statecheck_targetstates_id`),
  KEY `is_active` (`is_active`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_statecheck_tables`
--

DROP TABLE IF EXISTS `glpi_plugin_statecheck_tables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_statecheck_tables` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `comment` varchar(45) NOT NULL,
  `statetable` varchar(45) NOT NULL,
  `stateclass` varchar(45) NOT NULL,
  `class` varchar(45) NOT NULL,
  `frontname` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `plugin_statecheck_tables_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_tag_tagitems`
--

DROP TABLE IF EXISTS `glpi_plugin_tag_tagitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_tag_tagitems` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_tag_tags_id` int(10) unsigned NOT NULL DEFAULT 0,
  `items_id` int(10) unsigned NOT NULL DEFAULT 1,
  `itemtype` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`itemtype`,`items_id`,`plugin_tag_tags_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_tag_tags`
--

DROP TABLE IF EXISTS `glpi_plugin_tag_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_tag_tags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 1,
  `name` varchar(255) NOT NULL DEFAULT '',
  `comment` text DEFAULT NULL,
  `color` varchar(50) NOT NULL DEFAULT '',
  `type_menu` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_tasklists_items_kanbans`
--

DROP TABLE IF EXISTS `glpi_plugin_tasklists_items_kanbans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_tasklists_items_kanbans` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `itemtype` varchar(100) NOT NULL,
  `items_id` int(10) unsigned DEFAULT NULL,
  `users_id` int(10) unsigned NOT NULL,
  `plugin_tasklists_taskstates_id` int(10) unsigned NOT NULL,
  `state` int(10) unsigned NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`itemtype`,`items_id`,`users_id`,`plugin_tasklists_taskstates_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_tasklists_preferences`
--

DROP TABLE IF EXISTS `glpi_plugin_tasklists_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_tasklists_preferences` (
  `id` int(10) unsigned NOT NULL COMMENT 'RELATION to glpi_users(id)',
  `default_type` int(10) unsigned NOT NULL DEFAULT 0,
  `automatic_refresh` tinyint(4) NOT NULL DEFAULT 0,
  `automatic_refresh_delay` int(10) unsigned NOT NULL DEFAULT 10,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_tasklists_stateorders`
--

DROP TABLE IF EXISTS `glpi_plugin_tasklists_stateorders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_tasklists_stateorders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_tasklists_taskstates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_tasklists_tasktypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `ranking` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plugin_tasklists_tasktypes_id` (`plugin_tasklists_tasktypes_id`),
  KEY `plugin_tasklists_taskstates_id` (`plugin_tasklists_taskstates_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_tasklists_tasks`
--

DROP TABLE IF EXISTS `glpi_plugin_tasklists_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_tasklists_tasks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `plugin_tasklists_tasktypes_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_tasklists_tasktypes (id)',
  `plugin_tasklists_taskstates_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_plugin_tasklists_taskstates (id)',
  `priority` int(10) unsigned NOT NULL DEFAULT 1,
  `visibility` int(10) unsigned NOT NULL DEFAULT 1,
  `actiontime` int(10) unsigned NOT NULL DEFAULT 0,
  `percent_done` int(10) unsigned NOT NULL DEFAULT 0,
  `state` int(10) unsigned NOT NULL DEFAULT 1,
  `due_date` timestamp NULL DEFAULT NULL,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_users (id)',
  `groups_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_groups (id)',
  `client` varchar(255) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `notepad` longtext DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `is_template` smallint(6) NOT NULL DEFAULT 0,
  `template_name` varchar(200) NOT NULL DEFAULT '',
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_archived` tinyint(4) NOT NULL DEFAULT 0,
  `users_id_requester` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_users (id)',
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `plugin_tasklists_tasktypes_id` (`plugin_tasklists_tasktypes_id`),
  KEY `is_template` (`is_template`),
  KEY `users_id` (`users_id`),
  KEY `groups_id` (`groups_id`),
  KEY `date_mod` (`date_mod`),
  KEY `is_deleted` (`is_deleted`),
  KEY `is_archived` (`is_archived`),
  KEY `users_id_requester` (`users_id_requester`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_tasklists_tasks_comments`
--

DROP TABLE IF EXISTS `glpi_plugin_tasklists_tasks_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_tasklists_tasks_comments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_tasklists_tasks_id` int(10) unsigned NOT NULL,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `language` varchar(5) DEFAULT NULL,
  `comment` text NOT NULL,
  `parent_comment_id` int(10) unsigned DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_tasklists_taskstates`
--

DROP TABLE IF EXISTS `glpi_plugin_tasklists_taskstates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_tasklists_taskstates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `is_finished` tinyint(4) NOT NULL DEFAULT 0,
  `tasktypes` varchar(255) DEFAULT NULL,
  `color` varchar(200) NOT NULL DEFAULT '#CCC',
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_tasklists_tasktypes`
--

DROP TABLE IF EXISTS `glpi_plugin_tasklists_tasktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_tasklists_tasktypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `plugin_tasklists_tasktypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `completename` text DEFAULT NULL,
  `level` int(10) unsigned NOT NULL DEFAULT 0,
  `ancestors_cache` longtext DEFAULT NULL,
  `sons_cache` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `unicity` (`plugin_tasklists_tasktypes_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_tasklists_tickets`
--

DROP TABLE IF EXISTS `glpi_plugin_tasklists_tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_tasklists_tickets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tickets_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_tasklists_tasks_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `plugin_tasklists_tasks_id` (`plugin_tasklists_tasks_id`),
  KEY `tickets_id` (`tickets_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_tasklists_typevisibilities`
--

DROP TABLE IF EXISTS `glpi_plugin_tasklists_typevisibilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_tasklists_typevisibilities` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plugin_tasklists_tasktypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `plugin_tasklists_tasktypes_id` (`plugin_tasklists_tasktypes_id`),
  KEY `groups_id` (`groups_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_ticketfilter_filterpatterns`
--

DROP TABLE IF EXISTS `glpi_plugin_ticketfilter_filterpatterns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_ticketfilter_filterpatterns` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 0,
  `date_creation` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `TicketMatchString` text NOT NULL,
  `TicketMatchStringLength` int(11) NOT NULL DEFAULT 11,
  `AssetMatchString` text DEFAULT NULL,
  `AssetMatchStringLength` int(11) NOT NULL DEFAULT 10,
  `SolvedMatchString` text DEFAULT NULL,
  `SolvedMatchStringLength` int(11) NOT NULL DEFAULT 10,
  `AutomaticallyMerge` tinyint(4) NOT NULL DEFAULT 0,
  `ReopenClosedTickets` tinyint(4) NOT NULL DEFAULT 0,
  `SearchTicketBody` tinyint(4) NOT NULL DEFAULT 0,
  `MatchSpecificSource` tinyint(4) DEFAULT NULL,
  `SuppressNotification` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `is_active` (`is_active`),
  KEY `date_creation` (`date_creation`),
  KEY `date_mod` (`date_mod`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_timelineticket_assigngroups`
--

DROP TABLE IF EXISTS `glpi_plugin_timelineticket_assigngroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_timelineticket_assigngroups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tickets_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date` timestamp NULL DEFAULT NULL,
  `groups_id` varchar(255) DEFAULT NULL,
  `begin` int(10) unsigned DEFAULT NULL,
  `delay` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tickets_id` (`tickets_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_timelineticket_assignusers`
--

DROP TABLE IF EXISTS `glpi_plugin_timelineticket_assignusers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_timelineticket_assignusers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tickets_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date` timestamp NULL DEFAULT NULL,
  `users_id` varchar(255) DEFAULT NULL,
  `begin` int(10) unsigned DEFAULT NULL,
  `delay` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tickets_id` (`tickets_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_timelineticket_configs`
--

DROP TABLE IF EXISTS `glpi_plugin_timelineticket_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_timelineticket_configs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `add_waiting` int(10) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_timelineticket_grouplevels`
--

DROP TABLE IF EXISTS `glpi_plugin_timelineticket_grouplevels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_timelineticket_grouplevels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `groups` longtext DEFAULT NULL,
  `rank` smallint(6) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_timelineticket_states`
--

DROP TABLE IF EXISTS `glpi_plugin_timelineticket_states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_timelineticket_states` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tickets_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date` timestamp NULL DEFAULT NULL,
  `old_status` varchar(255) DEFAULT NULL,
  `new_status` varchar(255) DEFAULT NULL,
  `delay` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tickets_id` (`tickets_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_treeview_configs`
--

DROP TABLE IF EXISTS `glpi_plugin_treeview_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_treeview_configs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `target` varchar(255) NOT NULL DEFAULT 'right',
  `folderLinks` tinyint(4) NOT NULL DEFAULT 0,
  `useSelection` tinyint(4) NOT NULL DEFAULT 0,
  `useLines` tinyint(4) NOT NULL DEFAULT 0,
  `useIcons` tinyint(4) NOT NULL DEFAULT 0,
  `closeSameLevel` tinyint(4) NOT NULL DEFAULT 0,
  `itemName` int(11) NOT NULL DEFAULT 0,
  `locationName` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_treeview_preferences`
--

DROP TABLE IF EXISTS `glpi_plugin_treeview_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_treeview_preferences` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_users (id)',
  `show_on_load` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_treeview_profiles`
--

DROP TABLE IF EXISTS `glpi_plugin_treeview_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_treeview_profiles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `treeview` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_typology_typologies`
--

DROP TABLE IF EXISTS `glpi_plugin_typology_typologies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_typology_typologies` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `is_deleted` (`is_deleted`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_typology_typologies_items`
--

DROP TABLE IF EXISTS `glpi_plugin_typology_typologies_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_typology_typologies_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_typology_typologies_id` int(10) unsigned NOT NULL DEFAULT 0,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to various tables, according to itemtype (id)',
  `itemtype` varchar(100) NOT NULL COMMENT 'see .class.php file',
  `is_validated` tinyint(4) DEFAULT NULL,
  `error` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`plugin_typology_typologies_id`,`itemtype`,`items_id`),
  KEY `itemtype` (`itemtype`),
  KEY `items_id` (`items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_typology_typologycriteriadefinitions`
--

DROP TABLE IF EXISTS `glpi_plugin_typology_typologycriteriadefinitions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_typology_typologycriteriadefinitions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_typology_typologycriterias_id` int(10) unsigned NOT NULL DEFAULT 0,
  `field` varchar(255) DEFAULT NULL,
  `action_type` varchar(100) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `plugin_typology_typologycriterias_id` (`plugin_typology_typologycriterias_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_typology_typologycriterias`
--

DROP TABLE IF EXISTS `glpi_plugin_typology_typologycriterias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_typology_typologycriterias` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `plugin_typology_typologies_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) NOT NULL COMMENT 'see .class.php file',
  `link` tinyint(4) NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `plugin_typology_typologies_id` (`plugin_typology_typologies_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_uninstall_models`
--

DROP TABLE IF EXISTS `glpi_plugin_uninstall_models`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_uninstall_models` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 1,
  `name` varchar(255) NOT NULL DEFAULT '',
  `transfers_id` int(10) unsigned NOT NULL,
  `states_id` int(10) unsigned NOT NULL,
  `raz_name` int(11) NOT NULL DEFAULT 1,
  `raz_contact` int(11) NOT NULL DEFAULT 1,
  `raz_contact_num` int(11) NOT NULL DEFAULT 1,
  `raz_ip` int(11) NOT NULL DEFAULT 1,
  `raz_os` int(11) NOT NULL DEFAULT 1,
  `raz_domain` int(11) NOT NULL DEFAULT 1,
  `raz_network` int(11) NOT NULL DEFAULT 1,
  `raz_history` int(11) NOT NULL DEFAULT 1,
  `raz_soft_history` int(11) NOT NULL DEFAULT 1,
  `raz_budget` int(11) NOT NULL DEFAULT 1,
  `raz_antivirus` int(11) NOT NULL DEFAULT 1,
  `raz_user` int(11) NOT NULL DEFAULT 1,
  `raz_ocs_registrykeys` int(11) NOT NULL DEFAULT 1,
  `comment` text NOT NULL,
  `groups_action` varchar(10) NOT NULL DEFAULT 'set',
  `groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `remove_from_ocs` int(11) NOT NULL DEFAULT 0,
  `delete_ocs_link` int(11) NOT NULL DEFAULT 0,
  `types_id` int(10) unsigned NOT NULL DEFAULT 0,
  `replace_name` tinyint(4) NOT NULL DEFAULT 0,
  `replace_serial` tinyint(4) NOT NULL DEFAULT 0,
  `replace_otherserial` tinyint(4) NOT NULL DEFAULT 0,
  `replace_documents` tinyint(4) NOT NULL DEFAULT 0,
  `replace_contracts` tinyint(4) NOT NULL DEFAULT 0,
  `replace_infocoms` tinyint(4) NOT NULL DEFAULT 0,
  `replace_reservations` tinyint(4) NOT NULL DEFAULT 0,
  `replace_users` tinyint(4) NOT NULL DEFAULT 0,
  `replace_groups` tinyint(4) NOT NULL DEFAULT 0,
  `replace_tickets` tinyint(4) NOT NULL DEFAULT 0,
  `replace_netports` tinyint(4) NOT NULL DEFAULT 0,
  `replace_direct_connections` tinyint(4) NOT NULL DEFAULT 0,
  `overwrite` tinyint(4) NOT NULL DEFAULT 0,
  `replace_method` int(11) NOT NULL DEFAULT 2,
  `raz_glpiinventory` int(11) NOT NULL DEFAULT 1,
  `raz_fusioninventory` int(11) NOT NULL DEFAULT 1,
  `raz_plugin_fields` tinyint(4) NOT NULL DEFAULT 1,
  `replace_contact` tinyint(4) NOT NULL DEFAULT 0,
  `replace_contact_num` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_uninstall_preferences`
--

DROP TABLE IF EXISTS `glpi_plugin_uninstall_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_uninstall_preferences` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `users_id` int(10) unsigned NOT NULL,
  `entities_id` int(10) unsigned DEFAULT 0,
  `templates_id` int(10) unsigned DEFAULT 0,
  `locations_action` varchar(10) NOT NULL DEFAULT 'set',
  `locations_id` int(10) unsigned DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_uninstall_profiles`
--

DROP TABLE IF EXISTS `glpi_plugin_uninstall_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_uninstall_profiles` (
  `id` int(10) unsigned NOT NULL DEFAULT 0,
  `profile` varchar(255) NOT NULL DEFAULT '0',
  `use` varchar(1) DEFAULT '',
  `replace` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_useditemsexport_configs`
--

DROP TABLE IF EXISTS `glpi_plugin_useditemsexport_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_useditemsexport_configs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `footer_text` varchar(255) DEFAULT '',
  `is_active` tinyint(4) NOT NULL DEFAULT 1,
  `orientation` varchar(1) NOT NULL DEFAULT 'P',
  `format` varchar(2) NOT NULL DEFAULT 'A4',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_useditemsexport_exports`
--

DROP TABLE IF EXISTS `glpi_plugin_useditemsexport_exports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_useditemsexport_exports` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `num` smallint(6) NOT NULL DEFAULT 0,
  `refnumber` varchar(9) NOT NULL DEFAULT '0000-0000',
  `authors_id` int(10) unsigned NOT NULL DEFAULT 0,
  `documents_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_vip_groups`
--

DROP TABLE IF EXISTS `glpi_plugin_vip_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_vip_groups` (
  `id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'RELATION to glpi_groups(id)',
  `name` varchar(100) DEFAULT 'VIP',
  `isvip` tinyint(4) DEFAULT 0,
  `vip_color` varchar(10) NOT NULL DEFAULT '#ff0000',
  `vip_icon` varchar(100) DEFAULT 'fa-exclamation-triangle',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_webhook_configs`
--

DROP TABLE IF EXISTS `glpi_plugin_webhook_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_webhook_configs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `plugin_webhook_operationtypes_id` int(11) NOT NULL DEFAULT 0 COMMENT 'operation type : POST, PUT, ...',
  `address` text DEFAULT NULL,
  `plugin_webhook_secrettypes_id` int(11) NOT NULL DEFAULT 0 COMMENT 'secret type : Basic Authentication, Personal Access Token, OAuth, ...',
  `secret` text DEFAULT NULL,
  `user` text DEFAULT NULL,
  `language` varchar(10) DEFAULT NULL,
  `debug` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_webhook_operationtypes`
--

DROP TABLE IF EXISTS `glpi_plugin_webhook_operationtypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_webhook_operationtypes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `comment` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `glpi_plugin_webhook_operationtype_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_webhook_secrettypes`
--

DROP TABLE IF EXISTS `glpi_plugin_webhook_secrettypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_webhook_secrettypes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `comment` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `glpi_plugin_webhook_secrettype_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_webresources_autoicons`
--

DROP TABLE IF EXISTS `glpi_plugin_webresources_autoicons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_webresources_autoicons` (
  `itemtype` varchar(100) NOT NULL,
  `items_id` int(11) NOT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `color` varchar(16) NOT NULL DEFAULT '#000000',
  PRIMARY KEY (`itemtype`,`items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_webresources_categories`
--

DROP TABLE IF EXISTS `glpi_plugin_webresources_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_webresources_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_webresources_resources`
--

DROP TABLE IF EXISTS `glpi_plugin_webresources_resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_webresources_resources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `users_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `link` varchar(255) NOT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `color` varchar(16) NOT NULL DEFAULT '#000000',
  `plugin_webresources_categories_id` int(11) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_webresources_resources_entities`
--

DROP TABLE IF EXISTS `glpi_plugin_webresources_resources_entities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_webresources_resources_entities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plugin_webresources_resources_id` int(11) NOT NULL,
  `entities_id` int(11) NOT NULL,
  `is_recursive` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_webresources_resources_groups`
--

DROP TABLE IF EXISTS `glpi_plugin_webresources_resources_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_webresources_resources_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plugin_webresources_resources_id` int(11) NOT NULL,
  `groups_id` int(11) NOT NULL,
  `entities_id` int(11) NOT NULL,
  `is_recursive` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_webresources_resources_profiles`
--

DROP TABLE IF EXISTS `glpi_plugin_webresources_resources_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_webresources_resources_profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plugin_webresources_resources_id` int(11) NOT NULL,
  `profiles_id` int(11) NOT NULL,
  `entities_id` int(11) NOT NULL,
  `is_recursive` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_webresources_resources_users`
--

DROP TABLE IF EXISTS `glpi_plugin_webresources_resources_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_webresources_resources_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plugin_webresources_resources_id` int(11) NOT NULL,
  `users_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_yagp_configs`
--

DROP TABLE IF EXISTS `glpi_plugin_yagp_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_yagp_configs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ticketsolveddate` tinyint(1) NOT NULL DEFAULT 0,
  `gototicket` tinyint(1) NOT NULL DEFAULT 0,
  `blockdate` tinyint(1) NOT NULL DEFAULT 0,
  `findrequest` tinyint(1) NOT NULL DEFAULT 0,
  `allow_anonymous_requester` tinyint(1) NOT NULL DEFAULT 0,
  `requestlabel` varchar(255) DEFAULT NULL,
  `change_df_min_val` tinyint(1) NOT NULL DEFAULT 0,
  `df_min_validation` int(11) NOT NULL DEFAULT 0,
  `recategorization` tinyint(1) NOT NULL DEFAULT 0,
  `hide_historical` tinyint(1) NOT NULL DEFAULT 0,
  `private_view` tinyint(1) NOT NULL DEFAULT 0,
  `quick_transfer` tinyint(1) NOT NULL DEFAULT 0,
  `autotransfer` tinyint(1) NOT NULL DEFAULT 0,
  `transfer_entity` int(10) unsigned NOT NULL DEFAULT 0,
  `autoclose_rejected_tickets` tinyint(1) NOT NULL DEFAULT 0,
  `solutiontypes` text DEFAULT NULL,
  `solutiontypes_id_rejected` int(10) unsigned NOT NULL DEFAULT 0,
  `requesttypes_id_reopen` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugin_yagp_tickets`
--

DROP TABLE IF EXISTS `glpi_plugin_yagp_tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugin_yagp_tickets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tickets_id` int(10) unsigned NOT NULL,
  `plugin_yagp_itilcategories_id` int(10) unsigned NOT NULL,
  `is_recategorized` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`tickets_id`),
  KEY `tickets_id` (`tickets_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugins`
--

DROP TABLE IF EXISTS `glpi_plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugins` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `directory` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `state` int(11) NOT NULL DEFAULT 0 COMMENT 'see define.php PLUGIN_* constant',
  `author` varchar(255) DEFAULT NULL,
  `homepage` varchar(255) DEFAULT NULL,
  `license` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`directory`),
  KEY `name` (`name`),
  KEY `state` (`state`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_plugs`
--

DROP TABLE IF EXISTS `glpi_plugs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_plugs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_printerlogs`
--

DROP TABLE IF EXISTS `glpi_printerlogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_printerlogs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `printers_id` int(10) unsigned NOT NULL,
  `total_pages` int(11) NOT NULL DEFAULT 0,
  `bw_pages` int(11) NOT NULL DEFAULT 0,
  `color_pages` int(11) NOT NULL DEFAULT 0,
  `rv_pages` int(11) NOT NULL DEFAULT 0,
  `prints` int(11) NOT NULL DEFAULT 0,
  `bw_prints` int(11) NOT NULL DEFAULT 0,
  `color_prints` int(11) NOT NULL DEFAULT 0,
  `copies` int(11) NOT NULL DEFAULT 0,
  `bw_copies` int(11) NOT NULL DEFAULT 0,
  `color_copies` int(11) NOT NULL DEFAULT 0,
  `scanned` int(11) NOT NULL DEFAULT 0,
  `date` date DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `faxed` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`printers_id`,`date`),
  KEY `date` (`date`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_printermodels`
--

DROP TABLE IF EXISTS `glpi_printermodels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_printermodels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `product_number` varchar(255) DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `picture_front` text DEFAULT NULL,
  `picture_rear` text DEFAULT NULL,
  `pictures` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `product_number` (`product_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_printers`
--

DROP TABLE IF EXISTS `glpi_printers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_printers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `contact` varchar(255) DEFAULT NULL,
  `contact_num` varchar(255) DEFAULT NULL,
  `users_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `serial` varchar(255) DEFAULT NULL,
  `otherserial` varchar(255) DEFAULT NULL,
  `have_serial` tinyint(4) NOT NULL DEFAULT 0,
  `have_parallel` tinyint(4) NOT NULL DEFAULT 0,
  `have_usb` tinyint(4) NOT NULL DEFAULT 0,
  `have_wifi` tinyint(4) NOT NULL DEFAULT 0,
  `have_ethernet` tinyint(4) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `memory_size` varchar(255) DEFAULT NULL,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `networks_id` int(10) unsigned NOT NULL DEFAULT 0,
  `printertypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `printermodels_id` int(10) unsigned NOT NULL DEFAULT 0,
  `manufacturers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_global` tinyint(4) NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_template` tinyint(4) NOT NULL DEFAULT 0,
  `template_name` varchar(255) DEFAULT NULL,
  `init_pages_counter` int(11) NOT NULL DEFAULT 0,
  `last_pages_counter` int(11) NOT NULL DEFAULT 0,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0,
  `ticket_tco` decimal(20,4) DEFAULT 0.0000,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  `uuid` varchar(255) DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `sysdescr` text DEFAULT NULL,
  `last_inventory_update` timestamp NULL DEFAULT NULL,
  `snmpcredentials_id` int(10) unsigned NOT NULL DEFAULT 0,
  `autoupdatesystems_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `is_template` (`is_template`),
  KEY `is_global` (`is_global`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `manufacturers_id` (`manufacturers_id`),
  KEY `groups_id` (`groups_id`),
  KEY `users_id` (`users_id`),
  KEY `locations_id` (`locations_id`),
  KEY `printermodels_id` (`printermodels_id`),
  KEY `networks_id` (`networks_id`),
  KEY `states_id` (`states_id`),
  KEY `users_id_tech` (`users_id_tech`),
  KEY `printertypes_id` (`printertypes_id`),
  KEY `is_deleted` (`is_deleted`),
  KEY `date_mod` (`date_mod`),
  KEY `groups_id_tech` (`groups_id_tech`),
  KEY `last_pages_counter` (`last_pages_counter`),
  KEY `is_dynamic` (`is_dynamic`),
  KEY `serial` (`serial`),
  KEY `otherserial` (`otherserial`),
  KEY `uuid` (`uuid`),
  KEY `date_creation` (`date_creation`),
  KEY `snmpcredentials_id` (`snmpcredentials_id`),
  KEY `autoupdatesystems_id` (`autoupdatesystems_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_printers_cartridgeinfos`
--

DROP TABLE IF EXISTS `glpi_printers_cartridgeinfos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_printers_cartridgeinfos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `printers_id` int(10) unsigned NOT NULL,
  `property` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `printers_id` (`printers_id`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_printertypes`
--

DROP TABLE IF EXISTS `glpi_printertypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_printertypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_problemcosts`
--

DROP TABLE IF EXISTS `glpi_problemcosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_problemcosts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `problems_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `begin_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `actiontime` int(11) NOT NULL DEFAULT 0,
  `cost_time` decimal(20,4) NOT NULL DEFAULT 0.0000,
  `cost_fixed` decimal(20,4) NOT NULL DEFAULT 0.0000,
  `cost_material` decimal(20,4) NOT NULL DEFAULT 0.0000,
  `budgets_id` int(10) unsigned NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `problems_id` (`problems_id`),
  KEY `begin_date` (`begin_date`),
  KEY `end_date` (`end_date`),
  KEY `entities_id` (`entities_id`),
  KEY `budgets_id` (`budgets_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_problems`
--

DROP TABLE IF EXISTS `glpi_problems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_problems` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 1,
  `content` longtext DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date` timestamp NULL DEFAULT NULL,
  `solvedate` timestamp NULL DEFAULT NULL,
  `closedate` timestamp NULL DEFAULT NULL,
  `time_to_resolve` timestamp NULL DEFAULT NULL,
  `users_id_recipient` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_lastupdater` int(10) unsigned NOT NULL DEFAULT 0,
  `urgency` int(11) NOT NULL DEFAULT 1,
  `impact` int(11) NOT NULL DEFAULT 1,
  `priority` int(11) NOT NULL DEFAULT 1,
  `itilcategories_id` int(10) unsigned NOT NULL DEFAULT 0,
  `impactcontent` longtext DEFAULT NULL,
  `causecontent` longtext DEFAULT NULL,
  `symptomcontent` longtext DEFAULT NULL,
  `actiontime` int(11) NOT NULL DEFAULT 0,
  `begin_waiting_date` timestamp NULL DEFAULT NULL,
  `waiting_duration` int(11) NOT NULL DEFAULT 0,
  `close_delay_stat` int(11) NOT NULL DEFAULT 0,
  `solve_delay_stat` int(11) NOT NULL DEFAULT 0,
  `date_creation` timestamp NULL DEFAULT NULL,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `is_deleted` (`is_deleted`),
  KEY `date` (`date`),
  KEY `closedate` (`closedate`),
  KEY `status` (`status`),
  KEY `priority` (`priority`),
  KEY `date_mod` (`date_mod`),
  KEY `itilcategories_id` (`itilcategories_id`),
  KEY `users_id_recipient` (`users_id_recipient`),
  KEY `solvedate` (`solvedate`),
  KEY `urgency` (`urgency`),
  KEY `impact` (`impact`),
  KEY `time_to_resolve` (`time_to_resolve`),
  KEY `users_id_lastupdater` (`users_id_lastupdater`),
  KEY `date_creation` (`date_creation`),
  KEY `locations_id` (`locations_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_problems_suppliers`
--

DROP TABLE IF EXISTS `glpi_problems_suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_problems_suppliers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `problems_id` int(10) unsigned NOT NULL DEFAULT 0,
  `suppliers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `type` int(11) NOT NULL DEFAULT 1,
  `use_notification` tinyint(4) NOT NULL DEFAULT 0,
  `alternative_email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`problems_id`,`type`,`suppliers_id`),
  KEY `group` (`suppliers_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_problems_tickets`
--

DROP TABLE IF EXISTS `glpi_problems_tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_problems_tickets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `problems_id` int(10) unsigned NOT NULL DEFAULT 0,
  `tickets_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`problems_id`,`tickets_id`),
  KEY `tickets_id` (`tickets_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_problems_users`
--

DROP TABLE IF EXISTS `glpi_problems_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_problems_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `problems_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `type` int(11) NOT NULL DEFAULT 1,
  `use_notification` tinyint(4) NOT NULL DEFAULT 0,
  `alternative_email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`problems_id`,`type`,`users_id`,`alternative_email`),
  KEY `user` (`users_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_problemtasks`
--

DROP TABLE IF EXISTS `glpi_problemtasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_problemtasks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) DEFAULT NULL,
  `problems_id` int(10) unsigned NOT NULL DEFAULT 0,
  `taskcategories_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date` timestamp NULL DEFAULT NULL,
  `begin` timestamp NULL DEFAULT NULL,
  `end` timestamp NULL DEFAULT NULL,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_editor` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `content` longtext DEFAULT NULL,
  `actiontime` int(11) NOT NULL DEFAULT 0,
  `state` int(11) NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `tasktemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `timeline_position` tinyint(4) NOT NULL DEFAULT 0,
  `is_private` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `problems_id` (`problems_id`),
  KEY `users_id` (`users_id`),
  KEY `users_id_editor` (`users_id_editor`),
  KEY `users_id_tech` (`users_id_tech`),
  KEY `groups_id_tech` (`groups_id_tech`),
  KEY `date` (`date`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `begin` (`begin`),
  KEY `end` (`end`),
  KEY `state` (`state`),
  KEY `taskcategories_id` (`taskcategories_id`),
  KEY `tasktemplates_id` (`tasktemplates_id`),
  KEY `is_private` (`is_private`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_problemtemplatehiddenfields`
--

DROP TABLE IF EXISTS `glpi_problemtemplatehiddenfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_problemtemplatehiddenfields` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `problemtemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `num` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`problemtemplates_id`,`num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_problemtemplatemandatoryfields`
--

DROP TABLE IF EXISTS `glpi_problemtemplatemandatoryfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_problemtemplatemandatoryfields` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `problemtemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `num` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`problemtemplates_id`,`num`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_problemtemplatepredefinedfields`
--

DROP TABLE IF EXISTS `glpi_problemtemplatepredefinedfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_problemtemplatepredefinedfields` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `problemtemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `num` int(11) NOT NULL DEFAULT 0,
  `value` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `problemtemplates_id` (`problemtemplates_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_problemtemplates`
--

DROP TABLE IF EXISTS `glpi_problemtemplates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_problemtemplates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_profilerights`
--

DROP TABLE IF EXISTS `glpi_profilerights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_profilerights` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `profiles_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `rights` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`profiles_id`,`name`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1373 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_profiles`
--

DROP TABLE IF EXISTS `glpi_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_profiles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `interface` varchar(255) DEFAULT 'helpdesk',
  `is_default` tinyint(4) NOT NULL DEFAULT 0,
  `helpdesk_hardware` int(11) NOT NULL DEFAULT 0,
  `helpdesk_item_type` text DEFAULT NULL,
  `ticket_status` text DEFAULT NULL COMMENT 'json encoded array of from/dest allowed status change',
  `date_mod` timestamp NULL DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `problem_status` text DEFAULT NULL COMMENT 'json encoded array of from/dest allowed status change',
  `create_ticket_on_login` tinyint(4) NOT NULL DEFAULT 0,
  `tickettemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `changetemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `problemtemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `change_status` text DEFAULT NULL COMMENT 'json encoded array of from/dest allowed status change',
  `managed_domainrecordtypes` text DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `interface` (`interface`),
  KEY `is_default` (`is_default`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `tickettemplates_id` (`tickettemplates_id`),
  KEY `changetemplates_id` (`changetemplates_id`),
  KEY `problemtemplates_id` (`problemtemplates_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_profiles_reminders`
--

DROP TABLE IF EXISTS `glpi_profiles_reminders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_profiles_reminders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reminders_id` int(10) unsigned NOT NULL DEFAULT 0,
  `profiles_id` int(10) unsigned NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned DEFAULT NULL,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `no_entity_restriction` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `reminders_id` (`reminders_id`),
  KEY `profiles_id` (`profiles_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_profiles_rssfeeds`
--

DROP TABLE IF EXISTS `glpi_profiles_rssfeeds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_profiles_rssfeeds` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rssfeeds_id` int(10) unsigned NOT NULL DEFAULT 0,
  `profiles_id` int(10) unsigned NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned DEFAULT NULL,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `no_entity_restriction` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `rssfeeds_id` (`rssfeeds_id`),
  KEY `profiles_id` (`profiles_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_profiles_users`
--

DROP TABLE IF EXISTS `glpi_profiles_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_profiles_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `profiles_id` int(10) unsigned NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 1,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  `is_default_profile` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `entities_id` (`entities_id`),
  KEY `profiles_id` (`profiles_id`),
  KEY `users_id` (`users_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `is_dynamic` (`is_dynamic`)
) ENGINE=InnoDB AUTO_INCREMENT=772 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_projectcosts`
--

DROP TABLE IF EXISTS `glpi_projectcosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_projectcosts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `projects_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `begin_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `cost` decimal(20,4) NOT NULL DEFAULT 0.0000,
  `budgets_id` int(10) unsigned NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `projects_id` (`projects_id`),
  KEY `begin_date` (`begin_date`),
  KEY `end_date` (`end_date`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `budgets_id` (`budgets_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_projects`
--

DROP TABLE IF EXISTS `glpi_projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_projects` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `priority` int(11) NOT NULL DEFAULT 1,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `projects_id` int(10) unsigned NOT NULL DEFAULT 0,
  `projectstates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `projecttypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plan_start_date` timestamp NULL DEFAULT NULL,
  `plan_end_date` timestamp NULL DEFAULT NULL,
  `real_start_date` timestamp NULL DEFAULT NULL,
  `real_end_date` timestamp NULL DEFAULT NULL,
  `percent_done` int(11) NOT NULL DEFAULT 0,
  `auto_percent_done` tinyint(4) NOT NULL DEFAULT 0,
  `show_on_global_gantt` tinyint(4) NOT NULL DEFAULT 0,
  `content` longtext DEFAULT NULL,
  `comment` longtext DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `date_creation` timestamp NULL DEFAULT NULL,
  `projecttemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_template` tinyint(4) NOT NULL DEFAULT 0,
  `template_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `code` (`code`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `is_deleted` (`is_deleted`),
  KEY `projects_id` (`projects_id`),
  KEY `projectstates_id` (`projectstates_id`),
  KEY `projecttypes_id` (`projecttypes_id`),
  KEY `priority` (`priority`),
  KEY `date` (`date`),
  KEY `date_mod` (`date_mod`),
  KEY `users_id` (`users_id`),
  KEY `groups_id` (`groups_id`),
  KEY `plan_start_date` (`plan_start_date`),
  KEY `plan_end_date` (`plan_end_date`),
  KEY `real_start_date` (`real_start_date`),
  KEY `real_end_date` (`real_end_date`),
  KEY `percent_done` (`percent_done`),
  KEY `show_on_global_gantt` (`show_on_global_gantt`),
  KEY `date_creation` (`date_creation`),
  KEY `projecttemplates_id` (`projecttemplates_id`),
  KEY `is_template` (`is_template`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_projectstates`
--

DROP TABLE IF EXISTS `glpi_projectstates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_projectstates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `color` varchar(255) DEFAULT NULL,
  `is_finished` tinyint(4) NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `is_finished` (`is_finished`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_projecttasklinks`
--

DROP TABLE IF EXISTS `glpi_projecttasklinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_projecttasklinks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `projecttasks_id_source` int(10) unsigned NOT NULL,
  `source_uuid` varchar(255) NOT NULL,
  `projecttasks_id_target` int(10) unsigned NOT NULL,
  `target_uuid` varchar(255) NOT NULL,
  `type` tinyint(4) NOT NULL DEFAULT 0,
  `lag` smallint(6) DEFAULT 0,
  `lead` smallint(6) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `projecttasks_id_source` (`projecttasks_id_source`),
  KEY `projecttasks_id_target` (`projecttasks_id_target`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_projecttasks`
--

DROP TABLE IF EXISTS `glpi_projecttasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_projecttasks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  `comment` longtext DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `projects_id` int(10) unsigned NOT NULL DEFAULT 0,
  `projecttasks_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_creation` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `plan_start_date` timestamp NULL DEFAULT NULL,
  `plan_end_date` timestamp NULL DEFAULT NULL,
  `real_start_date` timestamp NULL DEFAULT NULL,
  `real_end_date` timestamp NULL DEFAULT NULL,
  `planned_duration` int(11) NOT NULL DEFAULT 0,
  `effective_duration` int(11) NOT NULL DEFAULT 0,
  `projectstates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `projecttasktypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `percent_done` int(11) NOT NULL DEFAULT 0,
  `auto_percent_done` tinyint(4) NOT NULL DEFAULT 0,
  `is_milestone` tinyint(4) NOT NULL DEFAULT 0,
  `projecttasktemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_template` tinyint(4) NOT NULL DEFAULT 0,
  `template_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `projects_id` (`projects_id`),
  KEY `projecttasks_id` (`projecttasks_id`),
  KEY `date_creation` (`date_creation`),
  KEY `date_mod` (`date_mod`),
  KEY `users_id` (`users_id`),
  KEY `plan_start_date` (`plan_start_date`),
  KEY `plan_end_date` (`plan_end_date`),
  KEY `real_start_date` (`real_start_date`),
  KEY `real_end_date` (`real_end_date`),
  KEY `percent_done` (`percent_done`),
  KEY `projectstates_id` (`projectstates_id`),
  KEY `projecttasktypes_id` (`projecttasktypes_id`),
  KEY `projecttasktemplates_id` (`projecttasktemplates_id`),
  KEY `is_template` (`is_template`),
  KEY `is_milestone` (`is_milestone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_projecttasks_tickets`
--

DROP TABLE IF EXISTS `glpi_projecttasks_tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_projecttasks_tickets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tickets_id` int(10) unsigned NOT NULL DEFAULT 0,
  `projecttasks_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`tickets_id`,`projecttasks_id`),
  KEY `projects_id` (`projecttasks_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_projecttaskteams`
--

DROP TABLE IF EXISTS `glpi_projecttaskteams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_projecttaskteams` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `projecttasks_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) DEFAULT NULL,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`projecttasks_id`,`itemtype`,`items_id`),
  KEY `item` (`itemtype`,`items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_projecttasktemplates`
--

DROP TABLE IF EXISTS `glpi_projecttasktemplates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_projecttasktemplates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `comment` longtext DEFAULT NULL,
  `projects_id` int(10) unsigned NOT NULL DEFAULT 0,
  `projecttasks_id` int(10) unsigned NOT NULL DEFAULT 0,
  `plan_start_date` timestamp NULL DEFAULT NULL,
  `plan_end_date` timestamp NULL DEFAULT NULL,
  `real_start_date` timestamp NULL DEFAULT NULL,
  `real_end_date` timestamp NULL DEFAULT NULL,
  `planned_duration` int(11) NOT NULL DEFAULT 0,
  `effective_duration` int(11) NOT NULL DEFAULT 0,
  `projectstates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `projecttasktypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `percent_done` int(11) NOT NULL DEFAULT 0,
  `is_milestone` tinyint(4) NOT NULL DEFAULT 0,
  `comments` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `projects_id` (`projects_id`),
  KEY `projecttasks_id` (`projecttasks_id`),
  KEY `date_creation` (`date_creation`),
  KEY `date_mod` (`date_mod`),
  KEY `users_id` (`users_id`),
  KEY `plan_start_date` (`plan_start_date`),
  KEY `plan_end_date` (`plan_end_date`),
  KEY `real_start_date` (`real_start_date`),
  KEY `real_end_date` (`real_end_date`),
  KEY `percent_done` (`percent_done`),
  KEY `projectstates_id` (`projectstates_id`),
  KEY `projecttasktypes_id` (`projecttasktypes_id`),
  KEY `is_milestone` (`is_milestone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_projecttasktypes`
--

DROP TABLE IF EXISTS `glpi_projecttasktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_projecttasktypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_projectteams`
--

DROP TABLE IF EXISTS `glpi_projectteams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_projectteams` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `projects_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) DEFAULT NULL,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`projects_id`,`itemtype`,`items_id`),
  KEY `item` (`itemtype`,`items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_projecttypes`
--

DROP TABLE IF EXISTS `glpi_projecttypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_projecttypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_queuednotifications`
--

DROP TABLE IF EXISTS `glpi_queuednotifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_queuednotifications` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `itemtype` varchar(100) DEFAULT NULL,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `notificationtemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `sent_try` int(11) NOT NULL DEFAULT 0,
  `create_time` timestamp NULL DEFAULT NULL,
  `send_time` timestamp NULL DEFAULT NULL,
  `sent_time` timestamp NULL DEFAULT NULL,
  `name` text DEFAULT NULL,
  `sender` text DEFAULT NULL,
  `sendername` text DEFAULT NULL,
  `recipient` text DEFAULT NULL,
  `recipientname` text DEFAULT NULL,
  `replyto` text DEFAULT NULL,
  `replytoname` text DEFAULT NULL,
  `headers` text DEFAULT NULL,
  `body_html` longtext DEFAULT NULL,
  `body_text` longtext DEFAULT NULL,
  `messageid` text DEFAULT NULL,
  `documents` text DEFAULT NULL,
  `mode` varchar(20) NOT NULL COMMENT 'See Notification_NotificationTemplate::MODE_* constants',
  `event` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `item` (`itemtype`,`items_id`,`notificationtemplates_id`),
  KEY `is_deleted` (`is_deleted`),
  KEY `entities_id` (`entities_id`),
  KEY `sent_try` (`sent_try`),
  KEY `create_time` (`create_time`),
  KEY `send_time` (`send_time`),
  KEY `sent_time` (`sent_time`),
  KEY `mode` (`mode`),
  KEY `notificationtemplates_id` (`notificationtemplates_id`),
  KEY `recipient` (`recipient`(255))
) ENGINE=InnoDB AUTO_INCREMENT=2670 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_rackmodels`
--

DROP TABLE IF EXISTS `glpi_rackmodels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_rackmodels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `product_number` varchar(255) DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `pictures` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `product_number` (`product_number`),
  KEY `date_creation` (`date_creation`),
  KEY `date_mod` (`date_mod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_racks`
--

DROP TABLE IF EXISTS `glpi_racks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_racks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `serial` varchar(255) DEFAULT NULL,
  `otherserial` varchar(255) DEFAULT NULL,
  `rackmodels_id` int(10) unsigned DEFAULT NULL,
  `manufacturers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `racktypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `depth` int(11) DEFAULT NULL,
  `number_units` int(11) DEFAULT 0,
  `is_template` tinyint(4) NOT NULL DEFAULT 0,
  `template_name` varchar(255) DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `dcrooms_id` int(10) unsigned NOT NULL DEFAULT 0,
  `room_orientation` int(11) NOT NULL DEFAULT 0,
  `position` varchar(50) DEFAULT NULL,
  `bgcolor` varchar(7) DEFAULT NULL,
  `max_power` int(11) NOT NULL DEFAULT 0,
  `mesured_power` int(11) NOT NULL DEFAULT 0,
  `max_weight` int(11) NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `locations_id` (`locations_id`),
  KEY `rackmodels_id` (`rackmodels_id`),
  KEY `manufacturers_id` (`manufacturers_id`),
  KEY `racktypes_id` (`racktypes_id`),
  KEY `states_id` (`states_id`),
  KEY `users_id_tech` (`users_id_tech`),
  KEY `group_id_tech` (`groups_id_tech`),
  KEY `is_template` (`is_template`),
  KEY `is_deleted` (`is_deleted`),
  KEY `dcrooms_id` (`dcrooms_id`),
  KEY `date_creation` (`date_creation`),
  KEY `date_mod` (`date_mod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_racktypes`
--

DROP TABLE IF EXISTS `glpi_racktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_racktypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `name` (`name`),
  KEY `date_creation` (`date_creation`),
  KEY `date_mod` (`date_mod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_recurrentchanges`
--

DROP TABLE IF EXISTS `glpi_recurrentchanges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_recurrentchanges` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `is_active` tinyint(4) NOT NULL DEFAULT 0,
  `changetemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `begin_date` timestamp NULL DEFAULT NULL,
  `periodicity` varchar(255) DEFAULT NULL,
  `create_before` int(11) NOT NULL DEFAULT 0,
  `next_creation_date` timestamp NULL DEFAULT NULL,
  `calendars_id` int(10) unsigned NOT NULL DEFAULT 0,
  `end_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `is_active` (`is_active`),
  KEY `changetemplates_id` (`changetemplates_id`),
  KEY `next_creation_date` (`next_creation_date`),
  KEY `calendars_id` (`calendars_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_refusedequipments`
--

DROP TABLE IF EXISTS `glpi_refusedequipments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_refusedequipments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `itemtype` varchar(100) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `ip` text DEFAULT NULL,
  `mac` text DEFAULT NULL,
  `rules_id` int(10) unsigned NOT NULL DEFAULT 0,
  `method` varchar(255) DEFAULT NULL,
  `serial` varchar(255) DEFAULT NULL,
  `uuid` varchar(255) DEFAULT NULL,
  `agents_id` int(10) unsigned NOT NULL DEFAULT 0,
  `autoupdatesystems_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_creation` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `agents_id` (`agents_id`),
  KEY `autoupdatesystems_id` (`autoupdatesystems_id`),
  KEY `rules_id` (`rules_id`),
  KEY `date_creation` (`date_creation`),
  KEY `date_mod` (`date_mod`)
) ENGINE=InnoDB AUTO_INCREMENT=344 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_registeredids`
--

DROP TABLE IF EXISTS `glpi_registeredids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_registeredids` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) NOT NULL,
  `device_type` varchar(100) NOT NULL COMMENT 'USB, PCI ...',
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `item` (`itemtype`,`items_id`),
  KEY `device_type` (`device_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_reminders`
--

DROP TABLE IF EXISTS `glpi_reminders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_reminders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) DEFAULT NULL,
  `date` timestamp NULL DEFAULT NULL,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `text` text DEFAULT NULL,
  `begin` timestamp NULL DEFAULT NULL,
  `end` timestamp NULL DEFAULT NULL,
  `is_planned` tinyint(4) NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `state` int(11) NOT NULL DEFAULT 0,
  `begin_view_date` timestamp NULL DEFAULT NULL,
  `end_view_date` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `name` (`name`),
  KEY `date` (`date`),
  KEY `begin` (`begin`),
  KEY `end` (`end`),
  KEY `users_id` (`users_id`),
  KEY `is_planned` (`is_planned`),
  KEY `state` (`state`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_reminders_users`
--

DROP TABLE IF EXISTS `glpi_reminders_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_reminders_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reminders_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `reminders_id` (`reminders_id`),
  KEY `users_id` (`users_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_remindertranslations`
--

DROP TABLE IF EXISTS `glpi_remindertranslations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_remindertranslations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reminders_id` int(10) unsigned NOT NULL DEFAULT 0,
  `language` varchar(5) DEFAULT NULL,
  `name` text DEFAULT NULL,
  `text` longtext DEFAULT NULL,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `item` (`reminders_id`,`language`),
  KEY `users_id` (`users_id`),
  KEY `date_creation` (`date_creation`),
  KEY `date_mod` (`date_mod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_requesttypes`
--

DROP TABLE IF EXISTS `glpi_requesttypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_requesttypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `is_helpdesk_default` tinyint(4) NOT NULL DEFAULT 0,
  `is_followup_default` tinyint(4) NOT NULL DEFAULT 0,
  `is_mail_default` tinyint(4) NOT NULL DEFAULT 0,
  `is_mailfollowup_default` tinyint(4) NOT NULL DEFAULT 0,
  `is_active` tinyint(4) NOT NULL DEFAULT 1,
  `is_ticketheader` tinyint(4) NOT NULL DEFAULT 1,
  `is_itilfollowup` tinyint(4) NOT NULL DEFAULT 1,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `is_helpdesk_default` (`is_helpdesk_default`),
  KEY `is_followup_default` (`is_followup_default`),
  KEY `is_mail_default` (`is_mail_default`),
  KEY `is_mailfollowup_default` (`is_mailfollowup_default`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `is_active` (`is_active`),
  KEY `is_ticketheader` (`is_ticketheader`),
  KEY `is_itilfollowup` (`is_itilfollowup`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_reservationitems`
--

DROP TABLE IF EXISTS `glpi_reservationitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_reservationitems` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `itemtype` varchar(100) NOT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`itemtype`,`items_id`),
  KEY `is_active` (`is_active`),
  KEY `item` (`itemtype`,`items_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_reservations`
--

DROP TABLE IF EXISTS `glpi_reservations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_reservations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reservationitems_id` int(10) unsigned NOT NULL DEFAULT 0,
  `begin` timestamp NULL DEFAULT NULL,
  `end` timestamp NULL DEFAULT NULL,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `group` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `begin` (`begin`),
  KEY `end` (`end`),
  KEY `users_id` (`users_id`),
  KEY `resagroup` (`reservationitems_id`,`group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_rssfeeds`
--

DROP TABLE IF EXISTS `glpi_rssfeeds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_rssfeeds` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `url` text DEFAULT NULL,
  `refresh_rate` int(11) NOT NULL DEFAULT 86400,
  `max_items` int(11) NOT NULL DEFAULT 20,
  `have_error` tinyint(4) NOT NULL DEFAULT 0,
  `is_active` tinyint(4) NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `users_id` (`users_id`),
  KEY `date_mod` (`date_mod`),
  KEY `have_error` (`have_error`),
  KEY `is_active` (`is_active`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_rssfeeds_users`
--

DROP TABLE IF EXISTS `glpi_rssfeeds_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_rssfeeds_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rssfeeds_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `rssfeeds_id` (`rssfeeds_id`),
  KEY `users_id` (`users_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_ruleactions`
--

DROP TABLE IF EXISTS `glpi_ruleactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_ruleactions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rules_id` int(10) unsigned NOT NULL DEFAULT 0,
  `action_type` varchar(255) DEFAULT NULL COMMENT 'VALUE IN (assign, regex_result, append_regex_result, affectbyip, affectbyfqdn, affectbymac)',
  `field` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rules_id` (`rules_id`),
  KEY `field_value` (`field`(50),`value`(50))
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_rulecriterias`
--

DROP TABLE IF EXISTS `glpi_rulecriterias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_rulecriterias` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rules_id` int(10) unsigned NOT NULL DEFAULT 0,
  `criteria` varchar(255) DEFAULT NULL,
  `condition` int(11) NOT NULL DEFAULT 0 COMMENT 'see define.php PATTERN_* and REGEX_* constant',
  `pattern` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rules_id` (`rules_id`),
  KEY `condition` (`condition`)
) ENGINE=InnoDB AUTO_INCREMENT=221 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_rulematchedlogs`
--

DROP TABLE IF EXISTS `glpi_rulematchedlogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_rulematchedlogs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date` timestamp NULL DEFAULT NULL,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) DEFAULT NULL,
  `rules_id` int(10) unsigned DEFAULT NULL,
  `agents_id` int(10) unsigned NOT NULL DEFAULT 0,
  `method` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `agents_id` (`agents_id`),
  KEY `item` (`itemtype`,`items_id`),
  KEY `rules_id` (`rules_id`)
) ENGINE=InnoDB AUTO_INCREMENT=583784 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_rulerightparameters`
--

DROP TABLE IF EXISTS `glpi_rulerightparameters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_rulerightparameters` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_rules`
--

DROP TABLE IF EXISTS `glpi_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_rules` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `sub_type` varchar(255) NOT NULL DEFAULT '',
  `ranking` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `match` char(10) DEFAULT NULL COMMENT 'see define.php *_MATCHING constant',
  `is_active` tinyint(4) NOT NULL DEFAULT 1,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `uuid` varchar(255) DEFAULT NULL,
  `condition` int(11) NOT NULL DEFAULT 0,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_active` (`is_active`),
  KEY `sub_type` (`sub_type`),
  KEY `date_mod` (`date_mod`),
  KEY `is_recursive` (`is_recursive`),
  KEY `condition` (`condition`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_savedsearches`
--

DROP TABLE IF EXISTS `glpi_savedsearches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_savedsearches` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `type` int(11) NOT NULL DEFAULT 0 COMMENT 'see SavedSearch:: constants',
  `itemtype` varchar(100) NOT NULL,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_private` tinyint(4) NOT NULL DEFAULT 1,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `query` text DEFAULT NULL,
  `last_execution_time` int(11) DEFAULT NULL,
  `do_count` tinyint(4) NOT NULL DEFAULT 2 COMMENT 'Do or do not count results on list display see SavedSearch::COUNT_* constants',
  `last_execution_date` timestamp NULL DEFAULT NULL,
  `counter` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `type` (`type`),
  KEY `itemtype` (`itemtype`),
  KEY `entities_id` (`entities_id`),
  KEY `users_id` (`users_id`),
  KEY `is_private` (`is_private`),
  KEY `is_recursive` (`is_recursive`),
  KEY `last_execution_time` (`last_execution_time`),
  KEY `last_execution_date` (`last_execution_date`),
  KEY `do_count` (`do_count`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_savedsearches_alerts`
--

DROP TABLE IF EXISTS `glpi_savedsearches_alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_savedsearches_alerts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `savedsearches_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 0,
  `operator` tinyint(4) NOT NULL,
  `value` int(11) NOT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `frequency` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`savedsearches_id`,`operator`,`value`),
  KEY `name` (`name`),
  KEY `is_active` (`is_active`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_savedsearches_users`
--

DROP TABLE IF EXISTS `glpi_savedsearches_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_savedsearches_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) NOT NULL,
  `savedsearches_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`users_id`,`itemtype`),
  KEY `savedsearches_id` (`savedsearches_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_slalevelactions`
--

DROP TABLE IF EXISTS `glpi_slalevelactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_slalevelactions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `slalevels_id` int(10) unsigned NOT NULL DEFAULT 0,
  `action_type` varchar(255) DEFAULT NULL,
  `field` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `slalevels_id` (`slalevels_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_slalevelcriterias`
--

DROP TABLE IF EXISTS `glpi_slalevelcriterias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_slalevelcriterias` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `slalevels_id` int(10) unsigned NOT NULL DEFAULT 0,
  `criteria` varchar(255) DEFAULT NULL,
  `condition` int(11) NOT NULL DEFAULT 0 COMMENT 'see define.php PATTERN_* and REGEX_* constant',
  `pattern` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `slalevels_id` (`slalevels_id`),
  KEY `condition` (`condition`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_slalevels`
--

DROP TABLE IF EXISTS `glpi_slalevels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_slalevels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `slas_id` int(10) unsigned NOT NULL DEFAULT 0,
  `execution_time` int(11) NOT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 1,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `match` char(10) DEFAULT NULL COMMENT 'see define.php *_MATCHING constant',
  `uuid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `is_active` (`is_active`),
  KEY `slas_id` (`slas_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_slalevels_tickets`
--

DROP TABLE IF EXISTS `glpi_slalevels_tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_slalevels_tickets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tickets_id` int(10) unsigned NOT NULL DEFAULT 0,
  `slalevels_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`tickets_id`,`slalevels_id`),
  KEY `slalevels_id` (`slalevels_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_slas`
--

DROP TABLE IF EXISTS `glpi_slas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_slas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `type` int(11) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `number_time` int(11) NOT NULL,
  `use_ticket_calendar` tinyint(4) NOT NULL DEFAULT 0,
  `calendars_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `definition_time` varchar(255) DEFAULT NULL,
  `end_of_working_day` tinyint(4) NOT NULL DEFAULT 0,
  `date_creation` timestamp NULL DEFAULT NULL,
  `slms_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `calendars_id` (`calendars_id`),
  KEY `slms_id` (`slms_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_slms`
--

DROP TABLE IF EXISTS `glpi_slms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_slms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `use_ticket_calendar` tinyint(4) NOT NULL DEFAULT 0,
  `calendars_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `calendars_id` (`calendars_id`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_snmpcredentials`
--

DROP TABLE IF EXISTS `glpi_snmpcredentials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_snmpcredentials` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `snmpversion` varchar(8) NOT NULL DEFAULT '1',
  `community` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `authentication` varchar(255) DEFAULT NULL,
  `auth_passphrase` varchar(255) DEFAULT NULL,
  `encryption` varchar(255) DEFAULT NULL,
  `priv_passphrase` varchar(255) DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `snmpversion` (`snmpversion`),
  KEY `is_deleted` (`is_deleted`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_socketmodels`
--

DROP TABLE IF EXISTS `glpi_socketmodels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_socketmodels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_sockets`
--

DROP TABLE IF EXISTS `glpi_sockets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_sockets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `position` int(11) NOT NULL DEFAULT 0,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `socketmodels_id` int(10) unsigned NOT NULL DEFAULT 0,
  `wiring_side` tinyint(4) DEFAULT 1,
  `itemtype` varchar(255) DEFAULT NULL,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `networkports_id` int(10) unsigned NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `socketmodels_id` (`socketmodels_id`),
  KEY `location_name` (`locations_id`,`name`),
  KEY `item` (`itemtype`,`items_id`),
  KEY `networkports_id` (`networkports_id`),
  KEY `wiring_side` (`wiring_side`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_softwarecategories`
--

DROP TABLE IF EXISTS `glpi_softwarecategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_softwarecategories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `softwarecategories_id` int(10) unsigned NOT NULL DEFAULT 0,
  `completename` text DEFAULT NULL,
  `level` int(11) NOT NULL DEFAULT 0,
  `ancestors_cache` longtext DEFAULT NULL,
  `sons_cache` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `softwarecategories_id` (`softwarecategories_id`),
  KEY `level` (`level`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_softwarelicenses`
--

DROP TABLE IF EXISTS `glpi_softwarelicenses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_softwarelicenses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `softwares_id` int(10) unsigned NOT NULL DEFAULT 0,
  `softwarelicenses_id` int(10) unsigned NOT NULL DEFAULT 0,
  `completename` text DEFAULT NULL,
  `level` int(11) NOT NULL DEFAULT 0,
  `ancestors_cache` longtext DEFAULT NULL,
  `sons_cache` longtext DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `number` int(11) NOT NULL DEFAULT 0,
  `softwarelicensetypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `serial` varchar(255) DEFAULT NULL,
  `otherserial` varchar(255) DEFAULT NULL,
  `softwareversions_id_buy` int(10) unsigned NOT NULL DEFAULT 0,
  `softwareversions_id_use` int(10) unsigned NOT NULL DEFAULT 0,
  `expire` date DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `is_valid` tinyint(4) NOT NULL DEFAULT 1,
  `date_creation` timestamp NULL DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_helpdesk_visible` tinyint(4) NOT NULL DEFAULT 0,
  `is_template` tinyint(4) NOT NULL DEFAULT 0,
  `template_name` varchar(255) DEFAULT NULL,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0,
  `manufacturers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `contact` varchar(255) DEFAULT NULL,
  `contact_num` varchar(255) DEFAULT NULL,
  `allow_overquota` tinyint(4) NOT NULL DEFAULT 0,
  `pictures` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `is_template` (`is_template`),
  KEY `serial` (`serial`),
  KEY `otherserial` (`otherserial`),
  KEY `expire` (`expire`),
  KEY `softwareversions_id_buy` (`softwareversions_id_buy`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `softwarelicensetypes_id` (`softwarelicensetypes_id`),
  KEY `softwareversions_id_use` (`softwareversions_id_use`),
  KEY `date_mod` (`date_mod`),
  KEY `softwares_id_expire_number` (`softwares_id`,`expire`,`number`),
  KEY `locations_id` (`locations_id`),
  KEY `users_id_tech` (`users_id_tech`),
  KEY `users_id` (`users_id`),
  KEY `groups_id_tech` (`groups_id_tech`),
  KEY `groups_id` (`groups_id`),
  KEY `is_helpdesk_visible` (`is_helpdesk_visible`),
  KEY `is_deleted` (`is_deleted`),
  KEY `date_creation` (`date_creation`),
  KEY `manufacturers_id` (`manufacturers_id`),
  KEY `states_id` (`states_id`),
  KEY `allow_overquota` (`allow_overquota`),
  KEY `softwarelicenses_id` (`softwarelicenses_id`),
  KEY `level` (`level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_softwarelicensetypes`
--

DROP TABLE IF EXISTS `glpi_softwarelicensetypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_softwarelicensetypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `softwarelicensetypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `level` int(11) NOT NULL DEFAULT 0,
  `ancestors_cache` longtext DEFAULT NULL,
  `sons_cache` longtext DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `completename` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `softwarelicensetypes_id` (`softwarelicensetypes_id`),
  KEY `level` (`level`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_softwares`
--

DROP TABLE IF EXISTS `glpi_softwares`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_softwares` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `is_update` tinyint(4) NOT NULL DEFAULT 0,
  `softwares_id` int(10) unsigned NOT NULL DEFAULT 0,
  `manufacturers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `is_template` tinyint(4) NOT NULL DEFAULT 0,
  `template_name` varchar(255) DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `ticket_tco` decimal(20,4) DEFAULT 0.0000,
  `is_helpdesk_visible` tinyint(4) NOT NULL DEFAULT 1,
  `softwarecategories_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_valid` tinyint(4) NOT NULL DEFAULT 1,
  `date_creation` timestamp NULL DEFAULT NULL,
  `pictures` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `date_mod` (`date_mod`),
  KEY `name` (`name`),
  KEY `is_template` (`is_template`),
  KEY `is_update` (`is_update`),
  KEY `softwarecategories_id` (`softwarecategories_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `manufacturers_id` (`manufacturers_id`),
  KEY `groups_id` (`groups_id`),
  KEY `users_id` (`users_id`),
  KEY `locations_id` (`locations_id`),
  KEY `users_id_tech` (`users_id_tech`),
  KEY `softwares_id` (`softwares_id`),
  KEY `is_deleted` (`is_deleted`),
  KEY `is_helpdesk_visible` (`is_helpdesk_visible`),
  KEY `groups_id_tech` (`groups_id_tech`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=4599 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_softwareversions`
--

DROP TABLE IF EXISTS `glpi_softwareversions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_softwareversions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `softwares_id` int(10) unsigned NOT NULL DEFAULT 0,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `arch` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `operatingsystems_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `arch` (`arch`),
  KEY `softwares_id` (`softwares_id`),
  KEY `states_id` (`states_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `operatingsystems_id` (`operatingsystems_id`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=258906 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_solutiontemplates`
--

DROP TABLE IF EXISTS `glpi_solutiontemplates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_solutiontemplates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `content` mediumtext DEFAULT NULL,
  `solutiontypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `is_recursive` (`is_recursive`),
  KEY `solutiontypes_id` (`solutiontypes_id`),
  KEY `entities_id` (`entities_id`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_solutiontypes`
--

DROP TABLE IF EXISTS `glpi_solutiontypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_solutiontypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 1,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_ssovariables`
--

DROP TABLE IF EXISTS `glpi_ssovariables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_ssovariables` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_states`
--

DROP TABLE IF EXISTS `glpi_states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_states` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0,
  `completename` text DEFAULT NULL,
  `level` int(11) NOT NULL DEFAULT 0,
  `ancestors_cache` longtext DEFAULT NULL,
  `sons_cache` longtext DEFAULT NULL,
  `is_visible_computer` tinyint(4) NOT NULL DEFAULT 1,
  `is_visible_monitor` tinyint(4) NOT NULL DEFAULT 1,
  `is_visible_networkequipment` tinyint(4) NOT NULL DEFAULT 1,
  `is_visible_peripheral` tinyint(4) NOT NULL DEFAULT 1,
  `is_visible_phone` tinyint(4) NOT NULL DEFAULT 1,
  `is_visible_printer` tinyint(4) NOT NULL DEFAULT 1,
  `is_visible_softwareversion` tinyint(4) NOT NULL DEFAULT 1,
  `is_visible_softwarelicense` tinyint(4) NOT NULL DEFAULT 1,
  `is_visible_line` tinyint(4) NOT NULL DEFAULT 1,
  `is_visible_certificate` tinyint(4) NOT NULL DEFAULT 1,
  `is_visible_rack` tinyint(4) NOT NULL DEFAULT 1,
  `is_visible_passivedcequipment` tinyint(4) NOT NULL DEFAULT 1,
  `is_visible_enclosure` tinyint(4) NOT NULL DEFAULT 1,
  `is_visible_pdu` tinyint(4) NOT NULL DEFAULT 1,
  `is_visible_cluster` tinyint(4) NOT NULL DEFAULT 1,
  `is_visible_contract` tinyint(4) NOT NULL DEFAULT 1,
  `is_visible_appliance` tinyint(4) NOT NULL DEFAULT 1,
  `is_visible_databaseinstance` tinyint(4) NOT NULL DEFAULT 1,
  `is_visible_cable` tinyint(4) NOT NULL DEFAULT 1,
  `is_visible_unmanaged` tinyint(4) NOT NULL DEFAULT 1,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`states_id`,`name`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `is_visible_computer` (`is_visible_computer`),
  KEY `is_visible_monitor` (`is_visible_monitor`),
  KEY `is_visible_networkequipment` (`is_visible_networkequipment`),
  KEY `is_visible_peripheral` (`is_visible_peripheral`),
  KEY `is_visible_phone` (`is_visible_phone`),
  KEY `is_visible_printer` (`is_visible_printer`),
  KEY `is_visible_softwareversion` (`is_visible_softwareversion`),
  KEY `is_visible_softwarelicense` (`is_visible_softwarelicense`),
  KEY `is_visible_line` (`is_visible_line`),
  KEY `is_visible_certificate` (`is_visible_certificate`),
  KEY `is_visible_rack` (`is_visible_rack`),
  KEY `is_visible_passivedcequipment` (`is_visible_passivedcequipment`),
  KEY `is_visible_enclosure` (`is_visible_enclosure`),
  KEY `is_visible_pdu` (`is_visible_pdu`),
  KEY `is_visible_cluster` (`is_visible_cluster`),
  KEY `is_visible_contract` (`is_visible_contract`),
  KEY `is_visible_appliance` (`is_visible_appliance`),
  KEY `is_visible_databaseinstance` (`is_visible_databaseinstance`),
  KEY `is_visible_cable` (`is_visible_cable`),
  KEY `is_visible_unmanaged` (`is_visible_unmanaged`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `level` (`level`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_suppliers`
--

DROP TABLE IF EXISTS `glpi_suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_suppliers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `suppliertypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `registration_number` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `postcode` varchar(255) DEFAULT NULL,
  `town` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `phonenumber` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `fax` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 0,
  `pictures` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `suppliertypes_id` (`suppliertypes_id`),
  KEY `is_deleted` (`is_deleted`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `is_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_suppliers_tickets`
--

DROP TABLE IF EXISTS `glpi_suppliers_tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_suppliers_tickets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tickets_id` int(10) unsigned NOT NULL DEFAULT 0,
  `suppliers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `type` int(11) NOT NULL DEFAULT 1,
  `use_notification` tinyint(4) NOT NULL DEFAULT 1,
  `alternative_email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`tickets_id`,`type`,`suppliers_id`),
  KEY `group` (`suppliers_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_suppliertypes`
--

DROP TABLE IF EXISTS `glpi_suppliertypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_suppliertypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_taskcategories`
--

DROP TABLE IF EXISTS `glpi_taskcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_taskcategories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `taskcategories_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `completename` text DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `level` int(11) NOT NULL DEFAULT 0,
  `ancestors_cache` longtext DEFAULT NULL,
  `sons_cache` longtext DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 1,
  `is_helpdeskvisible` tinyint(4) NOT NULL DEFAULT 1,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `knowbaseitemcategories_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `taskcategories_id` (`taskcategories_id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `is_active` (`is_active`),
  KEY `is_helpdeskvisible` (`is_helpdeskvisible`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `knowbaseitemcategories_id` (`knowbaseitemcategories_id`),
  KEY `level` (`level`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_tasktemplates`
--

DROP TABLE IF EXISTS `glpi_tasktemplates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_tasktemplates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `content` mediumtext DEFAULT NULL,
  `taskcategories_id` int(10) unsigned NOT NULL DEFAULT 0,
  `actiontime` int(11) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `state` int(11) NOT NULL DEFAULT 0,
  `is_private` tinyint(4) NOT NULL DEFAULT 0,
  `users_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `is_recursive` (`is_recursive`),
  KEY `taskcategories_id` (`taskcategories_id`),
  KEY `entities_id` (`entities_id`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `is_private` (`is_private`),
  KEY `users_id_tech` (`users_id_tech`),
  KEY `groups_id_tech` (`groups_id_tech`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_ticketcosts`
--

DROP TABLE IF EXISTS `glpi_ticketcosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_ticketcosts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tickets_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `begin_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `actiontime` int(11) NOT NULL DEFAULT 0,
  `cost_time` decimal(20,4) NOT NULL DEFAULT 0.0000,
  `cost_fixed` decimal(20,4) NOT NULL DEFAULT 0.0000,
  `cost_material` decimal(20,4) NOT NULL DEFAULT 0.0000,
  `budgets_id` int(10) unsigned NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `tickets_id` (`tickets_id`),
  KEY `begin_date` (`begin_date`),
  KEY `end_date` (`end_date`),
  KEY `entities_id` (`entities_id`),
  KEY `budgets_id` (`budgets_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_ticketrecurrents`
--

DROP TABLE IF EXISTS `glpi_ticketrecurrents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_ticketrecurrents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `is_active` tinyint(4) NOT NULL DEFAULT 0,
  `tickettemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `begin_date` timestamp NULL DEFAULT NULL,
  `periodicity` varchar(255) DEFAULT NULL,
  `create_before` int(11) NOT NULL DEFAULT 0,
  `next_creation_date` timestamp NULL DEFAULT NULL,
  `calendars_id` int(10) unsigned NOT NULL DEFAULT 0,
  `end_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `is_active` (`is_active`),
  KEY `tickettemplates_id` (`tickettemplates_id`),
  KEY `next_creation_date` (`next_creation_date`),
  KEY `calendars_id` (`calendars_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_tickets`
--

DROP TABLE IF EXISTS `glpi_tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_tickets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `date` timestamp NULL DEFAULT NULL,
  `closedate` timestamp NULL DEFAULT NULL,
  `solvedate` timestamp NULL DEFAULT NULL,
  `takeintoaccountdate` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `users_id_lastupdater` int(10) unsigned NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 1,
  `users_id_recipient` int(10) unsigned NOT NULL DEFAULT 0,
  `requesttypes_id` int(10) unsigned NOT NULL DEFAULT 0,
  `content` longtext DEFAULT NULL,
  `urgency` int(11) NOT NULL DEFAULT 1,
  `impact` int(11) NOT NULL DEFAULT 1,
  `priority` int(11) NOT NULL DEFAULT 1,
  `itilcategories_id` int(10) unsigned NOT NULL DEFAULT 0,
  `type` int(11) NOT NULL DEFAULT 1,
  `global_validation` int(11) NOT NULL DEFAULT 1,
  `slas_id_ttr` int(10) unsigned NOT NULL DEFAULT 0,
  `slas_id_tto` int(10) unsigned NOT NULL DEFAULT 0,
  `slalevels_id_ttr` int(10) unsigned NOT NULL DEFAULT 0,
  `time_to_resolve` timestamp NULL DEFAULT NULL,
  `time_to_own` timestamp NULL DEFAULT NULL,
  `begin_waiting_date` timestamp NULL DEFAULT NULL,
  `sla_waiting_duration` int(11) NOT NULL DEFAULT 0,
  `ola_waiting_duration` int(11) NOT NULL DEFAULT 0,
  `olas_id_tto` int(10) unsigned NOT NULL DEFAULT 0,
  `olas_id_ttr` int(10) unsigned NOT NULL DEFAULT 0,
  `olalevels_id_ttr` int(10) unsigned NOT NULL DEFAULT 0,
  `ola_tto_begin_date` timestamp NULL DEFAULT NULL,
  `ola_ttr_begin_date` timestamp NULL DEFAULT NULL,
  `internal_time_to_resolve` timestamp NULL DEFAULT NULL,
  `internal_time_to_own` timestamp NULL DEFAULT NULL,
  `waiting_duration` int(11) NOT NULL DEFAULT 0,
  `close_delay_stat` int(11) NOT NULL DEFAULT 0,
  `solve_delay_stat` int(11) NOT NULL DEFAULT 0,
  `takeintoaccount_delay_stat` int(11) NOT NULL DEFAULT 0,
  `actiontime` int(11) NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `validation_percent` int(11) NOT NULL DEFAULT 0,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `date` (`date`),
  KEY `closedate` (`closedate`),
  KEY `status` (`status`),
  KEY `priority` (`priority`),
  KEY `request_type` (`requesttypes_id`),
  KEY `date_mod` (`date_mod`),
  KEY `entities_id` (`entities_id`),
  KEY `users_id_recipient` (`users_id_recipient`),
  KEY `solvedate` (`solvedate`),
  KEY `takeintoaccountdate` (`takeintoaccountdate`),
  KEY `urgency` (`urgency`),
  KEY `impact` (`impact`),
  KEY `global_validation` (`global_validation`),
  KEY `slas_id_tto` (`slas_id_tto`),
  KEY `slas_id_ttr` (`slas_id_ttr`),
  KEY `time_to_resolve` (`time_to_resolve`),
  KEY `time_to_own` (`time_to_own`),
  KEY `olas_id_tto` (`olas_id_tto`),
  KEY `olas_id_ttr` (`olas_id_ttr`),
  KEY `slalevels_id_ttr` (`slalevels_id_ttr`),
  KEY `internal_time_to_resolve` (`internal_time_to_resolve`),
  KEY `internal_time_to_own` (`internal_time_to_own`),
  KEY `users_id_lastupdater` (`users_id_lastupdater`),
  KEY `type` (`type`),
  KEY `itilcategories_id` (`itilcategories_id`),
  KEY `is_deleted` (`is_deleted`),
  KEY `name` (`name`),
  KEY `locations_id` (`locations_id`),
  KEY `date_creation` (`date_creation`),
  KEY `ola_waiting_duration` (`ola_waiting_duration`),
  KEY `olalevels_id_ttr` (`olalevels_id_ttr`)
) ENGINE=InnoDB AUTO_INCREMENT=458 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_tickets_contracts`
--

DROP TABLE IF EXISTS `glpi_tickets_contracts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_tickets_contracts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tickets_id` int(10) unsigned NOT NULL DEFAULT 0,
  `contracts_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`tickets_id`,`contracts_id`),
  KEY `contracts_id` (`contracts_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_tickets_tickets`
--

DROP TABLE IF EXISTS `glpi_tickets_tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_tickets_tickets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tickets_id_1` int(10) unsigned NOT NULL DEFAULT 0,
  `tickets_id_2` int(10) unsigned NOT NULL DEFAULT 0,
  `link` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`tickets_id_1`,`tickets_id_2`),
  KEY `tickets_id_2` (`tickets_id_2`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_tickets_users`
--

DROP TABLE IF EXISTS `glpi_tickets_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_tickets_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tickets_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `type` int(11) NOT NULL DEFAULT 1,
  `use_notification` tinyint(4) NOT NULL DEFAULT 1,
  `alternative_email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`tickets_id`,`type`,`users_id`,`alternative_email`),
  KEY `user` (`users_id`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=912 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_ticketsatisfactions`
--

DROP TABLE IF EXISTS `glpi_ticketsatisfactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_ticketsatisfactions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tickets_id` int(10) unsigned NOT NULL DEFAULT 0,
  `type` int(11) NOT NULL DEFAULT 1,
  `date_begin` timestamp NULL DEFAULT NULL,
  `date_answered` timestamp NULL DEFAULT NULL,
  `satisfaction` int(11) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tickets_id` (`tickets_id`)
) ENGINE=InnoDB AUTO_INCREMENT=367 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_tickettasks`
--

DROP TABLE IF EXISTS `glpi_tickettasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_tickettasks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) DEFAULT NULL,
  `tickets_id` int(10) unsigned NOT NULL DEFAULT 0,
  `taskcategories_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date` timestamp NULL DEFAULT NULL,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_editor` int(10) unsigned NOT NULL DEFAULT 0,
  `content` longtext DEFAULT NULL,
  `is_private` tinyint(4) NOT NULL DEFAULT 0,
  `actiontime` int(11) NOT NULL DEFAULT 0,
  `begin` timestamp NULL DEFAULT NULL,
  `end` timestamp NULL DEFAULT NULL,
  `state` int(11) NOT NULL DEFAULT 1,
  `users_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `tasktemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `timeline_position` tinyint(4) NOT NULL DEFAULT 0,
  `sourceitems_id` int(10) unsigned NOT NULL DEFAULT 0,
  `sourceof_items_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `date` (`date`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`),
  KEY `users_id` (`users_id`),
  KEY `users_id_editor` (`users_id_editor`),
  KEY `tickets_id` (`tickets_id`),
  KEY `is_private` (`is_private`),
  KEY `taskcategories_id` (`taskcategories_id`),
  KEY `state` (`state`),
  KEY `users_id_tech` (`users_id_tech`),
  KEY `groups_id_tech` (`groups_id_tech`),
  KEY `begin` (`begin`),
  KEY `end` (`end`),
  KEY `tasktemplates_id` (`tasktemplates_id`),
  KEY `sourceitems_id` (`sourceitems_id`),
  KEY `sourceof_items_id` (`sourceof_items_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_tickettemplatehiddenfields`
--

DROP TABLE IF EXISTS `glpi_tickettemplatehiddenfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_tickettemplatehiddenfields` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tickettemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `num` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`tickettemplates_id`,`num`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_tickettemplatemandatoryfields`
--

DROP TABLE IF EXISTS `glpi_tickettemplatemandatoryfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_tickettemplatemandatoryfields` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tickettemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `num` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`tickettemplates_id`,`num`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_tickettemplatepredefinedfields`
--

DROP TABLE IF EXISTS `glpi_tickettemplatepredefinedfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_tickettemplatepredefinedfields` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tickettemplates_id` int(10) unsigned NOT NULL DEFAULT 0,
  `num` int(11) NOT NULL DEFAULT 0,
  `value` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tickettemplates_id` (`tickettemplates_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_tickettemplates`
--

DROP TABLE IF EXISTS `glpi_tickettemplates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_tickettemplates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_ticketvalidations`
--

DROP TABLE IF EXISTS `glpi_ticketvalidations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_ticketvalidations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `tickets_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_validate` int(10) unsigned NOT NULL DEFAULT 0,
  `comment_submission` text DEFAULT NULL,
  `comment_validation` text DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 2,
  `submission_date` timestamp NULL DEFAULT NULL,
  `validation_date` timestamp NULL DEFAULT NULL,
  `timeline_position` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `entities_id` (`entities_id`),
  KEY `users_id` (`users_id`),
  KEY `users_id_validate` (`users_id_validate`),
  KEY `tickets_id` (`tickets_id`),
  KEY `submission_date` (`submission_date`),
  KEY `validation_date` (`validation_date`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_transfers`
--

DROP TABLE IF EXISTS `glpi_transfers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_transfers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `keep_ticket` int(11) NOT NULL DEFAULT 0,
  `keep_networklink` int(11) NOT NULL DEFAULT 0,
  `keep_reservation` int(11) NOT NULL DEFAULT 0,
  `keep_history` int(11) NOT NULL DEFAULT 0,
  `keep_device` int(11) NOT NULL DEFAULT 0,
  `keep_infocom` int(11) NOT NULL DEFAULT 0,
  `keep_dc_monitor` int(11) NOT NULL DEFAULT 0,
  `clean_dc_monitor` int(11) NOT NULL DEFAULT 0,
  `keep_dc_phone` int(11) NOT NULL DEFAULT 0,
  `clean_dc_phone` int(11) NOT NULL DEFAULT 0,
  `keep_dc_peripheral` int(11) NOT NULL DEFAULT 0,
  `clean_dc_peripheral` int(11) NOT NULL DEFAULT 0,
  `keep_dc_printer` int(11) NOT NULL DEFAULT 0,
  `clean_dc_printer` int(11) NOT NULL DEFAULT 0,
  `keep_supplier` int(11) NOT NULL DEFAULT 0,
  `clean_supplier` int(11) NOT NULL DEFAULT 0,
  `keep_contact` int(11) NOT NULL DEFAULT 0,
  `clean_contact` int(11) NOT NULL DEFAULT 0,
  `keep_contract` int(11) NOT NULL DEFAULT 0,
  `clean_contract` int(11) NOT NULL DEFAULT 0,
  `keep_software` int(11) NOT NULL DEFAULT 0,
  `clean_software` int(11) NOT NULL DEFAULT 0,
  `keep_document` int(11) NOT NULL DEFAULT 0,
  `clean_document` int(11) NOT NULL DEFAULT 0,
  `keep_cartridgeitem` int(11) NOT NULL DEFAULT 0,
  `clean_cartridgeitem` int(11) NOT NULL DEFAULT 0,
  `keep_cartridge` int(11) NOT NULL DEFAULT 0,
  `keep_consumable` int(11) NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `keep_disk` int(11) NOT NULL DEFAULT 0,
  `keep_certificate` int(11) NOT NULL DEFAULT 0,
  `clean_certificate` int(11) NOT NULL DEFAULT 0,
  `lock_updated_fields` int(11) NOT NULL DEFAULT 0,
  `keep_location` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_unmanageds`
--

DROP TABLE IF EXISTS `glpi_unmanageds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_unmanageds` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `serial` varchar(255) DEFAULT NULL,
  `otherserial` varchar(255) DEFAULT NULL,
  `contact` varchar(255) DEFAULT NULL,
  `contact_num` varchar(255) DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `networks_id` int(10) unsigned NOT NULL DEFAULT 0,
  `manufacturers_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `states_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `groups_id_tech` int(10) unsigned NOT NULL DEFAULT 0,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  `date_creation` timestamp NULL DEFAULT NULL,
  `autoupdatesystems_id` int(10) unsigned NOT NULL DEFAULT 0,
  `sysdescr` text DEFAULT NULL,
  `agents_id` int(10) unsigned NOT NULL DEFAULT 0,
  `itemtype` varchar(100) DEFAULT NULL,
  `accepted` tinyint(4) NOT NULL DEFAULT 0,
  `hub` tinyint(4) NOT NULL DEFAULT 0,
  `ip` varchar(255) DEFAULT NULL,
  `snmpcredentials_id` int(10) unsigned NOT NULL DEFAULT 0,
  `last_inventory_update` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `manufacturers_id` (`manufacturers_id`),
  KEY `groups_id` (`groups_id`),
  KEY `users_id` (`users_id`),
  KEY `locations_id` (`locations_id`),
  KEY `networks_id` (`networks_id`),
  KEY `states_id` (`states_id`),
  KEY `groups_id_tech` (`groups_id_tech`),
  KEY `is_deleted` (`is_deleted`),
  KEY `date_mod` (`date_mod`),
  KEY `is_dynamic` (`is_dynamic`),
  KEY `serial` (`serial`),
  KEY `otherserial` (`otherserial`),
  KEY `date_creation` (`date_creation`),
  KEY `autoupdatesystems_id` (`autoupdatesystems_id`),
  KEY `agents_id` (`agents_id`),
  KEY `snmpcredentials_id` (`snmpcredentials_id`),
  KEY `users_id_tech` (`users_id_tech`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_usbvendors`
--

DROP TABLE IF EXISTS `glpi_usbvendors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_usbvendors` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `vendorid` varchar(4) NOT NULL,
  `deviceid` varchar(4) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`vendorid`,`deviceid`),
  KEY `deviceid` (`deviceid`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_usercategories`
--

DROP TABLE IF EXISTS `glpi_usercategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_usercategories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_useremails`
--

DROP TABLE IF EXISTS `glpi_useremails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_useremails` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `users_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_default` tinyint(4) NOT NULL DEFAULT 0,
  `is_dynamic` tinyint(4) NOT NULL DEFAULT 0,
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`users_id`,`email`),
  KEY `email` (`email`),
  KEY `is_default` (`is_default`),
  KEY `is_dynamic` (`is_dynamic`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_users`
--

DROP TABLE IF EXISTS `glpi_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `password_last_update` timestamp NULL DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `phone2` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `realname` varchar(255) DEFAULT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `locations_id` int(10) unsigned NOT NULL DEFAULT 0,
  `language` char(10) DEFAULT NULL COMMENT 'see define.php CFG_GLPI[language] array',
  `use_mode` int(11) NOT NULL DEFAULT 0,
  `list_limit` int(11) DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 1,
  `comment` text DEFAULT NULL,
  `auths_id` int(10) unsigned NOT NULL DEFAULT 0,
  `authtype` int(11) NOT NULL DEFAULT 0,
  `last_login` timestamp NULL DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_sync` timestamp NULL DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `profiles_id` int(10) unsigned NOT NULL DEFAULT 0,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `usertitles_id` int(10) unsigned NOT NULL DEFAULT 0,
  `usercategories_id` int(10) unsigned NOT NULL DEFAULT 0,
  `date_format` int(11) DEFAULT NULL,
  `number_format` int(11) DEFAULT NULL,
  `names_format` int(11) DEFAULT NULL,
  `csv_delimiter` char(1) DEFAULT NULL,
  `is_ids_visible` tinyint(4) DEFAULT NULL,
  `use_flat_dropdowntree` tinyint(4) DEFAULT NULL,
  `use_flat_dropdowntree_on_search_result` tinyint(4) DEFAULT NULL,
  `show_jobs_at_login` tinyint(4) DEFAULT NULL,
  `priority_1` char(20) DEFAULT NULL,
  `priority_2` char(20) DEFAULT NULL,
  `priority_3` char(20) DEFAULT NULL,
  `priority_4` char(20) DEFAULT NULL,
  `priority_5` char(20) DEFAULT NULL,
  `priority_6` char(20) DEFAULT NULL,
  `followup_private` tinyint(4) DEFAULT NULL,
  `task_private` tinyint(4) DEFAULT NULL,
  `default_requesttypes_id` int(10) unsigned DEFAULT NULL,
  `password_forget_token` char(40) DEFAULT NULL,
  `password_forget_token_date` timestamp NULL DEFAULT NULL,
  `user_dn` text DEFAULT NULL,
  `user_dn_hash` varchar(32) DEFAULT NULL,
  `registration_number` varchar(255) DEFAULT NULL,
  `show_count_on_tabs` tinyint(4) DEFAULT NULL,
  `refresh_views` int(11) DEFAULT NULL,
  `set_default_tech` tinyint(4) DEFAULT NULL,
  `personal_token` varchar(255) DEFAULT NULL,
  `personal_token_date` timestamp NULL DEFAULT NULL,
  `api_token` varchar(255) DEFAULT NULL,
  `api_token_date` timestamp NULL DEFAULT NULL,
  `cookie_token` varchar(255) DEFAULT NULL,
  `cookie_token_date` timestamp NULL DEFAULT NULL,
  `display_count_on_home` int(11) DEFAULT NULL,
  `notification_to_myself` tinyint(4) DEFAULT NULL,
  `duedateok_color` varchar(255) DEFAULT NULL,
  `duedatewarning_color` varchar(255) DEFAULT NULL,
  `duedatecritical_color` varchar(255) DEFAULT NULL,
  `duedatewarning_less` int(11) DEFAULT NULL,
  `duedatecritical_less` int(11) DEFAULT NULL,
  `duedatewarning_unit` varchar(255) DEFAULT NULL,
  `duedatecritical_unit` varchar(255) DEFAULT NULL,
  `display_options` text DEFAULT NULL,
  `is_deleted_ldap` tinyint(4) NOT NULL DEFAULT 0,
  `pdffont` varchar(255) DEFAULT NULL,
  `picture` varchar(255) DEFAULT NULL,
  `begin_date` timestamp NULL DEFAULT NULL,
  `end_date` timestamp NULL DEFAULT NULL,
  `keep_devices_when_purging_item` tinyint(4) DEFAULT NULL,
  `privatebookmarkorder` longtext DEFAULT NULL,
  `backcreated` tinyint(4) DEFAULT NULL,
  `task_state` int(11) DEFAULT NULL,
  `palette` char(20) DEFAULT NULL,
  `page_layout` char(20) DEFAULT NULL,
  `fold_menu` tinyint(4) DEFAULT NULL,
  `fold_search` tinyint(4) DEFAULT NULL,
  `savedsearches_pinned` text DEFAULT NULL,
  `timeline_order` char(20) DEFAULT NULL,
  `itil_layout` text DEFAULT NULL,
  `richtext_layout` char(20) DEFAULT NULL,
  `set_default_requester` tinyint(4) DEFAULT NULL,
  `lock_autolock_mode` tinyint(4) DEFAULT NULL,
  `lock_directunlock_notification` tinyint(4) DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  `highcontrast_css` tinyint(4) DEFAULT 0,
  `plannings` text DEFAULT NULL,
  `sync_field` varchar(255) DEFAULT NULL,
  `groups_id` int(10) unsigned NOT NULL DEFAULT 0,
  `users_id_supervisor` int(10) unsigned NOT NULL DEFAULT 0,
  `timezone` varchar(50) DEFAULT NULL,
  `default_dashboard_central` varchar(100) DEFAULT NULL,
  `default_dashboard_assets` varchar(100) DEFAULT NULL,
  `default_dashboard_helpdesk` varchar(100) DEFAULT NULL,
  `default_dashboard_mini_ticket` varchar(100) DEFAULT NULL,
  `default_central_tab` tinyint(4) DEFAULT 0,
  `nickname` varchar(255) DEFAULT NULL,
  `timeline_action_btn_layout` tinyint(4) DEFAULT NULL,
  `timeline_date_format` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicityloginauth` (`name`,`authtype`,`auths_id`),
  KEY `firstname` (`firstname`),
  KEY `realname` (`realname`),
  KEY `entities_id` (`entities_id`),
  KEY `profiles_id` (`profiles_id`),
  KEY `locations_id` (`locations_id`),
  KEY `usertitles_id` (`usertitles_id`),
  KEY `usercategories_id` (`usercategories_id`),
  KEY `is_deleted` (`is_deleted`),
  KEY `is_active` (`is_active`),
  KEY `date_mod` (`date_mod`),
  KEY `authitem` (`authtype`,`auths_id`),
  KEY `is_deleted_ldap` (`is_deleted_ldap`),
  KEY `date_creation` (`date_creation`),
  KEY `begin_date` (`begin_date`),
  KEY `end_date` (`end_date`),
  KEY `sync_field` (`sync_field`),
  KEY `groups_id` (`groups_id`),
  KEY `users_id_supervisor` (`users_id_supervisor`),
  KEY `auths_id` (`auths_id`),
  KEY `default_requesttypes_id` (`default_requesttypes_id`),
  KEY `user_dn_hash` (`user_dn_hash`)
) ENGINE=InnoDB AUTO_INCREMENT=326 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_usertitles`
--

DROP TABLE IF EXISTS `glpi_usertitles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_usertitles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_virtualmachinestates`
--

DROP TABLE IF EXISTS `glpi_virtualmachinestates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_virtualmachinestates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_virtualmachinesystems`
--

DROP TABLE IF EXISTS `glpi_virtualmachinesystems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_virtualmachinesystems` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_virtualmachinetypes`
--

DROP TABLE IF EXISTS `glpi_virtualmachinetypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_virtualmachinetypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_vlans`
--

DROP TABLE IF EXISTS `glpi_vlans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_vlans` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `tag` int(11) NOT NULL DEFAULT 0,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `tag` (`tag`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_vobjects`
--

DROP TABLE IF EXISTS `glpi_vobjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_vobjects` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `itemtype` varchar(100) DEFAULT NULL,
  `items_id` int(10) unsigned NOT NULL DEFAULT 0,
  `data` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unicity` (`itemtype`,`items_id`),
  KEY `item` (`itemtype`,`items_id`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `glpi_wifinetworks`
--

DROP TABLE IF EXISTS `glpi_wifinetworks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glpi_wifinetworks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entities_id` int(10) unsigned NOT NULL DEFAULT 0,
  `is_recursive` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `essid` varchar(255) DEFAULT NULL,
  `mode` varchar(255) DEFAULT NULL COMMENT 'ad-hoc, access_point',
  `comment` text DEFAULT NULL,
  `date_mod` timestamp NULL DEFAULT NULL,
  `date_creation` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entities_id` (`entities_id`),
  KEY `is_recursive` (`is_recursive`),
  KEY `essid` (`essid`),
  KEY `name` (`name`),
  KEY `date_mod` (`date_mod`),
  KEY `date_creation` (`date_creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Final view structure for view `glpi_plugin_dataflows_destinationconnectors`
--

/*!50001 DROP VIEW IF EXISTS `glpi_plugin_dataflows_destinationconnectors`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`glpi`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `glpi_plugin_dataflows_destinationconnectors` AS select `glpi_plugin_dataflows_sourceconnectors`.`id` AS `id`,`glpi_plugin_dataflows_sourceconnectors`.`name` AS `name`,`glpi_plugin_dataflows_sourceconnectors`.`comment` AS `comment` from `glpi_plugin_dataflows_sourceconnectors` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `glpi_plugin_dataflows_fromcredentials`
--

/*!50001 DROP VIEW IF EXISTS `glpi_plugin_dataflows_fromcredentials`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`glpi`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `glpi_plugin_dataflows_fromcredentials` AS select `glpi_plugin_accounts_accounts`.`id` AS `id`,`glpi_plugin_accounts_accounts`.`name` AS `name`,`glpi_plugin_accounts_accounts`.`login` AS `comment` from `glpi_plugin_accounts_accounts` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `glpi_plugin_dataflows_tocredentials`
--

/*!50001 DROP VIEW IF EXISTS `glpi_plugin_dataflows_tocredentials`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`glpi`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `glpi_plugin_dataflows_tocredentials` AS select `glpi_plugin_accounts_accounts`.`id` AS `id`,`glpi_plugin_accounts_accounts`.`name` AS `name`,`glpi_plugin_accounts_accounts`.`login` AS `comment` from `glpi_plugin_accounts_accounts` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-22 10:53:23
