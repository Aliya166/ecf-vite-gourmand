<?php

namespace App\Repository;

use App\Entity\Commande;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Commande>
 */
class CommandeRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Commande::class);
    }

    public function findForEmployeeFilters(?string $status, ?string $client, ?string $dateStart, ?string $dateEnd, ?string $menu): array
    {
        $qb = $this->createQueryBuilder('c')
            ->leftJoin('c.user', 'u')
            ->addSelect('u')
            ->leftJoin('c.menu', 'm')
            ->addSelect('m')
            ->orderBy('c.dateCommande', 'DESC');

        if ($status) {
            $qb->andWhere('c.status = :status')
                ->setParameter('status', $status);
        }

        if ($client) {
            $qb->andWhere(
                'u.firstname LIKE :client
            OR u.lastname LIKE :client
            OR u.email LIKE :client
            OR CONCAT(u.firstname, \' \', u.lastname) LIKE :client
            OR CONCAT(u.lastname, \' \', u.firstname) LIKE :client'
            )
                ->setParameter('client', '%' . $client . '%');
        }

        if ($dateStart) {
            $qb->andWhere('c.dateLivraison >= :dateStart')
                ->setParameter('dateStart', new \DateTimeImmutable($dateStart));
        }

        if ($dateEnd) {
            $qb->andWhere('c.dateLivraison <= :dateEnd')
                ->setParameter('dateEnd', new \DateTimeImmutable($dateEnd));
        }

        if ($menu) {
            $qb->andWhere('m.id = :menu')
                ->setParameter('menu', $menu);
        }

        return $qb->getQuery()->getResult();
    }

    //    /**
    //     * @return Commande[] Returns an array of Commande objects
    //     */
    //    public function findByExampleField($value): array
    //    {
    //        return $this->createQueryBuilder('c')
    //            ->andWhere('c.exampleField = :val')
    //            ->setParameter('val', $value)
    //            ->orderBy('c.id', 'ASC')
    //            ->setMaxResults(10)
    //            ->getQuery()
    //            ->getResult()
    //        ;
    //    }

    //    public function findOneBySomeField($value): ?Commande
    //    {
    //        return $this->createQueryBuilder('c')
    //            ->andWhere('c.exampleField = :val')
    //            ->setParameter('val', $value)
    //            ->getQuery()
    //            ->getOneOrNullResult()
    //        ;
    //    }
}
