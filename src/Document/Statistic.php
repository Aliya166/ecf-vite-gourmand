<?php

namespace App\Document;

use Doctrine\ODM\MongoDB\Mapping\Annotations as MongoDB;

#[MongoDB\Document(collection: 'statistics')]
class Statistic
{
    #[MongoDB\Id]
    private ?string $id = null;

    #[MongoDB\Field(type: 'string')]
    private string $menuTitle;

    #[MongoDB\Field(type: 'int')]
    private int $ordersCount;

    #[MongoDB\Field(type: 'float')]
    private float $revenue;

    #[MongoDB\Field(type: 'date')]
    private \DateTimeInterface $createdAt;

    public function __construct(string $menuTitle, int $ordersCount, float $revenue)
    {
        $this->menuTitle = $menuTitle;
        $this->ordersCount = $ordersCount;
        $this->revenue = $revenue;
        $this->createdAt = new \DateTimeImmutable();
    }

    public function getId(): ?string
    {
        return $this->id;
    }

    public function getMenuTitle(): string
    {
        return $this->menuTitle;
    }

    public function getOrdersCount(): int
    {
        return $this->ordersCount;
    }

    public function getRevenue(): float
    {
        return $this->revenue;
    }

    public function getCreatedAt(): \DateTimeInterface
    {
        return $this->createdAt;
    }
}
