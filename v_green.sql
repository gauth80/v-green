-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le :  lun. 06 avr. 2020 à 23:20
-- Version du serveur :  5.7.26
-- Version de PHP :  7.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `v_green`
--

-- --------------------------------------------------------

--
-- Structure de la table `categorie`
--

DROP TABLE IF EXISTS `categorie`;
CREATE TABLE IF NOT EXISTS `categorie` (
  `cat_id` int(11) NOT NULL AUTO_INCREMENT,
  `cat_name` varchar(50) DEFAULT NULL COMMENT 'nom de la categorie',
  PRIMARY KEY (`cat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `categorie`
--

INSERT INTO `categorie` (`cat_id`, `cat_name`) VALUES
(1, 'guitare'),
(2, 'batterie'),
(3, 'piano'),
(4, 'studio'),
(5, 'eclairage'),
(6, 'dj'),
(7, 'cases'),
(8, 'accessoires'),
(9, 'instrument a vent');

-- --------------------------------------------------------

--
-- Structure de la table `clients`
--

DROP TABLE IF EXISTS `clients`;
CREATE TABLE IF NOT EXISTS `clients` (
  `cli_id` int(11) NOT NULL AUTO_INCREMENT,
  `cli_slug` varchar(50) DEFAULT NULL COMMENT 'Identifiant non physique du client',
  `cli_name` varchar(50) DEFAULT NULL COMMENT 'nom du client',
  `cli_surname` varchar(50) DEFAULT NULL COMMENT 'prenom ou pseudo du client',
  `cli_mail` varchar(50) DEFAULT NULL COMMENT 'adresse mail du client',
  `cli_tel` varchar(14) DEFAULT NULL COMMENT 'numéro téléphonique du client',
  `cli_password` char(60) DEFAULT NULL COMMENT 'mot de passe du client',
  `cli_created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'date de création du client',
  `cli_street` varchar(100) DEFAULT NULL COMMENT 'adresse physique du client',
  `cli_city` varchar(50) DEFAULT NULL COMMENT 'ville du client',
  `cli_zipcode` varchar(5) DEFAULT NULL COMMENT 'code postal du client',
  PRIMARY KEY (`cli_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `commande`
--

DROP TABLE IF EXISTS `commande`;
CREATE TABLE IF NOT EXISTS `commande` (
  `com_id` int(11) NOT NULL AUTO_INCREMENT,
  `com_created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'date de création de la commande',
  `com_slug` varchar(50) DEFAULT NULL COMMENT 'slug du client référent',
  `com_ref` varchar(50) DEFAULT NULL COMMENT 'la ref associer au produit',
  PRIMARY KEY (`com_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `fournisseur`
--

DROP TABLE IF EXISTS `fournisseur`;
CREATE TABLE IF NOT EXISTS `fournisseur` (
  `fou_id` int(11) NOT NULL AUTO_INCREMENT,
  `fou_name` varchar(100) DEFAULT NULL COMMENT 'nom du fournisseur',
  `fou_tel` varchar(14) DEFAULT NULL COMMENT 'numéro téléphonique du fournisseur',
  `fou_mail` varchar(100) DEFAULT NULL COMMENT 'mail du fournisseur',
  `fou_siret` int(14) DEFAULT NULL COMMENT 'siret du fournisseur, sert de slug',
  `fou_street` varchar(100) DEFAULT NULL COMMENT 'adresse physique du fournisseur',
  `fou_city` varchar(100) DEFAULT NULL COMMENT 'ville du fournisseur',
  `fou_contact` varchar(50) DEFAULT NULL COMMENT 'référent du fournisseur',
  `fou_price` decimal(7,2) DEFAULT NULL COMMENT 'prix du fournisseur, max 99 999.99',
  PRIMARY KEY (`fou_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `ligne_de_commande`
--

DROP TABLE IF EXISTS `ligne_de_commande`;
CREATE TABLE IF NOT EXISTS `ligne_de_commande` (
  `ldc_id` int(11) NOT NULL AUTO_INCREMENT,
  `ldc_created` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'création de l’expédition de la commande',
  `ldc_slug` varchar(11) DEFAULT NULL COMMENT 'slug de la reférence du produit associer',
  PRIMARY KEY (`ldc_id`),
  KEY `FK_co_id` (`ldc_slug`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `livraison`
--

DROP TABLE IF EXISTS `livraison`;
CREATE TABLE IF NOT EXISTS `livraison` (
  `liv_id` int(11) NOT NULL AUTO_INCREMENT,
  `liv_slug_cli` varchar(50) DEFAULT NULL COMMENT 'slug du client',
  `liv_slug_ref` varchar(11) DEFAULT NULL COMMENT 'slug du produit(via ref)',
  `liv_created` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'date de la création de l''expédition ',
  PRIMARY KEY (`liv_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `personnels`
--

DROP TABLE IF EXISTS `personnels`;
CREATE TABLE IF NOT EXISTS `personnels` (
  `per_id` int(11) NOT NULL AUTO_INCREMENT,
  `per_name` varchar(100) DEFAULT NULL COMMENT 'nom du personnel',
  `per_surname` varchar(50) DEFAULT NULL COMMENT 'prénom du personnel',
  `per_slug` varchar(20) DEFAULT NULL COMMENT 'slug du personnel',
  `per_mail` varchar(50) DEFAULT NULL COMMENT 'mail du personnel',
  `per_tel` varchar(14) DEFAULT NULL COMMENT 'numéro téléphonique du personnel',
  `per_password` char(60) DEFAULT NULL COMMENT 'mot de passe du personnel',
  PRIMARY KEY (`per_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `produits`
--

DROP TABLE IF EXISTS `produits`;
CREATE TABLE IF NOT EXISTS `produits` (
  `pro_id` int(11) NOT NULL AUTO_INCREMENT,
  `pro_slug` varchar(11) DEFAULT NULL COMMENT 'slug/référence du produit',
  `pro_lib` varchar(50) DEFAULT NULL COMMENT 'libelle du produit',
  `pro_desc` varchar(1000) DEFAULT NULL COMMENT 'description du produit',
  `pro_price` decimal(7,2) DEFAULT NULL COMMENT 'prix du produit, max 99 999.99',
  `pro_stock` int(11) DEFAULT NULL COMMENT 'nombre de produits en stock',
  `pro_ext` varchar(4) DEFAULT NULL COMMENT 'extension de l''img',
  `pro_created` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'date de mise en rayon',
  `pro_hydrate` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'date de la mise à jour (update/hydrate)',
  `pro_block` tinyint(1) DEFAULT NULL COMMENT 'blocage du produit',
  `pro_alt` varchar(200) DEFAULT NULL COMMENT 'texte alternatif du produit',
  `pro_title` varchar(100) DEFAULT NULL COMMENT 'titre du produit / attr title',
  `pro_cat_id` int(11) DEFAULT NULL COMMENT 'numéro de la catégorie',
  `pro_fou_id` int(11) DEFAULT NULL COMMENT 'numéro du fournisseur',
  PRIMARY KEY (`pro_id`),
  KEY `FK_cat_id` (`pro_cat_id`),
  KEY `FK_fourni_id` (`pro_fou_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `produits`
--

INSERT INTO `produits` (`pro_id`, `pro_slug`, `pro_lib`, `pro_desc`, `pro_price`, `pro_stock`, `pro_ext`, `pro_created`, `pro_hydrate`, `pro_block`, `pro_alt`, `pro_title`, `pro_cat_id`, `pro_fou_id`) VALUES
(1, 'gui000', 'guitare acoustique', 'Harley Benton est une marque créée pour et distribuée par le détaillant allemand Thomann. Créée en 19971, elle propose des guitares, basses, banjos, mandolines, microphones, amplificateurs, pédales d\'effet, des cordes, des médiators, des pièces détachées, etc., souvent à des prix peu élevés (qui s\'expliquent en partie par une fabrication uniquement asiatique et donc très bon marché). Le succès de cette marque s\'inscrit dans une tendance de fond d\'amélioration de la qualité des instruments peu chers.', '75.00', 6, 'png', '2020-04-01 22:00:00', '2020-04-02 17:46:35', 1, 'Harley Benton D-120CE BK', 'Harley Benton D-120CE BK', 1, NULL),
(2, 'gui001', 'guitare classique', 'La manche et la table de ce modèle d\'instrument sont faites en épicéa de Californie avec un dos et côté en érable', '39.55', 2, 'png', '2020-04-01 22:00:00', '2020-04-02 17:46:40', 1, 'Delson Sevilla guitare classique', 'Delson Sevilla guitare classique', 1, NULL),
(3, 'gui003', 'electro acoustique', 'L\'ES-335 était une tentative de trouver un terrain d\'entente: un ton plus chaud qu\'un corps solide produit avec presque aussi peu de rétroaction', '267.50', 2, 'png', '2020-04-01 22:00:00', '2020-04-02 19:37:58', 1, 'Gibson ES 335', 'Gibson ES 335', 1, NULL),
(4, 'bass000', 'basse electrique', 'Le Thunderbird a été conçu par le concepteur automobile américain Raymond H. Dietrich (Chrysler, Lincoln, Checker)', '1999.99', 1, 'png', '2020-04-01 22:00:00', '2020-04-02 19:38:19', 1, 'Gibson Thunderbird', 'Gibson Thunderbird', 1, NULL),
(5, 'bass001', 'basse acoustique', 'Le premier modèle simplement appelé \"Les Paul Bass\", avait quelques caractéristiques intéressantes, notamment des circuits basse impédance, spécialement conçus pour l\'enregistrement en studio.\r\n', '2039.00', 0, 'png', '2020-04-01 22:00:00', '2020-04-02 19:37:21', 1, 'Gibson Lespaul', 'Gibson Lespaul', 1, NULL),
(6, 'bass002', 'basse semi acoustique', 'Basse semi acoustique en l\'honneur de Pat Martino.', '3449.99', 0, 'png', '2020-04-01 22:00:00', '2020-04-02 19:56:40', 1, 'gipson pat martino', 'gipson pat martino', 1, NULL),
(7, 'uku000', 'ukulélés', 'Who lives in a pineapple under the sea?\r\nSpongebob Squarepant!', '14.99', 0, 'png', '2020-04-01 22:00:00', '2020-04-02 20:07:53', 1, 'ukulélés', 'ukulélés', 1, NULL),
(8, 'vio000', 'other cord', 'Le violon est un instrument de musique à cordes frottées. Constitué de 71 éléments de bois collés ou assemblés les uns aux autres..', '155.00', 3, 'png', '2020-04-01 22:00:00', '2020-04-02 20:12:34', 1, 'Stentor SR1500', 'Stentor SR1500', 1, NULL),
(9, 'bat000', 'batterie', 'Les batteries pour débutants.', '550.50', 1, 'png', '2020-04-01 22:00:00', '2020-04-02 20:20:44', 1, 'batterie Pearl', 'batterie Pearl', 2, NULL),
(10, 'pia000', 'piano de scène', 'Un clavier électronique, un clavier portable ou un clavier numérique est un instrument de musique électronique.', '1256.00', 2, 'png', '2020-04-01 22:00:00', '2020-04-02 20:28:50', 1, 'Kawai ES-8 B', 'Kawai ES-8 B', 3, NULL),
(11, 'stu000', 'console de mixage', 'Les consoles analogiques de la série 68 ont été développées pour fournir l\'ensemble de fonctionnalités de base le plus souvent nécessaire pour l\'enregistrement analogique.', '9999.99', 1, 'png', '2020-04-01 22:00:00', '2020-04-02 20:41:16', 1, 'Trident audio', 'Trident audio', 4, NULL),
(12, 'ecl000', 'projecteur', 'éclairage led dmx512 classique.', '56.75', 4, 'png', '2020-04-01 22:00:00', '2020-04-02 21:09:45', 1, 'Projecteur LED DMX512', 'Projecteur LED DMX512', 5, NULL),
(13, 'tab000', 'table de dj', 'une table de dj, houlala vive la description..', '1429.00', 1, 'png', '2020-04-01 22:00:00', '2020-04-02 21:19:34', 1, 'FF-4000', 'FF-4000', 6, NULL),
(14, 'cas000', 'cases', 'c\'est une boite, voila.', '129.00', 4, 'png', '2020-04-01 22:00:00', '2020-04-02 21:27:54', 1, 'flyht pro case', 'flyht pro case', 7, NULL),
(15, 'acc000', 'micro', 'etrange outil porteur de maladie mais qui permet d\'être audible, après tout dépend de celui qui l\'utilise.', '366.66', 6, 'png', '2020-04-01 22:00:00', '2020-04-02 21:27:54', 1, 'micro shure sm7b', 'micro shure sm7b', 8, NULL),
(16, 'acc001', 'cable', 'Un câble d’amplis', '14.99', 12, 'png', '2020-04-01 22:00:00', '2020-04-02 21:30:53', 1, 'cordial cfu 1.5', 'cordial cfu 1.5', 8, NULL),
(17, 'ven000', 'saxophone', 'Le saxophone est un instrument de musique à vent appartenant à la famille des bois. Il a été inventé par le Belge Adolphe Sax et breveté à Paris le 21 mars 1846.', '620.00', 4, 'png', '2020-04-01 22:00:00', '2020-04-02 21:34:35', 1, 'startone sas-75 alto', 'startone sas-75 alto', 9, NULL),
(18, 'ref000', 'cat_gui', 'lorem... a bah nan', '120.00', 0, 'png', '2020-04-04 22:00:00', '2020-04-05 05:27:26', 0, 'guitare', 'guitare', 1, NULL),
(19, 'ref001', 'cat_bat', NULL, '499.99', 0, 'png', '2020-04-04 22:00:00', '2020-04-05 05:27:26', 0, 'batterie', 'batterie', 2, NULL),
(20, 'ref002', 'cat_pia', NULL, '2499.90', 0, 'png', '2020-04-04 22:00:00', '2020-04-05 05:35:06', 0, 'piano', 'piano', 3, NULL),
(21, 'ref003', 'cat_mic', NULL, '99.10', 0, 'png', '2020-04-04 22:00:00', '2020-04-05 05:35:06', 0, 'micro', 'micro', 8, NULL),
(22, 'ref004', 'cat_son', NULL, '7999.99', 0, 'png', '2020-04-04 22:00:00', '2020-04-05 05:41:33', 0, 'sono', 'sono', 6, NULL),
(23, 'ref005', 'cat_cas', NULL, '129.66', 0, 'png', '2020-04-04 22:00:00', '2020-04-05 05:41:33', 0, 'cases', 'cases', 7, NULL),
(24, 'ref006', 'cat_acc', NULL, '9.99', 0, 'png', '2020-04-04 22:00:00', '2020-04-05 05:44:28', 0, 'câble', 'câble', 8, NULL),
(25, 'ref007', 'cat_sax', NULL, '880.00', 0, 'png', '2020-04-04 22:00:00', '2020-04-05 05:46:18', 0, 'saxophone', 'saxophone', 9, NULL);
-- COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
