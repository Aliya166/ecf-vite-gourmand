CREATE TABLE role (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    libelle VARCHAR(50) NOT NULL
);

CREATE TABLE utilisateur (
    utilisateur_id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    prenom VARCHAR(50),
    telephone VARCHAR(50),
    ville VARCHAR(50),
    pays VARCHAR(50),
    adresse_postale VARCHAR(50),
    role_id INT NOT NULL,
    FOREIGN KEY (role_id) REFERENCES role(role_id)
);

CREATE TABLE regime (
    regime_id INT AUTO_INCREMENT PRIMARY KEY,
    libelle VARCHAR(50) NOT NULL
);

CREATE TABLE theme (
    theme_id INT AUTO_INCREMENT PRIMARY KEY,
    libelle VARCHAR(50) NOT NULL
);

CREATE TABLE menu (
    menu_id INT AUTO_INCREMENT PRIMARY KEY,
    titre VARCHAR(50) NOT NULL,
    nombre_personne_minimum INT NOT NULL,
    prix_personne DOUBLE NOT NULL,
    regime VARCHAR(50),
    description TEXT,
    quantite_restante INT,
    regime_id INT,
    theme_id INT,
    FOREIGN KEY (regime_id) REFERENCES regime(regime_id),
    FOREIGN KEY (theme_id) REFERENCES theme(theme_id)
);

CREATE TABLE plat (
    plat_id INT AUTO_INCREMENT PRIMARY KEY,
    titre_plat VARCHAR(50) NOT NULL,
    photo BLOB,
    menu_id INT NOT NULL,
    FOREIGN KEY (menu_id) REFERENCES menu(menu_id)
);

CREATE TABLE allergene (
    allergene_id INT AUTO_INCREMENT PRIMARY KEY,
    libelle VARCHAR(50) NOT NULL
);

CREATE TABLE plat_allergene (
    plat_id INT NOT NULL,
    allergene_id INT NOT NULL,
    PRIMARY KEY (plat_id, allergene_id),
    FOREIGN KEY (plat_id) REFERENCES plat(plat_id),
    FOREIGN KEY (allergene_id) REFERENCES allergene(allergene_id)
);

CREATE TABLE horaire (
    horaire_id INT AUTO_INCREMENT PRIMARY KEY,
    jour VARCHAR(50) NOT NULL,
    heure_ouverture VARCHAR(50),
    heure_fermeture VARCHAR(50)
);

CREATE TABLE commande (
    numero_commande VARCHAR(50) PRIMARY KEY,
    date_commande DATE NOT NULL,
    date_prestation DATE NOT NULL,
    heure_livraison VARCHAR(50),
    prix_menu DOUBLE NOT NULL,
    nombre_personne INT NOT NULL,
    prix_livraison DOUBLE,
    statut VARCHAR(50),
    pret_materiel BOOLEAN,
    restitution_materiel BOOLEAN,
    utilisateur_id INT NOT NULL,
    menu_id INT NOT NULL,
    FOREIGN KEY (utilisateur_id) REFERENCES utilisateur(utilisateur_id),
    FOREIGN KEY (menu_id) REFERENCES menu(menu_id)
);

CREATE TABLE avis (
    avis_id INT AUTO_INCREMENT PRIMARY KEY,
    note INT NOT NULL,
    description TEXT,
    statut VARCHAR(50),
    utilisateur_id INT NOT NULL,
    FOREIGN KEY (utilisateur_id) REFERENCES utilisateur(utilisateur_id)
);

INSERT INTO role (libelle) VALUES
('ROLE_USER'),
('ROLE_EMPLOYE'),
('ROLE_ADMIN');

INSERT INTO regime (libelle) VALUES
('Végétarien'),
('Vegan'),
('Sans gluten');

INSERT INTO theme (libelle) VALUES
('Mariage'),
('Anniversaire'),
('Entreprise');

INSERT INTO allergene (libelle) VALUES
('Gluten'),
('Lactose'),
('Fruits à coque');