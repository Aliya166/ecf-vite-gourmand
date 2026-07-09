<?php

namespace App\Entity;

use App\Repository\MenuRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: MenuRepository::class)]
class Menu
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    private ?string $title = null;

    #[ORM\Column(type: Types::TEXT, nullable: true)]
    private ?string $description = null;

    #[ORM\Column(type: Types::DECIMAL, precision: 10, scale: 2)]
    private ?string $price = null;

    #[ORM\Column]
    private ?bool $isActive = null;

    #[ORM\Column]
    private ?\DateTimeImmutable $createAt = null;

    /**
     * @var Collection<int, Commande>
     */
    #[ORM\OneToMany(targetEntity: Commande::class, mappedBy: 'menu')]
    private Collection $commandes;

    #[ORM\ManyToOne(inversedBy: 'menus')]
    private ?Regime $regime = null;

    #[ORM\ManyToOne(inversedBy: 'menus')]
    private ?Theme $theme = null;

    #[ORM\Column]
    private ?int $nombrePersonneMinimum = null;

    #[ORM\Column]
    private ?int $stockDisponible = 5;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $imageMain = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $imageSecond = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $imageThird = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $imageFourth = null;

    /**
     * @var Collection<int, Plat>
     */
    #[ORM\ManyToMany(targetEntity: Plat::class, inversedBy: 'menus')]
    private Collection $platsMany;

    public function __construct()
    {
        $this->commandes = new ArrayCollection();
        $this->platsMany = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getTitle(): ?string
    {
        return $this->title;
    }

    public function setTitle(string $title): static
    {
        $this->title = $title;

        return $this;
    }

    public function getDescription(): ?string
    {
        return $this->description;
    }

    public function setDescription(?string $description): static
    {
        $this->description = $description;

        return $this;
    }

    public function getPrice(): ?string
    {
        return $this->price;
    }

    public function setPrice(string $price): static
    {
        $this->price = $price;

        return $this;
    }

    public function isActive(): ?bool
    {
        return $this->isActive;
    }

    public function setIsActive(bool $isActive): static
    {
        $this->isActive = $isActive;

        return $this;
    }

    public function getCreateAt(): ?\DateTimeImmutable
    {
        return $this->createAt;
    }

    public function setCreateAt(\DateTimeImmutable $createAt): static
    {
        $this->createAt = $createAt;

        return $this;
    }

    /**
     * @return Collection<int, Commande>
     */
    public function getCommandes(): Collection
    {
        return $this->commandes;
    }

    public function addCommande(Commande $commande): static
    {
        if (!$this->commandes->contains($commande)) {
            $this->commandes->add($commande);
            $commande->setMenu($this);
        }

        return $this;
    }

    public function removeCommande(Commande $commande): static
    {
        if ($this->commandes->removeElement($commande)) {
            // set the owning side to null (unless already changed)
            if ($commande->getMenu() === $this) {
                $commande->setMenu(null);
            }
        }

        return $this;
    }

    public function getRegime(): ?Regime
    {
        return $this->regime;
    }

    public function setRegime(?Regime $regime): static
    {
        $this->regime = $regime;

        return $this;
    }

    public function getTheme(): ?Theme
    {
        return $this->theme;
    }

    public function setTheme(?Theme $theme): static
    {
        $this->theme = $theme;

        return $this;
    }

    public function getNombrePersonneMinimum(): ?int
    {
        return $this->nombrePersonneMinimum;
    }

    public function setNombrePersonneMinimum(int $nombrePersonneMinimum): static
    {
        $this->nombrePersonneMinimum = $nombrePersonneMinimum;

        return $this;
    }

    public function getStockDisponible(): ?int
    {
        return $this->stockDisponible;
    }

    public function setStockDisponible(int $stockDisponible): static
    {
        $this->stockDisponible = $stockDisponible;

        return $this;
    }

    public function getImageMain(): ?string
    {
        return $this->imageMain;
    }

    public function setImageMain(?string $imageMain): static
    {
        $this->imageMain = $imageMain;

        return $this;
    }

    public function getImageSecond(): ?string
    {
        return $this->imageSecond;
    }

    public function setImageSecond(?string $imageSecond): static
    {
        $this->imageSecond = $imageSecond;

        return $this;
    }

    public function getImageThird(): ?string
    {
        return $this->imageThird;
    }

    public function setImageThird(?string $imageThird): static
    {
        $this->imageThird = $imageThird;

        return $this;
    }

    public function getImageFourth(): ?string
    {
        return $this->imageFourth;
    }

    public function setImageFourth(?string $imageFourth): static
    {
        $this->imageFourth = $imageFourth;

        return $this;
    }

    /**
     * @return Collection<int, Plat>
     */
    public function getPlatsMany(): Collection
    {
        return $this->platsMany;
    }

    public function addPlatsMany(Plat $platsMany): static
    {
        if (!$this->platsMany->contains($platsMany)) {
            $this->platsMany->add($platsMany);
        }

        return $this;
    }

    public function removePlatsMany(Plat $platsMany): static
    {
        $this->platsMany->removeElement($platsMany);

        return $this;
    }
}
