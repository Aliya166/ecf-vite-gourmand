-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : ven. 17 juil. 2026 à 23:44
-- Version du serveur : 10.4.28-MariaDB
-- Version de PHP : 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `vite_gourmand`
--

-- --------------------------------------------------------

--
-- Structure de la table `allergene`
--

CREATE TABLE `allergene` (
  `id` int(11) NOT NULL,
  `libelle` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `allergene`
--

INSERT INTO `allergene` (`id`, `libelle`) VALUES
(1, 'Gluten'),
(2, 'Lait'),
(3, 'Œufs'),
(4, 'Poisson'),
(5, 'Fruits à coque'),
(6, 'Moutarde'),
(7, 'Soja'),
(8, 'Sulfites'),
(9, 'Céleri');

-- --------------------------------------------------------

--
-- Structure de la table `avis`
--

CREATE TABLE `avis` (
  `id` int(11) NOT NULL,
  `note` int(11) NOT NULL,
  `description` longtext NOT NULL,
  `status` varchar(50) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `avis`
--

INSERT INTO `avis` (`id`, `note`, `description`, `status`, `user_id`) VALUES
(7, 5, 'Une excellente expérience ! La livraison a été rapide, les plats étaient encore bien chauds et parfaitement présentés. Les produits sont frais, les portions généreuses et le service très professionnel. Je recommanderai sans hésiter Vite & Gourmand à mes proches.', 'approuve', 17),
(8, 5, 'Très satisfaite de ma commande !', 'approuve', 17),
(9, 5, 'Commande reçue à l’heure prévue. Les plats étaient délicieux, bien emballés et la livraison s’est déroulée sans aucun problème. Un service fiable et de grande qualité. Je commanderai à nouveau avec plaisir !', 'approuve', 18);

-- --------------------------------------------------------

--
-- Structure de la table `commande`
--

CREATE TABLE `commande` (
  `id` int(11) NOT NULL,
  `date_commande` datetime NOT NULL,
  `nombre_personnes` int(11) NOT NULL,
  `status` varchar(255) NOT NULL,
  `commentaire` longtext DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `menu_id` int(11) DEFAULT NULL,
  `date_livraison` date NOT NULL,
  `heure_livraison` time NOT NULL,
  `adresse_livraison` varchar(255) NOT NULL,
  `ville_livraison` varchar(255) NOT NULL,
  `distance_km` double DEFAULT NULL,
  `prix_livraison` decimal(10,2) DEFAULT NULL,
  `reduction` decimal(10,2) DEFAULT NULL,
  `prix_total` decimal(10,2) NOT NULL,
  `mode_contact_client` varchar(50) DEFAULT NULL,
  `motif_annulation` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `commande`
--

INSERT INTO `commande` (`id`, `date_commande`, `nombre_personnes`, `status`, `commentaire`, `user_id`, `menu_id`, `date_livraison`, `heure_livraison`, `adresse_livraison`, `ville_livraison`, `distance_km`, `prix_livraison`, `reduction`, `prix_total`, `mode_contact_client`, `motif_annulation`) VALUES
(37, '2026-07-17 19:45:03', 9, 'prete', NULL, 17, 14, '2026-07-18', '21:45:00', '57 rue du Faubourg Saint Denis', 'Paris 75010', 500.86, 300.51, 28.71, 558.90, NULL, NULL),
(38, '2026-07-17 21:15:03', 9, 'confirmee', NULL, 18, 10, '2026-07-20', '13:30:00', '57 rue du', 'Bordeaux', 0, 0.00, 35.91, 323.19, NULL, NULL),
(39, '2026-07-17 21:17:54', 2, 'terminee', NULL, 17, 15, '2026-07-17', '00:20:00', 'Paris', 'Paris 75010', 502, 301.18, 0.00, 356.58, NULL, NULL),
(40, '2026-07-17 21:21:57', 4, 'terminee', NULL, 18, 14, '2026-07-17', '23:20:00', '57 rue du', 'Bordeaux', 0, 0.00, 0.00, 127.60, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `commande_status_history`
--

CREATE TABLE `commande_status_history` (
  `id` int(11) NOT NULL,
  `status` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `commande_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `commande_status_history`
--

INSERT INTO `commande_status_history` (`id`, `status`, `created_at`, `commande_id`) VALUES
(31, 'en_attente', '2026-07-17 19:45:03', 37),
(32, 'en_attente', '2026-07-17 21:15:03', 38),
(33, 'en_preparation', '2026-07-17 21:15:51', 37),
(34, 'prete', '2026-07-17 21:15:57', 37),
(35, 'confirmee', '2026-07-17 21:16:25', 38),
(36, 'en_attente', '2026-07-17 21:17:54', 39),
(37, 'en_preparation', '2026-07-17 21:18:22', 39),
(38, 'prete', '2026-07-17 21:18:30', 39),
(39, 'livree', '2026-07-17 21:18:36', 39),
(40, 'terminee', '2026-07-17 21:18:43', 39),
(41, 'en_attente', '2026-07-17 21:21:57', 40),
(42, 'confirmee', '2026-07-17 21:22:17', 40),
(43, 'en_preparation', '2026-07-17 21:22:23', 40),
(44, 'prete', '2026-07-17 21:22:29', 40),
(45, 'livree', '2026-07-17 21:22:35', 40),
(46, 'terminee', '2026-07-17 21:22:41', 40);

-- --------------------------------------------------------

--
-- Structure de la table `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20260617155740', '2026-06-17 15:58:54', 26),
('DoctrineMigrations\\Version20260617211005', '2026-06-17 21:11:16', 30),
('DoctrineMigrations\\Version20260618165032', '2026-06-18 16:52:43', 31),
('DoctrineMigrations\\Version20260618165922', '2026-06-18 16:59:53', 83),
('DoctrineMigrations\\Version20260618172443', '2026-06-18 17:25:12', 40),
('DoctrineMigrations\\Version20260618173115', '2026-06-18 17:46:51', 53),
('DoctrineMigrations\\Version20260618182431', '2026-06-18 18:25:03', 47),
('DoctrineMigrations\\Version20260618185519', '2026-06-18 18:55:45', 69),
('DoctrineMigrations\\Version20260618191916', '2026-06-18 19:19:32', 22),
('DoctrineMigrations\\Version20260618192134', '2026-06-18 19:21:45', 8),
('DoctrineMigrations\\Version20260618192353', '2026-06-18 19:24:04', 12),
('DoctrineMigrations\\Version20260618192618', '2026-06-18 19:26:28', 15),
('DoctrineMigrations\\Version20260618193104', '2026-06-18 19:31:14', 81),
('DoctrineMigrations\\Version20260618201015', '2026-06-18 20:10:26', 121),
('DoctrineMigrations\\Version20260618220210', '2026-06-18 22:02:49', 50),
('DoctrineMigrations\\Version20260618223000', '2026-06-18 22:30:35', 81),
('DoctrineMigrations\\Version20260618234540', '2026-06-18 23:45:50', 31),
('DoctrineMigrations\\Version20260619210141', '2026-06-19 21:01:52', 27),
('DoctrineMigrations\\Version20260621213650', '2026-06-21 21:37:01', 46),
('DoctrineMigrations\\Version20260622221240', '2026-06-22 22:12:49', 35),
('DoctrineMigrations\\Version20260622233742', '2026-06-22 23:37:51', 98),
('DoctrineMigrations\\Version20260630222339', '2026-06-30 22:24:26', 90),
('DoctrineMigrations\\Version20260701193833', '2026-07-01 19:38:47', 57),
('DoctrineMigrations\\Version20260704002346', '2026-07-04 00:23:58', 74),
('DoctrineMigrations\\Version20260704004445', '2026-07-04 00:45:05', 80),
('DoctrineMigrations\\Version20260708204747', '2026-07-08 20:48:33', 76),
('DoctrineMigrations\\Version20260708212706', '2026-07-08 21:27:32', 41),
('DoctrineMigrations\\Version20260709152318', '2026-07-09 15:23:51', 34);

-- --------------------------------------------------------

--
-- Structure de la table `gallery_image`
--

CREATE TABLE `gallery_image` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` longtext DEFAULT NULL,
  `image_url` varchar(255) NOT NULL,
  `is_active` tinyint(4) NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `gallery_image`
--

INSERT INTO `gallery_image` (`id`, `title`, `description`, `image_url`, `is_active`, `created_at`) VALUES
(5, 'Salade gourmande au poulet grillé', 'Une salade fraîche préparée avec du poulet grillé, des légumes de saison et des ingrédients soigneusement sélectionnés.', 'menus-hero-6a5a48f007093.png', 1, '2026-07-14 17:23:00'),
(6, 'Des ingrédients frais chaque jour', 'Nous sélectionnons chaque jour des produits frais et de qualité afin de préparer des repas savoureux et équilibrés.', 'legume-6a5a49645fa8c.png', 1, '2026-07-18 17:25:00'),
(7, 'Notre histoire et notre passion', 'Depuis nos débuts, Vite & Gourmand met la passion de la cuisine et la qualité au cœur de chaque repas préparé.', 'about-hero-6a5a49aeac578.png', 1, '2026-07-17 17:26:00'),
(8, 'Menu Fraicheur', 'Un menu équilibré, composé de recettes généreuses et de produits soigneusement sélectionnés pour votre plaisir.', 'fraicheur-6a5a4a1eda7c9.png', 1, '2026-07-16 17:28:00'),
(9, 'Menu Gourmet', 'Une expérience culinaire gourmande pensée pour satisfaire toutes les envies avec des plats faits maison.', 'gourmand-6a5a4a56e3f5d.png', 1, '2026-07-12 17:29:00');

-- --------------------------------------------------------

--
-- Structure de la table `horaire`
--

CREATE TABLE `horaire` (
  `id` int(11) NOT NULL,
  `jour` varchar(50) NOT NULL,
  `heure_overture` varchar(50) NOT NULL,
  `heure_fermeture` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `horaire`
--

INSERT INTO `horaire` (`id`, `jour`, `heure_overture`, `heure_fermeture`) VALUES
(1, 'Lundi - Vendredi', '12:00', '20:00'),
(2, 'Samedi', '18:00', '23:00'),
(3, 'Dimanche', 'Ferme', 'Ferme');

-- --------------------------------------------------------

--
-- Structure de la table `menu`
--

CREATE TABLE `menu` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` longtext DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `is_active` tinyint(4) NOT NULL,
  `create_at` datetime NOT NULL,
  `regime_id` int(11) DEFAULT NULL,
  `theme_id` int(11) DEFAULT NULL,
  `nombre_personne_minimum` int(11) NOT NULL,
  `image_main` varchar(255) DEFAULT NULL,
  `image_second` varchar(255) DEFAULT NULL,
  `image_third` varchar(255) DEFAULT NULL,
  `image_fourth` varchar(255) DEFAULT NULL,
  `stock_disponible` int(11) NOT NULL,
  `conditions` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `menu`
--

INSERT INTO `menu` (`id`, `title`, `description`, `price`, `is_active`, `create_at`, `regime_id`, `theme_id`, `nombre_personne_minimum`, `image_main`, `image_second`, `image_third`, `image_fourth`, `stock_disponible`, `conditions`) VALUES
(9, 'Menu Tradition', 'Un menu généreux aux saveurs classiques, composé de produits frais et de recettes faites maison.', 34.90, 1, '2026-07-17 02:52:00', 4, 1, 4, 'tradition-6a597e7ab7981.png', 'burrata-tomates-pesto-6a597e7ab7c7f.png', 'supreme-poulet-6a597e7ab7e15.png', 'fondant-6a597e7ab7f6e.png', 5, '☑ Produits frais sélectionnés avec soin et préparés le jour même.\n☑ Réservation conseillée au moins 48 heures avant la livraison.\n☑ Commande minimum selon le nombre de personnes indiqué.\n☑ Adaptation possible en fonction des allergies alimentaires.\n☑ Modification de la commande jusqu\'à 24 heures avant la livraison.\n☑ Livraison professionnelle dans toute l\'Île-de-France.'),
(10, 'Menu Océan', 'Un menu raffiné autour du saumon, idéal pour les amateurs de saveurs marines et de cuisine légère.', 39.90, 1, '2026-07-17 03:48:00', 3, 2, 4, 'ocean-6a598aa3d4058.png', 'tartare-saumon-6a598aa3d448e.png', 'saumon-6a598aa3d4613.png', 'tarte-6a598aa3d4771.png', 6, '☑ Produits frais sélectionnés avec soin et préparés le jour même.\n☑ Réservation conseillée au moins 48 heures avant la livraison.\n☑ Commande minimum selon le nombre de personnes indiqué.\n☑ Adaptation possible en fonction des allergies alimentaires.\n☑ Modification de la commande jusqu\'à 24 heures avant la livraison.\n☑ Livraison professionnelle dans toute l\'Île-de-France.'),
(11, 'Menu Italien', 'Une sélection gourmande inspirée de la cuisine italienne, entre produits savoureux, pâtes crémeuses et dessert traditionnel.', 36.60, 1, '2026-07-17 03:53:00', 3, 3, 3, 'italien-6a598bb19b07a.png', 'carpaccio-boeuf-6a598bb19b3a1.png', 'tagliatelles-6a598bb19b552.png', 'tiramisu-6a598bb19b6f5.png', 4, '☑ Produits frais sélectionnés avec soin et préparés le jour même.\n☑ Réservation conseillée au moins 48 heures avant la livraison.\n☑ Commande minimum selon le nombre de personnes indiqué.\n☑ Adaptation possible en fonction des allergies alimentaires.\n☑ Modification de la commande jusqu\'à 24 heures avant la livraison.\n☑ Livraison professionnelle dans toute l\'Île-de-France.'),
(12, 'Menu Méditerranéen', 'Un menu frais et coloré inspiré des saveurs méditerranéennes, composé de légumes, de poisson et d’un dessert fruité.', 35.90, 1, '2026-07-17 03:56:00', 2, 1, 6, 'mediterraneen-6a598c6dd3958.png', 'salade-grecque-6a598c6dd3d2e.png', 'filet-dorade-6a598c6dd3e7a.png', 'panna-cotta-6a598c6dd3fad.png', 5, '☑ Produits frais sélectionnés avec soin et préparés le jour même.\n☑ Réservation conseillée au moins 48 heures avant la livraison.\n☑ Commande minimum selon le nombre de personnes indiqué.\n☑ Adaptation possible en fonction des allergies alimentaires.\n☑ Modification de la commande jusqu\'à 24 heures avant la livraison.\n☑ Livraison professionnelle dans toute l\'Île-de-France.'),
(13, 'Menu Gourmand', 'Un menu chaleureux et généreux, associant une entrée onctueuse, un plat raffiné et un dessert crémeux.', 42.80, 1, '2026-07-17 04:00:00', 3, 2, 5, 'gourmand-6a598d3bac6bd.png', 'voloute-legumes-6a598d3baca5e.png', 'canard-6a598d3bacbc1.png', 'cheesecake-6a598d3bacd0d.png', 10, '☑ Produits frais sélectionnés avec soin et préparés le jour même.\n☑ Réservation conseillée au moins 48 heures avant la livraison.\n☑ Commande minimum selon le nombre de personnes indiqué.\n☑ Adaptation possible en fonction des allergies alimentaires.\n☑ Modification de la commande jusqu\'à 24 heures avant la livraison.\n☑ Livraison professionnelle dans toute l\'Île-de-France.'),
(14, 'Menu Fraîcheur', 'Un menu équilibré et léger, composé de recettes fraîches, de légumes de saison et d’un dessert aux fruits.', 31.90, 1, '2026-07-17 04:03:00', 4, 3, 3, 'fraicheur-6a598e015f495.png', 'cesar-6a598e015f8a4.png', 'poulet-6a598e015fa15.png', 'fruits-6a598e015fb5a.png', 5, '☑ Produits frais sélectionnés avec soin et préparés le jour même.\n☑ Réservation conseillée au moins 48 heures avant la livraison.\n☑ Commande minimum selon le nombre de personnes indiqué.\n☑ Adaptation possible en fonction des allergies alimentaires.\n☑ Modification de la commande jusqu\'à 24 heures avant la livraison.\n☑ Livraison professionnelle dans toute l\'Île-de-France.'),
(15, 'Menu Végétarien', 'Un menu complet sans viande ni poisson, composé de recettes gourmandes et préparées avec des produits frais.', 27.70, 1, '2026-07-17 04:07:00', 1, 1, 2, 'vegetarien-6a598ee646f90.png', 'bruschetta-6a598ee64736f.png', 'risotto-6a598ee6474d9.png', 'mousse-6a598ee64762b.png', 3, '☑ Produits frais sélectionnés avec soin et préparés le jour même.\n☑ Réservation conseillée au moins 48 heures avant la livraison.\n☑ Commande minimum selon le nombre de personnes indiqué.\n☑ Adaptation possible en fonction des allergies alimentaires.\n☑ Modification de la commande jusqu\'à 24 heures avant la livraison.\n☑ Livraison professionnelle dans toute l\'Île-de-France.'),
(16, 'Menu Prestige', 'Un menu élégant conçu pour les grandes occasions, composé de produits raffinés et de recettes gastronomiques.', 54.80, 1, '2026-07-17 04:10:00', 2, 2, 5, 'prestige-6a598fb3543f6.png', 'foie-gras-6a598fb3547d6.png', 'beouf-6a598fb35493a.png', 'opera-6a598fb354a88.png', 7, '☑ Produits frais sélectionnés avec soin et préparés le jour même.\n☑ Réservation conseillée au moins 48 heures avant la livraison.\n☑ Commande minimum selon le nombre de personnes indiqué.\n☑ Adaptation possible en fonction des allergies alimentaires.\n☑ Modification de la commande jusqu\'à 24 heures avant la livraison.\n☑ Livraison professionnelle dans toute l\'Île-de-France.'),
(17, 'Menu Saveurs du Chef', 'Une sélection originale imaginée par le chef, mêlant produits de saison, textures délicates et saveurs raffinées.', 38.90, 1, '2026-07-17 04:13:00', 2, 3, 4, 'saveurs-6a5990884c16e.png', 'carpaccio-betterave-6a5990884c62a.png', 'cabillaud-6a5990884c82c.png', 'creme-6a5990884c98b.png', 4, '☑ Produits frais sélectionnés avec soin et préparés le jour même.\n☑ Réservation conseillée au moins 48 heures avant la livraison.\n☑ Commande minimum selon le nombre de personnes indiqué.\n☑ Adaptation possible en fonction des allergies alimentaires.\n☑ Modification de la commande jusqu\'à 24 heures avant la livraison.\n☑ Livraison professionnelle dans toute l\'Île-de-France.');

-- --------------------------------------------------------

--
-- Structure de la table `menu_plat`
--

CREATE TABLE `menu_plat` (
  `menu_id` int(11) NOT NULL,
  `plat_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `menu_plat`
--

INSERT INTO `menu_plat` (`menu_id`, `plat_id`) VALUES
(9, 5),
(9, 14),
(9, 23),
(10, 6),
(10, 15),
(10, 24),
(11, 7),
(11, 16),
(11, 25),
(12, 8),
(12, 17),
(12, 26),
(13, 9),
(13, 18),
(13, 27),
(14, 10),
(14, 19),
(14, 28),
(15, 5),
(15, 20),
(15, 29),
(16, 12),
(16, 21),
(16, 30),
(17, 13),
(17, 22),
(17, 31);

-- --------------------------------------------------------

--
-- Structure de la table `messenger_messages`
--

CREATE TABLE `messenger_messages` (
  `id` bigint(20) NOT NULL,
  `body` longtext NOT NULL,
  `headers` longtext NOT NULL,
  `queue_name` varchar(190) NOT NULL,
  `created_at` datetime NOT NULL,
  `available_at` datetime NOT NULL,
  `delivered_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `messenger_messages`
--

INSERT INTO `messenger_messages` (`id`, `body`, `headers`, `queue_name`, `created_at`, `available_at`, `delivered_at`) VALUES
(14, 'O:36:\\\"Symfony\\\\Component\\\\Messenger\\\\Envelope\\\":2:{s:44:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Envelope\\0stamps\\\";a:6:{s:46:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\\";a:1:{i:0;O:46:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\\":1:{s:55:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\0busName\\\";s:21:\\\"messenger.bus.default\\\";}}s:51:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\ErrorDetailsStamp\\\";a:1:{i:0;O:51:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\ErrorDetailsStamp\\\":4:{s:67:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\ErrorDetailsStamp\\0exceptionClass\\\";s:62:\\\"Symfony\\\\Component\\\\Mailer\\\\Exception\\\\UnexpectedResponseException\\\";s:66:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\ErrorDetailsStamp\\0exceptionCode\\\";i:550;s:69:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\ErrorDetailsStamp\\0exceptionMessage\\\";s:169:\\\"Expected response code \\\"354\\\" but got code \\\"550\\\", with message \\\"550 5.7.0 Too many emails per second. Please upgrade your plan https://mailtrap.io/billing/plans/testing\\\".\\\";s:69:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\ErrorDetailsStamp\\0flattenException\\\";O:57:\\\"Symfony\\\\Component\\\\ErrorHandler\\\\Exception\\\\FlattenException\\\":12:{s:66:\\\"\\0Symfony\\\\Component\\\\ErrorHandler\\\\Exception\\\\FlattenException\\0message\\\";s:169:\\\"Expected response code \\\"354\\\" but got code \\\"550\\\", with message \\\"550 5.7.0 Too many emails per second. Please upgrade your plan https://mailtrap.io/billing/plans/testing\\\".\\\";s:63:\\\"\\0Symfony\\\\Component\\\\ErrorHandler\\\\Exception\\\\FlattenException\\0code\\\";i:550;s:67:\\\"\\0Symfony\\\\Component\\\\ErrorHandler\\\\Exception\\\\FlattenException\\0previous\\\";N;s:64:\\\"\\0Symfony\\\\Component\\\\ErrorHandler\\\\Exception\\\\FlattenException\\0trace\\\";a:1:{i:0;a:8:{s:9:\\\"namespace\\\";s:0:\\\"\\\";s:11:\\\"short_class\\\";s:0:\\\"\\\";s:5:\\\"class\\\";s:0:\\\"\\\";s:4:\\\"type\\\";s:0:\\\"\\\";s:8:\\\"function\\\";s:0:\\\"\\\";s:4:\\\"file\\\";s:95:\\\"/Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/mailer/Transport/Smtp/SmtpTransport.php\\\";s:4:\\\"line\\\";i:331;s:4:\\\"args\\\";a:0:{}}}s:72:\\\"\\0Symfony\\\\Component\\\\ErrorHandler\\\\Exception\\\\FlattenException\\0traceAsString\\\";s:7557:\\\"#0 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/mailer/Transport/Smtp/SmtpTransport.php(187): Symfony\\\\Component\\\\Mailer\\\\Transport\\\\Smtp\\\\SmtpTransport->assertResponseCode(\\\'550 5.7.0 Too m...\\\', Array)\n#1 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/mailer/Transport/Smtp/EsmtpTransport.php(150): Symfony\\\\Component\\\\Mailer\\\\Transport\\\\Smtp\\\\SmtpTransport->executeCommand(\\\'DATA\\\\r\\\\n\\\', Array)\n#2 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/mailer/Transport/Smtp/SmtpTransport.php(209): Symfony\\\\Component\\\\Mailer\\\\Transport\\\\Smtp\\\\EsmtpTransport->executeCommand(\\\'DATA\\\\r\\\\n\\\', Array)\n#3 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/mailer/Transport/AbstractTransport.php(90): Symfony\\\\Component\\\\Mailer\\\\Transport\\\\Smtp\\\\SmtpTransport->doSend(Object(Symfony\\\\Component\\\\Mailer\\\\SentMessage))\n#4 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/mailer/Transport/Smtp/SmtpTransport.php(138): Symfony\\\\Component\\\\Mailer\\\\Transport\\\\AbstractTransport->send(Object(Symfony\\\\Bridge\\\\Twig\\\\Mime\\\\TemplatedEmail), Object(Symfony\\\\Component\\\\Mailer\\\\DelayedEnvelope))\n#5 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/mailer/Transport/Transports.php(51): Symfony\\\\Component\\\\Mailer\\\\Transport\\\\Smtp\\\\SmtpTransport->send(Object(Symfony\\\\Bridge\\\\Twig\\\\Mime\\\\TemplatedEmail), NULL)\n#6 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/mailer/Messenger/MessageHandler.php(29): Symfony\\\\Component\\\\Mailer\\\\Transport\\\\Transports->send(Object(Symfony\\\\Bridge\\\\Twig\\\\Mime\\\\TemplatedEmail), NULL)\n#7 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/messenger/Middleware/HandleMessageMiddleware.php(148): Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\MessageHandler->__invoke(Object(Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage))\n#8 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/messenger/Middleware/HandleMessageMiddleware.php(90): Symfony\\\\Component\\\\Messenger\\\\Middleware\\\\HandleMessageMiddleware->callHandler(Object(Closure), Object(Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage), NULL, NULL)\n#9 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/messenger/Middleware/SendMessageMiddleware.php(75): Symfony\\\\Component\\\\Messenger\\\\Middleware\\\\HandleMessageMiddleware->handle(Object(Symfony\\\\Component\\\\Messenger\\\\Envelope), Object(Symfony\\\\Component\\\\Messenger\\\\Middleware\\\\TraceableStack))\n#10 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/messenger/Middleware/FailedMessageProcessingMiddleware.php(34): Symfony\\\\Component\\\\Messenger\\\\Middleware\\\\SendMessageMiddleware->handle(Object(Symfony\\\\Component\\\\Messenger\\\\Envelope), Object(Symfony\\\\Component\\\\Messenger\\\\Middleware\\\\TraceableStack))\n#11 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/messenger/Middleware/DispatchAfterCurrentBusMiddleware.php(68): Symfony\\\\Component\\\\Messenger\\\\Middleware\\\\FailedMessageProcessingMiddleware->handle(Object(Symfony\\\\Component\\\\Messenger\\\\Envelope), Object(Symfony\\\\Component\\\\Messenger\\\\Middleware\\\\TraceableStack))\n#12 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/messenger/Middleware/RejectRedeliveredMessageMiddleware.php(41): Symfony\\\\Component\\\\Messenger\\\\Middleware\\\\DispatchAfterCurrentBusMiddleware->handle(Object(Symfony\\\\Component\\\\Messenger\\\\Envelope), Object(Symfony\\\\Component\\\\Messenger\\\\Middleware\\\\TraceableStack))\n#13 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/messenger/Middleware/AddBusNameStampMiddleware.php(35): Symfony\\\\Component\\\\Messenger\\\\Middleware\\\\RejectRedeliveredMessageMiddleware->handle(Object(Symfony\\\\Component\\\\Messenger\\\\Envelope), Object(Symfony\\\\Component\\\\Messenger\\\\Middleware\\\\TraceableStack))\n#14 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/messenger/Middleware/AddDefaultStampsMiddleware.php(33): Symfony\\\\Component\\\\Messenger\\\\Middleware\\\\AddBusNameStampMiddleware->handle(Object(Symfony\\\\Component\\\\Messenger\\\\Envelope), Object(Symfony\\\\Component\\\\Messenger\\\\Middleware\\\\TraceableStack))\n#15 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/messenger/Middleware/TraceableMiddleware.php(36): Symfony\\\\Component\\\\Messenger\\\\Middleware\\\\AddDefaultStampsMiddleware->handle(Object(Symfony\\\\Component\\\\Messenger\\\\Envelope), Object(Symfony\\\\Component\\\\Messenger\\\\Middleware\\\\TraceableStack))\n#16 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/messenger/MessageBus.php(69): Symfony\\\\Component\\\\Messenger\\\\Middleware\\\\TraceableMiddleware->handle(Object(Symfony\\\\Component\\\\Messenger\\\\Envelope), Object(Symfony\\\\Component\\\\Messenger\\\\Middleware\\\\TraceableStack))\n#17 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/messenger/TraceableMessageBus.php(30): Symfony\\\\Component\\\\Messenger\\\\MessageBus->dispatch(Object(Symfony\\\\Component\\\\Messenger\\\\Envelope), Array)\n#18 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/messenger/RoutableMessageBus.php(51): Symfony\\\\Component\\\\Messenger\\\\TraceableMessageBus->dispatch(Object(Symfony\\\\Component\\\\Messenger\\\\Envelope), Array)\n#19 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/messenger/Worker.php(187): Symfony\\\\Component\\\\Messenger\\\\RoutableMessageBus->dispatch(Object(Symfony\\\\Component\\\\Messenger\\\\Envelope))\n#20 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/messenger/Worker.php(126): Symfony\\\\Component\\\\Messenger\\\\Worker->handleMessage(Object(Symfony\\\\Component\\\\Messenger\\\\Envelope), \\\'async\\\')\n#21 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/messenger/Command/ConsumeMessagesCommand.php(283): Symfony\\\\Component\\\\Messenger\\\\Worker->run(Array)\n#22 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/console/Command/Command.php(341): Symfony\\\\Component\\\\Messenger\\\\Command\\\\ConsumeMessagesCommand->execute(Object(Symfony\\\\Component\\\\Console\\\\Input\\\\ArgvInput), Object(Symfony\\\\Component\\\\Console\\\\Output\\\\ConsoleOutput))\n#23 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/console/Application.php(1117): Symfony\\\\Component\\\\Console\\\\Command\\\\Command->run(Object(Symfony\\\\Component\\\\Console\\\\Input\\\\ArgvInput), Object(Symfony\\\\Component\\\\Console\\\\Output\\\\ConsoleOutput))\n#24 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/framework-bundle/Console/Application.php(123): Symfony\\\\Component\\\\Console\\\\Application->doRunCommand(Object(Symfony\\\\Component\\\\Messenger\\\\Command\\\\ConsumeMessagesCommand), Object(Symfony\\\\Component\\\\Console\\\\Input\\\\ArgvInput), Object(Symfony\\\\Component\\\\Console\\\\Output\\\\ConsoleOutput))\n#25 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/console/Application.php(356): Symfony\\\\Bundle\\\\FrameworkBundle\\\\Console\\\\Application->doRunCommand(Object(Symfony\\\\Component\\\\Messenger\\\\Command\\\\ConsumeMessagesCommand), Object(Symfony\\\\Component\\\\Console\\\\Input\\\\ArgvInput), Object(Symfony\\\\Component\\\\Console\\\\Output\\\\ConsoleOutput))\n#26 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/framework-bundle/Console/Application.php(77): Symfony\\\\Component\\\\Console\\\\Application->doRun(Object(Symfony\\\\Component\\\\Console\\\\Input\\\\ArgvInput), Object(Symfony\\\\Component\\\\Console\\\\Output\\\\ConsoleOutput))\n#27 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/console/Application.php(195): Symfony\\\\Bundle\\\\FrameworkBundle\\\\Console\\\\Application->doRun(Object(Symfony\\\\Component\\\\Console\\\\Input\\\\ArgvInput), Object(Symfony\\\\Component\\\\Console\\\\Output\\\\ConsoleOutput))\n#28 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/runtime/Runner/Symfony/ConsoleApplicationRunner.php(49): Symfony\\\\Component\\\\Console\\\\Application->run(Object(Symfony\\\\Component\\\\Console\\\\Input\\\\ArgvInput), Object(Symfony\\\\Component\\\\Console\\\\Output\\\\ConsoleOutput))\n#29 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/autoload_runtime.php(32): Symfony\\\\Component\\\\Runtime\\\\Runner\\\\Symfony\\\\ConsoleApplicationRunner->run()\n#30 /Users/aliya/Desktop/ECF Vite & Gourmand/bin/console(15): require_once(\\\'/Users/aliya/De...\\\')\n#31 {main}\\\";s:64:\\\"\\0Symfony\\\\Component\\\\ErrorHandler\\\\Exception\\\\FlattenException\\0class\\\";s:62:\\\"Symfony\\\\Component\\\\Mailer\\\\Exception\\\\UnexpectedResponseException\\\";s:69:\\\"\\0Symfony\\\\Component\\\\ErrorHandler\\\\Exception\\\\FlattenException\\0statusCode\\\";i:500;s:69:\\\"\\0Symfony\\\\Component\\\\ErrorHandler\\\\Exception\\\\FlattenException\\0statusText\\\";s:21:\\\"Internal Server Error\\\";s:66:\\\"\\0Symfony\\\\Component\\\\ErrorHandler\\\\Exception\\\\FlattenException\\0headers\\\";a:0:{}s:63:\\\"\\0Symfony\\\\Component\\\\ErrorHandler\\\\Exception\\\\FlattenException\\0file\\\";s:95:\\\"/Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/mailer/Transport/Smtp/SmtpTransport.php\\\";s:63:\\\"\\0Symfony\\\\Component\\\\ErrorHandler\\\\Exception\\\\FlattenException\\0line\\\";i:331;s:67:\\\"\\0Symfony\\\\Component\\\\ErrorHandler\\\\Exception\\\\FlattenException\\0asString\\\";N;}}}s:44:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\DelayStamp\\\";a:4:{i:0;O:44:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\DelayStamp\\\":1:{s:51:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\DelayStamp\\0delay\\\";i:988;}i:1;O:44:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\DelayStamp\\\":1:{s:51:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\DelayStamp\\0delay\\\";i:1905;}i:2;O:44:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\DelayStamp\\\":1:{s:51:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\DelayStamp\\0delay\\\";i:3812;}i:3;O:44:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\DelayStamp\\\":1:{s:51:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\DelayStamp\\0delay\\\";i:0;}}s:49:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\RedeliveryStamp\\\";a:4:{i:0;O:49:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\RedeliveryStamp\\\":2:{s:64:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\RedeliveryStamp\\0redeliveredAt\\\";O:17:\\\"DateTimeImmutable\\\":3:{s:4:\\\"date\\\";s:26:\\\"2026-07-01 18:15:02.518880\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:61:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\RedeliveryStamp\\0retryCount\\\";i:1;}i:1;O:49:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\RedeliveryStamp\\\":2:{s:64:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\RedeliveryStamp\\0redeliveredAt\\\";O:17:\\\"DateTimeImmutable\\\":3:{s:4:\\\"date\\\";s:26:\\\"2026-07-01 18:15:03.995235\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:61:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\RedeliveryStamp\\0retryCount\\\";i:2;}i:2;O:49:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\RedeliveryStamp\\\":2:{s:64:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\RedeliveryStamp\\0redeliveredAt\\\";O:17:\\\"DateTimeImmutable\\\":3:{s:4:\\\"date\\\";s:26:\\\"2026-07-01 18:15:04.979679\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:61:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\RedeliveryStamp\\0retryCount\\\";i:3;}i:3;O:49:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\RedeliveryStamp\\\":2:{s:64:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\RedeliveryStamp\\0redeliveredAt\\\";O:17:\\\"DateTimeImmutable\\\":3:{s:4:\\\"date\\\";s:26:\\\"2026-07-01 18:15:07.982246\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:61:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\RedeliveryStamp\\0retryCount\\\";i:0;}}s:57:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\TransportMessageIdStamp\\\";a:1:{i:0;O:57:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\TransportMessageIdStamp\\\":1:{s:61:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\TransportMessageIdStamp\\0id\\\";i:12;}}s:61:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\SentToFailureTransportStamp\\\";a:1:{i:0;O:61:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\SentToFailureTransportStamp\\\":1:{s:83:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\SentToFailureTransportStamp\\0originalReceiverName\\\";s:5:\\\"async\\\";}}}s:45:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Envelope\\0message\\\";O:51:\\\"Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\\":2:{s:60:\\\"\\0Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\0message\\\";O:39:\\\"Symfony\\\\Bridge\\\\Twig\\\\Mime\\\\TemplatedEmail\\\":5:{i:0;s:24:\\\"emails/welcome.html.twig\\\";i:1;N;i:2;a:1:{s:4:\\\"user\\\";O:15:\\\"App\\\\Entity\\\\User\\\":11:{s:19:\\\"\\0App\\\\Entity\\\\User\\0id\\\";i:11;s:22:\\\"\\0App\\\\Entity\\\\User\\0email\\\";s:16:\\\"test13@gmail.com\\\";s:22:\\\"\\0App\\\\Entity\\\\User\\0roles\\\";a:0:{}s:25:\\\"\\0App\\\\Entity\\\\User\\0password\\\";s:8:\\\"e99baaa8\\\";s:26:\\\"\\0App\\\\Entity\\\\User\\0firstname\\\";s:5:\\\"Samba\\\";s:25:\\\"\\0App\\\\Entity\\\\User\\0lastname\\\";s:6:\\\"Kaloga\\\";s:22:\\\"\\0App\\\\Entity\\\\User\\0phone\\\";s:10:\\\"0619886988\\\";s:24:\\\"\\0App\\\\Entity\\\\User\\0address\\\";s:18:\\\"6 Rue Louis Vallin\\\";s:26:\\\"\\0App\\\\Entity\\\\User\\0createdAt\\\";O:17:\\\"DateTimeImmutable\\\":3:{s:4:\\\"date\\\";s:26:\\\"2026-07-01 18:10:16.559705\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:26:\\\"\\0App\\\\Entity\\\\User\\0commandes\\\";O:33:\\\"Doctrine\\\\ORM\\\\PersistentCollection\\\":2:{s:13:\\\"\\0*\\0collection\\\";O:43:\\\"Doctrine\\\\Common\\\\Collections\\\\ArrayCollection\\\":1:{s:53:\\\"\\0Doctrine\\\\Common\\\\Collections\\\\ArrayCollection\\0elements\\\";a:0:{}}s:14:\\\"\\0*\\0initialized\\\";b:1;}s:21:\\\"\\0App\\\\Entity\\\\User\\0avis\\\";O:33:\\\"Doctrine\\\\ORM\\\\PersistentCollection\\\":2:{s:13:\\\"\\0*\\0collection\\\";O:43:\\\"Doctrine\\\\Common\\\\Collections\\\\ArrayCollection\\\":1:{s:53:\\\"\\0Doctrine\\\\Common\\\\Collections\\\\ArrayCollection\\0elements\\\";a:0:{}}s:14:\\\"\\0*\\0initialized\\\";b:1;}}}i:3;a:6:{i:0;N;i:1;N;i:2;N;i:3;N;i:4;a:0:{}i:5;a:2:{i:0;O:37:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\\":2:{s:46:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\0headers\\\";a:3:{s:4:\\\"from\\\";a:1:{i:0;O:47:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:4:\\\"From\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:58:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\\";a:1:{i:0;O:30:\\\"Symfony\\\\Component\\\\Mime\\\\Address\\\":2:{s:39:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\\";s:23:\\\"contact@vitegourmand.fr\\\";s:36:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\\";s:15:\\\"Vite & Gourmand\\\";}}}}s:2:\\\"to\\\";a:1:{i:0;O:47:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:2:\\\"To\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:58:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\\";a:1:{i:0;O:30:\\\"Symfony\\\\Component\\\\Mime\\\\Address\\\":2:{s:39:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\\";s:16:\\\"test13@gmail.com\\\";s:36:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\\";s:0:\\\"\\\";}}}}s:7:\\\"subject\\\";a:1:{i:0;O:48:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\UnstructuredHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:7:\\\"Subject\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:55:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\UnstructuredHeader\\0value\\\";s:30:\\\"Bienvenue chez Vite & Gourmand\\\";}}}s:49:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\0lineLength\\\";i:76;}i:1;N;}}i:4;N;}s:61:\\\"\\0Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\0envelope\\\";N;}}', '[]', 'failed', '2026-07-01 18:15:07', '2026-07-01 18:15:07', NULL),
(15, 'O:36:\\\"Symfony\\\\Component\\\\Messenger\\\\Envelope\\\":2:{s:44:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Envelope\\0stamps\\\";a:6:{s:46:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\\";a:1:{i:0;O:46:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\\":1:{s:55:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\0busName\\\";s:21:\\\"messenger.bus.default\\\";}}s:51:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\ErrorDetailsStamp\\\";a:1:{i:0;O:51:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\ErrorDetailsStamp\\\":4:{s:67:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\ErrorDetailsStamp\\0exceptionClass\\\";s:62:\\\"Symfony\\\\Component\\\\Mailer\\\\Exception\\\\UnexpectedResponseException\\\";s:66:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\ErrorDetailsStamp\\0exceptionCode\\\";i:550;s:69:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\ErrorDetailsStamp\\0exceptionMessage\\\";s:169:\\\"Expected response code \\\"354\\\" but got code \\\"550\\\", with message \\\"550 5.7.0 Too many emails per second. Please upgrade your plan https://mailtrap.io/billing/plans/testing\\\".\\\";s:69:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\ErrorDetailsStamp\\0flattenException\\\";O:57:\\\"Symfony\\\\Component\\\\ErrorHandler\\\\Exception\\\\FlattenException\\\":12:{s:66:\\\"\\0Symfony\\\\Component\\\\ErrorHandler\\\\Exception\\\\FlattenException\\0message\\\";s:169:\\\"Expected response code \\\"354\\\" but got code \\\"550\\\", with message \\\"550 5.7.0 Too many emails per second. Please upgrade your plan https://mailtrap.io/billing/plans/testing\\\".\\\";s:63:\\\"\\0Symfony\\\\Component\\\\ErrorHandler\\\\Exception\\\\FlattenException\\0code\\\";i:550;s:67:\\\"\\0Symfony\\\\Component\\\\ErrorHandler\\\\Exception\\\\FlattenException\\0previous\\\";N;s:64:\\\"\\0Symfony\\\\Component\\\\ErrorHandler\\\\Exception\\\\FlattenException\\0trace\\\";a:1:{i:0;a:8:{s:9:\\\"namespace\\\";s:0:\\\"\\\";s:11:\\\"short_class\\\";s:0:\\\"\\\";s:5:\\\"class\\\";s:0:\\\"\\\";s:4:\\\"type\\\";s:0:\\\"\\\";s:8:\\\"function\\\";s:0:\\\"\\\";s:4:\\\"file\\\";s:95:\\\"/Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/mailer/Transport/Smtp/SmtpTransport.php\\\";s:4:\\\"line\\\";i:331;s:4:\\\"args\\\";a:0:{}}}s:72:\\\"\\0Symfony\\\\Component\\\\ErrorHandler\\\\Exception\\\\FlattenException\\0traceAsString\\\";s:7557:\\\"#0 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/mailer/Transport/Smtp/SmtpTransport.php(187): Symfony\\\\Component\\\\Mailer\\\\Transport\\\\Smtp\\\\SmtpTransport->assertResponseCode(\\\'550 5.7.0 Too m...\\\', Array)\n#1 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/mailer/Transport/Smtp/EsmtpTransport.php(150): Symfony\\\\Component\\\\Mailer\\\\Transport\\\\Smtp\\\\SmtpTransport->executeCommand(\\\'DATA\\\\r\\\\n\\\', Array)\n#2 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/mailer/Transport/Smtp/SmtpTransport.php(209): Symfony\\\\Component\\\\Mailer\\\\Transport\\\\Smtp\\\\EsmtpTransport->executeCommand(\\\'DATA\\\\r\\\\n\\\', Array)\n#3 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/mailer/Transport/AbstractTransport.php(90): Symfony\\\\Component\\\\Mailer\\\\Transport\\\\Smtp\\\\SmtpTransport->doSend(Object(Symfony\\\\Component\\\\Mailer\\\\SentMessage))\n#4 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/mailer/Transport/Smtp/SmtpTransport.php(138): Symfony\\\\Component\\\\Mailer\\\\Transport\\\\AbstractTransport->send(Object(Symfony\\\\Bridge\\\\Twig\\\\Mime\\\\TemplatedEmail), Object(Symfony\\\\Component\\\\Mailer\\\\DelayedEnvelope))\n#5 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/mailer/Transport/Transports.php(51): Symfony\\\\Component\\\\Mailer\\\\Transport\\\\Smtp\\\\SmtpTransport->send(Object(Symfony\\\\Bridge\\\\Twig\\\\Mime\\\\TemplatedEmail), NULL)\n#6 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/mailer/Messenger/MessageHandler.php(29): Symfony\\\\Component\\\\Mailer\\\\Transport\\\\Transports->send(Object(Symfony\\\\Bridge\\\\Twig\\\\Mime\\\\TemplatedEmail), NULL)\n#7 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/messenger/Middleware/HandleMessageMiddleware.php(148): Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\MessageHandler->__invoke(Object(Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage))\n#8 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/messenger/Middleware/HandleMessageMiddleware.php(90): Symfony\\\\Component\\\\Messenger\\\\Middleware\\\\HandleMessageMiddleware->callHandler(Object(Closure), Object(Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage), NULL, NULL)\n#9 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/messenger/Middleware/SendMessageMiddleware.php(75): Symfony\\\\Component\\\\Messenger\\\\Middleware\\\\HandleMessageMiddleware->handle(Object(Symfony\\\\Component\\\\Messenger\\\\Envelope), Object(Symfony\\\\Component\\\\Messenger\\\\Middleware\\\\TraceableStack))\n#10 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/messenger/Middleware/FailedMessageProcessingMiddleware.php(34): Symfony\\\\Component\\\\Messenger\\\\Middleware\\\\SendMessageMiddleware->handle(Object(Symfony\\\\Component\\\\Messenger\\\\Envelope), Object(Symfony\\\\Component\\\\Messenger\\\\Middleware\\\\TraceableStack))\n#11 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/messenger/Middleware/DispatchAfterCurrentBusMiddleware.php(68): Symfony\\\\Component\\\\Messenger\\\\Middleware\\\\FailedMessageProcessingMiddleware->handle(Object(Symfony\\\\Component\\\\Messenger\\\\Envelope), Object(Symfony\\\\Component\\\\Messenger\\\\Middleware\\\\TraceableStack))\n#12 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/messenger/Middleware/RejectRedeliveredMessageMiddleware.php(41): Symfony\\\\Component\\\\Messenger\\\\Middleware\\\\DispatchAfterCurrentBusMiddleware->handle(Object(Symfony\\\\Component\\\\Messenger\\\\Envelope), Object(Symfony\\\\Component\\\\Messenger\\\\Middleware\\\\TraceableStack))\n#13 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/messenger/Middleware/AddBusNameStampMiddleware.php(35): Symfony\\\\Component\\\\Messenger\\\\Middleware\\\\RejectRedeliveredMessageMiddleware->handle(Object(Symfony\\\\Component\\\\Messenger\\\\Envelope), Object(Symfony\\\\Component\\\\Messenger\\\\Middleware\\\\TraceableStack))\n#14 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/messenger/Middleware/AddDefaultStampsMiddleware.php(33): Symfony\\\\Component\\\\Messenger\\\\Middleware\\\\AddBusNameStampMiddleware->handle(Object(Symfony\\\\Component\\\\Messenger\\\\Envelope), Object(Symfony\\\\Component\\\\Messenger\\\\Middleware\\\\TraceableStack))\n#15 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/messenger/Middleware/TraceableMiddleware.php(36): Symfony\\\\Component\\\\Messenger\\\\Middleware\\\\AddDefaultStampsMiddleware->handle(Object(Symfony\\\\Component\\\\Messenger\\\\Envelope), Object(Symfony\\\\Component\\\\Messenger\\\\Middleware\\\\TraceableStack))\n#16 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/messenger/MessageBus.php(69): Symfony\\\\Component\\\\Messenger\\\\Middleware\\\\TraceableMiddleware->handle(Object(Symfony\\\\Component\\\\Messenger\\\\Envelope), Object(Symfony\\\\Component\\\\Messenger\\\\Middleware\\\\TraceableStack))\n#17 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/messenger/TraceableMessageBus.php(30): Symfony\\\\Component\\\\Messenger\\\\MessageBus->dispatch(Object(Symfony\\\\Component\\\\Messenger\\\\Envelope), Array)\n#18 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/messenger/RoutableMessageBus.php(51): Symfony\\\\Component\\\\Messenger\\\\TraceableMessageBus->dispatch(Object(Symfony\\\\Component\\\\Messenger\\\\Envelope), Array)\n#19 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/messenger/Worker.php(187): Symfony\\\\Component\\\\Messenger\\\\RoutableMessageBus->dispatch(Object(Symfony\\\\Component\\\\Messenger\\\\Envelope))\n#20 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/messenger/Worker.php(126): Symfony\\\\Component\\\\Messenger\\\\Worker->handleMessage(Object(Symfony\\\\Component\\\\Messenger\\\\Envelope), \\\'async\\\')\n#21 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/messenger/Command/ConsumeMessagesCommand.php(283): Symfony\\\\Component\\\\Messenger\\\\Worker->run(Array)\n#22 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/console/Command/Command.php(341): Symfony\\\\Component\\\\Messenger\\\\Command\\\\ConsumeMessagesCommand->execute(Object(Symfony\\\\Component\\\\Console\\\\Input\\\\ArgvInput), Object(Symfony\\\\Component\\\\Console\\\\Output\\\\ConsoleOutput))\n#23 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/console/Application.php(1117): Symfony\\\\Component\\\\Console\\\\Command\\\\Command->run(Object(Symfony\\\\Component\\\\Console\\\\Input\\\\ArgvInput), Object(Symfony\\\\Component\\\\Console\\\\Output\\\\ConsoleOutput))\n#24 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/framework-bundle/Console/Application.php(123): Symfony\\\\Component\\\\Console\\\\Application->doRunCommand(Object(Symfony\\\\Component\\\\Messenger\\\\Command\\\\ConsumeMessagesCommand), Object(Symfony\\\\Component\\\\Console\\\\Input\\\\ArgvInput), Object(Symfony\\\\Component\\\\Console\\\\Output\\\\ConsoleOutput))\n#25 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/console/Application.php(356): Symfony\\\\Bundle\\\\FrameworkBundle\\\\Console\\\\Application->doRunCommand(Object(Symfony\\\\Component\\\\Messenger\\\\Command\\\\ConsumeMessagesCommand), Object(Symfony\\\\Component\\\\Console\\\\Input\\\\ArgvInput), Object(Symfony\\\\Component\\\\Console\\\\Output\\\\ConsoleOutput))\n#26 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/framework-bundle/Console/Application.php(77): Symfony\\\\Component\\\\Console\\\\Application->doRun(Object(Symfony\\\\Component\\\\Console\\\\Input\\\\ArgvInput), Object(Symfony\\\\Component\\\\Console\\\\Output\\\\ConsoleOutput))\n#27 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/console/Application.php(195): Symfony\\\\Bundle\\\\FrameworkBundle\\\\Console\\\\Application->doRun(Object(Symfony\\\\Component\\\\Console\\\\Input\\\\ArgvInput), Object(Symfony\\\\Component\\\\Console\\\\Output\\\\ConsoleOutput))\n#28 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/runtime/Runner/Symfony/ConsoleApplicationRunner.php(49): Symfony\\\\Component\\\\Console\\\\Application->run(Object(Symfony\\\\Component\\\\Console\\\\Input\\\\ArgvInput), Object(Symfony\\\\Component\\\\Console\\\\Output\\\\ConsoleOutput))\n#29 /Users/aliya/Desktop/ECF Vite & Gourmand/vendor/autoload_runtime.php(32): Symfony\\\\Component\\\\Runtime\\\\Runner\\\\Symfony\\\\ConsoleApplicationRunner->run()\n#30 /Users/aliya/Desktop/ECF Vite & Gourmand/bin/console(15): require_once(\\\'/Users/aliya/De...\\\')\n#31 {main}\\\";s:64:\\\"\\0Symfony\\\\Component\\\\ErrorHandler\\\\Exception\\\\FlattenException\\0class\\\";s:62:\\\"Symfony\\\\Component\\\\Mailer\\\\Exception\\\\UnexpectedResponseException\\\";s:69:\\\"\\0Symfony\\\\Component\\\\ErrorHandler\\\\Exception\\\\FlattenException\\0statusCode\\\";i:500;s:69:\\\"\\0Symfony\\\\Component\\\\ErrorHandler\\\\Exception\\\\FlattenException\\0statusText\\\";s:21:\\\"Internal Server Error\\\";s:66:\\\"\\0Symfony\\\\Component\\\\ErrorHandler\\\\Exception\\\\FlattenException\\0headers\\\";a:0:{}s:63:\\\"\\0Symfony\\\\Component\\\\ErrorHandler\\\\Exception\\\\FlattenException\\0file\\\";s:95:\\\"/Users/aliya/Desktop/ECF Vite & Gourmand/vendor/symfony/mailer/Transport/Smtp/SmtpTransport.php\\\";s:63:\\\"\\0Symfony\\\\Component\\\\ErrorHandler\\\\Exception\\\\FlattenException\\0line\\\";i:331;s:67:\\\"\\0Symfony\\\\Component\\\\ErrorHandler\\\\Exception\\\\FlattenException\\0asString\\\";N;}}}s:44:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\DelayStamp\\\";a:4:{i:0;O:44:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\DelayStamp\\\":1:{s:51:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\DelayStamp\\0delay\\\";i:905;}i:1;O:44:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\DelayStamp\\\":1:{s:51:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\DelayStamp\\0delay\\\";i:1984;}i:2;O:44:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\DelayStamp\\\":1:{s:51:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\DelayStamp\\0delay\\\";i:4186;}i:3;O:44:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\DelayStamp\\\":1:{s:51:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\DelayStamp\\0delay\\\";i:0;}}s:49:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\RedeliveryStamp\\\";a:4:{i:0;O:49:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\RedeliveryStamp\\\":2:{s:64:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\RedeliveryStamp\\0redeliveredAt\\\";O:17:\\\"DateTimeImmutable\\\":3:{s:4:\\\"date\\\";s:26:\\\"2026-07-01 18:15:02.022163\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:61:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\RedeliveryStamp\\0retryCount\\\";i:1;}i:1;O:49:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\RedeliveryStamp\\\":2:{s:64:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\RedeliveryStamp\\0redeliveredAt\\\";O:17:\\\"DateTimeImmutable\\\":3:{s:4:\\\"date\\\";s:26:\\\"2026-07-01 18:15:03.503842\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:61:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\RedeliveryStamp\\0retryCount\\\";i:2;}i:2;O:49:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\RedeliveryStamp\\\":2:{s:64:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\RedeliveryStamp\\0redeliveredAt\\\";O:17:\\\"DateTimeImmutable\\\":3:{s:4:\\\"date\\\";s:26:\\\"2026-07-01 18:15:04.487510\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:61:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\RedeliveryStamp\\0retryCount\\\";i:3;}i:3;O:49:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\RedeliveryStamp\\\":2:{s:64:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\RedeliveryStamp\\0redeliveredAt\\\";O:17:\\\"DateTimeImmutable\\\":3:{s:4:\\\"date\\\";s:26:\\\"2026-07-01 18:15:09.502160\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:61:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\RedeliveryStamp\\0retryCount\\\";i:0;}}s:57:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\TransportMessageIdStamp\\\";a:1:{i:0;O:57:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\TransportMessageIdStamp\\\":1:{s:61:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\TransportMessageIdStamp\\0id\\\";i:11;}}s:61:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\SentToFailureTransportStamp\\\";a:1:{i:0;O:61:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\SentToFailureTransportStamp\\\":1:{s:83:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\SentToFailureTransportStamp\\0originalReceiverName\\\";s:5:\\\"async\\\";}}}s:45:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Envelope\\0message\\\";O:51:\\\"Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\\":2:{s:60:\\\"\\0Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\0message\\\";O:39:\\\"Symfony\\\\Bridge\\\\Twig\\\\Mime\\\\TemplatedEmail\\\":5:{i:0;s:24:\\\"emails/welcome.html.twig\\\";i:1;N;i:2;a:1:{s:4:\\\"user\\\";O:15:\\\"App\\\\Entity\\\\User\\\":11:{s:19:\\\"\\0App\\\\Entity\\\\User\\0id\\\";i:10;s:22:\\\"\\0App\\\\Entity\\\\User\\0email\\\";s:16:\\\"test12@gmail.com\\\";s:22:\\\"\\0App\\\\Entity\\\\User\\0roles\\\";a:0:{}s:25:\\\"\\0App\\\\Entity\\\\User\\0password\\\";s:8:\\\"0f2457fd\\\";s:26:\\\"\\0App\\\\Entity\\\\User\\0firstname\\\";s:5:\\\"Samba\\\";s:25:\\\"\\0App\\\\Entity\\\\User\\0lastname\\\";s:6:\\\"Kaloga\\\";s:22:\\\"\\0App\\\\Entity\\\\User\\0phone\\\";s:10:\\\"0619886988\\\";s:24:\\\"\\0App\\\\Entity\\\\User\\0address\\\";s:18:\\\"6 Rue Louis Vallin\\\";s:26:\\\"\\0App\\\\Entity\\\\User\\0createdAt\\\";O:17:\\\"DateTimeImmutable\\\":3:{s:4:\\\"date\\\";s:26:\\\"2026-07-01 18:01:48.086229\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:26:\\\"\\0App\\\\Entity\\\\User\\0commandes\\\";O:33:\\\"Doctrine\\\\ORM\\\\PersistentCollection\\\":2:{s:13:\\\"\\0*\\0collection\\\";O:43:\\\"Doctrine\\\\Common\\\\Collections\\\\ArrayCollection\\\":1:{s:53:\\\"\\0Doctrine\\\\Common\\\\Collections\\\\ArrayCollection\\0elements\\\";a:0:{}}s:14:\\\"\\0*\\0initialized\\\";b:1;}s:21:\\\"\\0App\\\\Entity\\\\User\\0avis\\\";O:33:\\\"Doctrine\\\\ORM\\\\PersistentCollection\\\":2:{s:13:\\\"\\0*\\0collection\\\";O:43:\\\"Doctrine\\\\Common\\\\Collections\\\\ArrayCollection\\\":1:{s:53:\\\"\\0Doctrine\\\\Common\\\\Collections\\\\ArrayCollection\\0elements\\\";a:0:{}}s:14:\\\"\\0*\\0initialized\\\";b:1;}}}i:3;a:6:{i:0;N;i:1;N;i:2;N;i:3;N;i:4;a:0:{}i:5;a:2:{i:0;O:37:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\\":2:{s:46:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\0headers\\\";a:3:{s:4:\\\"from\\\";a:1:{i:0;O:47:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:4:\\\"From\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:58:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\\";a:1:{i:0;O:30:\\\"Symfony\\\\Component\\\\Mime\\\\Address\\\":2:{s:39:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\\";s:23:\\\"contact@vitegourmand.fr\\\";s:36:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\\";s:15:\\\"Vite & Gourmand\\\";}}}}s:2:\\\"to\\\";a:1:{i:0;O:47:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:2:\\\"To\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:58:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\\";a:1:{i:0;O:30:\\\"Symfony\\\\Component\\\\Mime\\\\Address\\\":2:{s:39:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\\";s:16:\\\"test12@gmail.com\\\";s:36:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\\";s:0:\\\"\\\";}}}}s:7:\\\"subject\\\";a:1:{i:0;O:48:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\UnstructuredHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:7:\\\"Subject\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:55:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\UnstructuredHeader\\0value\\\";s:30:\\\"Bienvenue chez Vite & Gourmand\\\";}}}s:49:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\0lineLength\\\";i:76;}i:1;N;}}i:4;N;}s:61:\\\"\\0Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\0envelope\\\";N;}}', '[]', 'failed', '2026-07-01 18:15:09', '2026-07-01 18:15:09', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `plat`
--

CREATE TABLE `plat` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` longtext DEFAULT NULL,
  `type_plat` varchar(50) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `is_active` tinyint(4) NOT NULL,
  `create_at` datetime NOT NULL,
  `photo` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `plat`
--

INSERT INTO `plat` (`id`, `name`, `description`, `type_plat`, `price`, `is_active`, `create_at`, `photo`) VALUES
(5, 'Burrata, tomates anciennes & pesto', 'Burrata crémeuse accompagnée de tomates anciennes, roquette, basilic frais et pesto maison.', 'Entrée', 10.90, 1, '2026-07-17 00:54:00', 'burrata-tomates-pesto-6a59618294b8b.png'),
(6, 'Tartare de saumon', 'Saumon frais coupé au couteau, assaisonné au citron, à l’aneth et aux herbes fraîches.', 'Entrée', 11.90, 1, '2026-07-17 00:57:00', 'tartare-saumon-6a596261e55c3.png'),
(7, 'Carpaccio de bœuf', 'Fines tranches de bœuf, roquette, copeaux de parmesan, câpres et vinaigrette maison.', 'Entrée', 11.50, 1, '2026-07-17 01:00:00', 'carpaccio-boeuf-6a5962f7d4e20.png'),
(8, 'Salade grecque', 'Tomates, concombre, feta, olives noires, oignon rouge et herbes méditerranéennes.', 'Entrée', 9.50, 1, '2026-07-17 01:03:00', 'salade-grecque-6a596363acf82.png'),
(9, 'Velouté de légumes', 'Velouté onctueux préparé avec des légumes de saison, des herbes fraîches et une touche de crème.', 'Entrée', 7.90, 1, '2026-07-17 01:04:00', 'voloute-legumes-6a5963d626e05.png'),
(10, 'Salade César', 'Salade romaine, poulet grillé, croûtons, parmesan et sauce César maison.', 'Entrée', 10.90, 1, '2026-07-17 01:06:00', 'cesar-6a59645347496.png'),
(11, 'Bruschetta tomates & mozzarella', 'Pain grillé garni de tomates fraîches, mozzarella, basilic et huile d’olive.', 'Entrée', 8.90, 1, '2026-07-17 01:08:00', 'bruschetta-6a5964c701e7c.png'),
(12, 'Foie gras & pain brioché', 'Foie gras accompagné de pain brioché toasté et d’un confit d’oignons.', 'Entrée', 14.90, 1, '2026-07-17 01:10:00', 'foie-gras-6a596532ca242.png'),
(13, 'Carpaccio de betterave & chèvre frais', 'Fines tranches de betterave, chèvre frais, roquette, noix et vinaigrette balsamique.', 'Entrée', 9.50, 1, '2026-07-17 01:12:00', 'carpaccio-betterave-6a5965ac1e40b.png'),
(14, 'Suprême de poulet rôti, purée maison', 'Suprême de poulet rôti accompagné d’une purée de pommes de terre maison et d’un jus aux herbes.', 'Plats', 18.90, 1, '2026-07-17 01:16:00', 'supreme-poulet-6a596692427b5.png'),
(15, 'Saumon grillé, risotto crémeux', 'Pavé de saumon grillé servi avec un risotto crémeux au parmesan et une touche de citron.', 'Plats', 21.90, 1, '2026-07-17 01:18:00', 'saumon-6a5966f47bf0d.png'),
(16, 'Tagliatelles aux champignons & parmesan', 'Tagliatelles fraîches, champignons poêlés, sauce crémeuse et parmesan affiné.', 'Plats', 17.90, 1, '2026-07-17 01:19:00', 'tagliatelles-6a596758e7f42.png'),
(17, 'Filet de dorade, légumes grillés', 'Filet de dorade rôti accompagné de courgettes, poivrons et oignons grillés.', 'Plats', 20.90, 1, '2026-07-17 01:21:00', 'filet-dorade-6a5967b88a73a.png'),
(18, 'Magret de canard, pommes grenailles', 'Magret de canard rôti, pommes grenailles aux herbes et sauce légèrement réduite.', 'Plats', 21.90, 1, '2026-07-17 01:23:00', 'canard-6a59681b25623.png'),
(19, 'Filet de poulet grillé & légumes', 'Filet de poulet grillé accompagné de légumes de saison rôtis aux herbes.', 'Plats', 17.90, 1, '2026-07-17 01:24:00', 'poulet-6a59686b19b0b.png'),
(20, 'Risotto aux champignons', 'Risotto crémeux aux champignons, parmesan et persil frais.', 'Plats', 16.90, 1, '2026-07-17 01:26:00', 'risotto-6a5968bd26e90.png'),
(21, 'Filet de bœuf, gratin dauphinois', 'Filet de bœuf grillé servi avec un gratin dauphinois fondant et un jus corsé.', 'Plats', 25.80, 1, '2026-07-17 01:27:00', 'beouf-6a596916a3c98.png'),
(22, 'Pavé de cabillaud, purée de patate douce', 'Pavé de cabillaud rôti accompagné d’une purée de patate douce et de légumes grillés.', 'Plats', 21.50, 1, '2026-07-17 01:28:00', 'cabillaud-6a59696ca9dd7.png'),
(23, 'Fondant au chocolat', 'Fondant au chocolat noir au cœur coulant, accompagné d’une touche de crème vanillée.', 'Dessert', 7.50, 1, '2026-07-17 01:45:00', 'fondant-6a596d70c6cc6.png'),
(24, 'Tarte au citron meringuée', 'Tarte au citron acidulée surmontée d’une meringue légèrement caramélisée.', 'Dessert', 7.80, 1, '2026-07-17 01:47:00', 'tarte-6a596dbf8d798.png'),
(25, 'Tiramisu maison', 'Tiramisu traditionnel au mascarpone, café et cacao.', 'Dessert', 7.50, 1, '2026-07-17 01:48:00', 'tiramisu-6a596e0fc9de2.png'),
(26, 'Panna cotta aux fruits rouges', 'Panna cotta vanillée accompagnée d’un coulis de fruits rouges.', 'Dessert', 6.90, 1, '2026-07-17 01:50:00', 'panna-cotta-6a596ea395910.png'),
(27, 'Cheesecake vanille', 'Cheesecake crémeux à la vanille sur une base biscuitée croustillante.', 'Dessert', 7.50, 1, '2026-07-17 01:52:00', 'cheesecake-6a596f0c02d06.png'),
(28, 'Salade de fruits frais', 'Mélange de fruits frais de saison, légèrement parfumé à la menthe.', 'Dessert', 6.50, 1, '2026-07-17 01:54:00', 'fruits-6a596f6096583.png'),
(29, 'Mousse au chocolat', 'Mousse légère et onctueuse préparée avec du chocolat noir.', 'Dessert', 6.90, 1, '2026-07-17 01:55:00', 'mousse-6a596fad1304f.png'),
(30, 'Opéra au café', 'Opéra au café\nEntremets composé de biscuit aux amandes, crème au café et ganache au chocolat.', 'Dessert', 8.90, 1, '2026-07-17 01:57:00', 'opera-6a597005325d4.png'),
(31, 'Crème brûlée', 'Crème vanillée cuite lentement et recouverte d’une fine couche de sucre caramélisé.', 'Dessert', 6.90, 1, '2026-07-17 01:58:00', 'creme-6a5970500a1ee.png');

-- --------------------------------------------------------

--
-- Structure de la table `plat_allergene`
--

CREATE TABLE `plat_allergene` (
  `plat_id` int(11) NOT NULL,
  `allergene_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `plat_allergene`
--

INSERT INTO `plat_allergene` (`plat_id`, `allergene_id`) VALUES
(5, 2),
(5, 5),
(6, 4),
(6, 6),
(7, 2),
(7, 6),
(7, 8),
(8, 2),
(9, 2),
(9, 9),
(10, 1),
(10, 3),
(10, 6),
(11, 1),
(12, 1),
(12, 3),
(12, 8),
(13, 2),
(13, 5),
(13, 6),
(13, 8),
(14, 2),
(14, 9),
(15, 4),
(16, 1),
(16, 3),
(17, 4),
(18, 8),
(21, 8),
(21, 9),
(22, 4),
(23, 1),
(23, 2),
(23, 3),
(23, 7),
(24, 1),
(24, 3),
(25, 1),
(25, 3),
(26, 2),
(27, 1),
(27, 2),
(27, 3),
(29, 1),
(29, 2),
(29, 7),
(30, 1),
(30, 2),
(30, 3),
(30, 5),
(30, 7),
(31, 2),
(31, 3);

-- --------------------------------------------------------

--
-- Structure de la table `regime`
--

CREATE TABLE `regime` (
  `id` int(11) NOT NULL,
  `libelle` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `regime`
--

INSERT INTO `regime` (`id`, `libelle`) VALUES
(1, 'Végétarien'),
(2, 'Sans gluten'),
(3, 'Sans lactose'),
(4, 'Halal'),
(5, 'Vegan');

-- --------------------------------------------------------

--
-- Structure de la table `reset_password_request`
--

CREATE TABLE `reset_password_request` (
  `id` int(11) NOT NULL,
  `selector` varchar(20) NOT NULL,
  `hashed_token` varchar(100) NOT NULL,
  `requested_at` datetime NOT NULL,
  `expires_at` datetime NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `reset_password_request`
--

INSERT INTO `reset_password_request` (`id`, `selector`, `hashed_token`, `requested_at`, `expires_at`, `user_id`) VALUES
(11, 'OpYznDteqdcOKFDjt5Lk', 'gQdCyWo34Rrd4G3NQ1LiKR1xrkcVzJMh4LqR+wjif9w=', '2026-07-17 21:29:15', '2026-07-17 22:29:15', 18);

-- --------------------------------------------------------

--
-- Structure de la table `theme`
--

CREATE TABLE `theme` (
  `id` int(11) NOT NULL,
  `libelle` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `theme`
--

INSERT INTO `theme` (`id`, `libelle`) VALUES
(1, 'Anniversaire'),
(2, 'Mariage'),
(3, 'Business');

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `email` varchar(180) NOT NULL,
  `roles` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`roles`)),
  `password` varchar(255) NOT NULL,
  `firstname` varchar(100) NOT NULL,
  `lastname` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `address` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `email`, `roles`, `password`, `firstname`, `lastname`, `phone`, `address`, `created_at`) VALUES
(1, 'alisazamkovaya@gmail.com', '[\"ROLE_ADMIN\"]', '$2y$13$43Bh.emo82/lx43eILv6Y.kYCifsexmo729nQKcITtzw8xZJeBmr.', 'Alisa', 'Zamkovaya', '1234567890', '77 avenue de l\'arche', '2026-06-17 16:25:51'),
(14, 'employee@gmail.com', '[\"ROLE_EMPLOYE\"]', '$2y$13$lYdbW.sTjmZ2vuJ/8bvrce0MbQ5DlAG7D6/QGlFEdFLLElg5XCDRW', 'Khamzat', 'Vagapov', '0758306416', '77 avenue de l\'arche', '2026-07-03 23:24:53'),
(17, 'client1@gmail.com', '[]', '$2y$13$JKi4xFMjWdt/JIwD8UNAGOJye45F6muwyGENdqvSdiPDyqL3NJqpW', 'Daria', 'Wayn', '123456789', 'Paris,France', '2026-07-17 15:33:00'),
(18, 'aliyazamkova@gmail.com', '[]', '$2y$13$rqasZ2DtdQgJYXLIisOohOzP85Zz6AEGVKz2lT/RarsFS9e0AzCw.', 'Aliya', 'Zamkova', '0649623344', '6 Rue Louis Vallin', '2026-07-17 21:13:25');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `allergene`
--
ALTER TABLE `allergene`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `avis`
--
ALTER TABLE `avis`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_8F91ABF0A76ED395` (`user_id`);

--
-- Index pour la table `commande`
--
ALTER TABLE `commande`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_6EEAA67DA76ED395` (`user_id`),
  ADD KEY `IDX_6EEAA67DCCD7E912` (`menu_id`);

--
-- Index pour la table `commande_status_history`
--
ALTER TABLE `commande_status_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_EA31081482EA2E54` (`commande_id`);

--
-- Index pour la table `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Index pour la table `gallery_image`
--
ALTER TABLE `gallery_image`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `horaire`
--
ALTER TABLE `horaire`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_7D053A9335E7D534` (`regime_id`),
  ADD KEY `IDX_7D053A9359027487` (`theme_id`);

--
-- Index pour la table `menu_plat`
--
ALTER TABLE `menu_plat`
  ADD PRIMARY KEY (`menu_id`,`plat_id`),
  ADD KEY `IDX_E8775249CCD7E912` (`menu_id`),
  ADD KEY `IDX_E8775249D73DB560` (`plat_id`);

--
-- Index pour la table `messenger_messages`
--
ALTER TABLE `messenger_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_75EA56E0FB7336F0E3BD61CE16BA31DBBF396750` (`queue_name`,`available_at`,`delivered_at`,`id`);

--
-- Index pour la table `plat`
--
ALTER TABLE `plat`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `plat_allergene`
--
ALTER TABLE `plat_allergene`
  ADD PRIMARY KEY (`plat_id`,`allergene_id`),
  ADD KEY `IDX_6FA44BBFD73DB560` (`plat_id`),
  ADD KEY `IDX_6FA44BBF4646AB2` (`allergene_id`);

--
-- Index pour la table `regime`
--
ALTER TABLE `regime`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `reset_password_request`
--
ALTER TABLE `reset_password_request`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_7CE748AA76ED395` (`user_id`);

--
-- Index pour la table `theme`
--
ALTER TABLE `theme`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_IDENTIFIER_EMAIL` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `allergene`
--
ALTER TABLE `allergene`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `avis`
--
ALTER TABLE `avis`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `commande`
--
ALTER TABLE `commande`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT pour la table `commande_status_history`
--
ALTER TABLE `commande_status_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT pour la table `gallery_image`
--
ALTER TABLE `gallery_image`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `horaire`
--
ALTER TABLE `horaire`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `menu`
--
ALTER TABLE `menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT pour la table `messenger_messages`
--
ALTER TABLE `messenger_messages`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT pour la table `plat`
--
ALTER TABLE `plat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT pour la table `regime`
--
ALTER TABLE `regime`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `reset_password_request`
--
ALTER TABLE `reset_password_request`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT pour la table `theme`
--
ALTER TABLE `theme`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `avis`
--
ALTER TABLE `avis`
  ADD CONSTRAINT `FK_8F91ABF0A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Contraintes pour la table `commande`
--
ALTER TABLE `commande`
  ADD CONSTRAINT `FK_6EEAA67DA76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `FK_6EEAA67DCCD7E912` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`);

--
-- Contraintes pour la table `commande_status_history`
--
ALTER TABLE `commande_status_history`
  ADD CONSTRAINT `FK_EA31081482EA2E54` FOREIGN KEY (`commande_id`) REFERENCES `commande` (`id`);

--
-- Contraintes pour la table `menu`
--
ALTER TABLE `menu`
  ADD CONSTRAINT `FK_7D053A9335E7D534` FOREIGN KEY (`regime_id`) REFERENCES `regime` (`id`),
  ADD CONSTRAINT `FK_7D053A9359027487` FOREIGN KEY (`theme_id`) REFERENCES `theme` (`id`);

--
-- Contraintes pour la table `menu_plat`
--
ALTER TABLE `menu_plat`
  ADD CONSTRAINT `FK_E8775249CCD7E912` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_E8775249D73DB560` FOREIGN KEY (`plat_id`) REFERENCES `plat` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `plat_allergene`
--
ALTER TABLE `plat_allergene`
  ADD CONSTRAINT `FK_6FA44BBF4646AB2` FOREIGN KEY (`allergene_id`) REFERENCES `allergene` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_6FA44BBFD73DB560` FOREIGN KEY (`plat_id`) REFERENCES `plat` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `reset_password_request`
--
ALTER TABLE `reset_password_request`
  ADD CONSTRAINT `FK_7CE748AA76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
