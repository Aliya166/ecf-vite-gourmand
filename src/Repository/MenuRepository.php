<?php

namespace App\Repository;

use App\Entity\Menu;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Menu>
 */
class MenuRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Menu::class);
    }

    public function findFilteredMenus(
        ?int $themeId,
        ?int $regimeId,
        ?float $maxPrice,
        ?int $personnes,
    ): array {
        $qb = $this->createQueryBuilder('m')
            ->andWhere('m.isActive = true');

        if ($themeId !== null) {
            $qb->andWhere('IDENTITY(m.theme) = :themeId') 
                ->setParameter('themeId', $themeId);
        }

        if ($regimeId !== null) {
            $qb->andWhere('IDENTITY(m.regime) = :regimeId')
                ->setParameter('regimeId', $regimeId);
        }

        if ($maxPrice) {
            $qb->andWhere('m.price <= :maxPrice')
                ->setParameter('maxPrice', $maxPrice);
        }

        if ($personnes) {
            $qb->andWhere('m.nombrePersonneMinimum <= :personnes')
                ->setParameter('personnes', $personnes);
        }

        return $qb
            ->orderBy('m.price', 'ASC')
            ->getQuery()
            ->getResult();
    }




    //    /**
    //     * @return Menu[] Returns an array of Menu objects
    //     */
    //    public function findByExampleField($value): array
    //    {
    //        return $this->createQueryBuilder('m')
    //            ->andWhere('m.exampleField = :val')
    //            ->setParameter('val', $value)
    //            ->orderBy('m.id', 'ASC')
    //            ->setMaxResults(10)
    //            ->getQuery()
    //            ->getResult()
    //        ;
    //    }

    //    public function findOneBySomeField($value): ?Menu
    //    {
    //        return $this->createQueryBuilder('m')
    //            ->andWhere('m.exampleField = :val')
    //            ->setParameter('val', $value)
    //            ->getQuery()
    //            ->getOneOrNullResult()
    //        ;
    //    }

    
}
