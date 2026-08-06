<?php

namespace App\Service;

use App\Document\Statistic;
use Doctrine\ODM\MongoDB\DocumentManager;

class MongoStatisticsService
{
    public function __construct(
        private DocumentManager $documentManager
    ) {
    }

    public function clearStatistics(): void
    {
        $this->documentManager
            ->createQueryBuilder(Statistic::class)
            ->remove()
            ->getQuery()
            ->execute();
    }

    public function saveMenuStatistic(
        string $menuTitle,
        int $ordersCount,
        float $revenue
    ): void {
        $statistic = new Statistic(
            $menuTitle,
            $ordersCount,
            $revenue
        );

        $this->documentManager->persist($statistic);
    }

    public function flush(): void
    {
        $this->documentManager->flush();
    }

    public function getStatistics(): array
    {
        $statistics = $this->documentManager
            ->getRepository(Statistic::class)
            ->findAll();

        return array_map(
            static fn (Statistic $statistic): array => [
                'menuTitle' => $statistic->getMenuTitle(),
                'ordersCount' => $statistic->getOrdersCount(),
                'revenue' => $statistic->getRevenue(),
            ],
            $statistics
        );
    }
}