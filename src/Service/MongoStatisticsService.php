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

    /**
     * Lit les statistiques directement depuis MongoDB.
     */
    public function readStatistics(): array
    {
        $documents = $this->documentManager
            ->getRepository(Statistic::class)
            ->findAll();

        $statistics = [];

        foreach ($documents as $document) {
            $statistics[] = [
                'id' => $document->getId(),
                'menuTitle' => $document->getMenuTitle(),
                'ordersCount' => $document->getOrdersCount(),
                'revenue' => $document->getRevenue(),
                'createdAt' => $document->getCreatedAt()->format('Y-m-d H:i:s'),
            ];
        }

        usort(
            $statistics,
            static fn(array $first, array $second): int =>
                $second['revenue'] <=> $first['revenue']
        );

        return $statistics;
    }

    public function flush(): void
    {
        $this->documentManager->flush();
    }
}