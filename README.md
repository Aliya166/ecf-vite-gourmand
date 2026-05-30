# Vite & Gourmand

## Description

Vite & Gourmand est une application web de commande de repas en ligne développée dans le cadre de l'ECF Studi.

L'application permet aux utilisateurs de :

- Consulter les plats disponibles
- Créer un compte
- Se connecter
- Passer une commande
- Gérer leur profil

## Technologies utilisées

### Front-end

- HTML5
- CSS3
- JavaScript

### Back-end

- PHP 8
- Symfony 7

### Base de données

- MySQL

## Installation du projet

Cloner le dépôt :

```bash
git clone URL_DU_REPOSITOIRE
```

Installer les dépendances :

```bash
composer install
```

Configurer le fichier :

```bash
.env
```

Créer la base de données :

```bash
php bin/console doctrine:database:create
```

Exécuter les migrations :

```bash
php bin/console doctrine:migrations:migrate
```

Lancer le serveur :

```bash
symfony server:start
```

## Auteur

Alisa Zamkova
Projet réalisé dans le cadre de l'ECF Développeur Web et Web Mobile.