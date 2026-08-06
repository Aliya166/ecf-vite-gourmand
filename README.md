# 🍽️ Vite & Gourmand

Application web de livraison de repas développée avec Symfony 7 dans le cadre de l'Épreuve de Certification (ECF) du titre professionnel Développeur Web et Web Mobile.

---

## 📸 Aperçu de l'application

![Accueil](public/images/public/readme/homepage.png)

---

# Présentation

Vite & Gourmand est une plateforme de commande de repas permettant aux utilisateurs de découvrir des menus équilibrés, de passer commande en ligne et de suivre leurs commandes depuis un espace personnel sécurisé.

L'application a été développée dans le respect des bonnes pratiques Symfony en mettant l'accent sur :

- la sécurité ;
- la gestion des rôles ;
- l'expérience utilisateur ;
- la validation des données ;
- une architecture MVC claire ;
- des tests unitaires.

L'application possède également un espace Employé et un espace Administrateur permettant la gestion complète de l'activité du restaurant.

---

# Fonctionnalités

## 👤 Visiteur

- Consultation des menus disponibles
- Consultation des détails des menus
- Filtrage dynamique des menus
- Consultation des plats
- Création d'un compte
- Connexion
- Consultation des pages publiques
- Formulaire de contact

---

## 👥 Client

- Authentification sécurisée
- Consultation de son profil
- Modification des informations personnelles
- Modification du mot de passe
- Création d'une commande
- Suivi des commandes
- Modification d'une commande (selon son statut)
- Annulation d'une commande
- Consultation du motif d'annulation
- Dépôt d'un avis après une commande terminée

---

## 👨‍🍳 Employé

- Gestion des commandes
- Modification des statuts
- Validation ou refus des avis
- Gestion des menus
- Gestion des plats
- Gestion des horaires
- Gestion des conditions des menus
- Annulation d'une commande avec motif personnalisé

---

## 👑 Administrateur

Toutes les fonctionnalités Employé, plus :

- Gestion des comptes employés
- Création de nouveaux employés
- Désactivation des comptes employés
- Consultation des statistiques
- Chiffre d'affaires par menu
- Statistiques des commandes
- Consultation des données MongoDB

---

# Technologies utilisées

## Front-end

- HTML5
- CSS3
- Bootstrap 5
- JavaScript
- Twig

## Back-end

- PHP 8.2
- Symfony 7
- Doctrine ORM

## Bases de données

- MariaDB / MySQL
- MongoDB Atlas

## Tests

- PHPUnit

## Outils

- Composer
- Git
- GitHub
- Symfony CLI
- XAMPP
- Visual Studio Code
- PhpMyAdmin
- MongoDB Atlas
- Docker Desktop
- Docker Compose
- Mailpit
- Heroku

---

# Architecture

Symfony
│
├── Controller
├── Entity
├── Repository
├── Form
├── Service
├── Security
├── EventSubscriber
├── Command
├── Templates (Twig)
├── Public
└── Tests

---

# Installation avec Docker

Docker permet de lancer l'application dans un environnement local complet et reproductible, sans installer manuellement PHP, MySQL ou Mailpit sur la machine.

## Prérequis

- Docker Desktop
- Docker Compose

## 1. Cloner le dépôt
git clone https://github.com/Aliya166/ecf-vite-gourmand.git
cd ecf-vite-gourmand

## 2. Construire et démarrer les conteneurs
docker compose up -d --buildCette commande démarre les services suivants :

- app : application Symfony avec PHP et Apache ;
- database : base de données MySQL 8 ;
- mailer : Mailpit pour tester les emails en environnement local.

## 3. Vérifier l'état des conteneurs
docker compose ps 
Le conteneur de la base de données doit apparaître avec l'état healthy.

## 4. Accéder aux services

Application Symfony :
http://localhost:8080Interface Mailpit :
http://localhost:8025

## 5. Exécuter les commandes Symfony

Les commandes Symfony doivent être exécutées dans le conteneur app.

Exemple :
docker compose exec app php bin/console about

## 6. Exécuter les tests PHPUnit
docker compose exec -e APP_ENV=test app php bin/phpunit Résultat validé dans l'environnement Docker :
Tests: 13, Assertions: 13 
Les messages Deprecations éventuels sont des avertissements de compatibilité Symfony et ne correspondent pas à des échecs de tests.

## 7. Tester les emails

En environnement Docker, les emails sont interceptés par Mailpit.

Configuration utilisée :
MAILER_DSN=smtp://mailer:1025 Les emails peuvent être consultés à l'adresse :
http://localhost:8025

## 8. Arrêter les conteneurs
docker compose down 
Pour reconstruire complètement l'application :
docker compose down
docker compose up -d --build> Ne pas utiliser docker compose down -v si vous souhaitez conserver les données MySQL locales.

## Architecture Docker

L'environnement Docker repose sur trois services principaux :
Docker Compose
│
├── app
│   ├── PHP
│   ├── Apache
│   └── Symfony
│
├── database
│   └── MySQL 8
│
└── mailer
    └── MailpitLes variables d'environnement nécessaires au fonctionnement local sont définies dans le fichier compose.yaml.

MongoDB est utilisé pour les statistiques administratives. En production, l'application utilise MongoDB Atlas via les variables :

- MONGODB_URI
- MONGODB_DB

---

# Installation sans Docker

## Prérequis

- PHP 8.2 ou supérieur
- Composer
- MySQL ou MariaDB
- Symfony CLI ou un serveur PHP local

## 1. Cloner le dépôt
git clone https://github.com/Aliya166/ecf-vite-gourmand.git
cd ecf-vite-gourmand

## 2. Installer les dépendances
composer install

## 3. Configurer les variables d'environnement

Créer un fichier .env.local à la racine du projet.

Exemple :
APP_ENV=dev
APP_SECRET=

DATABASE_URL=

MAILER_DSN=

MONGODB_URI=
MONGODB_DB=

## 4. Créer la base de données
php bin/console doctrine:database:create

## 5. Créer la structure de la base

Deux méthodes sont possibles.

Avec les migrations Doctrine :
php bin/console doctrine:migrations:migrateOu en important le dump SQL fourni avec le projet :
vite_gourmand.sql

## 6. Lancer l'application

Avec Symfony CLI :
symfony server:startOu avec le serveur PHP intégré :
php -S localhost:8000 -t publicPuis ouvrir :
http://localhost:8000

---

# Tests PHPUnit

## Sans Docker
php bin/phpunit

## Avec Docker
docker compose exec -e APP_ENV=test app php bin/phpunitRésultat actuellement validé :
Tests: 13, Assertions: 13

---

# Sécurité

L'application implémente plusieurs mécanismes de sécurité :

- Authentification Symfony Security
- Hashage des mots de passe
- Protection CSRF
- Contrôle des rôles
- Validation des formulaires
- Gestion des accès par rôle
- Protection contre les accès non autorisés
- Validation des fichiers uploadés

---

# Bases de données

## MySQL

Stockage principal :

- utilisateurs
- commandes
- menus
- plats
- horaires
- avis

## MongoDB Atlas

Stockage des statistiques :

- nombre de commandes
- chiffre d'affaires
- menus les plus vendus
- statistiques d'activité

---

# Auteur

Alisa Zamkova

Projet réalisé dans le cadre de l'Épreuve de Certification (ECF)
du titre professionnel

Développeur Web et Web Mobile

2026

---

# Licence

Projet réalisé uniquement dans un cadre pédagogique.

Tous droits réservés.