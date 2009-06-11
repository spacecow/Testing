-- MySQL dump 10.11
--
-- Host: localhost    Database: yoyaku_development
-- ------------------------------------------------------
-- Server version	5.0.67-community-nt

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `classrooms`
--

DROP TABLE IF EXISTS `classrooms`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `classrooms` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `address` varchar(255) default NULL,
  `description` text,
  `inactive` tinyint(1) default NULL,
  `note` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `classrooms`
--

LOCK TABLES `classrooms` WRITE;
/*!40000 ALTER TABLE `classrooms` DISABLE KEYS */;
INSERT INTO `classrooms` VALUES (1,'1','','',0,'','2009-05-13 14:03:01','2009-05-13 14:03:01'),(2,'2','','',0,'','2009-05-13 14:03:34','2009-05-13 14:03:34'),(3,'3','','',0,'','2009-05-13 14:03:38','2009-05-13 14:03:38'),(4,'4','','',0,'','2009-05-15 12:17:08','2009-05-15 12:17:08');
/*!40000 ALTER TABLE `classrooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_times`
--

DROP TABLE IF EXISTS `course_times`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `course_times` (
  `id` int(11) NOT NULL auto_increment,
  `start_time` time default NULL,
  `end_time` time default NULL,
  `text` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `course_times`
--

LOCK TABLES `course_times` WRITE;
/*!40000 ALTER TABLE `course_times` DISABLE KEYS */;
INSERT INTO `course_times` VALUES (1,'13:00:00','13:50:00','13:00 -- 13:50','2009-05-07 09:37:00','2009-05-07 09:37:00'),(2,'14:00:00','16:00:00','14:00 -- 16:00','2009-05-07 10:54:58','2009-05-07 10:54:58'),(3,'15:00:00','17:00:00','15:00 -- 17:00','2009-05-07 14:38:52','2009-05-07 14:38:52'),(4,'14:00:00','14:50:00','14:00 -- 14:50','2009-05-07 14:39:26','2009-05-07 14:39:26'),(5,'12:00:00','12:50:00','12:00 -- 12:50','2009-05-07 14:39:57','2009-05-07 14:39:57'),(6,'13:00:00','15:00:00','13:00 -- 15:00','2009-05-07 14:40:31','2009-05-07 14:40:31'),(7,'11:50:00','13:50:00','11:50 -- 13:50','2009-05-07 14:48:31','2009-05-07 14:48:31'),(8,'10:50:00','11:40:00','10:50 -- 11:40','2009-05-07 14:48:57','2009-05-07 14:48:57'),(9,'17:50:00','18:40:00','17:50 -- 18:40','2009-05-07 14:55:45','2009-05-07 14:55:45'),(11,'18:50:00','20:50:00','18:50 -- 20:50','2009-05-07 14:58:04','2009-05-07 14:58:04'),(12,'16:50:00','17:40:00','16:50 -- 17:40','2009-05-07 15:36:04','2009-05-07 15:36:04'),(13,'18:50:00','19:40:00','18:50 -- 19:40','2009-05-07 15:37:38','2009-05-07 15:37:38'),(14,'19:50:00','20:40:00','19:50 -- 20:40','2009-05-07 15:37:55','2009-05-19 02:59:22'),(15,'14:10:00','16:10:00','14:10 -- 16:10','2009-05-08 09:44:05','2009-05-08 09:44:05'),(16,'16:30:00','18:30:00','16:30 -- 18:30','2009-05-08 09:44:29','2009-05-08 09:44:29'),(17,'16:30:00','17:20:00','16:30 -- 17:20','2009-05-08 09:58:00','2009-05-08 09:58:00'),(18,'17:30:00','18:20:00','17:30 -- 18:20','2009-05-08 09:58:22','2009-05-08 09:58:22'),(20,'18:19:00','18:21:00','18:19 -- 18:21','2009-05-18 10:32:28','2009-05-18 10:32:28'),(21,'19:00:00','21:00:00','19:00 -- 21:00','2009-05-19 03:06:18','2009-05-19 03:06:18'),(22,'16:30:00','17:30:00','16:30 -- 17:30','2009-05-19 04:12:44','2009-05-19 04:12:44'),(23,'17:00:00','18:00:00','17:00 -- 18:00','2009-05-19 04:13:03','2009-05-19 04:13:03'),(24,'21:10:00','22:10:00','21:10 -- 22:10','2009-05-19 04:13:21','2009-05-19 04:13:21'),(25,'19:00:00','20:00:00','19:00 -- 20:00','2009-05-21 04:12:05','2009-05-21 04:12:05'),(26,'20:10:00','21:10:00','20:10 -- 21:10','2009-05-21 04:12:26','2009-05-21 04:12:26'),(27,'15:30:00','17:30:00','15:30 -- 17:30','2009-05-21 04:14:19','2009-05-21 04:14:19'),(28,'16:40:00','17:40:00','16:40 -- 17:40','2009-05-21 04:14:40','2009-05-21 04:14:40'),(29,'13:30:00','14:30:00','13:30 -- 14:30','2009-05-22 03:15:31','2009-05-22 03:15:31'),(30,'14:45:00','15:45:00','14:45 -- 15:45','2009-05-22 03:15:49','2009-05-22 03:15:49'),(31,'16:00:00','17:00:00','16:00 -- 17:00','2009-05-22 03:16:07','2009-05-22 03:16:07'),(32,'15:30:00','16:30:00','15:30 -- 16:30','2009-05-22 03:16:27','2009-05-22 03:16:27'),(33,'17:40:00','18:40:00','17:40 -- 18:40','2009-05-22 03:16:48','2009-05-22 03:16:48');
/*!40000 ALTER TABLE `course_times` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `courses` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` text,
  `inactive` tinyint(1) default NULL,
  `note` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES (1,'入門 I','',0,'','2009-05-07 09:36:19','2009-05-14 11:20:01'),(2,'入門 II','',0,'','2009-05-07 10:54:18','2009-05-14 11:24:52'),(3,'初級 I','',0,'','2009-05-07 10:54:38','2009-05-14 11:25:04'),(4,'初級 II','',0,'','2009-05-07 14:30:33','2009-05-14 11:25:15'),(5,'中級 I','',0,'','2009-05-07 14:31:21','2009-05-14 11:25:25'),(6,'中級 II','',0,'','2009-05-14 11:15:28','2009-05-14 11:15:28'),(7,'中国語 中I','',0,'','2009-05-18 10:26:56','2009-05-18 10:26:56'),(8,'中国語 中II','',0,'','2009-05-19 03:05:50','2009-05-19 03:05:50'),(10,'韓国語 中III','',0,'','2009-05-21 04:10:54','2009-05-21 04:10:54'),(11,'個別英語','',0,'','2009-05-21 04:24:33','2009-05-27 07:12:20'),(12,'個別韓国','',0,'','2009-05-21 04:26:41','2009-05-27 07:12:45'),(13,'中国語 中III (中)','',0,'','2009-05-22 03:12:08','2009-05-22 03:12:08'),(14,'個別中国','',0,'','2009-05-22 03:13:23','2009-05-27 07:12:55');
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `docs`
--

DROP TABLE IF EXISTS `docs`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `docs` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) default NULL,
  `url` varchar(255) default NULL,
  `contents` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `docs`
--

LOCK TABLES `docs` WRITE;
/*!40000 ALTER TABLE `docs` DISABLE KEYS */;
INSERT INTO `docs` VALUES (1,'HABTM Checkboxes',NULL,'<pre class=\"code\">\n<div class=\"path\"><a href=\"habtm_checkboxes/_form.html.erb.txt\">yoyaku/app/views/docs/_form.html.erb</a></div>\n&lt;p>\n  &lt;%= f.label :title %>&lt;br />\n  &lt;%= f.text_field :title %>\n&lt;/p>\n&lt;p>\n  &lt;%= f.label :url %>&lt;br />\n  &lt;%= f.text_field :url %>\n&lt;/p>\n&lt;p>\n&lt;% Tag.all.each do |tag| %>\n  &lt;%= check_box_tag \"doc[tag_ids][]\", tag.id, @doc.tags.include?(tag) %>\n  &lt;%= tag.name %>\n&lt;/p>\n&lt;% end %>\n&lt;p>\n  &lt;%= f.submit label_text %>\n&lt;/p>\n</pre>\nThe <span class=\"method\">tag_ids</span> method accepts an array of ids, so:\n\ndoc.tag_ids = [1, 2, 3]\n\nWill set tags with ids 1, 2 and 3 to that doc. Normally in Rails\nforms you put the name of the attribute in square brackets and use\nthat as the name of the field:\n\ndoc[tag_ids]\n\nThis way Rails knows it\'s an attribute of doc. But if you just did\nthis, it would take only one check box value and set that:\n\ndoc.tag_ids = 1\n\nBut here the <span class=\"method\">tag_ids</span> method expects an array, so you need those\nempty square brackets in the name of the check box. Rails will then\ngather up all values with this same name and place them in an array.\nThis is what the empty square brackets do:\n\ndoc[tag_ids][]\n','2009-05-25 19:36:32','2009-05-25 19:36:32'),(2,'Eager Loading',NULL,'One way to improve performance is to cut down on the number of SQL queries.\nThis code displays some extra listing for the admin. Without <i>eager loading</i>\na new SQL query is sent to the database every time the associations <span class=\"var\">course</span>\nand <span class=\"var\">course_time</span> are called:\n\n<pre class=\"code\">\n<div class=\"path\"><a href=\"yoyaku_03/index.html.erb.txt\">yoyaku/app/views/template_classes/index.html.erb</a></div>\n&lt;h1>Listing Template Classes&lt;/h1>\n\n...\n\n&lt;% if admin? %>\n  &lt;table>\n  &lt;% @template_classes.each do |template_class| %>\n    &lt;tr>\n      &lt;td>&lt;%=h <span class=\"highlight\">template_class.course</span> %>&lt;/td>\n      &lt;td>&lt;%=h <span class=\"highlight\">template_class.course_time</span> %>&lt;/td>\n      &lt;td>&lt;%=h template_class.day %>&lt;/td>\n      &lt;td>&lt;%=h template_class.title %>&lt;/td>\n      &lt;td>&lt;%=h template_class.description %>&lt;/td>\n      &lt;td>&lt;%=h template_class.inactive %>&lt;/td>\n      &lt;td>&lt;%=h template_class.note %>&lt;/td>\n      &lt;td>&lt;%= link_to \'Show\', template_class %>&lt;/td>\n      &lt;td>&lt;%= link_to \'Edit\', edit_template_class_path(template_class) %>&lt;/td>\n      &lt;td>&lt;%= link_to \'Destroy\', template_class, :confirm => \'Are you sure?\',\n        :method => :delete %>\n      &lt;/td>\n    &lt;/tr>\n  &lt;% end %>\n  &lt;/table>\n&lt;% end %>\n</pre>\nWith a simple option, a join statement is constructed for you that fetches\nall the associations at the same time as it fetches the <span class=\"var\">template classes</span>.\nObserve that the name of the association is included, not the name of the\nmodel:\n\n<pre class=\"code\">\n<div class=\"path\"><a href=\"yoyaku_03/template_classes_controller.rb.txt\">yoyaku/app/controllers/template_classes_controller.rb</a></div>\nclass TemplateClassesController &lt; ApplicationController\n  ...\n\n  def index\n    @template_classes = TemplateClass.find( :all, <span class=\"highlight\">:include=>[\'course\',\'course_time\']</span> )\n    ...\n  end\n...\nend\n</pre>\n','2009-05-25 19:36:33','2009-05-25 19:36:33'),(3,'The :through relation',NULL,'<pre class=\"code\">\n<div class=\"path\"><a href=\"yoyaku_09/student_class.rb.txt\">yoyaku/app/models/student_class.rb</a></div>\nclass StudentClass &lt; ActiveRecord::Base\n  belongs_to :student\n  belongs_to :klass\nend\n\n\n<div class=\"path\"><a href=\"yoyaku_09/student.rb.txt\">yoyaku/app/models/student.rb</a></div>\nclass Student &lt; ActiveRecord::Base\n  belongs_to :person\n  <span class=\"highlight\">has_many :student_classes\n  has_many :klasses, :through=>\'student_classes\'</span>\n\n  def to_s\n    \"#{person}\"\n  end\nend\n\n\n<div class=\"path\"><a href=\"yoyaku_09/klass.rb.txt\">yoyaku/app/models/klass.rb</a></div>\nclass Klass &lt; ActiveRecord::Base\n  belongs_to :course\n  belongs_to :teacher\n  belongs_to :classroom\n  <span class=\"highlight\">has_many :student_classes\n  has_many :students, :through=>\'student_classes\'</span>\n\n  validates_presence_of :course_id\n\n  def to_s\n    \"#{tostring}\"\n  end\nend\n</pre>\n\n<pre class=\"code\">\n<div class=\"path\"><a href=\"yoyaku_09/_klass.html.erb.txt\">yoyaku/app/views/klasses/_klass.html.erb</a></div>\n&lt;% form_for(klass) do |f| %>\n\n  ...\n\n&lt;% end %>\n<span class=\"highlight\">&lt;% student_classes = klass.student_classes.all %></span>\n&lt;% student_classes.each do |student_class| %>\n  &lt;td class=\"table-units\">\n    &lt;% form_for(<span class=\"highlight\">student_class</span>) do |f2| %>\n      &lt;%= f2.select <span class=\"highlight\">:student_id</span>,\n        Student.find(\n          :all,\n          :conditions => [\"person_id = people.id\"],\n          :include => :person ).map{|e| [e, e.id]},\n        {},\n        { :class => \'table-units\',\n          :onchange => \'this.form.submit();\' } %>\n    &lt;% end %>\n  &lt;/td>\n&lt;% end %>\n\n...\n</pre>\nAlso understand that with the :through relation, you can reach the\nother table directly with Rails:\n\nklass.students.all\n','2009-05-25 19:36:33','2009-05-25 19:36:33'),(4,'Filtering Sensitive Logs',NULL,'By default, Rails stores all submitted parameters in plain text in\nthe logs:\n\n<pre class=\"code\">\nProcessing UsersController#create (for 127.0.0.1 at 2009-05-25 01:24:59) [POST]\nSession ID: ...\nParameters: {\"user\"=>{\"name\"=>\"johan\", <span class=\"highlight\">\"password_confirmation\"=>\"sercret\",\n  \"password\"=>\"sercret\"</span>}, \"commit\"=>\"Add User\", \"authenticity_token\"=>\"...\"}\n</pre>\nFilter this so it doesn\'t show up in the log file by uncomment:\n<pre class=\"code\">\n<div class=\"path\"><a href=\"yoyaku_11/application.rb.txt\">yoyaku/app/controllers/application.rb</a></div>\n# Filters added to this controller apply to all controllers in the application.\n# Likewise, all the methods added will be available for all controllers.\n\nclass ApplicationController &lt; ActionController::Base\n  ...\n  # See ActionController::Base for details\n  # Uncomment this to filter the contents of submitted sensitive data parameters\n  # from your application log (in this case, all fields with names like \"password\").\n  <span class=\"highlight\">filter_parameter_logging :password</span>\nend\n</pre>\nResulting in a log-file entry:\n\n<pre class=\"code\">\nProcessing UsersController#create (for 127.0.0.1 at 2009-05-25 01:32:31) [POST]\nSession ID: ...\nParameters: {\"user\"=>{\"name\"=>\"johan\", <span class=\"highlight\">\"password_confirmation\"=>\"[FILTERED]\",\n\"password\"=>\"[FILTERED]\"</span>}, \"commit\"=>\"Add User\", \"action\"=>\"create\",\n  \"authenticity_token\"=>\"...\", \"controller\"=>\"users\"}\n</pre>\n','2009-05-25 19:36:33','2009-05-25 19:36:33');
/*!40000 ALTER TABLE `docs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `docs_tags`
--

DROP TABLE IF EXISTS `docs_tags`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `docs_tags` (
  `doc_id` int(11) default NULL,
  `tag_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `docs_tags`
--

LOCK TABLES `docs_tags` WRITE;
/*!40000 ALTER TABLE `docs_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `docs_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `klasses`
--

DROP TABLE IF EXISTS `klasses`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `klasses` (
  `id` int(11) NOT NULL auto_increment,
  `course_id` int(11) default NULL,
  `teacher_id` int(11) default NULL,
  `classroom_id` int(11) default NULL,
  `capacity` int(11) default NULL,
  `date` datetime default NULL,
  `start_time` time default NULL,
  `end_time` time default NULL,
  `title` varchar(255) default NULL,
  `description` text,
  `cancel` tinyint(1) default NULL,
  `mail_sending` int(11) default NULL,
  `note` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `tostring` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `klasses`
--

LOCK TABLES `klasses` WRITE;
/*!40000 ALTER TABLE `klasses` DISABLE KEYS */;
INSERT INTO `klasses` VALUES (1,2,NULL,NULL,NULL,'2009-05-21 00:00:00','17:50:00','18:40:00','','',0,NULL,'','2009-05-21 04:27:56','2009-05-21 04:27:56','入門 II-17:50-18:40'),(2,1,NULL,1,NULL,'2009-05-21 00:00:00','18:50:00','20:50:00','','',0,NULL,'','2009-05-21 04:27:56','2009-05-21 08:01:03','入門 I-18:50-20:50'),(3,3,NULL,NULL,NULL,'2009-05-21 00:00:00','18:50:00','20:50:00','','',0,NULL,'','2009-05-21 04:27:56','2009-05-21 04:27:56','初級 I-18:50-20:50'),(4,4,NULL,NULL,NULL,'2009-05-21 00:00:00','17:50:00','18:40:00','','',0,NULL,'','2009-05-21 04:27:56','2009-05-21 04:27:56','初級 II-17:50-18:40'),(5,6,NULL,NULL,NULL,'2009-05-21 00:00:00','17:50:00','18:40:00','','',0,NULL,'','2009-05-21 04:27:56','2009-05-21 04:27:56','中級 II-17:50-18:40'),(6,5,NULL,NULL,NULL,'2009-05-21 00:00:00','18:50:00','20:50:00','','',0,NULL,'','2009-05-21 04:27:56','2009-05-21 04:27:56','中級 I-18:50-20:50'),(7,2,NULL,NULL,NULL,'2009-05-21 00:00:00','17:50:00','18:40:00','','',0,NULL,'','2009-05-21 04:27:56','2009-05-21 04:27:56','入門 II-17:50-18:40'),(8,1,NULL,NULL,NULL,'2009-05-21 00:00:00','18:50:00','20:50:00','','',0,NULL,'','2009-05-21 04:27:56','2009-05-21 04:27:56','入門 I-18:50-20:50'),(9,3,NULL,NULL,NULL,'2009-05-21 00:00:00','18:50:00','20:50:00','','',0,NULL,'','2009-05-21 04:27:56','2009-05-21 04:27:56','初級 I-18:50-20:50'),(10,4,NULL,NULL,NULL,'2009-05-21 00:00:00','17:50:00','18:40:00','','',0,NULL,'','2009-05-21 04:27:57','2009-05-21 04:27:57','初級 II-17:50-18:40'),(11,5,NULL,NULL,NULL,'2009-05-21 00:00:00','18:50:00','20:50:00','','',0,NULL,'','2009-05-21 04:27:57','2009-05-21 04:27:57','中級 I-18:50-20:50'),(12,6,NULL,NULL,NULL,'2009-05-21 00:00:00','17:50:00','18:40:00','','',0,NULL,'','2009-05-21 04:27:57','2009-05-21 04:27:57','中級 II-17:50-18:40'),(13,10,NULL,NULL,NULL,'2009-05-21 00:00:00','19:00:00','20:00:00','','',0,NULL,'','2009-05-21 04:27:57','2009-05-21 04:27:57','韓国語 中III-19:00-20:00'),(14,10,NULL,NULL,NULL,'2009-05-21 00:00:00','20:10:00','21:10:00','','',0,NULL,'','2009-05-21 04:27:57','2009-05-21 04:27:57','韓国語 中III-20:10-21:10'),(15,11,NULL,NULL,NULL,'2009-05-21 00:00:00','15:30:00','17:30:00','','',0,NULL,'','2009-05-21 04:27:57','2009-05-21 04:27:57','個別 英語-15:30-17:30'),(16,12,NULL,NULL,NULL,'2009-05-21 00:00:00','16:30:00','18:30:00','','',0,NULL,'','2009-05-21 04:27:57','2009-05-21 04:27:57','個別 韓語-16:30-18:30'),(17,11,NULL,NULL,NULL,'2009-05-21 00:00:00','16:40:00','17:40:00','','',0,NULL,'','2009-05-21 04:27:57','2009-05-21 04:27:57','個別 英語-16:40-17:40'),(18,2,NULL,NULL,NULL,'2009-05-22 00:00:00','17:50:00','18:40:00','','',0,NULL,'','2009-05-22 03:20:05','2009-05-22 03:20:05','入門 II-17:50-18:40'),(19,1,NULL,NULL,NULL,'2009-05-22 00:00:00','18:50:00','20:50:00','','',0,NULL,'','2009-05-22 03:20:05','2009-05-22 03:20:05','入門 I-18:50-20:50'),(20,3,NULL,NULL,NULL,'2009-05-22 00:00:00','18:50:00','20:50:00','','',0,NULL,'','2009-05-22 03:20:05','2009-05-22 03:20:05','初級 I-18:50-20:50'),(21,4,NULL,NULL,NULL,'2009-05-22 00:00:00','17:50:00','18:40:00','','',0,NULL,'','2009-05-22 03:20:05','2009-05-22 03:20:05','初級 II-17:50-18:40'),(22,6,NULL,NULL,NULL,'2009-05-22 00:00:00','16:50:00','17:40:00','','',0,NULL,'','2009-05-22 03:20:05','2009-05-22 03:20:05','中級 II-16:50-17:40'),(23,6,NULL,NULL,NULL,'2009-05-22 00:00:00','18:50:00','19:40:00','','',0,NULL,'','2009-05-22 03:20:05','2009-05-22 03:20:05','中級 II-18:50-19:40'),(24,6,NULL,NULL,NULL,'2009-05-22 00:00:00','19:50:00','20:40:00','','',0,NULL,'','2009-05-22 03:20:05','2009-05-22 03:20:05','中級 II-19:50-20:40'),(25,5,NULL,NULL,NULL,'2009-05-22 00:00:00','18:50:00','20:50:00','','',0,NULL,'','2009-05-22 03:20:06','2009-05-22 03:20:06','中級 I-18:50-20:50'),(26,2,NULL,NULL,NULL,'2009-05-22 00:00:00','17:50:00','18:40:00','','',0,NULL,'','2009-05-22 03:20:06','2009-05-22 03:20:06','入門 II-17:50-18:40'),(27,1,NULL,NULL,NULL,'2009-05-22 00:00:00','18:50:00','20:50:00','','',0,NULL,'','2009-05-22 03:20:06','2009-05-22 03:20:06','入門 I-18:50-20:50'),(28,4,NULL,NULL,NULL,'2009-05-22 00:00:00','17:50:00','18:40:00','','',0,NULL,'','2009-05-22 03:20:06','2009-05-22 03:20:06','初級 II-17:50-18:40'),(29,3,NULL,NULL,NULL,'2009-05-22 00:00:00','18:50:00','20:50:00','','',0,NULL,'','2009-05-22 03:20:06','2009-05-22 03:20:06','初級 I-18:50-20:50'),(30,5,NULL,NULL,NULL,'2009-05-22 00:00:00','18:50:00','20:50:00','','',0,NULL,'','2009-05-22 03:20:06','2009-05-22 03:20:06','中級 I-18:50-20:50'),(31,6,NULL,NULL,NULL,'2009-05-22 00:00:00','18:50:00','19:40:00','','',0,NULL,'','2009-05-22 03:20:06','2009-05-22 03:20:06','中級 II-18:50-19:40'),(32,6,NULL,NULL,NULL,'2009-05-22 00:00:00','19:50:00','20:40:00','','',0,NULL,'','2009-05-22 03:20:06','2009-05-22 03:20:06','中級 II-19:50-20:40'),(33,13,NULL,NULL,NULL,'2009-05-22 00:00:00','19:00:00','20:00:00','','',0,NULL,'','2009-05-22 03:20:06','2009-05-22 03:20:06','中国語 中III (中)-19:00-20:00'),(34,13,NULL,NULL,NULL,'2009-05-22 00:00:00','20:10:00','21:10:00','','',0,NULL,'','2009-05-22 03:20:06','2009-05-22 03:20:06','中国語 中III (中)-20:10-21:10'),(35,11,NULL,NULL,NULL,'2009-05-22 00:00:00','13:30:00','14:30:00','','',0,NULL,'','2009-05-22 03:20:06','2009-05-22 03:20:06','個別 英語-13:30-14:30'),(36,11,NULL,NULL,NULL,'2009-05-22 00:00:00','14:45:00','15:45:00','','',0,NULL,'','2009-05-22 03:20:06','2009-05-22 03:20:06','個別 英語-14:45-15:45'),(37,11,NULL,NULL,NULL,'2009-05-22 00:00:00','16:00:00','17:00:00','','',0,NULL,'','2009-05-22 03:20:06','2009-05-22 03:20:06','個別 英語-16:00-17:00'),(38,11,NULL,NULL,NULL,'2009-05-22 00:00:00','15:30:00','16:30:00','','',0,NULL,'','2009-05-22 03:20:06','2009-05-22 03:20:06','個別 英語-15:30-16:30'),(39,11,NULL,NULL,NULL,'2009-05-22 00:00:00','16:40:00','17:40:00','','',0,NULL,'','2009-05-22 03:20:06','2009-05-22 03:20:06','個別 英語-16:40-17:40'),(40,14,NULL,NULL,NULL,'2009-05-22 00:00:00','17:40:00','18:40:00','','',0,NULL,'','2009-05-22 03:20:06','2009-05-22 03:20:06','個別 中国-17:40-18:40'),(41,11,NULL,NULL,NULL,'2009-05-22 00:00:00','17:40:00','18:40:00','','',0,NULL,'','2009-05-22 03:20:06','2009-05-22 03:20:06','個別 英語-17:40-18:40'),(42,1,NULL,NULL,NULL,'2009-05-23 00:00:00','11:50:00','13:50:00','','',0,NULL,'','2009-05-22 07:32:28','2009-05-22 07:32:28','入門 I-11:50-13:50'),(43,2,NULL,NULL,NULL,'2009-05-23 00:00:00','10:50:00','11:40:00','','',0,NULL,'','2009-05-22 07:32:28','2009-05-22 07:32:28','入門 II-10:50-11:40'),(44,3,NULL,NULL,NULL,'2009-05-23 00:00:00','11:50:00','13:50:00','','',0,NULL,'','2009-05-22 07:32:28','2009-05-22 07:32:28','初級 I-11:50-13:50'),(45,4,NULL,NULL,NULL,'2009-05-23 00:00:00','10:50:00','11:40:00','','',0,NULL,'','2009-05-22 07:32:28','2009-05-22 07:32:28','初級 II-10:50-11:40'),(46,2,NULL,NULL,NULL,'2009-05-23 00:00:00','16:50:00','17:40:00','','',0,NULL,'','2009-05-22 07:32:28','2009-05-22 07:32:28','入門 II-16:50-17:40'),(47,2,NULL,NULL,NULL,'2009-05-23 00:00:00','17:50:00','18:40:00','','',0,NULL,'','2009-05-22 07:32:28','2009-05-22 07:32:28','入門 II-17:50-18:40'),(48,1,NULL,NULL,NULL,'2009-05-23 00:00:00','18:50:00','20:50:00','','',0,NULL,'','2009-05-22 07:32:28','2009-05-22 07:32:28','入門 I-18:50-20:50'),(49,4,NULL,NULL,NULL,'2009-05-23 00:00:00','17:50:00','18:40:00','','',0,NULL,'','2009-05-22 07:32:29','2009-05-22 07:32:29','初級 II-17:50-18:40'),(50,4,NULL,NULL,NULL,'2009-05-23 00:00:00','18:50:00','19:40:00','','',0,NULL,'','2009-05-22 07:32:29','2009-05-22 07:32:29','初級 II-18:50-19:40'),(51,4,NULL,NULL,NULL,'2009-05-23 00:00:00','19:50:00','20:40:00','','',0,NULL,'','2009-05-22 07:32:29','2009-05-22 07:32:29','初級 II-19:50-20:40'),(52,3,NULL,NULL,NULL,'2009-05-23 00:00:00','18:50:00','20:50:00','','',0,NULL,'','2009-05-22 07:32:29','2009-05-22 07:32:29','初級 I-18:50-20:50'),(53,3,NULL,NULL,NULL,'2009-05-23 00:00:00','14:10:00','16:10:00','','',0,NULL,'','2009-05-22 07:32:29','2009-05-22 07:32:29','初級 I-14:10-16:10'),(54,3,NULL,NULL,NULL,'2009-05-23 00:00:00','16:30:00','18:30:00','','',0,NULL,'','2009-05-22 07:32:29','2009-05-22 07:32:29','初級 I-16:30-18:30'),(55,5,NULL,NULL,NULL,'2009-05-23 00:00:00','18:50:00','20:50:00','','',0,NULL,'','2009-05-22 07:32:29','2009-05-22 07:32:29','中級 I-18:50-20:50'),(56,6,NULL,NULL,NULL,'2009-05-23 00:00:00','16:30:00','17:20:00','','',0,NULL,'','2009-05-22 07:32:29','2009-05-22 07:32:29','中級 II-16:30-17:20'),(57,6,NULL,NULL,NULL,'2009-05-23 00:00:00','17:30:00','18:20:00','','',0,NULL,'','2009-05-22 07:32:29','2009-05-22 07:32:29','中級 II-17:30-18:20'),(58,3,NULL,NULL,NULL,'2009-05-25 00:00:00','14:00:00','16:00:00','','',0,NULL,'','2009-05-25 07:28:03','2009-05-25 07:28:03','初級 I-14:00-16:00'),(59,1,NULL,NULL,NULL,'2009-05-25 00:00:00','14:00:00','16:00:00','','',0,NULL,'','2009-05-25 07:28:03','2009-05-25 07:28:03','入門 I-14:00-16:00'),(60,2,NULL,NULL,NULL,'2009-05-25 00:00:00','13:00:00','13:50:00','','',0,NULL,'','2009-05-25 07:28:03','2009-05-25 07:28:03','入門 II-13:00-13:50'),(61,4,NULL,NULL,NULL,'2009-05-25 00:00:00','13:00:00','13:50:00','','',0,NULL,'','2009-05-25 07:28:04','2009-05-25 07:28:04','初級 II-13:00-13:50'),(62,2,NULL,NULL,NULL,'2009-05-25 00:00:00','17:50:00','18:40:00','','',0,NULL,'','2009-05-25 07:28:04','2009-05-25 07:28:04','入門 II-17:50-18:40'),(63,1,NULL,NULL,NULL,'2009-05-25 00:00:00','18:50:00','20:50:00','','',0,NULL,'','2009-05-25 07:28:04','2009-05-25 07:28:04','入門 I-18:50-20:50'),(64,4,NULL,NULL,NULL,'2009-05-25 00:00:00','17:50:00','18:40:00','','',0,NULL,'','2009-05-25 07:28:04','2009-05-25 07:28:04','初級 II-17:50-18:40'),(65,3,NULL,NULL,NULL,'2009-05-25 00:00:00','18:50:00','20:50:00','','',0,NULL,'','2009-05-25 07:28:04','2009-05-25 07:28:04','初級 I-18:50-20:50'),(66,6,NULL,NULL,NULL,'2009-05-25 00:00:00','16:50:00','17:40:00','','',0,NULL,'','2009-05-25 07:28:04','2009-05-25 07:28:04','中級 II-16:50-17:40'),(67,6,NULL,NULL,NULL,'2009-05-25 00:00:00','17:50:00','18:40:00','','',0,NULL,'','2009-05-25 07:28:04','2009-05-25 07:28:04','中級 II-17:50-18:40'),(68,5,NULL,NULL,NULL,'2009-05-25 00:00:00','18:50:00','20:50:00','','',0,NULL,'','2009-05-25 07:28:04','2009-05-25 07:28:04','中級 I-18:50-20:50'),(69,1,NULL,NULL,NULL,'2009-05-26 00:00:00','15:00:00','17:00:00','','',0,NULL,'','2009-05-26 03:05:00','2009-05-27 06:45:36','入門 I-15:00-17:00'),(70,2,NULL,NULL,NULL,'2009-05-26 00:00:00','14:00:00','14:50:00','','',0,NULL,'','2009-05-26 03:05:00','2009-05-27 06:45:45','入門 II-14:00-14:50'),(71,3,NULL,NULL,NULL,'2009-05-26 00:00:00','15:00:00','17:00:00','','',0,NULL,'','2009-05-26 03:05:00','2009-05-26 03:05:00','初級 I-15:00-17:00'),(72,4,NULL,NULL,NULL,'2009-05-26 00:00:00','14:00:00','14:50:00','','',0,NULL,'','2009-05-26 03:05:00','2009-05-27 06:46:25','初級 II-14:00-14:50'),(73,2,NULL,1,NULL,'2009-05-26 00:00:00','17:50:00','18:40:00','','',0,NULL,'','2009-05-26 03:05:00','2009-05-26 13:02:38','入門 II-17:50-18:40'),(74,1,NULL,NULL,NULL,'2009-05-26 00:00:00','18:50:00','20:50:00','','',0,NULL,'','2009-05-26 03:05:00','2009-05-26 03:05:00','入門 I-18:50-20:50'),(75,3,NULL,NULL,NULL,'2009-05-26 00:00:00','18:50:00','20:50:00','','',0,NULL,'','2009-05-26 03:05:00','2009-05-26 03:05:00','初級 I-18:50-20:50'),(76,4,NULL,NULL,NULL,'2009-05-26 00:00:00','17:50:00','18:40:00','','',0,NULL,'','2009-05-26 03:05:00','2009-05-26 03:05:00','初級 II-17:50-18:40'),(77,6,NULL,NULL,NULL,'2009-05-26 00:00:00','17:50:00','18:40:00','','',0,NULL,'','2009-05-26 03:05:01','2009-05-26 03:05:01','中級 II-17:50-18:40'),(78,5,NULL,NULL,NULL,'2009-05-26 00:00:00','18:50:00','20:50:00','','',0,NULL,'','2009-05-26 03:05:01','2009-05-26 03:05:01','中級 I-18:50-20:50'),(79,8,NULL,NULL,NULL,'2009-05-26 00:00:00','19:00:00','21:00:00','','',0,NULL,'','2009-05-26 03:05:01','2009-05-26 03:05:01','中国語 中II-19:00-21:00'),(80,3,NULL,NULL,NULL,'2009-05-26 00:00:00','15:00:00','17:00:00','','',0,NULL,'','2009-05-26 03:05:01','2009-05-26 03:05:01','初級 I-15:00-17:00'),(81,4,NULL,NULL,NULL,'2009-05-26 00:00:00','14:00:00','14:50:00','','',0,NULL,'','2009-05-26 03:05:01','2009-05-27 06:46:29','初級 II-14:00-14:50'),(82,2,NULL,2,NULL,'2009-05-26 00:00:00','14:00:00','14:50:00','','',0,NULL,'','2009-05-26 03:05:01','2009-05-27 06:45:41','入門 II-14:00-14:50'),(83,1,NULL,NULL,NULL,'2009-05-26 00:00:00','15:00:00','17:00:00','','',0,NULL,'','2009-05-26 03:05:01','2009-05-26 03:05:01','入門 I-15:00-17:00'),(84,2,NULL,3,NULL,'2009-05-26 00:00:00','17:50:00','18:40:00','','',0,NULL,'','2009-05-26 03:05:01','2009-05-27 06:46:15','入門 II-17:50-18:40'),(85,1,NULL,1,NULL,'2009-05-26 00:00:00','18:50:00','20:50:00','','',0,NULL,'','2009-05-26 03:05:01','2009-05-27 06:46:20','入門 I-18:50-20:50'),(86,3,NULL,NULL,NULL,'2009-05-26 00:00:00','18:50:00','20:50:00','','',0,NULL,'','2009-05-26 03:05:01','2009-05-26 03:05:01','初級 I-18:50-20:50'),(87,4,NULL,NULL,NULL,'2009-05-26 00:00:00','17:50:00','18:40:00','','',0,NULL,'','2009-05-26 03:05:01','2009-05-26 03:05:01','初級 II-17:50-18:40'),(88,5,NULL,NULL,NULL,'2009-05-26 00:00:00','18:50:00','20:50:00','','',0,NULL,'','2009-05-26 03:05:01','2009-05-26 03:05:01','中級 I-18:50-20:50'),(89,6,NULL,NULL,NULL,'2009-05-26 00:00:00','17:50:00','18:40:00','','',0,NULL,'','2009-05-26 03:05:01','2009-05-26 03:05:01','中級 II-17:50-18:40');
/*!40000 ALTER TABLE `klasses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `people`
--

DROP TABLE IF EXISTS `people`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `people` (
  `id` int(11) NOT NULL auto_increment,
  `user_name` varchar(255) default NULL,
  `family_name` varchar(255) default NULL,
  `first_name` varchar(255) default NULL,
  `family_name_kana` varchar(255) default NULL,
  `first_name_kana` varchar(255) default NULL,
  `gender` tinyint(4) default NULL,
  `address1` varchar(255) default NULL,
  `address2` varchar(255) default NULL,
  `home_phone` varchar(10) default NULL,
  `mobile_phone` varchar(11) default NULL,
  `mail_address_mobile` varchar(255) default NULL,
  `mail_address_pc` varchar(255) default NULL,
  `ritei` tinyint(1) default NULL,
  `last_login` datetime default NULL,
  `note` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `inactive` tinyint(1) default NULL,
  `status` smallint(6) default NULL,
  `tostring` varchar(255) default NULL,
  `hashed_password` varchar(255) default NULL,
  `salt` varchar(255) default NULL,
  `check` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `people`
--

LOCK TABLES `people` WRITE;
/*!40000 ALTER TABLE `people` DISABLE KEYS */;
INSERT INTO `people` VALUES (1,'johan_sveholm','Sveholm','Johan','スベホルム','ヨハン',1,'','','','','jsveholm@gmail.com','',0,NULL,'','2009-05-28 03:09:26','2009-05-28 03:09:26',0,NULL,'Sveholm Johan','293e15a444975fcb9643fedb3b8cf504bbad8ca7','371323100.598827204426456',NULL),(6,'akira_kurosawa','黒澤','明','クロサワ','アキラ',1,'','','','','akira@docomo.ne.jp','',0,NULL,'','2009-05-28 03:45:05','2009-05-28 03:45:05',0,NULL,'黒澤 明','20177db412e798979b814d1734af9ee1e7fdfbc5','363264800.483587170081733',NULL);
/*!40000 ALTER TABLE `people` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20090506050154'),('20090506053152'),('20090506063956'),('20090506124432'),('20090509102806'),('20090510152348'),('20090511143923'),('20090512095933'),('20090512104601'),('20090512114908'),('20090513140420'),('20090515130716'),('20090519031737'),('20090520064434'),('20090521043834'),('20090521052406'),('20090522133345'),('20090522133714'),('20090523122615'),('20090525033732');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `sessions` (
  `id` int(11) NOT NULL auto_increment,
  `session_id` varchar(255) NOT NULL,
  `data` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_sessions_on_session_id` (`session_id`),
  KEY `index_sessions_on_updated_at` (`updated_at`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES (1,'86c818430abe6504a68fbd888578afef','BAh7ByIKZmxhc2hJQzonQWN0aW9uQ29udHJvbGxlcjo6Rmxhc2g6OkZsYXNo\nSGFzaHsABjoKQHVzZWR7ADoNc2NoZWR1bGVvOg1TY2hlZHVsZQA=\n','2009-05-09 11:43:15','2009-05-09 14:36:02'),(2,'e6ab5932a840b1ffa5cf79dd0000d421','BAh7ByIKZmxhc2hJQzonQWN0aW9uQ29udHJvbGxlcjo6Rmxhc2g6OkZsYXNo\nSGFzaHsABjoKQHVzZWR7ADoNc2NoZWR1bGVvOg1TY2hlZHVsZQA=\n','2009-05-11 08:17:30','2009-05-11 10:20:48'),(3,'e62ca998d64865f8a6fea1a99373cfb9','BAh7BiIKZmxhc2hJQzonQWN0aW9uQ29udHJvbGxlcjo6Rmxhc2g6OkZsYXNo\nSGFzaHsABjoKQHVzZWR7AA==\n','2009-05-12 09:52:33','2009-05-12 11:53:42'),(4,'bf5e574ae9aa44b10c4d81ae0e8083c4','BAh7BiIKZmxhc2hJQzonQWN0aW9uQ29udHJvbGxlcjo6Rmxhc2g6OkZsYXNo\nSGFzaHsABjoKQHVzZWR7AA==\n','2009-05-12 09:52:44','2009-05-12 09:52:44'),(5,'739d6f547cccd935bcef83fdbe7bc540','BAh7BzoNc2NoZWR1bGVvOg1TY2hlZHVsZQAiCmZsYXNoSUM6J0FjdGlvbkNv\nbnRyb2xsZXI6OkZsYXNoOjpGbGFzaEhhc2h7BjoLbm90aWNlIiRLbGFzcyB3\nYXMgc3VjY2Vzc2Z1bGx5IGNyZWF0ZWQuBjoKQHVzZWR7BjsIVA==\n','2009-05-13 13:11:49','2009-05-13 16:35:16'),(6,'fe625215396f4fd80228bd427f82aa1c','BAh7BiIKZmxhc2hJQzonQWN0aW9uQ29udHJvbGxlcjo6Rmxhc2g6OkZsYXNo\nSGFzaHsABjoKQHVzZWR7AA==\n','2009-05-14 10:01:44','2009-05-14 10:01:44'),(7,'dcc234fbab7a87674fa854f6d50824ab','BAh7BzoNc2NoZWR1bGVvOg1TY2hlZHVsZQAiCmZsYXNoSUM6J0FjdGlvbkNv\nbnRyb2xsZXI6OkZsYXNoOjpGbGFzaEhhc2h7AAY6CkB1c2VkewA=\n','2009-05-14 10:01:51','2009-05-14 15:32:01'),(8,'8b52358e75a8fa88c18e9ec154628497','BAh7BzoNc2NoZWR1bGVvOg1TY2hlZHVsZQAiCmZsYXNoSUM6J0FjdGlvbkNv\nbnRyb2xsZXI6OkZsYXNoOjpGbGFzaEhhc2h7AAY6CkB1c2VkewA=\n','2009-05-15 09:55:37','2009-05-15 12:01:52'),(9,'f67be3ef3234f19dcd8a890ac2425eb7','BAh7BiIKZmxhc2hJQzonQWN0aW9uQ29udHJvbGxlcjo6Rmxhc2g6OkZsYXNo\nSGFzaHsABjoKQHVzZWR7AA==\n','2009-05-15 12:09:25','2009-05-15 12:09:25'),(10,'b5b6a8908578bda49393bd0e9fdadd7f','BAh7BzoNc2NoZWR1bGVvOg1TY2hlZHVsZQAiCmZsYXNoSUM6J0FjdGlvbkNv\nbnRyb2xsZXI6OkZsYXNoOjpGbGFzaEhhc2h7AAY6CkB1c2VkewA=\n','2009-05-15 12:09:42','2009-05-15 13:31:38'),(11,'90ad685a6c0d09d3191f7fab82bfd739','BAh7BzoNc2NoZWR1bGVvOg1TY2hlZHVsZQAiCmZsYXNoSUM6J0FjdGlvbkNv\nbnRyb2xsZXI6OkZsYXNoOjpGbGFzaEhhc2h7AAY6CkB1c2VkewA=\n','2009-05-15 13:37:24','2009-05-15 14:55:40'),(12,'ff1110db5f925ae8889437b64f160cbd','BAh7BzoNc2NoZWR1bGVvOg1TY2hlZHVsZQAiCmZsYXNoSUM6J0FjdGlvbkNv\nbnRyb2xsZXI6OkZsYXNoOjpGbGFzaEhhc2h7BjoLbm90aWNlIiNDb2NrIHdh\ncyBzdWNjZXNzZnVsbHkgY3JlYXRlZC4GOgpAdXNlZHsGOwhU\n','2009-05-18 10:06:03','2009-05-18 08:17:09'),(13,'56e9d7a8eaf6d6ca4d18d7bf261159f7','BAh7BzoNc2NoZWR1bGVvOg1TY2hlZHVsZQAiCmZsYXNoSUM6J0FjdGlvbkNv\nbnRyb2xsZXI6OkZsYXNoOjpGbGFzaEhhc2h7AAY6CkB1c2VkewA=\n','2009-05-18 08:18:46','2009-05-18 08:41:43'),(14,'136cb0be0c627c3e6236256cea41cfc3','BAh7ByIKZmxhc2hJQzonQWN0aW9uQ29udHJvbGxlcjo6Rmxhc2g6OkZsYXNo\nSGFzaHsABjoKQHVzZWR7ADoNc2NoZWR1bGVvOg1TY2hlZHVsZQA=\n','2009-05-19 02:52:34','2009-05-19 04:23:35'),(15,'ed27375537fc175c78fe7fd412c60739','BAh7BiIKZmxhc2hJQzonQWN0aW9uQ29udHJvbGxlcjo6Rmxhc2g6OkZsYXNo\nSGFzaHsABjoKQHVzZWR7AA==\n','2009-05-19 09:59:23','2009-05-19 09:59:23'),(16,'d5369a1cc0e8a0ea29a086d8963a4c03','BAh7BzoNc2NoZWR1bGVvOg1TY2hlZHVsZQAiCmZsYXNoSUM6J0FjdGlvbkNv\nbnRyb2xsZXI6OkZsYXNoOjpGbGFzaEhhc2h7AAY6CkB1c2VkewA=\n','2009-05-19 09:59:24','2009-05-19 11:11:43'),(17,'e022c418e05b93ee1dd12b1b5815a394','BAh7BzoNc2NoZWR1bGVvOg1TY2hlZHVsZQAiCmZsYXNoSUM6J0FjdGlvbkNv\nbnRyb2xsZXI6OkZsYXNoOjpGbGFzaEhhc2h7AAY6CkB1c2VkewA=\n','2009-05-20 02:46:44','2009-05-20 09:12:58'),(18,'7ffc86c77aebc3ac8dafdcd4acdf17d6','BAh7BzoNc2NoZWR1bGVvOg1TY2hlZHVsZQAiCmZsYXNoSUM6J0FjdGlvbkNv\nbnRyb2xsZXI6OkZsYXNoOjpGbGFzaEhhc2h7AAY6CkB1c2VkewA=\n','2009-05-21 04:00:10','2009-05-21 08:13:53'),(19,'eef137bea9159f6e3e765c3ecb849046','BAh7ByIKZmxhc2hJQzonQWN0aW9uQ29udHJvbGxlcjo6Rmxhc2g6OkZsYXNo\nSGFzaHsABjoKQHVzZWR7ADoNc2NoZWR1bGVvOg1TY2hlZHVsZQA=\n','2009-05-22 03:08:47','2009-05-22 08:22:23'),(25,'74c9a7a2aa1f8016f7d0e84275d932a7','BAh7CToNc2NoZWR1bGVvOg1TY2hlZHVsZQA6DnBlcnNvbl9pZGkQIgpmbGFz\naElDOidBY3Rpb25Db250cm9sbGVyOjpGbGFzaDo6Rmxhc2hIYXNoewAGOgpA\ndXNlZHsAOhFvcmlnaW5hbF91cmkw\n','2009-05-25 08:02:16','2009-05-25 09:55:38'),(26,'cd502bff551740887091d96a9465ff6f','BAh7CToNc2NoZWR1bGVvOg1TY2hlZHVsZQA6DnBlcnNvbl9pZGkQIgpmbGFz\naElDOidBY3Rpb25Db250cm9sbGVyOjpGbGFzaDo6Rmxhc2hIYXNoewAGOgpA\ndXNlZHsAOhFvcmlnaW5hbF91cmkw\n','2009-05-26 03:00:52','2009-05-26 03:05:03'),(27,'49e18e41684af288b589abc2388a4dda','BAh7CToOcGVyc29uX2lkaRAiCmZsYXNoSUM6J0FjdGlvbkNvbnRyb2xsZXI6\nOkZsYXNoOjpGbGFzaEhhc2h7AAY6CkB1c2VkewA6DXNjaGVkdWxlbzoNU2No\nZWR1bGUAOhFvcmlnaW5hbF91cmkw\n','2009-05-27 06:38:08','2009-05-27 12:25:28'),(28,'d78c42d19e786a3a1441fde7ba47cad7','BAh7CjoNc2NoZWR1bGVvOg1TY2hlZHVsZQA6DnBlcnNvbl9pZGkGOhFvcmln\naW5hbF91cmkwIgpmbGFzaElDOidBY3Rpb25Db250cm9sbGVyOjpGbGFzaDo6\nRmxhc2hIYXNoewAGOgpAdXNlZHsAOg1yZWRpcmVjdCIxL3Blb3BsZT9jYXRl\nZ29yeT0lRTUlOEYlOTclRTglQUMlOUIlRTclOTQlOUY=\n','2009-05-28 03:08:21','2009-05-28 04:30:14');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_classes`
--

DROP TABLE IF EXISTS `student_classes`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `student_classes` (
  `id` int(11) NOT NULL auto_increment,
  `student_id` int(11) default NULL,
  `klass_id` int(11) default NULL,
  `cancel` tinyint(1) default NULL,
  `note` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `student_classes`
--

LOCK TABLES `student_classes` WRITE;
/*!40000 ALTER TABLE `student_classes` DISABLE KEYS */;
INSERT INTO `student_classes` VALUES (2,8,2,0,'','2009-05-21 06:53:57','2009-05-21 08:10:53'),(3,8,2,0,'','2009-05-21 06:54:09','2009-05-21 06:54:20'),(5,9,28,NULL,NULL,'2009-05-22 03:26:55','2009-05-22 08:23:31');
/*!40000 ALTER TABLE `student_classes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_courses`
--

DROP TABLE IF EXISTS `student_courses`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `student_courses` (
  `id` int(11) NOT NULL auto_increment,
  `student_id` int(11) default NULL,
  `course_id` int(11) default NULL,
  `cancel` tinyint(1) default NULL,
  `note` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `student_courses`
--

LOCK TABLES `student_courses` WRITE;
/*!40000 ALTER TABLE `student_courses` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `students` (
  `id` int(11) NOT NULL auto_increment,
  `person_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (3,6,'2009-05-28 03:45:05','2009-05-28 03:45:05');
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (1,'rails','2009-05-25 19:36:32','2009-05-25 19:36:32'),(2,'checkbox','2009-05-25 19:36:32','2009-05-25 19:36:32'),(3,'habtm','2009-05-25 19:36:33','2009-05-25 19:36:33'),(4,'performance','2009-05-25 19:36:33','2009-05-25 19:36:33'),(5,'active-record','2009-05-25 19:36:33','2009-05-25 19:36:33'),(6,'hmt','2009-05-25 19:36:33','2009-05-25 19:36:33'),(7,'log','2009-05-25 19:36:34','2009-05-25 19:36:34'),(8,'filter','2009-05-25 19:36:34','2009-05-25 19:36:34');
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teachers`
--

DROP TABLE IF EXISTS `teachers`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `teachers` (
  `id` int(11) NOT NULL auto_increment,
  `person_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `teachers`
--

LOCK TABLES `teachers` WRITE;
/*!40000 ALTER TABLE `teachers` DISABLE KEYS */;
INSERT INTO `teachers` VALUES (1,1,'2009-05-28 03:09:26','2009-05-28 03:09:26');
/*!40000 ALTER TABLE `teachers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `template_classes`
--

DROP TABLE IF EXISTS `template_classes`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `template_classes` (
  `id` int(11) NOT NULL auto_increment,
  `course_id` int(11) default NULL,
  `course_time_id` int(11) default NULL,
  `day` varchar(255) default NULL,
  `title` varchar(255) default NULL,
  `description` text,
  `inactive` tinyint(1) default NULL,
  `note` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `teacher_id` int(11) default NULL,
  `classroom_id` int(11) default NULL,
  `capacity` int(11) default NULL,
  `start_time` time default NULL,
  `end_time` time default NULL,
  `mail_sending` tinyint(4) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `template_classes`
--

LOCK TABLES `template_classes` WRITE;
/*!40000 ALTER TABLE `template_classes` DISABLE KEYS */;
INSERT INTO `template_classes` VALUES (9,3,2,'Monday','','',0,'','2009-05-07 12:50:35','2009-05-07 12:50:35',NULL,NULL,NULL,NULL,NULL,NULL),(11,1,2,'Monday','','',0,'','2009-05-07 14:28:51','2009-05-07 14:28:51',NULL,NULL,NULL,NULL,NULL,NULL),(12,2,1,'Monday','','',0,'','2009-05-07 14:30:02','2009-05-07 14:30:02',NULL,NULL,NULL,NULL,NULL,NULL),(13,4,1,'Monday','','',0,'','2009-05-07 14:32:49','2009-05-07 14:32:49',NULL,NULL,NULL,NULL,NULL,NULL),(14,1,3,'Tuesday','','',0,'','2009-05-07 14:41:27','2009-05-07 14:41:27',NULL,NULL,NULL,NULL,NULL,NULL),(15,2,4,'Tuesday','','',0,'','2009-05-07 14:43:57','2009-05-07 14:43:57',NULL,NULL,NULL,NULL,NULL,NULL),(16,3,3,'Tuesday','','',0,'','2009-05-07 14:44:24','2009-05-19 03:14:48',NULL,NULL,NULL,'15:00:00','17:00:00',NULL),(17,4,4,'Tuesday','','',0,'','2009-05-07 14:44:39','2009-05-07 14:44:39',NULL,NULL,NULL,NULL,NULL,NULL),(18,1,6,'Wednesday','','',0,'','2009-05-07 14:45:19','2009-05-07 14:45:19',NULL,NULL,NULL,NULL,NULL,NULL),(19,2,5,'Wednesday','','',0,'','2009-05-07 14:45:56','2009-05-07 14:45:56',NULL,NULL,NULL,NULL,NULL,NULL),(20,3,6,'Wednesday','','',0,'','2009-05-07 14:46:15','2009-05-07 14:46:15',NULL,NULL,NULL,NULL,NULL,NULL),(21,4,5,'Wednesday','','',0,'','2009-05-07 14:47:36','2009-05-07 14:47:37',NULL,NULL,NULL,NULL,NULL,NULL),(24,1,7,'Saturday','','',0,'','2009-05-07 14:50:50','2009-05-07 14:50:50',NULL,NULL,NULL,NULL,NULL,NULL),(25,2,8,'Saturday','','',0,'','2009-05-07 14:51:06','2009-05-07 14:51:06',NULL,NULL,NULL,NULL,NULL,NULL),(26,3,7,'Saturday','','',0,'','2009-05-07 14:51:17','2009-05-07 14:51:17',NULL,NULL,NULL,NULL,NULL,NULL),(27,4,8,'Saturday','','',0,'','2009-05-07 14:51:26','2009-05-07 14:51:26',NULL,NULL,NULL,NULL,NULL,NULL),(28,2,9,'Monday','','',0,'','2009-05-07 14:58:33','2009-05-07 14:58:34',NULL,NULL,NULL,NULL,NULL,NULL),(29,1,11,'Monday','','',0,'','2009-05-07 14:59:43','2009-05-07 14:59:43',NULL,NULL,NULL,NULL,NULL,NULL),(30,4,9,'Monday','','',0,'','2009-05-07 15:00:05','2009-05-07 15:00:06',NULL,NULL,NULL,NULL,NULL,NULL),(31,3,11,'Monday','','',0,'','2009-05-07 15:00:13','2009-05-07 15:00:13',NULL,NULL,NULL,NULL,NULL,NULL),(32,2,9,'Tuesday','','',0,'','2009-05-07 15:00:44','2009-05-07 15:00:44',NULL,NULL,NULL,NULL,NULL,NULL),(33,1,11,'Tuesday','','',0,'','2009-05-07 15:01:02','2009-05-07 15:01:02',NULL,NULL,NULL,NULL,NULL,NULL),(34,3,11,'Tuesday','','',0,'','2009-05-07 15:01:10','2009-05-07 15:01:11',NULL,NULL,NULL,NULL,NULL,NULL),(35,4,9,'Tuesday','','',0,'','2009-05-07 15:01:17','2009-05-07 15:01:17',NULL,NULL,NULL,NULL,NULL,NULL),(36,2,9,'Thursday','','',0,'','2009-05-07 15:01:35','2009-05-07 15:01:35',NULL,NULL,NULL,NULL,NULL,NULL),(37,1,11,'Thursday','','',0,'','2009-05-07 15:01:45','2009-05-07 15:01:45',NULL,NULL,NULL,NULL,NULL,NULL),(38,3,11,'Thursday','','',0,'','2009-05-07 15:01:54','2009-05-07 15:01:54',NULL,NULL,NULL,NULL,NULL,NULL),(39,4,9,'Thursday','','',0,'','2009-05-07 15:02:01','2009-05-07 15:02:01',NULL,NULL,NULL,NULL,NULL,NULL),(40,2,9,'Friday','','',0,'','2009-05-07 15:02:26','2009-05-07 15:02:26',NULL,NULL,NULL,NULL,NULL,NULL),(41,1,11,'Friday','','',0,'','2009-05-07 15:02:46','2009-05-07 15:02:46',NULL,NULL,NULL,NULL,NULL,NULL),(42,3,11,'Friday','','',0,'','2009-05-07 15:02:53','2009-05-07 15:02:53',NULL,NULL,NULL,NULL,NULL,NULL),(43,4,9,'Friday','','',0,'','2009-05-07 15:02:59','2009-05-07 15:02:59',NULL,NULL,NULL,NULL,NULL,NULL),(44,6,12,'Monday','','',0,'','2009-05-07 15:36:28','2009-05-07 15:36:28',NULL,NULL,NULL,NULL,NULL,NULL),(45,6,12,'Friday','','',0,'','2009-05-07 15:37:13','2009-05-07 15:37:13',NULL,NULL,NULL,NULL,NULL,NULL),(46,6,13,'Friday','','',0,'','2009-05-07 15:38:21','2009-05-07 15:38:21',NULL,NULL,NULL,NULL,NULL,NULL),(47,6,14,'Friday','','',0,'','2009-05-07 15:38:48','2009-05-07 15:38:48',NULL,NULL,NULL,NULL,NULL,NULL),(48,5,11,'Friday','','',0,'','2009-05-07 15:40:08','2009-05-07 15:40:08',NULL,NULL,NULL,NULL,NULL,NULL),(49,6,9,'Monday','','',0,'','2009-05-07 15:40:53','2009-05-07 15:40:54',NULL,NULL,NULL,NULL,NULL,NULL),(50,5,11,'Monday','','',0,'','2009-05-07 15:41:00','2009-05-07 15:41:00',NULL,NULL,NULL,NULL,NULL,NULL),(51,6,9,'Tuesday','','',0,'','2009-05-07 15:41:11','2009-05-07 15:41:11',NULL,NULL,NULL,NULL,NULL,NULL),(52,5,11,'Tuesday','','',0,'','2009-05-07 15:41:17','2009-05-07 15:41:17',NULL,NULL,NULL,NULL,NULL,NULL),(53,6,9,'Thursday','','',0,'','2009-05-07 15:41:31','2009-05-07 15:41:31',NULL,NULL,NULL,NULL,NULL,NULL),(54,5,11,'Thursday','','',0,'','2009-05-07 15:41:37','2009-05-07 15:41:38',NULL,NULL,NULL,NULL,NULL,NULL),(55,2,13,'Wednesday','','',0,'','2009-05-07 15:42:17','2009-05-07 15:42:18',NULL,NULL,NULL,NULL,NULL,NULL),(56,4,13,'Wednesday','','',0,'','2009-05-07 15:42:30','2009-05-07 15:42:30',NULL,NULL,NULL,NULL,NULL,NULL),(57,2,14,'Wednesday','','',0,'','2009-05-07 15:42:49','2009-05-07 15:42:49',NULL,NULL,NULL,NULL,NULL,NULL),(58,4,14,'Wednesday','','',0,'','2009-05-07 15:42:56','2009-05-07 15:42:57',NULL,NULL,NULL,NULL,NULL,NULL),(59,6,9,'Wednesday','','',0,'','2009-05-07 15:43:57','2009-05-07 15:43:58',NULL,NULL,NULL,NULL,NULL,NULL),(60,2,12,'Saturday','','',0,'','2009-05-08 09:40:59','2009-05-08 09:40:59',NULL,NULL,NULL,NULL,NULL,NULL),(61,2,9,'Saturday','','',0,'','2009-05-08 09:41:17','2009-05-08 09:41:17',NULL,NULL,NULL,NULL,NULL,NULL),(62,1,11,'Saturday','','',0,'','2009-05-08 09:41:39','2009-05-08 09:41:39',NULL,NULL,NULL,NULL,NULL,NULL),(63,4,9,'Saturday','','',0,'','2009-05-08 09:41:53','2009-05-08 09:41:53',NULL,NULL,NULL,NULL,NULL,NULL),(64,4,13,'Saturday','','',0,'','2009-05-08 09:42:18','2009-05-08 09:42:18',NULL,NULL,NULL,NULL,NULL,NULL),(65,4,14,'Saturday','','',0,'','2009-05-08 09:42:57','2009-05-08 09:42:57',NULL,NULL,NULL,NULL,NULL,NULL),(66,3,11,'Saturday','','',0,'','2009-05-08 09:43:25','2009-05-08 09:43:25',NULL,NULL,NULL,NULL,NULL,NULL),(67,3,15,'Saturday','','',0,'','2009-05-08 09:44:53','2009-05-08 09:44:54',NULL,NULL,NULL,NULL,NULL,NULL),(68,3,16,'Saturday','','',0,'','2009-05-08 09:45:33','2009-05-08 09:45:33',NULL,NULL,NULL,NULL,NULL,NULL),(69,5,11,'Saturday','','',0,'','2009-05-08 09:56:08','2009-05-08 09:56:08',NULL,NULL,NULL,NULL,NULL,NULL),(70,6,17,'Saturday','','',0,'','2009-05-08 09:58:46','2009-05-08 09:58:47',NULL,NULL,NULL,NULL,NULL,NULL),(71,6,18,'Saturday','','',0,'','2009-05-08 09:59:33','2009-05-08 09:59:33',NULL,NULL,NULL,NULL,NULL,NULL),(72,8,21,'Tuesday','','',0,'','2009-05-19 03:06:50','2009-05-19 03:06:50',NULL,NULL,NULL,'19:00:00','21:00:00',NULL),(73,3,3,'Tuesday','','',0,'','2009-05-19 03:11:33','2009-05-19 03:15:01',NULL,NULL,NULL,'15:00:00','17:00:00',NULL),(75,4,4,'Tuesday','','',0,'','2009-05-19 03:15:25','2009-05-19 03:15:25',NULL,NULL,NULL,'14:00:00','14:50:00',NULL),(76,1,6,'Wednesday','','',0,'','2009-05-19 04:03:02','2009-05-19 04:03:02',NULL,NULL,NULL,'13:00:00','15:00:00',NULL),(77,2,5,'Wednesday','','',0,'','2009-05-19 04:03:18','2009-05-19 04:03:18',NULL,NULL,NULL,'12:00:00','12:50:00',NULL),(78,3,6,'Wednesday','','',0,'','2009-05-19 04:03:29','2009-05-19 04:03:29',NULL,NULL,NULL,'13:00:00','15:00:00',NULL),(79,4,5,'Wednesday','','',0,'','2009-05-19 04:03:42','2009-05-19 04:03:42',NULL,NULL,NULL,'12:00:00','12:50:00',NULL),(80,2,13,'Wednesday','','',0,'','2009-05-19 04:03:56','2009-05-19 04:03:56',NULL,NULL,NULL,'18:50:00','19:40:00',NULL),(81,2,14,'Wednesday','','',0,'','2009-05-19 04:04:09','2009-05-19 04:04:09',NULL,NULL,NULL,'19:50:00','20:40:00',NULL),(82,4,13,'Wednesday','','',0,'','2009-05-19 04:04:22','2009-05-19 04:04:22',NULL,NULL,NULL,'18:50:00','19:40:00',NULL),(83,4,14,'Wednesday','','',0,'','2009-05-19 04:04:31','2009-05-19 04:04:31',NULL,NULL,NULL,'19:50:00','20:40:00',NULL),(84,6,9,'Wednesday','','',0,'','2009-05-19 04:04:46','2009-05-19 04:04:46',NULL,NULL,NULL,'17:50:00','18:40:00',NULL),(85,7,21,'Wednesday','','',0,'','2009-05-19 04:09:15','2009-05-19 04:09:15',NULL,NULL,NULL,'19:00:00','21:00:00',NULL),(86,7,21,'Wednesday','','',0,'','2009-05-19 04:09:33','2009-05-19 04:09:33',NULL,NULL,NULL,'19:00:00','21:00:00',NULL),(87,9,22,'Wednesday','','',0,'','2009-05-19 04:15:40','2009-05-19 04:20:27',NULL,NULL,NULL,'16:30:00','17:30:00',NULL),(88,2,9,'Thursday','','',0,'','2009-05-21 04:02:26','2009-05-21 04:02:26',NULL,NULL,NULL,'17:50:00','18:40:00',NULL),(89,1,11,'Thursday','','',0,'','2009-05-21 04:02:39','2009-05-21 04:02:39',NULL,NULL,NULL,'18:50:00','20:50:00',NULL),(90,3,11,'Thursday','','',0,'','2009-05-21 04:03:06','2009-05-21 04:03:06',NULL,NULL,NULL,'18:50:00','20:50:00',NULL),(91,4,9,'Thursday','','',0,'','2009-05-21 04:03:20','2009-05-21 04:03:20',NULL,NULL,NULL,'17:50:00','18:40:00',NULL),(92,5,11,'Thursday','','',0,'','2009-05-21 04:03:30','2009-05-21 04:03:30',NULL,NULL,NULL,'18:50:00','20:50:00',NULL),(93,6,9,'Thursday','','',0,'','2009-05-21 04:03:40','2009-05-21 04:03:40',NULL,NULL,NULL,'17:50:00','18:40:00',NULL),(94,10,25,'Thursday','','',0,'','2009-05-21 04:13:04','2009-05-21 04:13:04',NULL,NULL,NULL,'19:00:00','20:00:00',NULL),(95,10,26,'Thursday','','',0,'','2009-05-21 04:13:27','2009-05-21 04:13:27',NULL,NULL,NULL,'20:10:00','21:10:00',NULL),(96,11,27,'Thursday','','',0,'','2009-05-21 04:15:16','2009-05-21 04:25:05',NULL,NULL,NULL,'15:30:00','17:30:00',NULL),(97,12,16,'Thursday','','',0,'','2009-05-21 04:22:30','2009-05-21 04:27:03',NULL,NULL,NULL,'16:30:00','18:30:00',NULL),(98,11,28,'Thursday','','',0,'','2009-05-21 04:22:56','2009-05-21 04:26:00',NULL,NULL,NULL,'16:40:00','17:40:00',NULL),(99,2,9,'Friday','','',0,'','2009-05-22 03:09:36','2009-05-22 03:09:36',NULL,NULL,NULL,'17:50:00','18:40:00',NULL),(100,1,11,'Friday','','',0,'','2009-05-22 03:09:47','2009-05-22 03:09:47',NULL,NULL,NULL,'18:50:00','20:50:00',NULL),(101,4,9,'Friday','','',0,'','2009-05-22 03:10:02','2009-05-22 03:10:02',NULL,NULL,NULL,'17:50:00','18:40:00',NULL),(102,3,11,'Friday','','',0,'','2009-05-22 03:10:17','2009-05-22 03:10:17',NULL,NULL,NULL,'18:50:00','20:50:00',NULL),(103,5,11,'Friday','','',0,'','2009-05-22 03:10:38','2009-05-22 03:10:38',NULL,NULL,NULL,'18:50:00','20:50:00',NULL),(104,6,13,'Friday','','',0,'','2009-05-22 03:10:51','2009-05-22 03:10:51',NULL,NULL,NULL,'18:50:00','19:40:00',NULL),(105,6,14,'Friday','','',0,'','2009-05-22 03:11:03','2009-05-22 03:11:03',NULL,NULL,NULL,'19:50:00','20:40:00',NULL),(106,13,25,'Friday','','',0,'','2009-05-22 03:14:22','2009-05-22 03:14:22',NULL,NULL,NULL,'19:00:00','20:00:00',NULL),(107,13,26,'Friday','','',0,'','2009-05-22 03:14:44','2009-05-22 03:14:44',NULL,NULL,NULL,'20:10:00','21:10:00',NULL),(108,11,29,'Friday','','',0,'','2009-05-22 03:17:19','2009-05-22 03:17:19',NULL,NULL,NULL,'13:30:00','14:30:00',NULL),(109,11,30,'Friday','','',0,'','2009-05-22 03:17:39','2009-05-22 03:17:39',NULL,NULL,NULL,'14:45:00','15:45:00',NULL),(110,11,31,'Friday','','',0,'','2009-05-22 03:18:02','2009-05-22 03:18:02',NULL,NULL,NULL,'16:00:00','17:00:00',NULL),(111,11,32,'Friday','','',0,'','2009-05-22 03:18:29','2009-05-22 03:18:29',NULL,NULL,NULL,'15:30:00','16:30:00',NULL),(112,11,28,'Friday','','',0,'','2009-05-22 03:18:48','2009-05-22 03:18:48',NULL,NULL,NULL,'16:40:00','17:40:00',NULL),(113,14,33,'Friday','','',0,'','2009-05-22 03:19:22','2009-05-22 03:19:22',NULL,NULL,NULL,'17:40:00','18:40:00',NULL),(114,11,33,'Friday','','',0,'','2009-05-22 03:19:46','2009-05-22 03:19:46',NULL,NULL,NULL,'17:40:00','18:40:00',NULL),(115,2,4,'Tuesday','','',0,'','2009-05-26 03:04:00','2009-05-26 03:04:00',NULL,NULL,NULL,'14:00:00','14:50:00',NULL),(116,1,3,'Tuesday','','',0,'','2009-05-26 03:04:07','2009-05-26 03:04:07',NULL,NULL,NULL,'15:00:00','17:00:00',NULL),(117,2,9,'Tuesday','','',0,'','2009-05-26 03:04:13','2009-05-26 03:04:13',NULL,NULL,NULL,'17:50:00','18:40:00',NULL),(118,1,11,'Tuesday','','',0,'','2009-05-26 03:04:19','2009-05-26 03:04:19',NULL,NULL,NULL,'18:50:00','20:50:00',NULL),(119,3,11,'Tuesday','','',0,'','2009-05-26 03:04:29','2009-05-26 03:04:29',NULL,NULL,NULL,'18:50:00','20:50:00',NULL),(120,4,9,'Tuesday','','',0,'','2009-05-26 03:04:37','2009-05-26 03:04:37',NULL,NULL,NULL,'17:50:00','18:40:00',NULL),(121,5,11,'Tuesday','','',0,'','2009-05-26 03:04:44','2009-05-26 03:04:44',NULL,NULL,NULL,'18:50:00','20:50:00',NULL),(122,6,9,'Tuesday','','',0,'','2009-05-26 03:04:52','2009-05-26 03:04:52',NULL,NULL,NULL,'17:50:00','18:40:00',NULL);
/*!40000 ALTER TABLE `template_classes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2009-05-28  4:38:52
