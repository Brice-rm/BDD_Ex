-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : lun. 25 jan. 2021 à 13:36
-- Version du serveur :  5.7.31
-- Version de PHP : 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `bibliothèque`
--

-- --------------------------------------------------------

--
-- Structure de la table `auteur`
--

DROP TABLE IF EXISTS `auteur`;
CREATE TABLE IF NOT EXISTS `auteur` (
  `numAuteur` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prenom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`numAuteur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `caracterise`
--

DROP TABLE IF EXISTS `caracterise`;
CREATE TABLE IF NOT EXISTS `caracterise` (
  `numOuvrage` int(11) NOT NULL,
  `numMot` int(11) NOT NULL,
  KEY `numOuvrage` (`numOuvrage`),
  KEY `numMot` (`numMot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `ecrit`
--

DROP TABLE IF EXISTS `ecrit`;
CREATE TABLE IF NOT EXISTS `ecrit` (
  `numAuteur` int(11) NOT NULL,
  `numOuvrage` int(11) NOT NULL,
  KEY `numAuteur` (`numAuteur`),
  KEY `ecrit_fk_numouvrage` (`numOuvrage`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `editeur`
--

DROP TABLE IF EXISTS `editeur`;
CREATE TABLE IF NOT EXISTS `editeur` (
  `numEditeur` int(11) NOT NULL AUTO_INCREMENT,
  `nomEditeur` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `adresseEditeur` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`numEditeur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `emprunte`
--

DROP TABLE IF EXISTS `emprunte`;
CREATE TABLE IF NOT EXISTS `emprunte` (
  `numExemplaire` int(11) NOT NULL,
  `numEmprunteur` int(11) NOT NULL,
  `dateEmprun` date NOT NULL,
  `dateRetour` date NOT NULL,
  KEY `emprunte_fk_numemprunteur` (`numEmprunteur`),
  KEY `emprunte_fk_numexemplaire` (`numExemplaire`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `emprunteur`
--

DROP TABLE IF EXISTS `emprunteur`;
CREATE TABLE IF NOT EXISTS `emprunteur` (
  `numEmprunteur` int(11) NOT NULL AUTO_INCREMENT,
  `nomEmprunteur` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `adresseEmprunteur` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telephone` int(11) NOT NULL,
  PRIMARY KEY (`numEmprunteur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `exemplaire`
--

DROP TABLE IF EXISTS `exemplaire`;
CREATE TABLE IF NOT EXISTS `exemplaire` (
  `numExemplaire` int(11) NOT NULL AUTO_INCREMENT,
  `position` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dateAchat` date NOT NULL,
  `numOuvrage` int(11) NOT NULL,
  PRIMARY KEY (`numExemplaire`),
  KEY `exemplaire_fk_numouvrage` (`numOuvrage`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `motclef`
--

DROP TABLE IF EXISTS `motclef`;
CREATE TABLE IF NOT EXISTS `motclef` (
  `numMot` int(11) NOT NULL AUTO_INCREMENT,
  `mot` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`numMot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `ouvrage`
--

DROP TABLE IF EXISTS `ouvrage`;
CREATE TABLE IF NOT EXISTS `ouvrage` (
  `numOuvrage` int(11) NOT NULL,
  `titre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `numEditeur` int(11) NOT NULL,
  KEY `numOuvrage` (`numOuvrage`),
  KEY `ouvrage_fk_numediteur` (`numEditeur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `caracterise`
--
ALTER TABLE `caracterise`
  ADD CONSTRAINT `caracterise_fk_nummot` FOREIGN KEY (`numMot`) REFERENCES `motclef` (`numMot`),
  ADD CONSTRAINT `caracterise_fk_numouvrage` FOREIGN KEY (`numOuvrage`) REFERENCES `ouvrage` (`numOuvrage`);

--
-- Contraintes pour la table `ecrit`
--
ALTER TABLE `ecrit`
  ADD CONSTRAINT `ecrit_fk_numauteur` FOREIGN KEY (`numAuteur`) REFERENCES `auteur` (`numAuteur`),
  ADD CONSTRAINT `ecrit_fk_numouvrage` FOREIGN KEY (`numOuvrage`) REFERENCES `ouvrage` (`numOuvrage`);

--
-- Contraintes pour la table `emprunte`
--
ALTER TABLE `emprunte`
  ADD CONSTRAINT `emprunte_fk_numemprunteur` FOREIGN KEY (`numEmprunteur`) REFERENCES `emprunteur` (`numEmprunteur`),
  ADD CONSTRAINT `emprunte_fk_numexemplaire` FOREIGN KEY (`numExemplaire`) REFERENCES `exemplaire` (`numExemplaire`);

--
-- Contraintes pour la table `exemplaire`
--
ALTER TABLE `exemplaire`
  ADD CONSTRAINT `exemplaire_fk_numouvrage` FOREIGN KEY (`numOuvrage`) REFERENCES `ouvrage` (`numOuvrage`);

--
-- Contraintes pour la table `ouvrage`
--
ALTER TABLE `ouvrage`
  ADD CONSTRAINT `ouvrage_fk_numediteur` FOREIGN KEY (`numEditeur`) REFERENCES `editeur` (`numEditeur`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
