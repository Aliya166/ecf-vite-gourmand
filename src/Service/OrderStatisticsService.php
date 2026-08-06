<?php

namespace App\Service;

use App\Repository\CommandeRepository;

class OrderStatisticsService
{
    private string $filePath;

    public function __construct(private CommandeRepository $commandeRepository)
    {
        $this->filePath = dirname(__DIR__, 2) . '/var/statistics/orders_stats.json';
    }

    public function generate(): array
    {
        $commandes = $this->commandeRepository->findAll();

        $stats = [
            'generatedAt' => (new \DateTimeImmutable())->format('Y-m-d H:i:s'),
            'menus' => [],
        ];

        foreach ($commandes as $commande) {
            if (!$commande->getMenu()) {
                continue;
            }

            $menuId = $commande->getMenu()->getId();
            $menuTitle = $commande->getMenu()->getTitle();

            if (!isset($stats['menus'][$menuId])) {
                $stats['menus'][$menuId] = [
                    'menuId' => $menuId,
                    'menuTitle' => $menuTitle,
                    'ordersCount' => 0,
                    'revenue' => 0,
                    'orders' => [],
                ];
            }

            $price = $commande->getPrixTotal() ?? 0;

            $stats['menus'][$menuId]['ordersCount']++;
            $stats['menus'][$menuId]['revenue'] += (float) $price;

            $stats['menus'][$menuId]['orders'][] = [
                'commandeId' => $commande->getId(),
                'dateLivraison' => $commande->getDateLivraison()?->format('Y-m-d'),
                'status' => $commande->getStatus(),
                'total' => (float) $price,
            ];
        }

        $directory = dirname($this->filePath);

        if (!is_dir($directory)) {
            mkdir($directory, 0775, true);
        }

        file_put_contents(
            $this->filePath,
            json_encode($stats, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE)
        );

        return $stats;
    }

    public function read(?string $dateStart = null, ?string $dateEnd = null, ?string $selectedMenu = null): array
    {
        if (!file_exists($this->filePath)) {
            $this->generate();
        }

        $stats = json_decode(file_get_contents($this->filePath), true);

        $filtered = [
            'generatedAt' => $stats['generatedAt'] ?? null,
            'menus' => [],
        ];

        foreach ($stats['menus'] ?? [] as $menuId => $menuData) {
            if ($selectedMenu && (string) $menuId !== (string) $selectedMenu) {
                continue;
            }

            $filteredOrders = [];

            foreach ($menuData['orders'] ?? [] as $order) {
                $orderDate = $order['dateLivraison'] ?? null;

                if (!$orderDate) {
                    continue;
                }

                if ($dateStart && $orderDate < $dateStart) {
                    continue;
                }

                if ($dateEnd && $orderDate > $dateEnd) {
                    continue;
                }

                $filteredOrders[] = $order;
            }

            if (!empty($filteredOrders)) {
                $filtered['menus'][$menuId] = [
                    'menuId' => $menuData['menuId'],
                    'menuTitle' => $menuData['menuTitle'],
                    'ordersCount' => count($filteredOrders),
                    'revenue' => array_sum(array_column($filteredOrders, 'total')),
                    'orders' => $filteredOrders,
                ];
            }
        }

        return $filtered;
    }
}
