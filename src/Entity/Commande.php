<?php

namespace App\Entity;

use App\Repository\CommandeRepository;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: CommandeRepository::class)]
class Commande
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column]
    private ?\DateTimeImmutable $dateCommande = null;

    #[ORM\Column]
    private ?int $nombrePersonnes = null;

    #[ORM\Column(length: 255)]
    private ?string $status = null;

    #[ORM\Column(type: Types::TEXT, nullable: true)]
    private ?string $commentaire = null;

    #[ORM\ManyToOne(inversedBy: 'commandes')]
    #[ORM\JoinColumn(nullable: false)]
    private ?User $user = null;

    #[ORM\ManyToOne(inversedBy: 'commandes')]
    private ?Menu $menu = null;

    #[ORM\Column(type: Types::DATE_MUTABLE)]
    private ?\DateTime $dateLivraison = null;

    #[ORM\Column(type: Types::TIME_MUTABLE)]
    private ?\DateTime $heureLivraison = null;

    #[ORM\Column(length: 255)]
    private ?string $adresseLivraison = null;

    #[ORM\Column(length: 255)]
    private ?string $villeLivraison = null;

    #[ORM\Column(nullable: true)]
    private ?float $distanceKm = null;

    #[ORM\Column(type: Types::DECIMAL, precision: 10, scale: 2, nullable: true)]
    private ?string $prixLivraison = null;

    #[ORM\Column(type: Types::DECIMAL, precision: 10, scale: 2, nullable: true)]
    private ?string $reduction = null;

    #[ORM\Column(type: Types::DECIMAL, precision: 10, scale: 2)]
    private ?string $prixTotal = null;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getDateCommande(): ?\DateTimeImmutable
    {
        return $this->dateCommande;
    }

    public function setDateCommande(\DateTimeImmutable $dateCommande): static
    {
        $this->dateCommande = $dateCommande;

        return $this;
    }

    public function getNombrePersonnes(): ?int
    {
        return $this->nombrePersonnes;
    }

    public function setNombrePersonnes(int $nombrePersonnes): static
    {
        $this->nombrePersonnes = $nombrePersonnes;

        return $this;
    }

    public function getStatus(): ?string
    {
        return $this->status;
    }

    public function setStatus(string $status): static
    {
        $this->status = $status;

        return $this;
    }

    public function getCommentaire(): ?string
    {
        return $this->commentaire;
    }

    public function setCommentaire(?string $commentaire): static
    {
        $this->commentaire = $commentaire;

        return $this;
    }

    public function getUser(): ?User
    {
        return $this->user;
    }

    public function setUser(?User $user): static
    {
        $this->user = $user;

        return $this;
    }

    public function getMenu(): ?Menu
    {
        return $this->menu;
    }

    public function setMenu(?Menu $menu): static
    {
        $this->menu = $menu;

        return $this;
    }

    public function getDateLivraison(): ?\DateTime
    {
        return $this->dateLivraison;
    }

    public function setDateLivraison(\DateTime $dateLivraison): static
    {
        $this->dateLivraison = $dateLivraison;

        return $this;
    }

    public function getHeureLivraison(): ?\DateTime
    {
        return $this->heureLivraison;
    }

    public function setHeureLivraison(\DateTime $heureLivraison): static
    {
        $this->heureLivraison = $heureLivraison;

        return $this;
    }

    public function getAdresseLivraison(): ?string
    {
        return $this->adresseLivraison;
    }

    public function setAdresseLivraison(string $adresseLivraison): static
    {
        $this->adresseLivraison = $adresseLivraison;

        return $this;
    }

    public function getVilleLivraison(): ?string
    {
        return $this->villeLivraison;
    }

    public function setVilleLivraison(string $villeLivraison): static
    {
        $this->villeLivraison = $villeLivraison;

        return $this;
    }

    public function getDistanceKm(): ?float
    {
        return $this->distanceKm;
    }

    public function setDistanceKm(?float $distanceKm): static
    {
        $this->distanceKm = $distanceKm;

        return $this;
    }

    public function getPrixLivraison(): ?string
    {
        return $this->prixLivraison;
    }

    public function setPrixLivraison(?string $prixLivraison): static
    {
        $this->prixLivraison = $prixLivraison;

        return $this;
    }

    public function getReduction(): ?string
    {
        return $this->reduction;
    }

    public function setReduction(?string $reduction): static
    {
        $this->reduction = $reduction;

        return $this;
    }

    public function getPrixTotal(): ?string
    {
        return $this->prixTotal;
    }

    public function setPrixTotal(string $prixTotal): static
    {
        $this->prixTotal = $prixTotal;

        return $this;
    }
}
