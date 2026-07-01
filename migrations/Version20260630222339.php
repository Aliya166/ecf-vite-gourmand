<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20260630222339 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE commande ADD date_livraison DATE NOT NULL, ADD heure_livraison TIME NOT NULL, ADD adresse_livraison VARCHAR(255) NOT NULL, ADD ville_livraison VARCHAR(255) NOT NULL, ADD distance_km DOUBLE PRECISION DEFAULT NULL, ADD prix_livraison NUMERIC(10, 2) DEFAULT NULL, ADD reduction NUMERIC(10, 2) DEFAULT NULL, ADD prix_total NUMERIC(10, 2) NOT NULL');
        $this->addSql('ALTER TABLE plat DROP FOREIGN KEY `FK_2038A207CCD7E912`');
        $this->addSql('DROP INDEX IDX_2038A207CCD7E912 ON plat');
        $this->addSql('ALTER TABLE plat DROP menu_id');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE commande DROP date_livraison, DROP heure_livraison, DROP adresse_livraison, DROP ville_livraison, DROP distance_km, DROP prix_livraison, DROP reduction, DROP prix_total');
        $this->addSql('ALTER TABLE plat ADD menu_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE plat ADD CONSTRAINT `FK_2038A207CCD7E912` FOREIGN KEY (menu_id) REFERENCES menu (id)');
        $this->addSql('CREATE INDEX IDX_2038A207CCD7E912 ON plat (menu_id)');
    }
}
