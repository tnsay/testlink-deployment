-- phpMyAdmin SQL Dump
-- version 5.1.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 02, 2025 at 08:25 AM
-- Server version: 5.7.24
-- PHP Version: 8.3.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `testlink2`
--

-- --------------------------------------------------------

--
-- Table structure for table `assignment_status`
--

DROP TABLE IF EXISTS `assignment_status`;
CREATE TABLE IF NOT EXISTS `assignment_status` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `description` varchar(100) NOT NULL DEFAULT 'unknown',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `assignment_status`
--

INSERT INTO `assignment_status` (`id`, `description`) VALUES
(1, 'open'),
(2, 'closed'),
(3, 'completed'),
(4, 'todo_urgent'),
(5, 'todo');

-- --------------------------------------------------------

--
-- Table structure for table `assignment_types`
--

DROP TABLE IF EXISTS `assignment_types`;
CREATE TABLE IF NOT EXISTS `assignment_types` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_table` varchar(30) DEFAULT '',
  `description` varchar(100) NOT NULL DEFAULT 'unknown',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `assignment_types`
--

INSERT INTO `assignment_types` (`id`, `fk_table`, `description`) VALUES
(1, 'testplan_tcversions', 'testcase_execution'),
(2, 'tcversions', 'testcase_review');

-- --------------------------------------------------------

--
-- Table structure for table `attachments`
--

DROP TABLE IF EXISTS `attachments`;
CREATE TABLE IF NOT EXISTS `attachments` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `fk_table` varchar(250) DEFAULT '',
  `title` varchar(250) DEFAULT '',
  `description` varchar(250) DEFAULT '',
  `file_name` varchar(250) NOT NULL DEFAULT '',
  `file_path` varchar(250) DEFAULT '',
  `file_size` int(11) NOT NULL DEFAULT '0',
  `file_type` varchar(250) NOT NULL DEFAULT '',
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `content` longblob,
  `compression_type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `attachments_idx1` (`fk_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `baseline_l1l2_context`
--

DROP TABLE IF EXISTS `baseline_l1l2_context`;
CREATE TABLE IF NOT EXISTS `baseline_l1l2_context` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `testplan_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `platform_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `begin_exec_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `end_exec_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `creation_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `udx1_context` (`testplan_id`,`platform_id`,`creation_ts`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `baseline_l1l2_details`
--

DROP TABLE IF EXISTS `baseline_l1l2_details`;
CREATE TABLE IF NOT EXISTS `baseline_l1l2_details` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `context_id` int(10) UNSIGNED NOT NULL,
  `top_tsuite_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `child_tsuite_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `status` char(1) DEFAULT NULL,
  `qty` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `total_tc` int(10) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `udx1_details` (`context_id`,`top_tsuite_id`,`child_tsuite_id`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `builds`
--

DROP TABLE IF EXISTS `builds`;
CREATE TABLE IF NOT EXISTS `builds` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `testplan_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `name` varchar(100) NOT NULL DEFAULT 'undefined',
  `notes` text,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `is_open` tinyint(1) NOT NULL DEFAULT '1',
  `author_id` int(10) UNSIGNED DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `release_date` date DEFAULT NULL,
  `closed_on_date` date DEFAULT NULL,
  `commit_id` varchar(64) DEFAULT NULL,
  `tag` varchar(64) DEFAULT NULL,
  `branch` varchar(64) DEFAULT NULL,
  `release_candidate` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`testplan_id`,`name`),
  KEY `testplan_id` (`testplan_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Available builds';

--
-- Dumping data for table `builds`
--

INSERT INTO `builds` (`id`, `testplan_id`, `name`, `notes`, `active`, `is_open`, `author_id`, `creation_ts`, `release_date`, `closed_on_date`, `commit_id`, `tag`, `branch`, `release_candidate`) VALUES
(1, 2, 'Build1 R1', '<p>This is Releaese1 final build for Addispay Ecommerce site and consumer app.</p>\r\n', 1, 1, NULL, '2025-05-22 05:19:21', '2025-06-30', NULL, '', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `cfield_build_design_values`
--

DROP TABLE IF EXISTS `cfield_build_design_values`;
CREATE TABLE IF NOT EXISTS `cfield_build_design_values` (
  `field_id` int(10) NOT NULL DEFAULT '0',
  `node_id` int(10) NOT NULL DEFAULT '0',
  `value` varchar(4000) NOT NULL DEFAULT '',
  PRIMARY KEY (`field_id`,`node_id`),
  KEY `idx_cfield_build_design_values` (`node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `cfield_design_values`
--

DROP TABLE IF EXISTS `cfield_design_values`;
CREATE TABLE IF NOT EXISTS `cfield_design_values` (
  `field_id` int(10) NOT NULL DEFAULT '0',
  `node_id` int(10) NOT NULL DEFAULT '0',
  `value` varchar(4000) NOT NULL DEFAULT '',
  PRIMARY KEY (`field_id`,`node_id`),
  KEY `idx_cfield_design_values` (`node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `cfield_execution_values`
--

DROP TABLE IF EXISTS `cfield_execution_values`;
CREATE TABLE IF NOT EXISTS `cfield_execution_values` (
  `field_id` int(10) NOT NULL DEFAULT '0',
  `execution_id` int(10) NOT NULL DEFAULT '0',
  `testplan_id` int(10) NOT NULL DEFAULT '0',
  `tcversion_id` int(10) NOT NULL DEFAULT '0',
  `value` varchar(4000) NOT NULL DEFAULT '',
  PRIMARY KEY (`field_id`,`execution_id`,`testplan_id`,`tcversion_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `cfield_node_types`
--

DROP TABLE IF EXISTS `cfield_node_types`;
CREATE TABLE IF NOT EXISTS `cfield_node_types` (
  `field_id` int(10) NOT NULL DEFAULT '0',
  `node_type_id` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`field_id`,`node_type_id`),
  KEY `idx_custom_fields_assign` (`node_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `cfield_testplan_design_values`
--

DROP TABLE IF EXISTS `cfield_testplan_design_values`;
CREATE TABLE IF NOT EXISTS `cfield_testplan_design_values` (
  `field_id` int(10) NOT NULL DEFAULT '0',
  `link_id` int(10) NOT NULL DEFAULT '0' COMMENT 'point to testplan_tcversion id',
  `value` varchar(4000) NOT NULL DEFAULT '',
  PRIMARY KEY (`field_id`,`link_id`),
  KEY `idx_cfield_tplan_design_val` (`link_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `cfield_testprojects`
--

DROP TABLE IF EXISTS `cfield_testprojects`;
CREATE TABLE IF NOT EXISTS `cfield_testprojects` (
  `field_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `testproject_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `display_order` smallint(5) UNSIGNED NOT NULL DEFAULT '1',
  `location` smallint(5) UNSIGNED NOT NULL DEFAULT '1',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `required_on_design` tinyint(1) NOT NULL DEFAULT '0',
  `required_on_execution` tinyint(1) NOT NULL DEFAULT '0',
  `monitorable` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`field_id`,`testproject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `codetrackers`
--

DROP TABLE IF EXISTS `codetrackers`;
CREATE TABLE IF NOT EXISTS `codetrackers` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `type` int(10) DEFAULT '0',
  `cfg` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codetrackers_uidx1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `custom_fields`
--

DROP TABLE IF EXISTS `custom_fields`;
CREATE TABLE IF NOT EXISTS `custom_fields` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '',
  `label` varchar(64) NOT NULL DEFAULT '' COMMENT 'label to display on user interface',
  `type` smallint(6) NOT NULL DEFAULT '0',
  `possible_values` varchar(4000) NOT NULL DEFAULT '',
  `default_value` varchar(4000) NOT NULL DEFAULT '',
  `valid_regexp` varchar(255) NOT NULL DEFAULT '',
  `length_min` int(10) NOT NULL DEFAULT '0',
  `length_max` int(10) NOT NULL DEFAULT '0',
  `show_on_design` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '1=> show it during specification design',
  `enable_on_design` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '1=> user can write/manage it during specification design',
  `show_on_execution` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT '1=> show it during test case execution',
  `enable_on_execution` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT '1=> user can write/manage it during test case execution',
  `show_on_testplan_design` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `enable_on_testplan_design` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_custom_fields_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `db_version`
--

DROP TABLE IF EXISTS `db_version`;
CREATE TABLE IF NOT EXISTS `db_version` (
  `version` varchar(50) NOT NULL DEFAULT 'unknown',
  `upgrade_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `notes` text,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `db_version`
--

INSERT INTO `db_version` (`version`, `upgrade_ts`, `notes`) VALUES
('DB 1.9.20', '2025-05-13 13:56:37', 'TestLink 1.9.20 Raijin');

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
CREATE TABLE IF NOT EXISTS `events` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `transaction_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `log_level` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `source` varchar(45) DEFAULT NULL,
  `description` text NOT NULL,
  `fired_at` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `activity` varchar(45) DEFAULT NULL,
  `object_id` int(10) UNSIGNED DEFAULT NULL,
  `object_type` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `transaction_id` (`transaction_id`),
  KEY `fired_at` (`fired_at`)
) ENGINE=InnoDB AUTO_INCREMENT=741 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`id`, `transaction_id`, `log_level`, `source`, `description`, `fired_at`, `activity`, `object_id`, `object_type`) VALUES
(1, 1, 16, 'GUI', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:21:\"audit_login_succeeded\";s:6:\"params\";a:2:{i:0;s:5:\"admin\";i:1;s:3:\"::1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1747144716, 'LOGIN', 1, 'users'),
(2, 2, 16, 'GUI', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:21:\"audit_login_succeeded\";s:6:\"params\";a:2:{i:0;s:5:\"admin\";i:1;s:3:\"::1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1747898470, 'LOGIN', 1, 'users'),
(3, 3, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:25:\"audit_testproject_created\";s:6:\"params\";a:1:{i:0;s:18:\"Dev final Release1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1747898547, 'CREATE', 1, 'testprojects'),
(4, 3, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"DataTablesSelector\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747898548, 'PHP', 0, NULL),
(5, 3, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747898548, 'PHP', 0, NULL),
(6, 4, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"DataTablesSelector\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747900279, 'PHP', 0, NULL),
(7, 4, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747900279, 'PHP', 0, NULL),
(8, 5, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"DataTablesSelector\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747900310, 'PHP', 0, NULL),
(9, 5, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747900310, 'PHP', 0, NULL),
(10, 6, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:23:\"audit_testproject_saved\";s:6:\"params\";a:1:{i:0;s:18:\"Dev final Release1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1747900497, 'UPDATE', 1, 'testprojects'),
(11, 6, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"DataTablesSelector\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747900497, 'PHP', 0, NULL),
(12, 6, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747900497, 'PHP', 0, NULL),
(13, 7, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$uploadOp - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\bff0c136f1b7cb8883a6bf84b38afc8ef933b3bc_0.file.planEdit.tpl.php - Line 130', 1747900582, 'PHP', 0, NULL),
(14, 7, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$itemID - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\bff0c136f1b7cb8883a6bf84b38afc8ef933b3bc_0.file.planEdit.tpl.php - Line 152', 1747900582, 'PHP', 0, NULL),
(15, 8, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:22:\"audit_testplan_created\";s:6:\"params\";a:2:{i:0;s:18:\"Dev final Release1\";i:1;s:18:\"Test Plan R1 Final\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1747900644, 'CREATED', 2, 'testplans'),
(16, 9, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nforeach() argument must be of type array|object, null given - in C:\\MAMP\\htdocs\\testlink2\\lib\\plan\\buildView.php - Line 90', 1747900785, 'PHP', 0, NULL),
(17, 10, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:19:\"audit_build_created\";s:6:\"params\";a:3:{i:0;s:18:\"Dev final Release1\";i:1;s:18:\"Test Plan R1 Final\";i:2;s:12:\"Build1 Final\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1747901961, 'CREATE', 1, 'builds'),
(18, 10, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$build - in C:\\MAMP\\htdocs\\testlink2\\lib\\plan\\buildEdit.php - Line 343', 1747901961, 'PHP', 0, NULL),
(19, 10, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined variable $args - in C:\\MAMP\\htdocs\\testlink2\\lib\\plan\\buildEdit.php - Line 371', 1747901961, 'PHP', 0, NULL),
(20, 10, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"user\" on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\plan\\buildEdit.php - Line 371', 1747901962, 'PHP', 0, NULL),
(21, 10, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"locale\" on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\plan\\buildEdit.php - Line 371', 1747901962, 'PHP', 0, NULL),
(22, 10, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"\" - in C:\\MAMP\\htdocs\\testlink2\\lib\\plan\\buildEdit.php - Line 371', 1747901962, 'PHP', 0, NULL),
(23, 11, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 0 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747905481, 'PHP', 0, NULL),
(24, 11, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 1 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747905481, 'PHP', 0, NULL),
(25, 11, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 2 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747905481, 'PHP', 0, NULL),
(26, 11, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 3 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747905481, 'PHP', 0, NULL),
(27, 12, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 0 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747906100, 'PHP', 0, NULL),
(28, 12, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 1 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747906101, 'PHP', 0, NULL),
(29, 12, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 2 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747906101, 'PHP', 0, NULL),
(30, 12, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 3 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747906101, 'PHP', 0, NULL),
(31, 13, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747906118, 'PHP', 0, NULL),
(32, 13, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747906118, 'PHP', 0, NULL),
(33, 13, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1747906118, 'PHP', 0, NULL),
(34, 14, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747906234, 'PHP', 0, NULL),
(35, 14, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747906234, 'PHP', 0, NULL),
(36, 14, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1747906234, 'PHP', 0, NULL),
(37, 15, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747906444, 'PHP', 0, NULL),
(38, 15, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747906444, 'PHP', 0, NULL),
(39, 15, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1747906444, 'PHP', 0, NULL),
(40, 16, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747906574, 'PHP', 0, NULL),
(41, 16, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747906574, 'PHP', 0, NULL),
(42, 16, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1747906574, 'PHP', 0, NULL),
(43, 17, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747906644, 'PHP', 0, NULL),
(44, 17, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747906644, 'PHP', 0, NULL),
(45, 17, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1747906644, 'PHP', 0, NULL),
(46, 18, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747906651, 'PHP', 0, NULL),
(47, 18, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747906651, 'PHP', 0, NULL),
(48, 18, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1747906651, 'PHP', 0, NULL),
(49, 19, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 0 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747906671, 'PHP', 0, NULL),
(50, 19, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 1 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747906671, 'PHP', 0, NULL),
(51, 19, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 2 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747906671, 'PHP', 0, NULL),
(52, 19, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 3 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747906671, 'PHP', 0, NULL),
(53, 20, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"DataTablesSelector\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747906970, 'PHP', 0, NULL),
(54, 20, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747906970, 'PHP', 0, NULL),
(55, 21, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"DataTablesSelector\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747907117, 'PHP', 0, NULL),
(56, 21, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747907117, 'PHP', 0, NULL),
(57, 22, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"DataTablesSelector\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747907173, 'PHP', 0, NULL),
(58, 22, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747907173, 'PHP', 0, NULL),
(59, 23, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"DataTablesSelector\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747907229, 'PHP', 0, NULL),
(60, 23, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747907229, 'PHP', 0, NULL),
(61, 24, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$uploadOp - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\bff0c136f1b7cb8883a6bf84b38afc8ef933b3bc_0.file.planEdit.tpl.php - Line 130', 1747907308, 'PHP', 0, NULL),
(62, 24, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$itemID - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\bff0c136f1b7cb8883a6bf84b38afc8ef933b3bc_0.file.planEdit.tpl.php - Line 152', 1747907308, 'PHP', 0, NULL),
(63, 24, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\bff0c136f1b7cb8883a6bf84b38afc8ef933b3bc_0.file.planEdit.tpl.php - Line 302', 1747907308, 'PHP', 0, NULL),
(64, 25, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"DataTablesSelector\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747907347, 'PHP', 0, NULL),
(65, 25, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747907347, 'PHP', 0, NULL),
(66, 26, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"DataTablesSelector\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747907392, 'PHP', 0, NULL),
(67, 26, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747907392, 'PHP', 0, NULL),
(68, 27, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"DataTablesSelector\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747907435, 'PHP', 0, NULL),
(69, 27, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747907436, 'PHP', 0, NULL),
(70, 28, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"DataTablesSelector\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747907454, 'PHP', 0, NULL),
(71, 28, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747907455, 'PHP', 0, NULL),
(72, 29, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 0 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747907670, 'PHP', 0, NULL),
(73, 29, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 1 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747907670, 'PHP', 0, NULL),
(74, 29, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 2 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747907670, 'PHP', 0, NULL),
(75, 29, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 3 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747907670, 'PHP', 0, NULL),
(76, 30, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 0 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747907805, 'PHP', 0, NULL),
(77, 30, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 1 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747907805, 'PHP', 0, NULL),
(78, 30, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 2 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747907805, 'PHP', 0, NULL),
(79, 30, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 3 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747907805, 'PHP', 0, NULL),
(80, 31, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747907816, 'PHP', 0, NULL),
(81, 31, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747907816, 'PHP', 0, NULL),
(82, 31, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1747907816, 'PHP', 0, NULL),
(83, 32, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747907853, 'PHP', 0, NULL),
(84, 32, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747907853, 'PHP', 0, NULL),
(85, 32, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1747907853, 'PHP', 0, NULL),
(86, 33, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747908356, 'PHP', 0, NULL),
(87, 33, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747908356, 'PHP', 0, NULL),
(88, 33, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1747908356, 'PHP', 0, NULL),
(89, 34, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747908368, 'PHP', 0, NULL),
(90, 34, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747908368, 'PHP', 0, NULL),
(91, 34, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1747908368, 'PHP', 0, NULL),
(92, 35, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 0 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747908379, 'PHP', 0, NULL),
(93, 35, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 1 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747908379, 'PHP', 0, NULL),
(94, 35, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 2 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747908379, 'PHP', 0, NULL),
(95, 35, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 3 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747908379, 'PHP', 0, NULL),
(96, 36, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 0 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747908382, 'PHP', 0, NULL),
(97, 36, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 1 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747908382, 'PHP', 0, NULL),
(98, 36, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 2 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747908382, 'PHP', 0, NULL),
(99, 36, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 3 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747908382, 'PHP', 0, NULL),
(100, 37, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 0 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747908419, 'PHP', 0, NULL),
(101, 37, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 1 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747908419, 'PHP', 0, NULL),
(102, 37, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 2 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747908419, 'PHP', 0, NULL),
(103, 37, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 3 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747908419, 'PHP', 0, NULL),
(104, 38, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 0 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747908476, 'PHP', 0, NULL),
(105, 38, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 1 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747908476, 'PHP', 0, NULL),
(106, 38, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 2 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747908476, 'PHP', 0, NULL),
(107, 38, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 3 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747908476, 'PHP', 0, NULL),
(108, 39, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747908552, 'PHP', 0, NULL),
(109, 39, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747908552, 'PHP', 0, NULL),
(110, 39, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1747908552, 'PHP', 0, NULL),
(111, 40, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747908578, 'PHP', 0, NULL),
(112, 40, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747908579, 'PHP', 0, NULL),
(113, 40, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1747908579, 'PHP', 0, NULL),
(114, 41, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747908602, 'PHP', 0, NULL),
(115, 41, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747908602, 'PHP', 0, NULL),
(116, 41, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1747908602, 'PHP', 0, NULL),
(117, 42, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747908621, 'PHP', 0, NULL),
(118, 42, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747908621, 'PHP', 0, NULL),
(119, 42, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1747908621, 'PHP', 0, NULL),
(120, 43, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 0 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747908636, 'PHP', 0, NULL),
(121, 43, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 1 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747908636, 'PHP', 0, NULL),
(122, 43, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 2 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747908636, 'PHP', 0, NULL),
(123, 43, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 3 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747908636, 'PHP', 0, NULL),
(124, 44, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 0 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747908684, 'PHP', 0, NULL),
(125, 44, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 1 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747908685, 'PHP', 0, NULL),
(126, 44, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 2 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747908685, 'PHP', 0, NULL),
(127, 44, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 3 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747908685, 'PHP', 0, NULL),
(128, 45, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 0 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747908803, 'PHP', 0, NULL),
(129, 45, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 1 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747908803, 'PHP', 0, NULL),
(130, 45, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 2 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747908803, 'PHP', 0, NULL),
(131, 45, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 3 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747908803, 'PHP', 0, NULL),
(132, 46, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747908807, 'PHP', 0, NULL),
(133, 46, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747908807, 'PHP', 0, NULL),
(134, 46, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1747908807, 'PHP', 0, NULL),
(135, 47, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747908821, 'PHP', 0, NULL),
(136, 47, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747908821, 'PHP', 0, NULL),
(137, 47, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1747908821, 'PHP', 0, NULL),
(138, 48, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 0 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747908864, 'PHP', 0, NULL),
(139, 48, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 1 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747908864, 'PHP', 0, NULL),
(140, 48, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 2 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747908864, 'PHP', 0, NULL),
(141, 48, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 3 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747908864, 'PHP', 0, NULL),
(142, 49, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 0 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747908938, 'PHP', 0, NULL),
(143, 49, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 1 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747908938, 'PHP', 0, NULL),
(144, 49, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 2 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747908938, 'PHP', 0, NULL),
(145, 49, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 3 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747908938, 'PHP', 0, NULL),
(146, 50, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747908963, 'PHP', 0, NULL),
(147, 50, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747908963, 'PHP', 0, NULL),
(148, 50, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1747908963, 'PHP', 0, NULL),
(149, 51, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747908972, 'PHP', 0, NULL),
(150, 51, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747908972, 'PHP', 0, NULL),
(151, 51, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1747908972, 'PHP', 0, NULL),
(152, 52, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747908982, 'PHP', 0, NULL),
(153, 52, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747908982, 'PHP', 0, NULL),
(154, 52, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1747908982, 'PHP', 0, NULL),
(155, 53, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 0 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909012, 'PHP', 0, NULL),
(156, 53, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 1 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909012, 'PHP', 0, NULL),
(157, 53, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 2 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909012, 'PHP', 0, NULL),
(158, 53, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 3 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909012, 'PHP', 0, NULL),
(159, 54, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 0 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909114, 'PHP', 0, NULL),
(160, 54, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 1 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909114, 'PHP', 0, NULL),
(161, 54, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 2 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909114, 'PHP', 0, NULL),
(162, 54, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 3 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909114, 'PHP', 0, NULL),
(163, 55, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747909118, 'PHP', 0, NULL),
(164, 55, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747909119, 'PHP', 0, NULL),
(165, 55, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1747909119, 'PHP', 0, NULL),
(166, 56, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747909133, 'PHP', 0, NULL),
(167, 56, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747909133, 'PHP', 0, NULL),
(168, 56, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1747909133, 'PHP', 0, NULL),
(169, 57, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747909152, 'PHP', 0, NULL),
(170, 57, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747909152, 'PHP', 0, NULL),
(171, 57, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1747909152, 'PHP', 0, NULL),
(172, 58, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747909155, 'PHP', 0, NULL),
(173, 58, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747909155, 'PHP', 0, NULL),
(174, 58, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1747909156, 'PHP', 0, NULL),
(175, 59, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747909196, 'PHP', 0, NULL),
(176, 59, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747909196, 'PHP', 0, NULL),
(177, 59, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1747909196, 'PHP', 0, NULL),
(178, 60, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 0 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909250, 'PHP', 0, NULL),
(179, 60, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 1 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909250, 'PHP', 0, NULL),
(180, 60, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 2 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909250, 'PHP', 0, NULL),
(181, 60, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 3 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909250, 'PHP', 0, NULL),
(182, 61, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 0 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909269, 'PHP', 0, NULL),
(183, 61, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 1 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909269, 'PHP', 0, NULL),
(184, 61, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 2 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909269, 'PHP', 0, NULL),
(185, 61, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 3 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909269, 'PHP', 0, NULL),
(186, 62, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 0 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909312, 'PHP', 0, NULL),
(187, 62, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 1 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909312, 'PHP', 0, NULL),
(188, 62, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 2 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909312, 'PHP', 0, NULL),
(189, 62, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 3 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909312, 'PHP', 0, NULL),
(190, 63, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 0 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909320, 'PHP', 0, NULL),
(191, 63, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 1 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909320, 'PHP', 0, NULL),
(192, 63, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 2 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909320, 'PHP', 0, NULL),
(193, 63, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 3 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909320, 'PHP', 0, NULL),
(194, 64, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 0 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909361, 'PHP', 0, NULL),
(195, 64, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 1 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909361, 'PHP', 0, NULL),
(196, 64, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 2 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909361, 'PHP', 0, NULL),
(197, 64, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 3 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909361, 'PHP', 0, NULL),
(198, 65, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 0 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909407, 'PHP', 0, NULL),
(199, 65, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 1 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909407, 'PHP', 0, NULL),
(200, 65, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 2 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909407, 'PHP', 0, NULL),
(201, 65, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 3 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909407, 'PHP', 0, NULL),
(202, 66, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 0 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909422, 'PHP', 0, NULL),
(203, 66, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 1 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909422, 'PHP', 0, NULL),
(204, 66, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 2 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909422, 'PHP', 0, NULL),
(205, 66, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 3 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909422, 'PHP', 0, NULL),
(206, 67, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 0 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909509, 'PHP', 0, NULL),
(207, 67, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 1 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909509, 'PHP', 0, NULL),
(208, 67, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 2 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909509, 'PHP', 0, NULL),
(209, 67, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 3 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909509, 'PHP', 0, NULL),
(210, 68, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747909521, 'PHP', 0, NULL),
(211, 68, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747909521, 'PHP', 0, NULL),
(212, 68, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1747909522, 'PHP', 0, NULL),
(213, 69, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747909549, 'PHP', 0, NULL),
(214, 69, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747909549, 'PHP', 0, NULL),
(215, 69, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1747909549, 'PHP', 0, NULL),
(216, 70, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 0 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909608, 'PHP', 0, NULL),
(217, 70, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 1 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909608, 'PHP', 0, NULL),
(218, 70, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 2 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909608, 'PHP', 0, NULL),
(219, 70, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 3 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909608, 'PHP', 0, NULL),
(220, 71, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 0 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909657, 'PHP', 0, NULL),
(221, 71, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 1 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909657, 'PHP', 0, NULL),
(222, 71, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 2 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909657, 'PHP', 0, NULL),
(223, 71, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 3 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747909657, 'PHP', 0, NULL),
(224, 72, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747909663, 'PHP', 0, NULL),
(225, 72, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747909663, 'PHP', 0, NULL);
INSERT INTO `events` (`id`, `transaction_id`, `log_level`, `source`, `description`, `fired_at`, `activity`, `object_id`, `object_type`) VALUES
(226, 72, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1747909663, 'PHP', 0, NULL),
(227, 73, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747909700, 'PHP', 0, NULL),
(228, 73, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747909700, 'PHP', 0, NULL),
(229, 73, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1747909700, 'PHP', 0, NULL),
(230, 74, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747915043, 'PHP', 0, NULL),
(231, 74, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1747915044, 'PHP', 0, NULL),
(232, 74, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1747915044, 'PHP', 0, NULL),
(233, 75, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 0 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747915890, 'PHP', 0, NULL),
(234, 75, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 1 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747915890, 'PHP', 0, NULL),
(235, 75, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 2 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747915890, 'PHP', 0, NULL),
(236, 75, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 3 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747915891, 'PHP', 0, NULL),
(237, 76, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"DataTablesSelector\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747916372, 'PHP', 0, NULL),
(238, 76, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747916372, 'PHP', 0, NULL),
(239, 77, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:23:\"audit_testproject_saved\";s:6:\"params\";a:1:{i:0;s:18:\"Dev final Release1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1747916383, 'UPDATE', 1, 'testprojects'),
(240, 77, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"DataTablesSelector\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747916383, 'PHP', 0, NULL),
(241, 77, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747916383, 'PHP', 0, NULL),
(242, 78, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"DataTablesSelector\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747916488, 'PHP', 0, NULL),
(243, 78, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747916488, 'PHP', 0, NULL),
(244, 79, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"DataTablesSelector\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747916536, 'PHP', 0, NULL),
(245, 79, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747916536, 'PHP', 0, NULL),
(246, 80, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"DataTablesSelector\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747916569, 'PHP', 0, NULL),
(247, 80, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747916569, 'PHP', 0, NULL),
(248, 81, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:17:\"audit_user_logout\";s:6:\"params\";a:1:{i:0;s:5:\"admin\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1747916606, 'LOGOUT', 1, 'users'),
(249, 82, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:21:\"audit_login_succeeded\";s:6:\"params\";a:2:{i:0;s:5:\"admin\";i:1;s:3:\"::1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1747916615, 'LOGIN', 1, 'users'),
(250, 83, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$uploadOp - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\bff0c136f1b7cb8883a6bf84b38afc8ef933b3bc_0.file.planEdit.tpl.php - Line 130', 1747916629, 'PHP', 0, NULL),
(251, 83, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$itemID - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\bff0c136f1b7cb8883a6bf84b38afc8ef933b3bc_0.file.planEdit.tpl.php - Line 152', 1747916629, 'PHP', 0, NULL),
(252, 83, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\bff0c136f1b7cb8883a6bf84b38afc8ef933b3bc_0.file.planEdit.tpl.php - Line 302', 1747916629, 'PHP', 0, NULL),
(253, 84, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:20:\"audit_testplan_saved\";s:6:\"params\";a:2:{i:0;s:18:\"Dev final Release1\";i:1;s:22:\"Test Plan R1 Final stg\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1747916746, 'SAVE', 2, 'testplans'),
(254, 85, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$uploadOp - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\bff0c136f1b7cb8883a6bf84b38afc8ef933b3bc_0.file.planEdit.tpl.php - Line 130', 1747916769, 'PHP', 0, NULL),
(255, 85, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$itemID - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\bff0c136f1b7cb8883a6bf84b38afc8ef933b3bc_0.file.planEdit.tpl.php - Line 152', 1747916769, 'PHP', 0, NULL),
(256, 85, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\bff0c136f1b7cb8883a6bf84b38afc8ef933b3bc_0.file.planEdit.tpl.php - Line 302', 1747916769, 'PHP', 0, NULL),
(257, 86, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"DataTablesSelector\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747917167, 'PHP', 0, NULL),
(258, 86, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747917167, 'PHP', 0, NULL),
(259, 87, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:23:\"audit_testproject_saved\";s:6:\"params\";a:1:{i:0;s:18:\"Dev final Release1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1747917188, 'UPDATE', 1, 'testprojects'),
(260, 87, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"DataTablesSelector\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747917188, 'PHP', 0, NULL),
(261, 87, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747917188, 'PHP', 0, NULL),
(262, 88, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"DataTablesSelector\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747917202, 'PHP', 0, NULL),
(263, 88, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747917202, 'PHP', 0, NULL),
(264, 89, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"DataTablesSelector\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747917628, 'PHP', 0, NULL),
(265, 89, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747917628, 'PHP', 0, NULL),
(266, 90, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:23:\"audit_testproject_saved\";s:6:\"params\";a:1:{i:0;s:18:\"Dev final Release1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1747917638, 'UPDATE', 1, 'testprojects'),
(267, 90, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"DataTablesSelector\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747917638, 'PHP', 0, NULL),
(268, 90, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747917638, 'PHP', 0, NULL),
(269, 91, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"DataTablesSelector\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747917691, 'PHP', 0, NULL),
(270, 91, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747917691, 'PHP', 0, NULL),
(271, 92, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$uploadOp - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\bff0c136f1b7cb8883a6bf84b38afc8ef933b3bc_0.file.planEdit.tpl.php - Line 130', 1747918180, 'PHP', 0, NULL),
(272, 92, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$itemID - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\bff0c136f1b7cb8883a6bf84b38afc8ef933b3bc_0.file.planEdit.tpl.php - Line 152', 1747918180, 'PHP', 0, NULL),
(273, 92, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\bff0c136f1b7cb8883a6bf84b38afc8ef933b3bc_0.file.planEdit.tpl.php - Line 302', 1747918180, 'PHP', 0, NULL),
(274, 93, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:17:\"audit_build_saved\";s:6:\"params\";a:3:{i:0;s:18:\"Dev final Release1\";i:1;s:22:\"Test Plan R1 Final stg\";i:2;s:9:\"Build1 R1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1747918498, 'SAVE', 1, 'builds'),
(275, 93, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$build - in C:\\MAMP\\htdocs\\testlink2\\lib\\plan\\buildEdit.php - Line 343', 1747918498, 'PHP', 0, NULL),
(276, 93, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined variable $args - in C:\\MAMP\\htdocs\\testlink2\\lib\\plan\\buildEdit.php - Line 371', 1747918498, 'PHP', 0, NULL),
(277, 93, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"user\" on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\plan\\buildEdit.php - Line 371', 1747918498, 'PHP', 0, NULL),
(278, 93, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"locale\" on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\plan\\buildEdit.php - Line 371', 1747918498, 'PHP', 0, NULL),
(279, 93, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"\" - in C:\\MAMP\\htdocs\\testlink2\\lib\\plan\\buildEdit.php - Line 371', 1747918498, 'PHP', 0, NULL),
(280, 94, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$uploadOp - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\bff0c136f1b7cb8883a6bf84b38afc8ef933b3bc_0.file.planEdit.tpl.php - Line 130', 1747918835, 'PHP', 0, NULL),
(281, 94, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$itemID - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\bff0c136f1b7cb8883a6bf84b38afc8ef933b3bc_0.file.planEdit.tpl.php - Line 152', 1747918835, 'PHP', 0, NULL),
(282, 94, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\bff0c136f1b7cb8883a6bf84b38afc8ef933b3bc_0.file.planEdit.tpl.php - Line 302', 1747918835, 'PHP', 0, NULL),
(283, 95, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:20:\"audit_testplan_saved\";s:6:\"params\";a:2:{i:0;s:18:\"Dev final Release1\";i:1;s:27:\"Test Plan R1 Final stg plan\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1747918848, 'SAVE', 2, 'testplans'),
(284, 96, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"DataTablesSelector\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747918901, 'PHP', 0, NULL),
(285, 96, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747918901, 'PHP', 0, NULL),
(286, 97, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:23:\"audit_testproject_saved\";s:6:\"params\";a:1:{i:0;s:26:\"Dev final Release1 Project\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1747918926, 'UPDATE', 1, 'testprojects'),
(287, 97, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"DataTablesSelector\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747918926, 'PHP', 0, NULL),
(288, 97, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747918926, 'PHP', 0, NULL),
(289, 98, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"DataTablesSelector\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747919215, 'PHP', 0, NULL),
(290, 98, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747919215, 'PHP', 0, NULL),
(291, 99, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$uploadOp - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\bff0c136f1b7cb8883a6bf84b38afc8ef933b3bc_0.file.planEdit.tpl.php - Line 130', 1747919384, 'PHP', 0, NULL),
(292, 99, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$itemID - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\bff0c136f1b7cb8883a6bf84b38afc8ef933b3bc_0.file.planEdit.tpl.php - Line 152', 1747919384, 'PHP', 0, NULL),
(293, 99, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\bff0c136f1b7cb8883a6bf84b38afc8ef933b3bc_0.file.planEdit.tpl.php - Line 302', 1747919384, 'PHP', 0, NULL),
(294, 100, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:20:\"audit_testplan_saved\";s:6:\"params\";a:2:{i:0;s:26:\"Dev final Release1 Project\";i:1;s:27:\"Test Plan R1 Final stg plan\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1747919514, 'SAVE', 2, 'testplans'),
(295, 101, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$uploadOp - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\bff0c136f1b7cb8883a6bf84b38afc8ef933b3bc_0.file.planEdit.tpl.php - Line 130', 1747919517, 'PHP', 0, NULL),
(296, 101, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$itemID - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\bff0c136f1b7cb8883a6bf84b38afc8ef933b3bc_0.file.planEdit.tpl.php - Line 152', 1747919517, 'PHP', 0, NULL),
(297, 102, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$uploadOp - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\bff0c136f1b7cb8883a6bf84b38afc8ef933b3bc_0.file.planEdit.tpl.php - Line 130', 1747919535, 'PHP', 0, NULL),
(298, 102, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$itemID - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\bff0c136f1b7cb8883a6bf84b38afc8ef933b3bc_0.file.planEdit.tpl.php - Line 152', 1747919535, 'PHP', 0, NULL),
(299, 102, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\bff0c136f1b7cb8883a6bf84b38afc8ef933b3bc_0.file.planEdit.tpl.php - Line 302', 1747919535, 'PHP', 0, NULL),
(300, 103, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$build - in C:\\MAMP\\htdocs\\testlink2\\lib\\plan\\buildEdit.php - Line 343', 1747919680, 'PHP', 0, NULL),
(301, 103, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined variable $args - in C:\\MAMP\\htdocs\\testlink2\\lib\\plan\\buildEdit.php - Line 371', 1747919680, 'PHP', 0, NULL),
(302, 103, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"user\" on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\plan\\buildEdit.php - Line 371', 1747919680, 'PHP', 0, NULL),
(303, 103, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"locale\" on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\plan\\buildEdit.php - Line 371', 1747919680, 'PHP', 0, NULL),
(304, 103, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"\" - in C:\\MAMP\\htdocs\\testlink2\\lib\\plan\\buildEdit.php - Line 371', 1747919680, 'PHP', 0, NULL),
(305, 104, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$build - in C:\\MAMP\\htdocs\\testlink2\\lib\\plan\\buildEdit.php - Line 343', 1747919682, 'PHP', 0, NULL),
(306, 104, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined variable $args - in C:\\MAMP\\htdocs\\testlink2\\lib\\plan\\buildEdit.php - Line 371', 1747919682, 'PHP', 0, NULL),
(307, 104, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"user\" on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\plan\\buildEdit.php - Line 371', 1747919682, 'PHP', 0, NULL),
(308, 104, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"locale\" on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\plan\\buildEdit.php - Line 371', 1747919682, 'PHP', 0, NULL),
(309, 104, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"\" - in C:\\MAMP\\htdocs\\testlink2\\lib\\plan\\buildEdit.php - Line 371', 1747919682, 'PHP', 0, NULL),
(310, 105, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$build - in C:\\MAMP\\htdocs\\testlink2\\lib\\plan\\buildEdit.php - Line 343', 1747919689, 'PHP', 0, NULL),
(311, 105, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined variable $args - in C:\\MAMP\\htdocs\\testlink2\\lib\\plan\\buildEdit.php - Line 371', 1747919689, 'PHP', 0, NULL),
(312, 105, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"user\" on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\plan\\buildEdit.php - Line 371', 1747919690, 'PHP', 0, NULL),
(313, 105, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"locale\" on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\plan\\buildEdit.php - Line 371', 1747919690, 'PHP', 0, NULL),
(314, 105, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"\" - in C:\\MAMP\\htdocs\\testlink2\\lib\\plan\\buildEdit.php - Line 371', 1747919690, 'PHP', 0, NULL),
(315, 106, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$build - in C:\\MAMP\\htdocs\\testlink2\\lib\\plan\\buildEdit.php - Line 343', 1747919691, 'PHP', 0, NULL),
(316, 106, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined variable $args - in C:\\MAMP\\htdocs\\testlink2\\lib\\plan\\buildEdit.php - Line 371', 1747919691, 'PHP', 0, NULL),
(317, 106, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"user\" on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\plan\\buildEdit.php - Line 371', 1747919691, 'PHP', 0, NULL),
(318, 106, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"locale\" on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\plan\\buildEdit.php - Line 371', 1747919691, 'PHP', 0, NULL),
(319, 106, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"\" - in C:\\MAMP\\htdocs\\testlink2\\lib\\plan\\buildEdit.php - Line 371', 1747919691, 'PHP', 0, NULL),
(320, 107, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$uploadOp - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\bff0c136f1b7cb8883a6bf84b38afc8ef933b3bc_0.file.planEdit.tpl.php - Line 130', 1747920070, 'PHP', 0, NULL),
(321, 107, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$itemID - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\bff0c136f1b7cb8883a6bf84b38afc8ef933b3bc_0.file.planEdit.tpl.php - Line 152', 1747920070, 'PHP', 0, NULL),
(322, 107, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\bff0c136f1b7cb8883a6bf84b38afc8ef933b3bc_0.file.planEdit.tpl.php - Line 302', 1747920071, 'PHP', 0, NULL),
(323, 108, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"DataTablesSelector\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747921701, 'PHP', 0, NULL),
(324, 108, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747921701, 'PHP', 0, NULL),
(325, 109, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"DataTablesSelector\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747921725, 'PHP', 0, NULL),
(326, 109, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747921725, 'PHP', 0, NULL),
(327, 110, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:19:\"audit_build_created\";s:6:\"params\";a:3:{i:0;s:26:\"Dev final Release1 Project\";i:1;s:27:\"Test Plan R1 Final stg plan\";i:2;s:6:\"Build2\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1747921764, 'CREATE', 2, 'builds'),
(328, 110, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$build - in C:\\MAMP\\htdocs\\testlink2\\lib\\plan\\buildEdit.php - Line 343', 1747921764, 'PHP', 0, NULL),
(329, 110, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined variable $args - in C:\\MAMP\\htdocs\\testlink2\\lib\\plan\\buildEdit.php - Line 371', 1747921764, 'PHP', 0, NULL),
(330, 110, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"user\" on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\plan\\buildEdit.php - Line 371', 1747921764, 'PHP', 0, NULL),
(331, 110, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"locale\" on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\plan\\buildEdit.php - Line 371', 1747921764, 'PHP', 0, NULL),
(332, 110, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"\" - in C:\\MAMP\\htdocs\\testlink2\\lib\\plan\\buildEdit.php - Line 371', 1747921764, 'PHP', 0, NULL),
(333, 111, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"DataTablesSelector\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747921811, 'PHP', 0, NULL),
(334, 111, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747921811, 'PHP', 0, NULL),
(335, 112, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"DataTablesSelector\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747921822, 'PHP', 0, NULL),
(336, 112, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747921822, 'PHP', 0, NULL),
(337, 113, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:21:\"audit_login_succeeded\";s:6:\"params\";a:2:{i:0;s:5:\"admin\";i:1;s:9:\"127.0.0.1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1747922001, 'LOGIN', 1, 'users'),
(338, 114, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"DataTablesSelector\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747922022, 'PHP', 0, NULL),
(339, 114, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747922022, 'PHP', 0, NULL),
(340, 115, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:19:\"audit_build_deleted\";s:6:\"params\";a:3:{i:0;s:26:\"Dev final Release1 Project\";i:1;s:27:\"Test Plan R1 Final stg plan\";i:2;s:6:\"Build2\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1747922072, 'DELETE', 2, 'builds'),
(341, 115, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$build - in C:\\MAMP\\htdocs\\testlink2\\lib\\plan\\buildEdit.php - Line 343', 1747922072, 'PHP', 0, NULL),
(342, 115, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined variable $args - in C:\\MAMP\\htdocs\\testlink2\\lib\\plan\\buildEdit.php - Line 371', 1747922072, 'PHP', 0, NULL),
(343, 115, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"user\" on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\plan\\buildEdit.php - Line 371', 1747922072, 'PHP', 0, NULL),
(344, 115, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"locale\" on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\plan\\buildEdit.php - Line 371', 1747922072, 'PHP', 0, NULL),
(345, 115, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"\" - in C:\\MAMP\\htdocs\\testlink2\\lib\\plan\\buildEdit.php - Line 371', 1747922072, 'PHP', 0, NULL),
(346, 116, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"DataTablesSelector\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747922182, 'PHP', 0, NULL),
(347, 116, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747922182, 'PHP', 0, NULL),
(348, 117, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"DataTablesSelector\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747922229, 'PHP', 0, NULL),
(349, 117, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747922229, 'PHP', 0, NULL),
(350, 118, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:21:\"audit_login_succeeded\";s:6:\"params\";a:2:{i:0;s:5:\"admin\";i:1;s:3:\"::1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1747980088, 'LOGIN', 1, 'users'),
(351, 119, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"DataTablesSelector\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747980681, 'PHP', 0, NULL),
(352, 119, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747980681, 'PHP', 0, NULL),
(353, 120, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 706', 1747981545, 'PHP', 0, NULL),
(354, 120, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 711', 1747981545, 'PHP', 0, NULL),
(355, 120, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 748', 1747981546, 'PHP', 0, NULL),
(356, 120, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 1172', 1747981546, 'PHP', 0, NULL),
(357, 121, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 706', 1747981546, 'PHP', 0, NULL),
(358, 121, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 711', 1747981546, 'PHP', 0, NULL),
(359, 121, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 748', 1747981546, 'PHP', 0, NULL),
(360, 121, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 1172', 1747981547, 'PHP', 0, NULL),
(361, 122, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 706', 1747981547, 'PHP', 0, NULL),
(362, 122, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 711', 1747981547, 'PHP', 0, NULL),
(363, 122, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 748', 1747981547, 'PHP', 0, NULL),
(364, 122, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 1172', 1747981547, 'PHP', 0, NULL),
(365, 123, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 706', 1747981717, 'PHP', 0, NULL),
(366, 123, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 711', 1747981717, 'PHP', 0, NULL),
(367, 123, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 748', 1747981717, 'PHP', 0, NULL),
(368, 123, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 1172', 1747981717, 'PHP', 0, NULL),
(369, 124, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:29:\"TC-1 : Reconcilation with CBE\";i:1;s:1:\"1\";i:2;s:27:\"Test Plan R1 Final stg plan\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1747981786, 'ASSIGN', 2, 'testplans'),
(370, 124, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 706', 1747981786, 'PHP', 0, NULL),
(371, 124, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 711', 1747981786, 'PHP', 0, NULL),
(372, 124, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 748', 1747981786, 'PHP', 0, NULL),
(373, 124, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 1172', 1747981786, 'PHP', 0, NULL),
(374, 124, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747981786, 'PHP', 0, NULL),
(375, 124, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 481', 1747981786, 'PHP', 0, NULL),
(376, 124, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747981786, 'PHP', 0, NULL),
(377, 124, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747981786, 'PHP', 0, NULL),
(378, 124, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747981786, 'PHP', 0, NULL),
(379, 124, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 498', 1747981786, 'PHP', 0, NULL),
(380, 124, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747981786, 'PHP', 0, NULL),
(381, 124, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747981786, 'PHP', 0, NULL),
(382, 124, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 498', 1747981786, 'PHP', 0, NULL),
(383, 124, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747981786, 'PHP', 0, NULL),
(384, 124, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747981787, 'PHP', 0, NULL),
(385, 124, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 498', 1747981787, 'PHP', 0, NULL),
(386, 124, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747981787, 'PHP', 0, NULL),
(387, 124, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747981787, 'PHP', 0, NULL),
(388, 124, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 498', 1747981787, 'PHP', 0, NULL),
(389, 124, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747981787, 'PHP', 0, NULL),
(390, 124, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747981787, 'PHP', 0, NULL),
(391, 124, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 498', 1747981787, 'PHP', 0, NULL),
(392, 124, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747981787, 'PHP', 0, NULL),
(393, 124, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747981787, 'PHP', 0, NULL),
(394, 124, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 498', 1747981787, 'PHP', 0, NULL),
(395, 124, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747981787, 'PHP', 0, NULL),
(396, 124, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747981787, 'PHP', 0, NULL),
(397, 124, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 498', 1747981787, 'PHP', 0, NULL),
(398, 124, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747981787, 'PHP', 0, NULL),
(399, 124, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747981787, 'PHP', 0, NULL),
(400, 124, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 498', 1747981787, 'PHP', 0, NULL),
(401, 124, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747981787, 'PHP', 0, NULL),
(402, 124, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747981787, 'PHP', 0, NULL),
(403, 124, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 498', 1747981787, 'PHP', 0, NULL),
(404, 124, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747981787, 'PHP', 0, NULL),
(405, 124, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747981787, 'PHP', 0, NULL),
(406, 124, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 498', 1747981787, 'PHP', 0, NULL),
(407, 125, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:33:\"TC-2 : Reconccilation with Mpessa\";i:1;s:1:\"1\";i:2;s:27:\"Test Plan R1 Final stg plan\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1747981959, 'ASSIGN', 2, 'testplans'),
(408, 125, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 706', 1747981959, 'PHP', 0, NULL),
(409, 125, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 711', 1747981959, 'PHP', 0, NULL),
(410, 125, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 748', 1747981959, 'PHP', 0, NULL),
(411, 125, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 1172', 1747981959, 'PHP', 0, NULL),
(412, 125, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747981959, 'PHP', 0, NULL),
(413, 125, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 481', 1747981959, 'PHP', 0, NULL),
(414, 125, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747981959, 'PHP', 0, NULL),
(415, 125, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747981959, 'PHP', 0, NULL),
(416, 125, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 481', 1747981959, 'PHP', 0, NULL),
(417, 125, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747981959, 'PHP', 0, NULL),
(418, 125, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747981959, 'PHP', 0, NULL),
(419, 125, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747981959, 'PHP', 0, NULL),
(420, 125, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 498', 1747981959, 'PHP', 0, NULL),
(421, 125, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747981959, 'PHP', 0, NULL),
(422, 125, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747981959, 'PHP', 0, NULL),
(423, 125, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 498', 1747981959, 'PHP', 0, NULL),
(424, 125, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747981959, 'PHP', 0, NULL),
(425, 125, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747981959, 'PHP', 0, NULL),
(426, 125, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 498', 1747981959, 'PHP', 0, NULL),
(427, 125, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747981959, 'PHP', 0, NULL),
(428, 125, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747981960, 'PHP', 0, NULL),
(429, 125, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 498', 1747981960, 'PHP', 0, NULL),
(430, 125, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747981960, 'PHP', 0, NULL),
(431, 125, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747981960, 'PHP', 0, NULL),
(432, 125, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 498', 1747981960, 'PHP', 0, NULL),
(433, 125, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747981960, 'PHP', 0, NULL);
INSERT INTO `events` (`id`, `transaction_id`, `log_level`, `source`, `description`, `fired_at`, `activity`, `object_id`, `object_type`) VALUES
(434, 125, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747981960, 'PHP', 0, NULL),
(435, 125, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 498', 1747981960, 'PHP', 0, NULL),
(436, 125, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747981960, 'PHP', 0, NULL),
(437, 125, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747981960, 'PHP', 0, NULL),
(438, 125, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 498', 1747981960, 'PHP', 0, NULL),
(439, 125, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747981960, 'PHP', 0, NULL),
(440, 125, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747981960, 'PHP', 0, NULL),
(441, 125, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 498', 1747981960, 'PHP', 0, NULL),
(442, 125, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747981960, 'PHP', 0, NULL),
(443, 125, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747981960, 'PHP', 0, NULL),
(444, 125, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 498', 1747981960, 'PHP', 0, NULL),
(445, 126, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$uploadOp - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\bff0c136f1b7cb8883a6bf84b38afc8ef933b3bc_0.file.planEdit.tpl.php - Line 130', 1747982062, 'PHP', 0, NULL),
(446, 126, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$itemID - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\bff0c136f1b7cb8883a6bf84b38afc8ef933b3bc_0.file.planEdit.tpl.php - Line 152', 1747982062, 'PHP', 0, NULL),
(447, 126, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\bff0c136f1b7cb8883a6bf84b38afc8ef933b3bc_0.file.planEdit.tpl.php - Line 302', 1747982062, 'PHP', 0, NULL),
(448, 127, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\1dab2b0440e8ca9efc072f60d9fb6806f76de964_0.file.inc_exec_show_tc_exec.tpl.php - Line 242', 1747982451, 'PHP', 0, NULL),
(449, 128, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\1dab2b0440e8ca9efc072f60d9fb6806f76de964_0.file.inc_exec_show_tc_exec.tpl.php - Line 242', 1747993420, 'PHP', 0, NULL),
(450, 129, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"DataTablesSelector\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747993437, 'PHP', 0, NULL),
(451, 129, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\d2881bdbb67f9d8f30605241b4d81f2e458e1d4f_0.file.DataTables.inc.tpl.php - Line 35', 1747993437, 'PHP', 0, NULL),
(452, 130, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 706', 1747993507, 'PHP', 0, NULL),
(453, 130, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 711', 1747993507, 'PHP', 0, NULL),
(454, 130, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 748', 1747993507, 'PHP', 0, NULL),
(455, 130, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 1172', 1747993507, 'PHP', 0, NULL),
(456, 130, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747993508, 'PHP', 0, NULL),
(457, 130, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 481', 1747993508, 'PHP', 0, NULL),
(458, 130, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747993508, 'PHP', 0, NULL),
(459, 130, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747993508, 'PHP', 0, NULL),
(460, 130, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 481', 1747993508, 'PHP', 0, NULL),
(461, 130, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747993508, 'PHP', 0, NULL),
(462, 130, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747993508, 'PHP', 0, NULL),
(463, 130, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747993508, 'PHP', 0, NULL),
(464, 130, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 498', 1747993508, 'PHP', 0, NULL),
(465, 130, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747993508, 'PHP', 0, NULL),
(466, 130, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747993508, 'PHP', 0, NULL),
(467, 130, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 498', 1747993508, 'PHP', 0, NULL),
(468, 130, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747993508, 'PHP', 0, NULL),
(469, 130, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747993508, 'PHP', 0, NULL),
(470, 130, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 498', 1747993508, 'PHP', 0, NULL),
(471, 130, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747993508, 'PHP', 0, NULL),
(472, 130, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747993508, 'PHP', 0, NULL),
(473, 130, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 498', 1747993508, 'PHP', 0, NULL),
(474, 130, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747993509, 'PHP', 0, NULL),
(475, 130, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747993509, 'PHP', 0, NULL),
(476, 130, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 498', 1747993509, 'PHP', 0, NULL),
(477, 130, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747993509, 'PHP', 0, NULL),
(478, 130, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747993509, 'PHP', 0, NULL),
(479, 130, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 498', 1747993509, 'PHP', 0, NULL),
(480, 130, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747993509, 'PHP', 0, NULL),
(481, 130, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747993509, 'PHP', 0, NULL),
(482, 130, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 498', 1747993509, 'PHP', 0, NULL),
(483, 130, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747993509, 'PHP', 0, NULL),
(484, 130, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747993509, 'PHP', 0, NULL),
(485, 130, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 498', 1747993509, 'PHP', 0, NULL),
(486, 130, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747993509, 'PHP', 0, NULL),
(487, 130, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747993509, 'PHP', 0, NULL),
(488, 130, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 498', 1747993509, 'PHP', 0, NULL),
(489, 131, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\1dab2b0440e8ca9efc072f60d9fb6806f76de964_0.file.inc_exec_show_tc_exec.tpl.php - Line 242', 1747993518, 'PHP', 0, NULL),
(490, 132, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 706', 1747994188, 'PHP', 0, NULL),
(491, 132, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 711', 1747994188, 'PHP', 0, NULL),
(492, 132, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 748', 1747994188, 'PHP', 0, NULL),
(493, 132, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 1172', 1747994188, 'PHP', 0, NULL),
(494, 132, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747994188, 'PHP', 0, NULL),
(495, 132, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 481', 1747994188, 'PHP', 0, NULL),
(496, 132, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747994188, 'PHP', 0, NULL),
(497, 132, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747994188, 'PHP', 0, NULL),
(498, 132, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 481', 1747994188, 'PHP', 0, NULL),
(499, 132, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747994188, 'PHP', 0, NULL),
(500, 132, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747994188, 'PHP', 0, NULL),
(501, 132, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747994188, 'PHP', 0, NULL),
(502, 132, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 498', 1747994188, 'PHP', 0, NULL),
(503, 132, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747994188, 'PHP', 0, NULL),
(504, 132, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747994188, 'PHP', 0, NULL),
(505, 132, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 498', 1747994188, 'PHP', 0, NULL),
(506, 132, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747994188, 'PHP', 0, NULL),
(507, 132, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747994188, 'PHP', 0, NULL),
(508, 132, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 498', 1747994188, 'PHP', 0, NULL),
(509, 132, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747994188, 'PHP', 0, NULL),
(510, 132, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747994188, 'PHP', 0, NULL),
(511, 132, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 498', 1747994188, 'PHP', 0, NULL),
(512, 132, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747994189, 'PHP', 0, NULL),
(513, 132, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747994189, 'PHP', 0, NULL),
(514, 132, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 498', 1747994189, 'PHP', 0, NULL),
(515, 132, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747994189, 'PHP', 0, NULL),
(516, 132, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747994189, 'PHP', 0, NULL),
(517, 132, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 498', 1747994189, 'PHP', 0, NULL),
(518, 132, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747994189, 'PHP', 0, NULL),
(519, 132, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747994189, 'PHP', 0, NULL),
(520, 132, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 498', 1747994189, 'PHP', 0, NULL),
(521, 132, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747994189, 'PHP', 0, NULL),
(522, 132, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747994189, 'PHP', 0, NULL),
(523, 132, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 498', 1747994189, 'PHP', 0, NULL),
(524, 132, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1747994189, 'PHP', 0, NULL),
(525, 132, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1747994189, 'PHP', 0, NULL),
(526, 132, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 498', 1747994189, 'PHP', 0, NULL),
(527, 133, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 0 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747994402, 'PHP', 0, NULL),
(528, 133, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 1 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747994403, 'PHP', 0, NULL),
(529, 133, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 2 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747994403, 'PHP', 0, NULL),
(530, 133, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 3 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747994403, 'PHP', 0, NULL),
(531, 134, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 0 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747994474, 'PHP', 0, NULL),
(532, 134, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 1 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747994474, 'PHP', 0, NULL),
(533, 134, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 2 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747994474, 'PHP', 0, NULL),
(534, 134, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 3 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1747994474, 'PHP', 0, NULL),
(535, 135, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:21:\"audit_login_succeeded\";s:6:\"params\";a:2:{i:0;s:5:\"admin\";i:1;s:3:\"::1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1748332821, 'LOGIN', 1, 'users'),
(536, 136, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 0 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748332906, 'PHP', 0, NULL),
(537, 136, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 1 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748332906, 'PHP', 0, NULL),
(538, 136, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 2 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748332906, 'PHP', 0, NULL),
(539, 136, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 3 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748332906, 'PHP', 0, NULL),
(540, 137, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 0 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748332962, 'PHP', 0, NULL),
(541, 137, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 1 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748332962, 'PHP', 0, NULL),
(542, 137, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 2 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748332962, 'PHP', 0, NULL),
(543, 137, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 3 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748332962, 'PHP', 0, NULL),
(544, 138, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1748332971, 'PHP', 0, NULL),
(545, 138, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1748332971, 'PHP', 0, NULL),
(546, 138, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$hideSummary - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 42', 1748332971, 'PHP', 0, NULL),
(547, 138, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1748332971, 'PHP', 0, NULL),
(548, 139, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1748333094, 'PHP', 0, NULL),
(549, 139, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1748333094, 'PHP', 0, NULL),
(550, 139, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$hideSummary - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 42', 1748333094, 'PHP', 0, NULL),
(551, 139, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1748333094, 'PHP', 0, NULL),
(552, 140, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1748333119, 'PHP', 0, NULL),
(553, 140, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1748333119, 'PHP', 0, NULL),
(554, 140, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$hideSummary - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 42', 1748333119, 'PHP', 0, NULL),
(555, 140, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1748333119, 'PHP', 0, NULL),
(556, 141, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1748333127, 'PHP', 0, NULL),
(557, 141, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1748333127, 'PHP', 0, NULL),
(558, 141, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$hideSummary - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 42', 1748333127, 'PHP', 0, NULL),
(559, 141, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1748333127, 'PHP', 0, NULL),
(560, 142, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1748333140, 'PHP', 0, NULL),
(561, 142, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1748333140, 'PHP', 0, NULL),
(562, 142, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$hideSummary - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 42', 1748333140, 'PHP', 0, NULL),
(563, 142, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1748333140, 'PHP', 0, NULL),
(564, 143, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1748333154, 'PHP', 0, NULL),
(565, 143, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1748333154, 'PHP', 0, NULL),
(566, 143, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$hideSummary - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 42', 1748333154, 'PHP', 0, NULL),
(567, 143, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1748333154, 'PHP', 0, NULL),
(568, 144, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 0 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748333173, 'PHP', 0, NULL),
(569, 144, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 1 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748333173, 'PHP', 0, NULL),
(570, 144, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 2 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748333173, 'PHP', 0, NULL),
(571, 144, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 3 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748333173, 'PHP', 0, NULL),
(572, 145, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 0 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748333215, 'PHP', 0, NULL),
(573, 145, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 1 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748333215, 'PHP', 0, NULL),
(574, 145, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 2 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748333215, 'PHP', 0, NULL),
(575, 145, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 3 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748333215, 'PHP', 0, NULL),
(576, 146, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 0 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748333221, 'PHP', 0, NULL),
(577, 146, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 1 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748333221, 'PHP', 0, NULL),
(578, 146, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 2 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748333221, 'PHP', 0, NULL),
(579, 146, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 3 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748333221, 'PHP', 0, NULL),
(580, 147, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1748333254, 'PHP', 0, NULL),
(581, 147, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1748333254, 'PHP', 0, NULL),
(582, 147, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$hideSummary - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 42', 1748333254, 'PHP', 0, NULL),
(583, 147, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$hidePreconditions - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 47', 1748333254, 'PHP', 0, NULL),
(584, 147, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1748333254, 'PHP', 0, NULL),
(585, 148, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1748333264, 'PHP', 0, NULL),
(586, 148, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1748333264, 'PHP', 0, NULL),
(587, 148, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$hideSummary - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 42', 1748333264, 'PHP', 0, NULL),
(588, 148, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$hidePreconditions - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 47', 1748333264, 'PHP', 0, NULL),
(589, 148, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1748333264, 'PHP', 0, NULL),
(590, 149, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1748333274, 'PHP', 0, NULL),
(591, 149, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1748333274, 'PHP', 0, NULL),
(592, 149, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$hideSummary - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 42', 1748333274, 'PHP', 0, NULL),
(593, 149, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$hidePreconditions - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 47', 1748333274, 'PHP', 0, NULL),
(594, 149, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1748333274, 'PHP', 0, NULL),
(595, 150, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1748333292, 'PHP', 0, NULL),
(596, 150, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1748333292, 'PHP', 0, NULL),
(597, 150, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$hideSummary - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 42', 1748333292, 'PHP', 0, NULL),
(598, 150, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$hidePreconditions - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 47', 1748333292, 'PHP', 0, NULL),
(599, 150, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1748333292, 'PHP', 0, NULL),
(600, 151, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1748333295, 'PHP', 0, NULL),
(601, 151, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1748333295, 'PHP', 0, NULL),
(602, 151, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$hideSummary - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 42', 1748333296, 'PHP', 0, NULL),
(603, 151, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$hidePreconditions - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 47', 1748333296, 'PHP', 0, NULL),
(604, 151, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1748333296, 'PHP', 0, NULL),
(605, 152, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 0 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748333315, 'PHP', 0, NULL),
(606, 152, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 1 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748333315, 'PHP', 0, NULL),
(607, 152, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 2 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748333315, 'PHP', 0, NULL),
(608, 152, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 3 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748333315, 'PHP', 0, NULL),
(609, 153, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 0 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748333329, 'PHP', 0, NULL),
(610, 153, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 1 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748333329, 'PHP', 0, NULL),
(611, 153, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 2 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748333329, 'PHP', 0, NULL),
(612, 153, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 3 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748333329, 'PHP', 0, NULL),
(613, 154, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1748333333, 'PHP', 0, NULL),
(614, 154, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1748333333, 'PHP', 0, NULL),
(615, 154, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$hideSummary - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 42', 1748333333, 'PHP', 0, NULL),
(616, 154, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$hidePreconditions - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 47', 1748333333, 'PHP', 0, NULL),
(617, 154, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1748333333, 'PHP', 0, NULL),
(618, 155, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1748333349, 'PHP', 0, NULL),
(619, 155, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1748333349, 'PHP', 0, NULL),
(620, 155, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$hideSummary - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 42', 1748333349, 'PHP', 0, NULL),
(621, 155, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$hidePreconditions - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 47', 1748333349, 'PHP', 0, NULL),
(622, 155, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1748333349, 'PHP', 0, NULL),
(623, 156, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1748333360, 'PHP', 0, NULL),
(624, 156, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1748333360, 'PHP', 0, NULL),
(625, 156, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$hideSummary - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 42', 1748333360, 'PHP', 0, NULL),
(626, 156, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$hidePreconditions - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 47', 1748333360, 'PHP', 0, NULL),
(627, 156, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1748333360, 'PHP', 0, NULL),
(628, 157, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1748333373, 'PHP', 0, NULL),
(629, 157, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1748333373, 'PHP', 0, NULL),
(630, 157, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$hideSummary - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 42', 1748333373, 'PHP', 0, NULL),
(631, 157, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$hidePreconditions - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 47', 1748333373, 'PHP', 0, NULL),
(632, 157, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1748333373, 'PHP', 0, NULL),
(633, 158, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1748333386, 'PHP', 0, NULL),
(634, 158, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1748333386, 'PHP', 0, NULL),
(635, 158, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$hideSummary - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 42', 1748333386, 'PHP', 0, NULL),
(636, 158, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$hidePreconditions - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 47', 1748333386, 'PHP', 0, NULL),
(637, 158, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1748333386, 'PHP', 0, NULL),
(638, 159, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 0 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748333488, 'PHP', 0, NULL),
(639, 159, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 1 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748333488, 'PHP', 0, NULL),
(640, 159, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 2 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748333488, 'PHP', 0, NULL);
INSERT INTO `events` (`id`, `transaction_id`, `log_level`, `source`, `description`, `fired_at`, `activity`, `object_id`, `object_type`) VALUES
(641, 159, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 3 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748333489, 'PHP', 0, NULL),
(642, 160, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 0 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748333526, 'PHP', 0, NULL),
(643, 160, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 1 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748333526, 'PHP', 0, NULL),
(644, 160, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 2 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748333526, 'PHP', 0, NULL),
(645, 160, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 3 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748333526, 'PHP', 0, NULL),
(646, 161, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1748333534, 'PHP', 0, NULL),
(647, 161, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1748333534, 'PHP', 0, NULL),
(648, 161, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$hideSummary - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 42', 1748333534, 'PHP', 0, NULL),
(649, 161, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$hidePreconditions - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 47', 1748333534, 'PHP', 0, NULL),
(650, 161, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1748333535, 'PHP', 0, NULL),
(651, 162, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1748333550, 'PHP', 0, NULL),
(652, 162, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1748333550, 'PHP', 0, NULL),
(653, 162, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$hideSummary - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 42', 1748333550, 'PHP', 0, NULL),
(654, 162, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$hidePreconditions - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 47', 1748333550, 'PHP', 0, NULL),
(655, 162, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1748333550, 'PHP', 0, NULL),
(656, 163, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1748333560, 'PHP', 0, NULL),
(657, 163, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1748333560, 'PHP', 0, NULL),
(658, 163, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$hideSummary - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 42', 1748333560, 'PHP', 0, NULL),
(659, 163, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$hidePreconditions - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 47', 1748333560, 'PHP', 0, NULL),
(660, 163, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1748333560, 'PHP', 0, NULL),
(661, 164, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 0 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748343777, 'PHP', 0, NULL),
(662, 164, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 1 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748343778, 'PHP', 0, NULL),
(663, 164, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 2 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748343778, 'PHP', 0, NULL),
(664, 164, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 3 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748343778, 'PHP', 0, NULL),
(665, 165, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 0 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748343815, 'PHP', 0, NULL),
(666, 165, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 1 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748343816, 'PHP', 0, NULL),
(667, 165, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 2 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748343816, 'PHP', 0, NULL),
(668, 165, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 3 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748343816, 'PHP', 0, NULL),
(669, 166, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"inc_relations\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1748343822, 'PHP', 0, NULL),
(670, 166, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nAttempt to read property \"value\" on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\b58d9378bd2afae808226c445e0d37f852715ea9_0.file.tctitle.inc.tpl.php - Line 39', 1748343822, 'PHP', 0, NULL),
(671, 166, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined property: stdClass::$hidePreconditions - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 47', 1748343822, 'PHP', 0, NULL),
(672, 166, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key \"ghost_preconditions\" - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\19e4279a63cd3be71747bd3801b2586679718fb7_0.file.inc_tcbody.tpl.php - Line 99', 1748343822, 'PHP', 0, NULL),
(673, 167, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 0 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748343861, 'PHP', 0, NULL),
(674, 167, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 1 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748343861, 'PHP', 0, NULL),
(675, 167, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 2 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748343861, 'PHP', 0, NULL),
(676, 167, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 3 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748343861, 'PHP', 0, NULL),
(677, 168, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 0 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748343876, 'PHP', 0, NULL),
(678, 168, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 1 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748343876, 'PHP', 0, NULL),
(679, 168, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 2 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748343876, 'PHP', 0, NULL),
(680, 168, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nUndefined array key 3 - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\testcase.class.php - Line 5568', 1748343876, 'PHP', 0, NULL),
(681, 169, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 706', 1748344074, 'PHP', 0, NULL),
(682, 169, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 711', 1748344074, 'PHP', 0, NULL),
(683, 169, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 748', 1748344074, 'PHP', 0, NULL),
(684, 169, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 1172', 1748344074, 'PHP', 0, NULL),
(685, 170, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:25:\"TC-13 : Create Event Link\";i:1;s:1:\"1\";i:2;s:27:\"Test Plan R1 Final stg plan\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1748344100, 'ASSIGN', 2, 'testplans'),
(686, 170, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:20:\"TC-14 : Update Event\";i:1;s:1:\"1\";i:2;s:27:\"Test Plan R1 Final stg plan\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1748344100, 'ASSIGN', 2, 'testplans'),
(687, 170, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:21:\"TC-15 : Pay for Event\";i:1;s:1:\"1\";i:2;s:27:\"Test Plan R1 Final stg plan\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1748344100, 'ASSIGN', 2, 'testplans'),
(688, 170, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:48:\"TC-16 : Refund Payment for event (Merchant Side)\";i:1;s:1:\"1\";i:2;s:27:\"Test Plan R1 Final stg plan\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1748344100, 'ASSIGN', 2, 'testplans'),
(689, 170, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:48:\"TC-17 : create event with missing required field\";i:1;s:1:\"1\";i:2;s:27:\"Test Plan R1 Final stg plan\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1748344100, 'ASSIGN', 2, 'testplans'),
(690, 170, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:35:\"TC-18 : Invalid ticket price format\";i:1;s:1:\"1\";i:2;s:27:\"Test Plan R1 Final stg plan\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1748344100, 'ASSIGN', 2, 'testplans'),
(691, 170, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 706', 1748344101, 'PHP', 0, NULL),
(692, 170, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 711', 1748344101, 'PHP', 0, NULL),
(693, 170, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 748', 1748344101, 'PHP', 0, NULL),
(694, 170, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 1172', 1748344101, 'PHP', 0, NULL),
(695, 170, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1748344101, 'PHP', 0, NULL),
(696, 170, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 481', 1748344101, 'PHP', 0, NULL),
(697, 170, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1748344101, 'PHP', 0, NULL),
(698, 170, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1748344101, 'PHP', 0, NULL),
(699, 170, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 481', 1748344101, 'PHP', 0, NULL),
(700, 170, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1748344101, 'PHP', 0, NULL),
(701, 170, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1748344101, 'PHP', 0, NULL),
(702, 170, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 481', 1748344101, 'PHP', 0, NULL),
(703, 170, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1748344101, 'PHP', 0, NULL),
(704, 170, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1748344101, 'PHP', 0, NULL),
(705, 170, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 481', 1748344101, 'PHP', 0, NULL),
(706, 170, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1748344101, 'PHP', 0, NULL),
(707, 170, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1748344101, 'PHP', 0, NULL),
(708, 170, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 481', 1748344101, 'PHP', 0, NULL),
(709, 170, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1748344101, 'PHP', 0, NULL),
(710, 170, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1748344101, 'PHP', 0, NULL),
(711, 170, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 481', 1748344101, 'PHP', 0, NULL),
(712, 170, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1748344101, 'PHP', 0, NULL),
(713, 171, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 706', 1748344107, 'PHP', 0, NULL),
(714, 171, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 711', 1748344107, 'PHP', 0, NULL),
(715, 171, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 748', 1748344107, 'PHP', 0, NULL),
(716, 171, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\lib\\functions\\specview.php - Line 1172', 1748344107, 'PHP', 0, NULL),
(717, 171, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1748344107, 'PHP', 0, NULL),
(718, 171, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 481', 1748344107, 'PHP', 0, NULL),
(719, 171, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1748344107, 'PHP', 0, NULL),
(720, 171, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1748344107, 'PHP', 0, NULL),
(721, 171, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 481', 1748344107, 'PHP', 0, NULL),
(722, 171, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1748344107, 'PHP', 0, NULL),
(723, 171, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1748344107, 'PHP', 0, NULL),
(724, 171, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 481', 1748344107, 'PHP', 0, NULL),
(725, 171, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1748344107, 'PHP', 0, NULL),
(726, 171, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1748344107, 'PHP', 0, NULL),
(727, 171, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 481', 1748344107, 'PHP', 0, NULL),
(728, 171, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1748344107, 'PHP', 0, NULL),
(729, 171, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1748344107, 'PHP', 0, NULL),
(730, 171, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 481', 1748344107, 'PHP', 0, NULL),
(731, 171, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1748344107, 'PHP', 0, NULL),
(732, 171, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 476', 1748344107, 'PHP', 0, NULL),
(733, 171, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 481', 1748344107, 'PHP', 0, NULL),
(734, 171, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\17a77fd511494d5318f0786c156d22db30bb1177_0.file.planAddTC_m1.tpl.php - Line 493', 1748344107, 'PHP', 0, NULL),
(735, 172, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\1dab2b0440e8ca9efc072f60d9fb6806f76de964_0.file.inc_exec_show_tc_exec.tpl.php - Line 242', 1748344130, 'PHP', 0, NULL),
(736, 173, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\1dab2b0440e8ca9efc072f60d9fb6806f76de964_0.file.inc_exec_show_tc_exec.tpl.php - Line 242', 1748347821, 'PHP', 0, NULL),
(737, 174, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\1dab2b0440e8ca9efc072f60d9fb6806f76de964_0.file.inc_exec_show_tc_exec.tpl.php - Line 242', 1748351541, 'PHP', 0, NULL),
(738, 175, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\1dab2b0440e8ca9efc072f60d9fb6806f76de964_0.file.inc_exec_show_tc_exec.tpl.php - Line 242', 1748353044, 'PHP', 0, NULL),
(739, 176, 2, 'GUI - Test Project ID : 1', 'E_WARNING\nTrying to access array offset on null - in C:\\MAMP\\htdocs\\testlink2\\gui\\templates_c\\1dab2b0440e8ca9efc072f60d9fb6806f76de964_0.file.inc_exec_show_tc_exec.tpl.php - Line 242', 1748353045, 'PHP', 0, NULL),
(740, 177, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:21:\"audit_login_succeeded\";s:6:\"params\";a:2:{i:0;s:5:\"admin\";i:1;s:3:\"::1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1748850003, 'LOGIN', 1, 'users');

-- --------------------------------------------------------

--
-- Table structure for table `executions`
--

DROP TABLE IF EXISTS `executions`;
CREATE TABLE IF NOT EXISTS `executions` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `build_id` int(10) NOT NULL DEFAULT '0',
  `tester_id` int(10) UNSIGNED DEFAULT NULL,
  `execution_ts` datetime DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  `testplan_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `tcversion_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `tcversion_number` smallint(5) UNSIGNED NOT NULL DEFAULT '1',
  `platform_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `execution_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 -> manual, 2 -> automated',
  `execution_duration` decimal(6,2) DEFAULT NULL COMMENT 'NULL will be considered as NO DATA Provided by user',
  `notes` text,
  PRIMARY KEY (`id`),
  KEY `executions_idx1` (`testplan_id`,`tcversion_id`,`platform_id`,`build_id`),
  KEY `executions_idx2` (`execution_type`),
  KEY `executions_idx3` (`tcversion_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `execution_bugs`
--

DROP TABLE IF EXISTS `execution_bugs`;
CREATE TABLE IF NOT EXISTS `execution_bugs` (
  `execution_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `bug_id` varchar(64) NOT NULL DEFAULT '0',
  `tcstep_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`execution_id`,`bug_id`,`tcstep_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `execution_tcsteps`
--

DROP TABLE IF EXISTS `execution_tcsteps`;
CREATE TABLE IF NOT EXISTS `execution_tcsteps` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `execution_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `tcstep_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `notes` text,
  `status` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `execution_tcsteps_idx1` (`execution_id`,`tcstep_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `execution_tcsteps_wip`
--

DROP TABLE IF EXISTS `execution_tcsteps_wip`;
CREATE TABLE IF NOT EXISTS `execution_tcsteps_wip` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tcstep_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `testplan_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `platform_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `build_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `tester_id` int(10) UNSIGNED DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `notes` text,
  `status` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `execution_tcsteps_wip_idx1` (`tcstep_id`,`testplan_id`,`platform_id`,`build_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Stand-in structure for view `exec_by_date_time`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `exec_by_date_time`;
CREATE TABLE IF NOT EXISTS `exec_by_date_time` (
`testplan_name` varchar(100)
,`yyyy_mm_dd` varchar(10)
,`yyyy_mm` varchar(7)
,`hh` varchar(7)
,`hour` varchar(7)
,`id` int(10) unsigned
,`build_id` int(10)
,`tester_id` int(10) unsigned
,`execution_ts` datetime
,`status` char(1)
,`testplan_id` int(10) unsigned
,`tcversion_id` int(10) unsigned
,`tcversion_number` smallint(5) unsigned
,`platform_id` int(10) unsigned
,`execution_type` tinyint(1)
,`execution_duration` decimal(6,2)
,`notes` text
);

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
CREATE TABLE IF NOT EXISTS `inventory` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `testproject_id` int(10) UNSIGNED NOT NULL,
  `owner_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `ipaddress` varchar(255) NOT NULL,
  `content` text,
  `creation_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modification_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `inventory_idx1` (`testproject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `issuetrackers`
--

DROP TABLE IF EXISTS `issuetrackers`;
CREATE TABLE IF NOT EXISTS `issuetrackers` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `type` int(10) DEFAULT '0',
  `cfg` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `issuetrackers_uidx1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `keywords`
--

DROP TABLE IF EXISTS `keywords`;
CREATE TABLE IF NOT EXISTS `keywords` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `keyword` varchar(100) NOT NULL DEFAULT '',
  `testproject_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `notes` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `keyword_testproject_id` (`keyword`,`testproject_id`),
  KEY `testproject_id` (`testproject_id`),
  KEY `keyword` (`keyword`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Stand-in structure for view `latest_exec_by_context`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `latest_exec_by_context`;
CREATE TABLE IF NOT EXISTS `latest_exec_by_context` (
`tcversion_id` int(10) unsigned
,`testplan_id` int(10) unsigned
,`build_id` int(10)
,`platform_id` int(10) unsigned
,`id` int(10) unsigned
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `latest_exec_by_testplan`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `latest_exec_by_testplan`;
CREATE TABLE IF NOT EXISTS `latest_exec_by_testplan` (
`tcversion_id` int(10) unsigned
,`testplan_id` int(10) unsigned
,`id` int(10) unsigned
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `latest_exec_by_testplan_plat`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `latest_exec_by_testplan_plat`;
CREATE TABLE IF NOT EXISTS `latest_exec_by_testplan_plat` (
`tcversion_id` int(10) unsigned
,`testplan_id` int(10) unsigned
,`platform_id` int(10) unsigned
,`id` int(10) unsigned
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `latest_req_version`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `latest_req_version`;
CREATE TABLE IF NOT EXISTS `latest_req_version` (
`req_id` int(10) unsigned
,`version` smallint(5) unsigned
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `latest_req_version_id`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `latest_req_version_id`;
CREATE TABLE IF NOT EXISTS `latest_req_version_id` (
`req_id` int(10) unsigned
,`version` smallint(5) unsigned
,`req_version_id` int(10) unsigned
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `latest_rspec_revision`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `latest_rspec_revision`;
CREATE TABLE IF NOT EXISTS `latest_rspec_revision` (
`req_spec_id` int(10) unsigned
,`testproject_id` int(10) unsigned
,`revision` smallint(5) unsigned
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `latest_tcase_version_id`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `latest_tcase_version_id`;
CREATE TABLE IF NOT EXISTS `latest_tcase_version_id` (
`testcase_id` int(10) unsigned
,`version` smallint(5) unsigned
,`tcversion_id` int(10) unsigned
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `latest_tcase_version_number`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `latest_tcase_version_number`;
CREATE TABLE IF NOT EXISTS `latest_tcase_version_number` (
`testcase_id` int(10) unsigned
,`version` smallint(5) unsigned
);

-- --------------------------------------------------------

--
-- Table structure for table `milestones`
--

DROP TABLE IF EXISTS `milestones`;
CREATE TABLE IF NOT EXISTS `milestones` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `testplan_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `target_date` date NOT NULL,
  `start_date` date DEFAULT NULL,
  `a` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `b` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `c` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `name` varchar(100) NOT NULL DEFAULT 'undefined',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_testplan_id` (`name`,`testplan_id`),
  KEY `testplan_id` (`testplan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nodes_hierarchy`
--

DROP TABLE IF EXISTS `nodes_hierarchy`;
CREATE TABLE IF NOT EXISTS `nodes_hierarchy` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `parent_id` int(10) UNSIGNED DEFAULT NULL,
  `node_type_id` int(10) UNSIGNED NOT NULL DEFAULT '1',
  `node_order` int(10) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pid_m_nodeorder` (`parent_id`,`node_order`),
  KEY `nodes_hierarchy_node_type_id` (`node_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nodes_hierarchy`
--

INSERT INTO `nodes_hierarchy` (`id`, `name`, `parent_id`, `node_type_id`, `node_order`) VALUES
(1, 'Dev final Release1 Project', NULL, 1, 1),
(2, 'Test Plan R1 Final stg plan', 1, 5, 0),
(3, 'Reconcilation CBE & Mpesa', 1, 2, 0),
(4, 'Reconcilation with CBE', 3, 3, 1000),
(5, '', 4, 4, 0),
(6, '', 5, 9, 0),
(7, '', 5, 9, 0),
(8, '', 5, 9, 0),
(10, 'Reconccilation with Mpessa', 3, 3, 1001),
(11, '', 10, 4, 0),
(12, '', 11, 9, 0),
(13, '', 11, 9, 0),
(16, 'Cleared transactions display on merchant ledger', 3, 3, 1002),
(17, '', 16, 4, 0),
(18, '', 17, 9, 0),
(19, '', 17, 9, 0),
(20, '', 17, 9, 0),
(22, 'Add Bank', 3, 3, 1003),
(23, '', 22, 4, 0),
(24, '', 23, 9, 0),
(25, '', 23, 9, 0),
(26, 'Refund Transactions Telebir & cbe', 3, 3, 1004),
(27, '', 26, 4, 0),
(28, '', 27, 9, 0),
(29, '', 27, 9, 0),
(30, '', 27, 9, 0),
(31, 'Settelment', 3, 3, 1005),
(32, '', 31, 4, 0),
(33, '', 32, 9, 0),
(34, '', 32, 9, 0),
(35, '', 32, 9, 0),
(36, '', 32, 9, 0),
(37, '', 32, 9, 0),
(38, 'B2C payment with cbe', 55, 3, 1006),
(39, '', 38, 4, 0),
(40, 'B2C payment with Awash', 55, 3, 1007),
(41, '', 40, 4, 0),
(42, 'Top up operation', 3, 3, 1008),
(43, '', 42, 4, 0),
(44, 'Recipt on escrow payment', 3, 3, 1009),
(45, '', 44, 4, 0),
(46, '', 45, 9, 0),
(47, '', 45, 9, 0),
(48, 'Verify Rate limiting ', 52, 3, 1010),
(49, '', 48, 4, 0),
(50, '', 49, 9, 0),
(51, '', 49, 9, 0),
(52, 'Security Tasks', 1, 2, 2),
(53, 'Verify account lock on retry', 52, 3, 1011),
(54, '', 53, 4, 0),
(55, 'B2C payment', 1, 2, 1),
(56, 'Event link', 1, 2, 3),
(57, 'Create Event Link', 56, 3, 1000),
(58, '', 57, 4, 0),
(59, '', 58, 9, 0),
(60, '', 58, 9, 0),
(61, '', 58, 9, 0),
(62, '', 58, 9, 0),
(63, '', 58, 9, 0),
(65, 'Update Event', 56, 3, 1001),
(66, '', 65, 4, 0),
(67, '', 66, 9, 0),
(68, '', 66, 9, 0),
(69, '', 66, 9, 0),
(70, '', 66, 9, 0),
(71, 'Pay for Event', 56, 3, 1002),
(72, '', 71, 4, 0),
(73, '', 72, 9, 0),
(74, '', 72, 9, 0),
(75, '', 72, 9, 0),
(76, '', 72, 9, 0),
(77, '', 72, 9, 0),
(78, 'Refund Payment for event (Merchant Side)', 56, 3, 1003),
(79, '', 78, 4, 0),
(80, '', 79, 9, 0),
(81, '', 79, 9, 0),
(82, '', 79, 9, 0),
(83, 'create event with missing required field', 56, 3, 1004),
(84, '', 83, 4, 0),
(85, 'Invalid ticket price format', 56, 3, 1005),
(86, '', 85, 4, 0);

-- --------------------------------------------------------

--
-- Table structure for table `node_types`
--

DROP TABLE IF EXISTS `node_types`;
CREATE TABLE IF NOT EXISTS `node_types` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `description` varchar(100) NOT NULL DEFAULT 'testproject',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `node_types`
--

INSERT INTO `node_types` (`id`, `description`) VALUES
(1, 'testproject'),
(2, 'testsuite'),
(3, 'testcase'),
(4, 'testcase_version'),
(5, 'testplan'),
(6, 'requirement_spec'),
(7, 'requirement'),
(8, 'requirement_version'),
(9, 'testcase_step'),
(10, 'requirement_revision'),
(11, 'requirement_spec_revision'),
(12, 'build'),
(13, 'platform'),
(14, 'user');

-- --------------------------------------------------------

--
-- Table structure for table `object_keywords`
--

DROP TABLE IF EXISTS `object_keywords`;
CREATE TABLE IF NOT EXISTS `object_keywords` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `fk_table` varchar(30) DEFAULT '',
  `keyword_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `udx01_object_keywords` (`fk_id`,`fk_table`,`keyword_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `platforms`
--

DROP TABLE IF EXISTS `platforms`;
CREATE TABLE IF NOT EXISTS `platforms` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `testproject_id` int(10) UNSIGNED NOT NULL,
  `notes` text NOT NULL,
  `enable_on_design` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `enable_on_execution` tinyint(1) UNSIGNED NOT NULL DEFAULT '1',
  `is_open` tinyint(1) UNSIGNED NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_platforms` (`testproject_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `plugins`
--

DROP TABLE IF EXISTS `plugins`;
CREATE TABLE IF NOT EXISTS `plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `basename` varchar(100) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `author_id` int(10) UNSIGNED DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `plugins_configuration`
--

DROP TABLE IF EXISTS `plugins_configuration`;
CREATE TABLE IF NOT EXISTS `plugins_configuration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `testproject_id` int(11) NOT NULL,
  `config_key` varchar(255) NOT NULL,
  `config_type` int(11) NOT NULL,
  `config_value` varchar(255) NOT NULL,
  `author_id` int(10) UNSIGNED DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `reqmgrsystems`
--

DROP TABLE IF EXISTS `reqmgrsystems`;
CREATE TABLE IF NOT EXISTS `reqmgrsystems` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `type` int(10) DEFAULT '0',
  `cfg` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reqmgrsystems_uidx1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `requirements`
--

DROP TABLE IF EXISTS `requirements`;
CREATE TABLE IF NOT EXISTS `requirements` (
  `id` int(10) UNSIGNED NOT NULL,
  `srs_id` int(10) UNSIGNED NOT NULL,
  `req_doc_id` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `requirements_req_doc_id` (`srs_id`,`req_doc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `req_coverage`
--

DROP TABLE IF EXISTS `req_coverage`;
CREATE TABLE IF NOT EXISTS `req_coverage` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `req_id` int(10) NOT NULL,
  `req_version_id` int(10) NOT NULL,
  `testcase_id` int(10) NOT NULL,
  `tcversion_id` int(10) NOT NULL,
  `link_status` int(11) NOT NULL DEFAULT '1',
  `is_active` int(11) NOT NULL DEFAULT '1',
  `author_id` int(10) UNSIGNED DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `review_requester_id` int(10) UNSIGNED DEFAULT NULL,
  `review_request_ts` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `req_coverage_full_link` (`req_id`,`req_version_id`,`testcase_id`,`tcversion_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='relation test case version ** requirement version';

-- --------------------------------------------------------

--
-- Table structure for table `req_monitor`
--

DROP TABLE IF EXISTS `req_monitor`;
CREATE TABLE IF NOT EXISTS `req_monitor` (
  `req_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `testproject_id` int(11) NOT NULL,
  PRIMARY KEY (`req_id`,`user_id`,`testproject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `req_relations`
--

DROP TABLE IF EXISTS `req_relations`;
CREATE TABLE IF NOT EXISTS `req_relations` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `source_id` int(10) UNSIGNED NOT NULL,
  `destination_id` int(10) UNSIGNED NOT NULL,
  `relation_type` smallint(5) UNSIGNED NOT NULL DEFAULT '1',
  `author_id` int(10) UNSIGNED DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `req_revisions`
--

DROP TABLE IF EXISTS `req_revisions`;
CREATE TABLE IF NOT EXISTS `req_revisions` (
  `parent_id` int(10) UNSIGNED NOT NULL,
  `id` int(10) UNSIGNED NOT NULL,
  `revision` smallint(5) UNSIGNED NOT NULL DEFAULT '1',
  `req_doc_id` varchar(64) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `scope` text,
  `status` char(1) NOT NULL DEFAULT 'V',
  `type` char(1) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `is_open` tinyint(1) NOT NULL DEFAULT '1',
  `expected_coverage` int(10) NOT NULL DEFAULT '1',
  `log_message` text,
  `author_id` int(10) UNSIGNED DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modifier_id` int(10) UNSIGNED DEFAULT NULL,
  `modification_ts` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `req_revisions_uidx1` (`parent_id`,`revision`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `req_specs`
--

DROP TABLE IF EXISTS `req_specs`;
CREATE TABLE IF NOT EXISTS `req_specs` (
  `id` int(10) UNSIGNED NOT NULL,
  `testproject_id` int(10) UNSIGNED NOT NULL,
  `doc_id` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `req_spec_uk1` (`doc_id`,`testproject_id`),
  KEY `testproject_id` (`testproject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Dev. Documents (e.g. System Requirements Specification)';

-- --------------------------------------------------------

--
-- Table structure for table `req_specs_revisions`
--

DROP TABLE IF EXISTS `req_specs_revisions`;
CREATE TABLE IF NOT EXISTS `req_specs_revisions` (
  `parent_id` int(10) UNSIGNED NOT NULL,
  `id` int(10) UNSIGNED NOT NULL,
  `revision` smallint(5) UNSIGNED NOT NULL DEFAULT '1',
  `doc_id` varchar(64) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `scope` text,
  `total_req` int(10) NOT NULL DEFAULT '0',
  `status` int(10) UNSIGNED DEFAULT '1',
  `type` char(1) DEFAULT NULL,
  `log_message` text,
  `author_id` int(10) UNSIGNED DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modifier_id` int(10) UNSIGNED DEFAULT NULL,
  `modification_ts` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `req_specs_revisions_uidx1` (`parent_id`,`revision`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `req_versions`
--

DROP TABLE IF EXISTS `req_versions`;
CREATE TABLE IF NOT EXISTS `req_versions` (
  `id` int(10) UNSIGNED NOT NULL,
  `version` smallint(5) UNSIGNED NOT NULL DEFAULT '1',
  `revision` smallint(5) UNSIGNED NOT NULL DEFAULT '1',
  `scope` text,
  `status` char(1) NOT NULL DEFAULT 'V',
  `type` char(1) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `is_open` tinyint(1) NOT NULL DEFAULT '1',
  `expected_coverage` int(10) NOT NULL DEFAULT '1',
  `author_id` int(10) UNSIGNED DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modifier_id` int(10) UNSIGNED DEFAULT NULL,
  `modification_ts` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `log_message` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `rights`
--

DROP TABLE IF EXISTS `rights`;
CREATE TABLE IF NOT EXISTS `rights` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `description` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `rights_descr` (`description`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `rights`
--

INSERT INTO `rights` (`id`, `description`) VALUES
(53, 'cfield_assignment'),
(18, 'cfield_management'),
(17, 'cfield_view'),
(51, 'codetracker_management'),
(52, 'codetracker_view'),
(56, 'delete_frozen_tcversion'),
(22, 'events_mgt'),
(54, 'exec_assign_testcases'),
(36, 'exec_delete'),
(35, 'exec_edit_notes'),
(49, 'exec_ro_access'),
(41, 'exec_testcases_assigned_to_me'),
(31, 'issuetracker_management'),
(32, 'issuetracker_view'),
(29, 'keyword_assignment'),
(9, 'mgt_modify_key'),
(12, 'mgt_modify_product'),
(11, 'mgt_modify_req'),
(7, 'mgt_modify_tc'),
(48, 'mgt_plugins'),
(16, 'mgt_testplan_create'),
(30, 'mgt_unfreeze_req'),
(13, 'mgt_users'),
(20, 'mgt_view_events'),
(8, 'mgt_view_key'),
(10, 'mgt_view_req'),
(6, 'mgt_view_tc'),
(21, 'mgt_view_usergroups'),
(50, 'monitor_requirement'),
(24, 'platform_management'),
(25, 'platform_view'),
(26, 'project_inventory_management'),
(27, 'project_inventory_view'),
(33, 'reqmgrsystem_management'),
(34, 'reqmgrsystem_view'),
(28, 'req_tcase_link_management'),
(14, 'role_management'),
(19, 'system_configuration'),
(47, 'testcase_freeze'),
(43, 'testplan_add_remove_platforms'),
(2, 'testplan_create_build'),
(1, 'testplan_execute'),
(3, 'testplan_metrics'),
(40, 'testplan_milestone_overview'),
(4, 'testplan_planning'),
(45, 'testplan_set_urgent_testcases'),
(46, 'testplan_show_testcases_newest_versions'),
(37, 'testplan_unlink_executed_testcases'),
(44, 'testplan_update_linked_testcase_versions'),
(5, 'testplan_user_role_assignment'),
(55, 'testproject_add_remove_keywords_executed_tcversions'),
(38, 'testproject_delete_executed_testcases'),
(39, 'testproject_edit_executed_testcases'),
(42, 'testproject_metrics_dashboard'),
(23, 'testproject_user_role_assignment'),
(15, 'user_role_assignment');

-- --------------------------------------------------------

--
-- Table structure for table `risk_assignments`
--

DROP TABLE IF EXISTS `risk_assignments`;
CREATE TABLE IF NOT EXISTS `risk_assignments` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `testplan_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `node_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `risk` char(1) NOT NULL DEFAULT '2',
  `importance` char(1) NOT NULL DEFAULT 'M',
  PRIMARY KEY (`id`),
  UNIQUE KEY `risk_assignments_tplan_node_id` (`testplan_id`,`node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `description` varchar(100) NOT NULL DEFAULT '',
  `notes` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_rights_roles_descr` (`description`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `description`, `notes`) VALUES
(1, '<reserved system role 1>', NULL),
(2, '<reserved system role 2>', NULL),
(3, '<no rights>', NULL),
(4, 'test designer', NULL),
(5, 'guest', NULL),
(6, 'senior tester', NULL),
(7, 'tester', NULL),
(8, 'admin', NULL),
(9, 'leader', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `role_rights`
--

DROP TABLE IF EXISTS `role_rights`;
CREATE TABLE IF NOT EXISTS `role_rights` (
  `role_id` int(10) NOT NULL DEFAULT '0',
  `right_id` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`role_id`,`right_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `role_rights`
--

INSERT INTO `role_rights` (`role_id`, `right_id`) VALUES
(4, 3),
(4, 6),
(4, 7),
(4, 8),
(4, 9),
(4, 10),
(4, 11),
(4, 28),
(4, 29),
(4, 30),
(4, 50),
(5, 3),
(5, 6),
(5, 8),
(6, 1),
(6, 2),
(6, 3),
(6, 6),
(6, 7),
(6, 8),
(6, 9),
(6, 11),
(6, 25),
(6, 27),
(6, 28),
(6, 29),
(6, 30),
(6, 50),
(7, 1),
(7, 3),
(7, 6),
(7, 8),
(8, 1),
(8, 2),
(8, 3),
(8, 4),
(8, 5),
(8, 6),
(8, 7),
(8, 8),
(8, 9),
(8, 10),
(8, 11),
(8, 12),
(8, 13),
(8, 14),
(8, 15),
(8, 16),
(8, 17),
(8, 18),
(8, 19),
(8, 20),
(8, 21),
(8, 22),
(8, 23),
(8, 24),
(8, 25),
(8, 26),
(8, 27),
(8, 28),
(8, 29),
(8, 30),
(8, 31),
(8, 32),
(8, 33),
(8, 34),
(8, 35),
(8, 36),
(8, 37),
(8, 38),
(8, 39),
(8, 40),
(8, 41),
(8, 42),
(8, 43),
(8, 44),
(8, 45),
(8, 46),
(8, 47),
(8, 48),
(8, 50),
(8, 51),
(8, 52),
(8, 53),
(8, 54),
(9, 1),
(9, 2),
(9, 3),
(9, 4),
(9, 5),
(9, 6),
(9, 7),
(9, 8),
(9, 9),
(9, 10),
(9, 11),
(9, 15),
(9, 16),
(9, 24),
(9, 25),
(9, 26),
(9, 27),
(9, 28),
(9, 29),
(9, 30),
(9, 47),
(9, 50);

-- --------------------------------------------------------

--
-- Table structure for table `tcsteps`
--

DROP TABLE IF EXISTS `tcsteps`;
CREATE TABLE IF NOT EXISTS `tcsteps` (
  `id` int(10) UNSIGNED NOT NULL,
  `step_number` int(11) NOT NULL DEFAULT '1',
  `actions` text,
  `expected_results` text,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `execution_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 -> manual, 2 -> automated',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tcsteps`
--

INSERT INTO `tcsteps` (`id`, `step_number`, `actions`, `expected_results`, `active`, `execution_type`) VALUES
(6, 1, '<p>verify reconcilation with cbe/deposit<br />\r\n&nbsp;</p>\r\n', '<p>Transaction available on ledger</p>\r\n', 1, 1),
(7, 3, '<p>verify reconcilation with cbe/refund pending trnx</p>\r\n', '<p>refunded transaction with refund/transaction id should be available on admin transaction page</p>\r\n', 1, 1),
(8, 4, '<p>clearing a refunded trnx to add to ledger</p>\r\n', '<p>Transaction added to ledger</p>\r\n', 1, 1),
(12, 1, '<p>verify reconcilation with Mpesa/deposit</p>\r\n', '<p>Transaction available on merchant and admin ledger</p>\r\n', 1, 1),
(13, 2, '<p>verify reconcilation with Mpesa/refund pending trnx</p>\r\n', '<p>Transaction available in admin transaction page</p>\r\n', 1, 1),
(18, 1, '<p>verify matched transactions &nbsp;mpesa and cbebirr on ledger</p>\r\n', '', 1, 1),
(19, 2, '<p>verify matched transactions&nbsp;mpesa and cbebirr on admin ledger</p>\r\n', '', 1, 1),
(20, 3, '<p>verify reconciled transactions &nbsp;mpesa and cbebirr on ledger</p>\r\n', '', 1, 1),
(24, 1, '<p>verify bank lists on add bank are registered on admin FSD bankaccount&nbsp;</p>\r\n', '', 1, 1),
(25, 2, '<p>verify bank approval</p>\r\n', '', 1, 1),
(28, 1, '<p>verify refunding request from ledger returns success</p>\r\n', '', 1, 1),
(29, 2, '<p>verify refund request sent to admin</p>\r\n', '', 1, 1),
(30, 3, '<p>verify approving refund request works and it adds transaction entry</p>\r\n', '', 1, 1),
(33, 1, '<p>process the withdrawal request sent,and notification recieved</p>\r\n', '', 1, 1),
(34, 2, '<p>add withdrawal request</p>\r\n', '', 1, 1),
(35, 3, '<p>verify add setelment after withdrawal request</p>\r\n', '', 1, 1),
(36, 4, '<p>verify settelment request processed successfuly and approved</p>\r\n', '', 1, 1),
(37, 5, '<p>verify notification sent to merchant on successful settelment</p>\r\n', '', 1, 1),
(46, 1, '<p>verify transaction paid with escrow generats recipt</p>\r\n', '<p>reciept available and able to display</p>\r\n', 1, 1),
(47, 2, '<p>verify transations paid with escrow are available on escrow service</p>\r\n', '<p>transaction page shows escrow transaction</p>\r\n', 1, 1),
(50, 1, '<p>Verify&nbsp;Rate limiting on consumer app</p>\r\n', '<p>request limited on specified threshold</p>\r\n', 1, 1),
(51, 2, '<p>account lock on 3 times incorrect credential</p>\r\n', '<p>account locked message</p>\r\n', 1, 1),
(59, 1, '<p>Create a valid event with title, date, price, and ticket type</p>\r\n', '', 1, 1),
(60, 2, '<p>Create an event with multiple ticket types (VIP, Standard)</p>\r\n', '', 1, 1),
(61, 3, '<p>Create event with optional fields (e.g., description, banner image)</p>\r\n', '', 1, 1),
(62, 4, '<p>Validate that the event link is generated successfully and is unique</p>\r\n', '', 1, 1),
(63, 5, '<p>Validate proper HTTP status (201 Created) and response schema</p>\r\n', '', 1, 1),
(67, 1, '<p>Update event name, date, and price successfully</p>\r\n', '', 1, 1),
(68, 2, '<p>Add new ticket types to an existing event</p>\r\n', '', 1, 1),
(69, 3, '<p>Remove a ticket type and validate response</p>\r\n', '', 1, 1),
(70, 4, '<p>Validate correct HTTP status (200 OK) and data integrity post-update</p>\r\n', '', 1, 1),
(73, 1, '<p>Make a valid payment using test card/token</p>\r\n', '', 1, 1),
(74, 2, '<p>Receive 200 response with payment ID and redirect to payment gateway</p>\r\n', '', 1, 1),
(75, 3, '<p>Validate callback updates payment status to &ldquo;PAID&rdquo;</p>\r\n', '', 1, 1),
(76, 4, '<p>Track payment via /payments/{id} endpoint and verify status = PAID</p>\r\n', '', 1, 1),
(77, 5, '<p>Create attendee record only after successful payment callback</p>\r\n', '', 1, 1),
(80, 1, '<p>Merchant initiates full refund for a successful payment</p>\r\n', '', 1, 1),
(81, 2, '<p>Refund status updates correctly in the system (REFUNDED)</p>\r\n', '', 1, 1),
(82, 3, '<p>User gets notified of refund via webhook or callback</p>\r\n', '', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tcversions`
--

DROP TABLE IF EXISTS `tcversions`;
CREATE TABLE IF NOT EXISTS `tcversions` (
  `id` int(10) UNSIGNED NOT NULL,
  `tc_external_id` int(10) UNSIGNED DEFAULT NULL,
  `version` smallint(5) UNSIGNED NOT NULL DEFAULT '1',
  `layout` smallint(5) UNSIGNED NOT NULL DEFAULT '1',
  `status` smallint(5) UNSIGNED NOT NULL DEFAULT '1',
  `summary` text,
  `preconditions` text,
  `importance` smallint(5) UNSIGNED NOT NULL DEFAULT '2',
  `author_id` int(10) UNSIGNED DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater_id` int(10) UNSIGNED DEFAULT NULL,
  `modification_ts` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `is_open` tinyint(1) NOT NULL DEFAULT '1',
  `execution_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 -> manual, 2 -> automated',
  `estimated_exec_duration` decimal(6,2) DEFAULT NULL COMMENT 'NULL will be considered as NO DATA Provided by user',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tcversions`
--

INSERT INTO `tcversions` (`id`, `tc_external_id`, `version`, `layout`, `status`, `summary`, `preconditions`, `importance`, `author_id`, `creation_ts`, `updater_id`, `modification_ts`, `active`, `is_open`, `execution_type`, `estimated_exec_duration`) VALUES
(5, 1, 1, 1, 1, '<p>reconcilation with cbe- acceptance criteria as on user story</p>\r\n', '<p>1, Transaction with cbe made</p>\r\n\r\n<p>2, successful clearing has been made</p>\r\n', 2, 1, '2025-05-22 06:28:21', 1, '2025-05-22 12:11:31', 1, 1, 1, NULL),
(11, 2, 1, 1, 1, '<p>this is to verify reconcilation of transactions with mpessa</p>\r\n\r\n<p>the acceptance crieteria has to be fullfilled</p>\r\n', '<p>successful clearing has been made with cbe</p>\r\n', 2, 1, '2025-05-22 06:56:45', 1, '2025-05-22 10:06:22', 1, 1, 1, NULL),
(17, 3, 1, 1, 1, '<p>Verify cleared transactions on merchant ledger&nbsp;</p>\r\n', '<p>transaction cleared and or reconciled</p>\r\n', 2, 1, '2025-05-22 07:07:56', 1, '2025-05-22 10:10:36', 1, 1, 1, NULL),
(23, 4, 1, 1, 1, '<p>verify change on admin , to add bank</p>\r\n', '<p>signup as merchant&nbsp;</p>\r\n\r\n<p>add bank&nbsp;</p>\r\n', 2, 1, '2025-05-22 07:13:23', 1, '2025-05-22 10:13:52', 1, 1, 1, NULL),
(27, 5, 1, 1, 1, '<p>verify refund end to end with&nbsp;Telebir and cbe</p>\r\n', '<p>success transaction available</p>\r\n', 2, 1, '2025-05-22 07:15:38', 1, '2025-05-22 10:16:32', 1, 1, 1, NULL),
(32, 6, 1, 1, 1, '<p>verify end to end settelment process</p>\r\n', '<p>transaction processed successfuly</p>\r\n\r\n<p>transaction cleared and inserted to available balance</p>\r\n\r\n<p>merchant able to request withdrawal request</p>\r\n', 2, 1, '2025-05-22 07:18:34', 1, '2025-05-22 10:20:21', 1, 1, 1, NULL),
(39, 7, 1, 1, 1, '', '', 2, 1, '2025-05-22 07:21:09', 1, '2025-05-22 10:21:47', 1, 1, 1, NULL),
(41, 8, 1, 1, 1, '', '', 2, 1, '2025-05-22 07:22:00', NULL, '2025-05-22 13:22:00', 1, 1, 1, NULL),
(43, 9, 1, 1, 1, '<p>successful Top up operation</p>\r\n', '<p>consumer app available and sign in required</p>\r\n', 2, 1, '2025-05-22 07:23:27', NULL, '2025-05-22 13:23:27', 1, 1, 1, NULL),
(45, 10, 1, 1, 1, '<p>verify reciept is available on successful escrow payment</p>\r\n', '<p>consumer app available</p>\r\n\r\n<p>customer successfully pay using escrow service</p>\r\n', 2, 1, '2025-05-22 07:25:09', 1, '2025-05-22 10:26:34', 1, 1, 1, NULL),
(49, 11, 1, 1, 1, '<p>Verify Rate limiting on login and other api requests</p>\r\n', '<p>consumer app available and able to sign in.</p>\r\n', 2, 1, '2025-05-22 07:27:37', 1, '2025-05-23 09:59:21', 1, 1, 1, NULL),
(54, 12, 1, 1, 1, '<p>verify consumer app account locked on three times credential retry</p>\r\n', '<p>access to the portal.</p>\r\n', 2, 1, '2025-05-23 07:01:14', NULL, '2025-05-23 13:01:14', 1, 1, 1, NULL),
(58, 13, 1, 1, 1, '<p>Verify that an event can be created with valid title, date, price, and ticket types.</p>\r\n', '<ol>\r\n	<li>Merchant account login</li>\r\n	<li>Access to event creation endpoint /api/events.</li>\r\n</ol>\r\n', 2, 1, '2025-05-27 05:02:42', 1, '2025-05-27 10:01:19', 1, 1, 1, NULL),
(66, 14, 1, 1, 1, '', '', 2, 1, '2025-05-27 05:07:02', 1, '2025-05-27 08:08:15', 1, 1, 1, NULL),
(72, 15, 1, 1, 1, '', '', 2, 1, '2025-05-27 05:08:49', 1, '2025-05-27 08:10:06', 1, 1, 1, NULL),
(79, 16, 1, 1, 1, '', '', 2, 1, '2025-05-27 05:12:06', 1, '2025-05-27 08:13:09', 1, 1, 1, NULL),
(84, 17, 1, 1, 1, '<p>create event with missing required field (e.g., event title or date)</p>\r\n', '', 2, 1, '2025-05-27 08:03:36', NULL, '2025-05-27 14:03:36', 1, 1, 1, NULL),
(86, 18, 1, 1, 1, '<p>Invalid ticket price format (e.g., text instead of number)</p>\r\n', '', 2, 1, '2025-05-27 08:04:36', NULL, '2025-05-27 14:04:36', 1, 1, 1, NULL);

-- --------------------------------------------------------

--
-- Stand-in structure for view `tcversions_without_keywords`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `tcversions_without_keywords`;
CREATE TABLE IF NOT EXISTS `tcversions_without_keywords` (
`testcase_id` int(10) unsigned
,`id` int(10) unsigned
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `tcversions_without_platforms`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `tcversions_without_platforms`;
CREATE TABLE IF NOT EXISTS `tcversions_without_platforms` (
`testcase_id` int(10) unsigned
,`id` int(10) unsigned
);

-- --------------------------------------------------------

--
-- Table structure for table `testcase_keywords`
--

DROP TABLE IF EXISTS `testcase_keywords`;
CREATE TABLE IF NOT EXISTS `testcase_keywords` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `testcase_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `tcversion_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `keyword_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx01_testcase_keywords` (`testcase_id`,`tcversion_id`,`keyword_id`),
  KEY `idx02_testcase_keywords` (`tcversion_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `testcase_platforms`
--

DROP TABLE IF EXISTS `testcase_platforms`;
CREATE TABLE IF NOT EXISTS `testcase_platforms` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `testcase_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `tcversion_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `platform_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx01_testcase_platform` (`testcase_id`,`tcversion_id`,`platform_id`),
  KEY `idx02_testcase_platform` (`tcversion_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `testcase_relations`
--

DROP TABLE IF EXISTS `testcase_relations`;
CREATE TABLE IF NOT EXISTS `testcase_relations` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `source_id` int(10) UNSIGNED NOT NULL,
  `destination_id` int(10) UNSIGNED NOT NULL,
  `link_status` tinyint(1) NOT NULL DEFAULT '1',
  `relation_type` smallint(5) UNSIGNED NOT NULL DEFAULT '1',
  `author_id` int(10) UNSIGNED DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `testcase_script_links`
--

DROP TABLE IF EXISTS `testcase_script_links`;
CREATE TABLE IF NOT EXISTS `testcase_script_links` (
  `tcversion_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `project_key` varchar(64) NOT NULL,
  `repository_name` varchar(64) NOT NULL,
  `code_path` varchar(255) NOT NULL,
  `branch_name` varchar(64) DEFAULT NULL,
  `commit_id` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`tcversion_id`,`project_key`,`repository_name`,`code_path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `testplans`
--

DROP TABLE IF EXISTS `testplans`;
CREATE TABLE IF NOT EXISTS `testplans` (
  `id` int(10) UNSIGNED NOT NULL,
  `testproject_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `notes` text,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `is_open` tinyint(1) NOT NULL DEFAULT '1',
  `is_public` tinyint(1) NOT NULL DEFAULT '1',
  `api_key` varchar(64) NOT NULL DEFAULT '829a2ded3ed0829a2dedd8ab81dfa2c77e8235bc3ed0d8ab81dfa2c77e8235bc',
  PRIMARY KEY (`id`),
  UNIQUE KEY `testplans_api_key` (`api_key`),
  KEY `testplans_testproject_id_active` (`testproject_id`,`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `testplans`
--

INSERT INTO `testplans` (`id`, `testproject_id`, `notes`, `active`, `is_open`, `is_public`, `api_key`) VALUES
(2, 1, '<p>Test Plan R1 Finalization stage&nbsp;</p>', 1, 1, 1, '833ad5cc7144816a35f5de537b1b1a4bf1f85d11f9f55097a10308b66de6e4a9');

-- --------------------------------------------------------

--
-- Table structure for table `testplan_platforms`
--

DROP TABLE IF EXISTS `testplan_platforms`;
CREATE TABLE IF NOT EXISTS `testplan_platforms` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `testplan_id` int(10) UNSIGNED NOT NULL,
  `platform_id` int(10) UNSIGNED NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_testplan_platforms` (`testplan_id`,`platform_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Connects a testplan with platforms';

-- --------------------------------------------------------

--
-- Table structure for table `testplan_tcversions`
--

DROP TABLE IF EXISTS `testplan_tcversions`;
CREATE TABLE IF NOT EXISTS `testplan_tcversions` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `testplan_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `tcversion_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `node_order` int(10) UNSIGNED NOT NULL DEFAULT '1',
  `urgency` smallint(5) NOT NULL DEFAULT '2',
  `platform_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `author_id` int(10) UNSIGNED DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `testplan_tcversions_tplan_tcversion` (`testplan_id`,`tcversion_id`,`platform_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `testplan_tcversions`
--

INSERT INTO `testplan_tcversions` (`id`, `testplan_id`, `tcversion_id`, `node_order`, `urgency`, `platform_id`, `author_id`, `creation_ts`) VALUES
(1, 2, 5, 10000, 2, 0, 1, '2025-05-23 03:29:46'),
(2, 2, 11, 10010, 2, 0, 1, '2025-05-23 03:32:39'),
(3, 2, 58, 10000, 2, 0, 1, '2025-05-27 08:08:20'),
(4, 2, 66, 10010, 2, 0, 1, '2025-05-27 08:08:20'),
(5, 2, 72, 10020, 2, 0, 1, '2025-05-27 08:08:20'),
(6, 2, 79, 10030, 2, 0, 1, '2025-05-27 08:08:20'),
(7, 2, 84, 10040, 2, 0, 1, '2025-05-27 08:08:20'),
(8, 2, 86, 10050, 2, 0, 1, '2025-05-27 08:08:20');

-- --------------------------------------------------------

--
-- Table structure for table `testprojects`
--

DROP TABLE IF EXISTS `testprojects`;
CREATE TABLE IF NOT EXISTS `testprojects` (
  `id` int(10) UNSIGNED NOT NULL,
  `notes` text,
  `color` varchar(12) NOT NULL DEFAULT '#9BD',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `option_reqs` tinyint(1) NOT NULL DEFAULT '0',
  `option_priority` tinyint(1) NOT NULL DEFAULT '0',
  `option_automation` tinyint(1) NOT NULL DEFAULT '0',
  `options` text,
  `prefix` varchar(16) NOT NULL,
  `tc_counter` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `is_public` tinyint(1) NOT NULL DEFAULT '1',
  `issue_tracker_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `code_tracker_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `reqmgr_integration_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `api_key` varchar(64) NOT NULL DEFAULT '0d8ab81dfa2c77e8235bc829a2ded3edfa2c78235bc829a27eded3ed0d8ab81d',
  PRIMARY KEY (`id`),
  UNIQUE KEY `testprojects_prefix` (`prefix`),
  UNIQUE KEY `testprojects_api_key` (`api_key`),
  KEY `testprojects_id_active` (`id`,`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `testprojects`
--

INSERT INTO `testprojects` (`id`, `notes`, `color`, `active`, `option_reqs`, `option_priority`, `option_automation`, `options`, `prefix`, `tc_counter`, `is_public`, `issue_tracker_enabled`, `code_tracker_enabled`, `reqmgr_integration_enabled`, `api_key`) VALUES
(1, '<p>This is to include Release1 finalization for test</p>', '', 1, 0, 0, 0, 'O:8:\"stdClass\":4:{s:19:\"requirementsEnabled\";i:1;s:19:\"testPriorityEnabled\";i:1;s:17:\"automationEnabled\";i:1;s:16:\"inventoryEnabled\";i:1;}', 'TC', 18, 1, 0, 0, 0, '8ac6aca34147d6fc9642b8260535530a848452436c9c21c752f005a60f4ce159');

-- --------------------------------------------------------

--
-- Table structure for table `testproject_codetracker`
--

DROP TABLE IF EXISTS `testproject_codetracker`;
CREATE TABLE IF NOT EXISTS `testproject_codetracker` (
  `testproject_id` int(10) UNSIGNED NOT NULL,
  `codetracker_id` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`testproject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `testproject_issuetracker`
--

DROP TABLE IF EXISTS `testproject_issuetracker`;
CREATE TABLE IF NOT EXISTS `testproject_issuetracker` (
  `testproject_id` int(10) UNSIGNED NOT NULL,
  `issuetracker_id` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`testproject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `testproject_reqmgrsystem`
--

DROP TABLE IF EXISTS `testproject_reqmgrsystem`;
CREATE TABLE IF NOT EXISTS `testproject_reqmgrsystem` (
  `testproject_id` int(10) UNSIGNED NOT NULL,
  `reqmgrsystem_id` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`testproject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `testsuites`
--

DROP TABLE IF EXISTS `testsuites`;
CREATE TABLE IF NOT EXISTS `testsuites` (
  `id` int(10) UNSIGNED NOT NULL,
  `details` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `testsuites`
--

INSERT INTO `testsuites` (`id`, `details`) VALUES
(3, '<p>This testsuit contains testcases for&nbsp;verification of&nbsp;reconcilation with deposite and refund options.</p>\r\n'),
(52, ''),
(55, '<p>verify b2c with cbe and awash</p>\r\n'),
(56, '');

-- --------------------------------------------------------

--
-- Table structure for table `text_templates`
--

DROP TABLE IF EXISTS `text_templates`;
CREATE TABLE IF NOT EXISTS `text_templates` (
  `id` int(10) UNSIGNED NOT NULL,
  `type` smallint(5) UNSIGNED NOT NULL,
  `title` varchar(100) NOT NULL,
  `template_data` text,
  `author_id` int(10) UNSIGNED DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_public` tinyint(1) NOT NULL DEFAULT '0',
  UNIQUE KEY `idx_text_templates` (`type`,`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Global Project Templates';

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
CREATE TABLE IF NOT EXISTS `transactions` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `entry_point` varchar(45) NOT NULL DEFAULT '',
  `start_time` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `end_time` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `session_id` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=178 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `entry_point`, `start_time`, `end_time`, `user_id`, `session_id`) VALUES
(1, '/testlink2/login.php', 1747144716, 1747144716, 1, 'cf0973d195a351302885ec616c8da905'),
(2, '/testlink2/login.php', 1747898470, 1747898470, 1, '4f100edac080598ed49401f604e7c5fb'),
(3, '/testlink2/lib/project/projectEdit.php', 1747898547, 1747898548, 1, '4f100edac080598ed49401f604e7c5fb'),
(4, '/testlink2/lib/project/projectView.php', 1747900279, 1747900279, 1, '4f100edac080598ed49401f604e7c5fb'),
(5, '/testlink2/lib/project/projectView.php', 1747900310, 1747900310, 1, '4f100edac080598ed49401f604e7c5fb'),
(6, '/testlink2/lib/project/projectEdit.php', 1747900497, 1747900497, 1, '4f100edac080598ed49401f604e7c5fb'),
(7, '/testlink2/lib/plan/planEdit.php', 1747900582, 1747900582, 1, '4f100edac080598ed49401f604e7c5fb'),
(8, '/testlink2/lib/plan/planEdit.php', 1747900644, 1747900644, 1, '4f100edac080598ed49401f604e7c5fb'),
(9, '/testlink2/lib/plan/buildView.php', 1747900785, 1747900786, 1, '4f100edac080598ed49401f604e7c5fb'),
(10, '/testlink2/lib/plan/buildEdit.php', 1747901961, 1747901962, 1, '4f100edac080598ed49401f604e7c5fb'),
(11, '/testlink2/lib/testcases/tcEdit.php', 1747905481, 1747905482, 1, '4f100edac080598ed49401f604e7c5fb'),
(12, '/testlink2/lib/testcases/tcEdit.php', 1747906100, 1747906103, 1, '4f100edac080598ed49401f604e7c5fb'),
(13, '/testlink2/lib/testcases/tcEdit.php', 1747906118, 1747906118, 1, '4f100edac080598ed49401f604e7c5fb'),
(14, '/testlink2/lib/testcases/tcEdit.php', 1747906234, 1747906235, 1, '4f100edac080598ed49401f604e7c5fb'),
(15, '/testlink2/lib/testcases/tcEdit.php', 1747906444, 1747906444, 1, '4f100edac080598ed49401f604e7c5fb'),
(16, '/testlink2/lib/testcases/tcEdit.php', 1747906574, 1747906574, 1, '4f100edac080598ed49401f604e7c5fb'),
(17, '/testlink2/lib/testcases/tcEdit.php', 1747906644, 1747906644, 1, '4f100edac080598ed49401f604e7c5fb'),
(18, '/testlink2/lib/testcases/tcEdit.php', 1747906651, 1747906652, 1, '4f100edac080598ed49401f604e7c5fb'),
(19, '/testlink2/lib/testcases/tcEdit.php', 1747906671, 1747906671, 1, '4f100edac080598ed49401f604e7c5fb'),
(20, '/testlink2/lib/testcases/tcAssign2Tplan.php', 1747906970, 1747906970, 1, '4f100edac080598ed49401f604e7c5fb'),
(21, '/testlink2/lib/testcases/tcAssign2Tplan.php', 1747907117, 1747907117, 1, '4f100edac080598ed49401f604e7c5fb'),
(22, '/testlink2/lib/testcases/tcAssign2Tplan.php', 1747907173, 1747907173, 1, '4f100edac080598ed49401f604e7c5fb'),
(23, '/testlink2/lib/testcases/tcAssign2Tplan.php', 1747907229, 1747907229, 1, '4f100edac080598ed49401f604e7c5fb'),
(24, '/testlink2/lib/plan/planEdit.php', 1747907308, 1747907308, 1, '4f100edac080598ed49401f604e7c5fb'),
(25, '/testlink2/lib/testcases/tcAssign2Tplan.php', 1747907347, 1747907347, 1, '4f100edac080598ed49401f604e7c5fb'),
(26, '/testlink2/lib/testcases/tcAssign2Tplan.php', 1747907392, 1747907392, 1, '4f100edac080598ed49401f604e7c5fb'),
(27, '/testlink2/lib/testcases/tcAssign2Tplan.php', 1747907435, 1747907436, 1, '4f100edac080598ed49401f604e7c5fb'),
(28, '/testlink2/lib/testcases/tcAssign2Tplan.php', 1747907454, 1747907455, 1, '4f100edac080598ed49401f604e7c5fb'),
(29, '/testlink2/lib/testcases/tcEdit.php', 1747907670, 1747907670, 1, '4f100edac080598ed49401f604e7c5fb'),
(30, '/testlink2/lib/testcases/tcEdit.php', 1747907805, 1747907805, 1, '4f100edac080598ed49401f604e7c5fb'),
(31, '/testlink2/lib/testcases/tcEdit.php', 1747907816, 1747907817, 1, '4f100edac080598ed49401f604e7c5fb'),
(32, '/testlink2/lib/testcases/tcEdit.php', 1747907853, 1747907853, 1, '4f100edac080598ed49401f604e7c5fb'),
(33, '/testlink2/lib/testcases/tcEdit.php', 1747908356, 1747908356, 1, '4f100edac080598ed49401f604e7c5fb'),
(34, '/testlink2/lib/testcases/tcEdit.php', 1747908368, 1747908368, 1, '4f100edac080598ed49401f604e7c5fb'),
(35, '/testlink2/lib/testcases/tcEdit.php', 1747908379, 1747908379, 1, '4f100edac080598ed49401f604e7c5fb'),
(36, '/testlink2/lib/testcases/tcEdit.php', 1747908382, 1747908383, 1, '4f100edac080598ed49401f604e7c5fb'),
(37, '/testlink2/lib/testcases/tcEdit.php', 1747908419, 1747908419, 1, '4f100edac080598ed49401f604e7c5fb'),
(38, '/testlink2/lib/testcases/tcEdit.php', 1747908476, 1747908477, 1, '4f100edac080598ed49401f604e7c5fb'),
(39, '/testlink2/lib/testcases/tcEdit.php', 1747908552, 1747908552, 1, '4f100edac080598ed49401f604e7c5fb'),
(40, '/testlink2/lib/testcases/tcEdit.php', 1747908578, 1747908579, 1, '4f100edac080598ed49401f604e7c5fb'),
(41, '/testlink2/lib/testcases/tcEdit.php', 1747908602, 1747908602, 1, '4f100edac080598ed49401f604e7c5fb'),
(42, '/testlink2/lib/testcases/tcEdit.php', 1747908621, 1747908621, 1, '4f100edac080598ed49401f604e7c5fb'),
(43, '/testlink2/lib/testcases/tcEdit.php', 1747908636, 1747908637, 1, '4f100edac080598ed49401f604e7c5fb'),
(44, '/testlink2/lib/testcases/tcEdit.php', 1747908684, 1747908685, 1, '4f100edac080598ed49401f604e7c5fb'),
(45, '/testlink2/lib/testcases/tcEdit.php', 1747908803, 1747908804, 1, '4f100edac080598ed49401f604e7c5fb'),
(46, '/testlink2/lib/testcases/tcEdit.php', 1747908807, 1747908807, 1, '4f100edac080598ed49401f604e7c5fb'),
(47, '/testlink2/lib/testcases/tcEdit.php', 1747908821, 1747908821, 1, '4f100edac080598ed49401f604e7c5fb'),
(48, '/testlink2/lib/testcases/tcEdit.php', 1747908864, 1747908864, 1, '4f100edac080598ed49401f604e7c5fb'),
(49, '/testlink2/lib/testcases/tcEdit.php', 1747908938, 1747908939, 1, '4f100edac080598ed49401f604e7c5fb'),
(50, '/testlink2/lib/testcases/tcEdit.php', 1747908963, 1747908963, 1, '4f100edac080598ed49401f604e7c5fb'),
(51, '/testlink2/lib/testcases/tcEdit.php', 1747908972, 1747908972, 1, '4f100edac080598ed49401f604e7c5fb'),
(52, '/testlink2/lib/testcases/tcEdit.php', 1747908982, 1747908982, 1, '4f100edac080598ed49401f604e7c5fb'),
(53, '/testlink2/lib/testcases/tcEdit.php', 1747909012, 1747909012, 1, '4f100edac080598ed49401f604e7c5fb'),
(54, '/testlink2/lib/testcases/tcEdit.php', 1747909114, 1747909114, 1, '4f100edac080598ed49401f604e7c5fb'),
(55, '/testlink2/lib/testcases/tcEdit.php', 1747909118, 1747909119, 1, '4f100edac080598ed49401f604e7c5fb'),
(56, '/testlink2/lib/testcases/tcEdit.php', 1747909133, 1747909133, 1, '4f100edac080598ed49401f604e7c5fb'),
(57, '/testlink2/lib/testcases/tcEdit.php', 1747909152, 1747909152, 1, '4f100edac080598ed49401f604e7c5fb'),
(58, '/testlink2/lib/testcases/tcEdit.php', 1747909155, 1747909156, 1, '4f100edac080598ed49401f604e7c5fb'),
(59, '/testlink2/lib/testcases/tcEdit.php', 1747909196, 1747909196, 1, '4f100edac080598ed49401f604e7c5fb'),
(60, '/testlink2/lib/testcases/tcEdit.php', 1747909250, 1747909250, 1, '4f100edac080598ed49401f604e7c5fb'),
(61, '/testlink2/lib/testcases/tcEdit.php', 1747909269, 1747909269, 1, '4f100edac080598ed49401f604e7c5fb'),
(62, '/testlink2/lib/testcases/tcEdit.php', 1747909312, 1747909312, 1, '4f100edac080598ed49401f604e7c5fb'),
(63, '/testlink2/lib/testcases/tcEdit.php', 1747909320, 1747909320, 1, '4f100edac080598ed49401f604e7c5fb'),
(64, '/testlink2/lib/testcases/tcEdit.php', 1747909361, 1747909361, 1, '4f100edac080598ed49401f604e7c5fb'),
(65, '/testlink2/lib/testcases/tcEdit.php', 1747909407, 1747909407, 1, '4f100edac080598ed49401f604e7c5fb'),
(66, '/testlink2/lib/testcases/tcEdit.php', 1747909422, 1747909422, 1, '4f100edac080598ed49401f604e7c5fb'),
(67, '/testlink2/lib/testcases/tcEdit.php', 1747909509, 1747909509, 1, '4f100edac080598ed49401f604e7c5fb'),
(68, '/testlink2/lib/testcases/tcEdit.php', 1747909521, 1747909522, 1, '4f100edac080598ed49401f604e7c5fb'),
(69, '/testlink2/lib/testcases/tcEdit.php', 1747909549, 1747909549, 1, '4f100edac080598ed49401f604e7c5fb'),
(70, '/testlink2/lib/testcases/tcEdit.php', 1747909608, 1747909609, 1, '4f100edac080598ed49401f604e7c5fb'),
(71, '/testlink2/lib/testcases/tcEdit.php', 1747909657, 1747909657, 1, '4f100edac080598ed49401f604e7c5fb'),
(72, '/testlink2/lib/testcases/tcEdit.php', 1747909663, 1747909663, 1, '4f100edac080598ed49401f604e7c5fb'),
(73, '/testlink2/lib/testcases/tcEdit.php', 1747909700, 1747909700, 1, '4f100edac080598ed49401f604e7c5fb'),
(74, '/testlink2/lib/testcases/tcEdit.php', 1747915043, 1747915044, 1, '4f100edac080598ed49401f604e7c5fb'),
(75, '/testlink2/lib/testcases/tcEdit.php', 1747915890, 1747915891, 1, '4f100edac080598ed49401f604e7c5fb'),
(76, '/testlink2/lib/project/projectView.php', 1747916372, 1747916372, 1, '4f100edac080598ed49401f604e7c5fb'),
(77, '/testlink2/lib/project/projectEdit.php', 1747916383, 1747916383, 1, '4f100edac080598ed49401f604e7c5fb'),
(78, '/testlink2/lib/testcases/tcAssign2Tplan.php', 1747916488, 1747916488, 1, '4f100edac080598ed49401f604e7c5fb'),
(79, '/testlink2/lib/testcases/tcAssign2Tplan.php', 1747916536, 1747916536, 1, '4f100edac080598ed49401f604e7c5fb'),
(80, '/testlink2/lib/testcases/tcAssign2Tplan.php', 1747916569, 1747916569, 1, '4f100edac080598ed49401f604e7c5fb'),
(81, '/testlink2/logout.php', 1747916606, 1747916606, 1, '4f100edac080598ed49401f604e7c5fb'),
(82, '/testlink2/login.php', 1747916615, 1747916615, 1, '4f100edac080598ed49401f604e7c5fb'),
(83, '/testlink2/lib/plan/planEdit.php', 1747916629, 1747916629, 1, '4f100edac080598ed49401f604e7c5fb'),
(84, '/testlink2/lib/plan/planEdit.php', 1747916746, 1747916746, 1, '4f100edac080598ed49401f604e7c5fb'),
(85, '/testlink2/lib/plan/planEdit.php', 1747916769, 1747916770, 1, '4f100edac080598ed49401f604e7c5fb'),
(86, '/testlink2/lib/project/projectView.php', 1747917167, 1747917167, 1, '4f100edac080598ed49401f604e7c5fb'),
(87, '/testlink2/lib/project/projectEdit.php', 1747917188, 1747917188, 1, '4f100edac080598ed49401f604e7c5fb'),
(88, '/testlink2/lib/testcases/tcAssign2Tplan.php', 1747917202, 1747917202, 1, '4f100edac080598ed49401f604e7c5fb'),
(89, '/testlink2/lib/project/projectView.php', 1747917628, 1747917628, 1, '4f100edac080598ed49401f604e7c5fb'),
(90, '/testlink2/lib/project/projectEdit.php', 1747917638, 1747917638, 1, '4f100edac080598ed49401f604e7c5fb'),
(91, '/testlink2/lib/project/projectView.php', 1747917691, 1747917691, 1, '4f100edac080598ed49401f604e7c5fb'),
(92, '/testlink2/lib/plan/planEdit.php', 1747918180, 1747918180, 1, '4f100edac080598ed49401f604e7c5fb'),
(93, '/testlink2/lib/plan/buildEdit.php', 1747918498, 1747918498, 1, '4f100edac080598ed49401f604e7c5fb'),
(94, '/testlink2/lib/plan/planEdit.php', 1747918835, 1747918835, 1, '4f100edac080598ed49401f604e7c5fb'),
(95, '/testlink2/lib/plan/planEdit.php', 1747918848, 1747918848, 1, '4f100edac080598ed49401f604e7c5fb'),
(96, '/testlink2/lib/project/projectView.php', 1747918901, 1747918902, 1, '4f100edac080598ed49401f604e7c5fb'),
(97, '/testlink2/lib/project/projectEdit.php', 1747918926, 1747918926, 1, '4f100edac080598ed49401f604e7c5fb'),
(98, '/testlink2/lib/testcases/tcAssign2Tplan.php', 1747919215, 1747919215, 1, '4f100edac080598ed49401f604e7c5fb'),
(99, '/testlink2/lib/plan/planEdit.php', 1747919384, 1747919384, 1, '4f100edac080598ed49401f604e7c5fb'),
(100, '/testlink2/lib/plan/planEdit.php', 1747919514, 1747919514, 1, '4f100edac080598ed49401f604e7c5fb'),
(101, '/testlink2/lib/plan/planEdit.php', 1747919517, 1747919518, 1, '4f100edac080598ed49401f604e7c5fb'),
(102, '/testlink2/lib/plan/planEdit.php', 1747919535, 1747919535, 1, '4f100edac080598ed49401f604e7c5fb'),
(103, '/testlink2/lib/plan/buildEdit.php', 1747919680, 1747919680, 1, '4f100edac080598ed49401f604e7c5fb'),
(104, '/testlink2/lib/plan/buildEdit.php', 1747919682, 1747919682, 1, '4f100edac080598ed49401f604e7c5fb'),
(105, '/testlink2/lib/plan/buildEdit.php', 1747919689, 1747919690, 1, '4f100edac080598ed49401f604e7c5fb'),
(106, '/testlink2/lib/plan/buildEdit.php', 1747919691, 1747919691, 1, '4f100edac080598ed49401f604e7c5fb'),
(107, '/testlink2/lib/plan/planEdit.php', 1747920070, 1747920071, 1, '4f100edac080598ed49401f604e7c5fb'),
(108, '/testlink2/lib/project/projectView.php', 1747921701, 1747921701, 1, '4f100edac080598ed49401f604e7c5fb'),
(109, '/testlink2/lib/testcases/tcAssign2Tplan.php', 1747921725, 1747921725, 1, '4f100edac080598ed49401f604e7c5fb'),
(110, '/testlink2/lib/plan/buildEdit.php', 1747921764, 1747921764, 1, '4f100edac080598ed49401f604e7c5fb'),
(111, '/testlink2/lib/testcases/tcAssign2Tplan.php', 1747921811, 1747921811, 1, '4f100edac080598ed49401f604e7c5fb'),
(112, '/testlink2/lib/testcases/tcAssign2Tplan.php', 1747921822, 1747921822, 1, '4f100edac080598ed49401f604e7c5fb'),
(113, '/testlink2/login.php', 1747922001, 1747922001, 1, '55e390b3b4c5a931b4d557a7d3ae3273'),
(114, '/testlink2/lib/testcases/tcAssign2Tplan.php', 1747922022, 1747922022, 1, '55e390b3b4c5a931b4d557a7d3ae3273'),
(115, '/testlink2/lib/plan/buildEdit.php', 1747922072, 1747922072, 1, '55e390b3b4c5a931b4d557a7d3ae3273'),
(116, '/testlink2/lib/project/projectView.php', 1747922182, 1747922183, 1, '55e390b3b4c5a931b4d557a7d3ae3273'),
(117, '/testlink2/lib/testcases/tcAssign2Tplan.php', 1747922229, 1747922229, 1, '55e390b3b4c5a931b4d557a7d3ae3273'),
(118, '/testlink2/login.php', 1747980088, 1747980088, 1, '4f100edac080598ed49401f604e7c5fb'),
(119, '/testlink2/lib/testcases/tcAssign2Tplan.php', 1747980681, 1747980681, 1, '4f100edac080598ed49401f604e7c5fb'),
(120, '/testlink2/lib/plan/planAddTC.php', 1747981545, 1747981546, 1, '4f100edac080598ed49401f604e7c5fb'),
(121, '/testlink2/lib/plan/planAddTC.php', 1747981546, 1747981547, 1, '4f100edac080598ed49401f604e7c5fb'),
(122, '/testlink2/lib/plan/planAddTC.php', 1747981547, 1747981547, 1, '4f100edac080598ed49401f604e7c5fb'),
(123, '/testlink2/lib/plan/planAddTC.php', 1747981717, 1747981717, 1, '4f100edac080598ed49401f604e7c5fb'),
(124, '/testlink2/lib/plan/planAddTC.php', 1747981786, 1747981787, 1, '4f100edac080598ed49401f604e7c5fb'),
(125, '/testlink2/lib/plan/planAddTC.php', 1747981959, 1747981960, 1, '4f100edac080598ed49401f604e7c5fb'),
(126, '/testlink2/lib/plan/planEdit.php', 1747982062, 1747982062, 1, '4f100edac080598ed49401f604e7c5fb'),
(127, '/testlink2/lib/execute/execSetResults.php', 1747982451, 1747982452, 1, '4f100edac080598ed49401f604e7c5fb'),
(128, '/testlink2/lib/execute/execSetResults.php', 1747993420, 1747993421, 1, '4f100edac080598ed49401f604e7c5fb'),
(129, '/testlink2/lib/testcases/tcAssign2Tplan.php', 1747993437, 1747993437, 1, '4f100edac080598ed49401f604e7c5fb'),
(130, '/testlink2/lib/plan/planAddTC.php', 1747993507, 1747993509, 1, '4f100edac080598ed49401f604e7c5fb'),
(131, '/testlink2/lib/execute/execSetResults.php', 1747993518, 1747993519, 1, '4f100edac080598ed49401f604e7c5fb'),
(132, '/testlink2/lib/plan/planAddTC.php', 1747994188, 1747994189, 1, '4f100edac080598ed49401f604e7c5fb'),
(133, '/testlink2/lib/testcases/tcEdit.php', 1747994402, 1747994403, 1, '4f100edac080598ed49401f604e7c5fb'),
(134, '/testlink2/lib/testcases/tcEdit.php', 1747994474, 1747994474, 1, '4f100edac080598ed49401f604e7c5fb'),
(135, '/testlink2/login.php', 1748332821, 1748332821, 1, '40321b10472db4f98b5a40edfebf8de5'),
(136, '/testlink2/lib/testcases/tcEdit.php', 1748332906, 1748332907, 1, '40321b10472db4f98b5a40edfebf8de5'),
(137, '/testlink2/lib/testcases/tcEdit.php', 1748332962, 1748332965, 1, '40321b10472db4f98b5a40edfebf8de5'),
(138, '/testlink2/lib/testcases/tcEdit.php', 1748332971, 1748332971, 1, '40321b10472db4f98b5a40edfebf8de5'),
(139, '/testlink2/lib/testcases/tcEdit.php', 1748333094, 1748333094, 1, '40321b10472db4f98b5a40edfebf8de5'),
(140, '/testlink2/lib/testcases/tcEdit.php', 1748333119, 1748333119, 1, '40321b10472db4f98b5a40edfebf8de5'),
(141, '/testlink2/lib/testcases/tcEdit.php', 1748333127, 1748333127, 1, '40321b10472db4f98b5a40edfebf8de5'),
(142, '/testlink2/lib/testcases/tcEdit.php', 1748333140, 1748333140, 1, '40321b10472db4f98b5a40edfebf8de5'),
(143, '/testlink2/lib/testcases/tcEdit.php', 1748333154, 1748333154, 1, '40321b10472db4f98b5a40edfebf8de5'),
(144, '/testlink2/lib/testcases/tcEdit.php', 1748333173, 1748333173, 1, '40321b10472db4f98b5a40edfebf8de5'),
(145, '/testlink2/lib/testcases/tcEdit.php', 1748333215, 1748333215, 1, '40321b10472db4f98b5a40edfebf8de5'),
(146, '/testlink2/lib/testcases/tcEdit.php', 1748333221, 1748333222, 1, '40321b10472db4f98b5a40edfebf8de5'),
(147, '/testlink2/lib/testcases/tcEdit.php', 1748333254, 1748333254, 1, '40321b10472db4f98b5a40edfebf8de5'),
(148, '/testlink2/lib/testcases/tcEdit.php', 1748333264, 1748333264, 1, '40321b10472db4f98b5a40edfebf8de5'),
(149, '/testlink2/lib/testcases/tcEdit.php', 1748333274, 1748333274, 1, '40321b10472db4f98b5a40edfebf8de5'),
(150, '/testlink2/lib/testcases/tcEdit.php', 1748333292, 1748333292, 1, '40321b10472db4f98b5a40edfebf8de5'),
(151, '/testlink2/lib/testcases/tcEdit.php', 1748333295, 1748333296, 1, '40321b10472db4f98b5a40edfebf8de5'),
(152, '/testlink2/lib/testcases/tcEdit.php', 1748333315, 1748333315, 1, '40321b10472db4f98b5a40edfebf8de5'),
(153, '/testlink2/lib/testcases/tcEdit.php', 1748333329, 1748333329, 1, '40321b10472db4f98b5a40edfebf8de5'),
(154, '/testlink2/lib/testcases/tcEdit.php', 1748333333, 1748333333, 1, '40321b10472db4f98b5a40edfebf8de5'),
(155, '/testlink2/lib/testcases/tcEdit.php', 1748333349, 1748333349, 1, '40321b10472db4f98b5a40edfebf8de5'),
(156, '/testlink2/lib/testcases/tcEdit.php', 1748333360, 1748333360, 1, '40321b10472db4f98b5a40edfebf8de5'),
(157, '/testlink2/lib/testcases/tcEdit.php', 1748333373, 1748333373, 1, '40321b10472db4f98b5a40edfebf8de5'),
(158, '/testlink2/lib/testcases/tcEdit.php', 1748333386, 1748333386, 1, '40321b10472db4f98b5a40edfebf8de5'),
(159, '/testlink2/lib/testcases/tcEdit.php', 1748333488, 1748333489, 1, '40321b10472db4f98b5a40edfebf8de5'),
(160, '/testlink2/lib/testcases/tcEdit.php', 1748333526, 1748333526, 1, '40321b10472db4f98b5a40edfebf8de5'),
(161, '/testlink2/lib/testcases/tcEdit.php', 1748333534, 1748333535, 1, '40321b10472db4f98b5a40edfebf8de5'),
(162, '/testlink2/lib/testcases/tcEdit.php', 1748333550, 1748333550, 1, '40321b10472db4f98b5a40edfebf8de5'),
(163, '/testlink2/lib/testcases/tcEdit.php', 1748333560, 1748333561, 1, '40321b10472db4f98b5a40edfebf8de5'),
(164, '/testlink2/lib/testcases/tcEdit.php', 1748343777, 1748343778, 1, '40321b10472db4f98b5a40edfebf8de5'),
(165, '/testlink2/lib/testcases/tcEdit.php', 1748343815, 1748343816, 1, '40321b10472db4f98b5a40edfebf8de5'),
(166, '/testlink2/lib/testcases/tcEdit.php', 1748343822, 1748343822, 1, '40321b10472db4f98b5a40edfebf8de5'),
(167, '/testlink2/lib/testcases/tcEdit.php', 1748343861, 1748343861, 1, '40321b10472db4f98b5a40edfebf8de5'),
(168, '/testlink2/lib/testcases/tcEdit.php', 1748343876, 1748343876, 1, '40321b10472db4f98b5a40edfebf8de5'),
(169, '/testlink2/lib/plan/planAddTC.php', 1748344074, 1748344074, 1, '40321b10472db4f98b5a40edfebf8de5'),
(170, '/testlink2/lib/plan/planAddTC.php', 1748344100, 1748344101, 1, '40321b10472db4f98b5a40edfebf8de5'),
(171, '/testlink2/lib/plan/planAddTC.php', 1748344107, 1748344107, 1, '40321b10472db4f98b5a40edfebf8de5'),
(172, '/testlink2/lib/execute/execSetResults.php', 1748344130, 1748344131, 1, '40321b10472db4f98b5a40edfebf8de5'),
(173, '/testlink2/lib/execute/execSetResults.php', 1748347821, 1748347821, 1, '40321b10472db4f98b5a40edfebf8de5'),
(174, '/testlink2/lib/execute/execSetResults.php', 1748351541, 1748351541, 1, '40321b10472db4f98b5a40edfebf8de5'),
(175, '/testlink2/lib/execute/execSetResults.php', 1748353044, 1748353044, 1, '40321b10472db4f98b5a40edfebf8de5'),
(176, '/testlink2/lib/execute/execSetResults.php', 1748353045, 1748353045, 1, '40321b10472db4f98b5a40edfebf8de5'),
(177, '/testlink2/login.php', 1748850003, 1748850004, 1, '7a3f6d083a350002a6ada276548e1199');

-- --------------------------------------------------------

--
-- Stand-in structure for view `tsuites_tree_depth_2`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `tsuites_tree_depth_2`;
CREATE TABLE IF NOT EXISTS `tsuites_tree_depth_2` (
`prefix` varchar(16)
,`testproject_name` varchar(100)
,`level1_name` varchar(100)
,`level2_name` varchar(100)
,`testproject_id` int(10) unsigned
,`level1_id` int(10) unsigned
,`level2_id` int(10) unsigned
);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `login` varchar(100) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL DEFAULT '',
  `role_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `email` varchar(100) NOT NULL DEFAULT '',
  `first` varchar(50) NOT NULL DEFAULT '',
  `last` varchar(50) NOT NULL DEFAULT '',
  `locale` varchar(10) NOT NULL DEFAULT 'en_GB',
  `default_testproject_id` int(10) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `script_key` varchar(32) DEFAULT NULL,
  `cookie_string` varchar(64) NOT NULL DEFAULT '',
  `auth_method` varchar(10) DEFAULT '',
  `creation_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expiration_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_login` (`login`),
  UNIQUE KEY `users_cookie_string` (`cookie_string`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='User information';

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `login`, `password`, `role_id`, `email`, `first`, `last`, `locale`, `default_testproject_id`, `active`, `script_key`, `cookie_string`, `auth_method`, `creation_ts`, `expiration_date`) VALUES
(1, 'admin', '$2y$10$gD4kp1leQZgBT79WEbsL4Os.Uil5ZwmU5CCsZyL79ulhsufn6lZcy', 8, '', 'Testlink', 'Administrator', 'en_GB', NULL, 1, NULL, 'd3df32b0f33c8e2186b55f5d99d4b53c9f5e3a1b45d4b913ca8865554cb03533', '', '2025-05-13 13:56:43', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_assignments`
--

DROP TABLE IF EXISTS `user_assignments`;
CREATE TABLE IF NOT EXISTS `user_assignments` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` int(10) UNSIGNED NOT NULL DEFAULT '1',
  `feature_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `user_id` int(10) UNSIGNED DEFAULT '0',
  `build_id` int(10) UNSIGNED DEFAULT '0',
  `deadline_ts` datetime DEFAULT NULL,
  `assigner_id` int(10) UNSIGNED DEFAULT '0',
  `creation_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` int(10) UNSIGNED DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `user_assignments_feature_id` (`feature_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_group`
--

DROP TABLE IF EXISTS `user_group`;
CREATE TABLE IF NOT EXISTS `user_group` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_group` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_group_assign`
--

DROP TABLE IF EXISTS `user_group_assign`;
CREATE TABLE IF NOT EXISTS `user_group_assign` (
  `usergroup_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  UNIQUE KEY `idx_user_group_assign` (`usergroup_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_testplan_roles`
--

DROP TABLE IF EXISTS `user_testplan_roles`;
CREATE TABLE IF NOT EXISTS `user_testplan_roles` (
  `user_id` int(10) NOT NULL DEFAULT '0',
  `testplan_id` int(10) NOT NULL DEFAULT '0',
  `role_id` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`,`testplan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_testproject_roles`
--

DROP TABLE IF EXISTS `user_testproject_roles`;
CREATE TABLE IF NOT EXISTS `user_testproject_roles` (
  `user_id` int(10) NOT NULL DEFAULT '0',
  `testproject_id` int(10) NOT NULL DEFAULT '0',
  `role_id` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`,`testproject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure for view `exec_by_date_time`
--
DROP TABLE IF EXISTS `exec_by_date_time`;

DROP VIEW IF EXISTS `exec_by_date_time`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `exec_by_date_time`  AS   (select `nhtpl`.`name` AS `testplan_name`,date_format(`e`.`execution_ts`,'%Y-%m-%d') AS `yyyy_mm_dd`,date_format(`e`.`execution_ts`,'%Y-%m') AS `yyyy_mm`,date_format(`e`.`execution_ts`,'%H') AS `hh`,date_format(`e`.`execution_ts`,'%k') AS `hour`,`e`.`id` AS `id`,`e`.`build_id` AS `build_id`,`e`.`tester_id` AS `tester_id`,`e`.`execution_ts` AS `execution_ts`,`e`.`status` AS `status`,`e`.`testplan_id` AS `testplan_id`,`e`.`tcversion_id` AS `tcversion_id`,`e`.`tcversion_number` AS `tcversion_number`,`e`.`platform_id` AS `platform_id`,`e`.`execution_type` AS `execution_type`,`e`.`execution_duration` AS `execution_duration`,`e`.`notes` AS `notes` from ((`executions` `e` join `testplans` `tpl` on((`tpl`.`id` = `e`.`testplan_id`))) join `nodes_hierarchy` `nhtpl` on((`nhtpl`.`id` = `tpl`.`id`))))  ;

-- --------------------------------------------------------

--
-- Structure for view `latest_exec_by_context`
--
DROP TABLE IF EXISTS `latest_exec_by_context`;

DROP VIEW IF EXISTS `latest_exec_by_context`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `latest_exec_by_context`  AS SELECT `executions`.`tcversion_id` AS `tcversion_id`, `executions`.`testplan_id` AS `testplan_id`, `executions`.`build_id` AS `build_id`, `executions`.`platform_id` AS `platform_id`, max(`executions`.`id`) AS `id` FROM `executions` GROUP BY `executions`.`tcversion_id`, `executions`.`testplan_id`, `executions`.`build_id`, `executions`.`platform_id``platform_id`  ;

-- --------------------------------------------------------

--
-- Structure for view `latest_exec_by_testplan`
--
DROP TABLE IF EXISTS `latest_exec_by_testplan`;

DROP VIEW IF EXISTS `latest_exec_by_testplan`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `latest_exec_by_testplan`  AS SELECT `executions`.`tcversion_id` AS `tcversion_id`, `executions`.`testplan_id` AS `testplan_id`, max(`executions`.`id`) AS `id` FROM `executions` GROUP BY `executions`.`tcversion_id`, `executions`.`testplan_id``testplan_id`  ;

-- --------------------------------------------------------

--
-- Structure for view `latest_exec_by_testplan_plat`
--
DROP TABLE IF EXISTS `latest_exec_by_testplan_plat`;

DROP VIEW IF EXISTS `latest_exec_by_testplan_plat`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `latest_exec_by_testplan_plat`  AS SELECT `executions`.`tcversion_id` AS `tcversion_id`, `executions`.`testplan_id` AS `testplan_id`, `executions`.`platform_id` AS `platform_id`, max(`executions`.`id`) AS `id` FROM `executions` GROUP BY `executions`.`tcversion_id`, `executions`.`testplan_id`, `executions`.`platform_id``platform_id`  ;

-- --------------------------------------------------------

--
-- Structure for view `latest_req_version`
--
DROP TABLE IF EXISTS `latest_req_version`;

DROP VIEW IF EXISTS `latest_req_version`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `latest_req_version`  AS SELECT `rq`.`id` AS `req_id`, max(`rqv`.`version`) AS `version` FROM ((`nodes_hierarchy` `nhrqv` join `requirements` `rq` on((`rq`.`id` = `nhrqv`.`parent_id`))) join `req_versions` `rqv` on((`rqv`.`id` = `nhrqv`.`id`))) GROUP BY `rq`.`id``id`  ;

-- --------------------------------------------------------

--
-- Structure for view `latest_req_version_id`
--
DROP TABLE IF EXISTS `latest_req_version_id`;

DROP VIEW IF EXISTS `latest_req_version_id`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `latest_req_version_id`  AS SELECT `lrqvn`.`req_id` AS `req_id`, `lrqvn`.`version` AS `version`, `reqv`.`id` AS `req_version_id` FROM ((`latest_req_version` `lrqvn` join `nodes_hierarchy` `nhrqv` on((`nhrqv`.`parent_id` = `lrqvn`.`req_id`))) join `req_versions` `reqv` on(((`reqv`.`id` = `nhrqv`.`id`) and (`reqv`.`version` = `lrqvn`.`version`))))  ;

-- --------------------------------------------------------

--
-- Structure for view `latest_rspec_revision`
--
DROP TABLE IF EXISTS `latest_rspec_revision`;

DROP VIEW IF EXISTS `latest_rspec_revision`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `latest_rspec_revision`  AS SELECT `rsr`.`parent_id` AS `req_spec_id`, `rs`.`testproject_id` AS `testproject_id`, max(`rsr`.`revision`) AS `revision` FROM (`req_specs_revisions` `rsr` join `req_specs` `rs` on((`rs`.`id` = `rsr`.`parent_id`))) GROUP BY `rsr`.`parent_id`, `rs`.`testproject_id``testproject_id`  ;

-- --------------------------------------------------------

--
-- Structure for view `latest_tcase_version_id`
--
DROP TABLE IF EXISTS `latest_tcase_version_id`;

DROP VIEW IF EXISTS `latest_tcase_version_id`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `latest_tcase_version_id`  AS SELECT `ltcvn`.`testcase_id` AS `testcase_id`, `ltcvn`.`version` AS `version`, `tcv`.`id` AS `tcversion_id` FROM ((`latest_tcase_version_number` `ltcvn` join `nodes_hierarchy` `nhtcv` on((`nhtcv`.`parent_id` = `ltcvn`.`testcase_id`))) join `tcversions` `tcv` on(((`tcv`.`id` = `nhtcv`.`id`) and (`tcv`.`version` = `ltcvn`.`version`))))  ;

-- --------------------------------------------------------

--
-- Structure for view `latest_tcase_version_number`
--
DROP TABLE IF EXISTS `latest_tcase_version_number`;

DROP VIEW IF EXISTS `latest_tcase_version_number`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `latest_tcase_version_number`  AS SELECT `nh_tc`.`id` AS `testcase_id`, max(`tcv`.`version`) AS `version` FROM ((`nodes_hierarchy` `nh_tc` join `nodes_hierarchy` `nh_tcv` on((`nh_tcv`.`parent_id` = `nh_tc`.`id`))) join `tcversions` `tcv` on((`nh_tcv`.`id` = `tcv`.`id`))) GROUP BY `testcase_id``testcase_id`  ;

-- --------------------------------------------------------

--
-- Structure for view `tcversions_without_keywords`
--
DROP TABLE IF EXISTS `tcversions_without_keywords`;

DROP VIEW IF EXISTS `tcversions_without_keywords`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `tcversions_without_keywords`  AS SELECT `nhtcv`.`parent_id` AS `testcase_id`, `nhtcv`.`id` AS `id` FROM `nodes_hierarchy` AS `nhtcv` WHERE ((`nhtcv`.`node_type_id` = 4) AND (not(exists(select 1 from `testcase_keywords` `tck` where (`tck`.`tcversion_id` = `nhtcv`.`id`)))))  ;

-- --------------------------------------------------------

--
-- Structure for view `tcversions_without_platforms`
--
DROP TABLE IF EXISTS `tcversions_without_platforms`;

DROP VIEW IF EXISTS `tcversions_without_platforms`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `tcversions_without_platforms`  AS SELECT `nhtcv`.`parent_id` AS `testcase_id`, `nhtcv`.`id` AS `id` FROM `nodes_hierarchy` AS `nhtcv` WHERE ((`nhtcv`.`node_type_id` = 4) AND (not(exists(select 1 from `testcase_platforms` `tcpl` where (`tcpl`.`tcversion_id` = `nhtcv`.`id`)))))  ;

-- --------------------------------------------------------

--
-- Structure for view `tsuites_tree_depth_2`
--
DROP TABLE IF EXISTS `tsuites_tree_depth_2`;

DROP VIEW IF EXISTS `tsuites_tree_depth_2`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `tsuites_tree_depth_2`  AS SELECT `tprj`.`prefix` AS `prefix`, `nhtprj`.`name` AS `testproject_name`, `nhts_l1`.`name` AS `level1_name`, `nhts_l2`.`name` AS `level2_name`, `nhtprj`.`id` AS `testproject_id`, `nhts_l1`.`id` AS `level1_id`, `nhts_l2`.`id` AS `level2_id` FROM (((`testprojects` `tprj` join `nodes_hierarchy` `nhtprj` on((`tprj`.`id` = `nhtprj`.`id`))) left join `nodes_hierarchy` `nhts_l1` on((`nhts_l1`.`parent_id` = `nhtprj`.`id`))) left join `nodes_hierarchy` `nhts_l2` on((`nhts_l2`.`parent_id` = `nhts_l1`.`id`))) WHERE ((`nhtprj`.`node_type_id` = 1) AND (`nhts_l1`.`node_type_id` = 2) AND (`nhts_l2`.`node_type_id` = 2))  ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
