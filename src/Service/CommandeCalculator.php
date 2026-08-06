<?php

namespace App\Service;

final class CommandeCalculator
{
    public function calculerReduction(
        float $sousTotal,
        int $nombrePersonnes,
        int $nombrePersonnesMinimum
    ): float {
        if ($nombrePersonnes >= $nombrePersonnesMinimum + 5) {
            return round($sousTotal * 0.10, 2);
        }

        return 0.00;
    }

    public function calculerPrixLivraison(
        string $ville,
        float $distanceKm
    ): float {
        $villeNormalisee = strtolower(trim($ville));

        if ($villeNormalisee === 'bordeaux') {
            return 0.00;
        }

        return round(5 + (0.59 * $distanceKm), 2);
    }
}