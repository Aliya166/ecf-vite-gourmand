<?php

namespace App\Tests\Service;

use App\Service\CommandeCalculator;
use PHPUnit\Framework\TestCase;

final class CommandeCalculatorTest extends TestCase
{
    private CommandeCalculator $calculator;

    protected function setUp(): void
    {
        $this->calculator = new CommandeCalculator();
    }

    public function testReductionIsAppliedWhenFivePeopleAreAddedToMinimum(): void
    {
        $reduction = $this->calculator->calculerReduction(
            180.00,
            9,
            4
        );

        $this->assertSame(18.00, $reduction);
    }

    public function testReductionIsNotAppliedBelowThreshold(): void
    {
        $reduction = $this->calculator->calculerReduction(
            160.00,
            8,
            4
        );

        $this->assertSame(0.00, $reduction);
    }

    public function testDeliveryPriceIsCalculatedCorrectly(): void
    {
        $prixLivraison = $this->calculator->calculerPrixLivraison(
            'Paris',
            10.00
        );

        $this->assertSame(10.90, $prixLivraison);
    }

    public function testDeliveryPriceIsFreeInBordeaux(): void
    {
        $prixLivraison = $this->calculator->calculerPrixLivraison(
            'Bordeaux',
            10.00
        );

        $this->assertSame(0.00, $prixLivraison);
    }

    public function testDeliveryPriceIncludesFiveEuroFixedFeeAtZeroKilometres(): void
    {
        $prixLivraison = $this->calculator->calculerPrixLivraison(
            'Paris',
            0.00
        );

        $this->assertSame(5.00, $prixLivraison);
    }
}