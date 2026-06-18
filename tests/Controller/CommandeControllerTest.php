<?php

namespace App\Tests\Controller;

use App\Entity\Commande;
use App\Repository\CommandeRepository;
use Doctrine\ORM\EntityManagerInterface;
use Doctrine\ORM\EntityRepository;
use Symfony\Bundle\FrameworkBundle\KernelBrowser;
use Symfony\Bundle\FrameworkBundle\Test\WebTestCase;

final class CommandeControllerTest extends WebTestCase
{
    private KernelBrowser $client;
    private EntityManagerInterface $manager;
    /** @var EntityRepository<Commande> $commandeRepository */
    private EntityRepository $commandeRepository;
    private string $path = '/commande/';

    protected function setUp(): void
    {
        $this->client = static::createClient();
        $this->manager = static::getContainer()->get('doctrine')->getManager();
        $this->commandeRepository = $this->manager->getRepository(Commande::class);

        foreach ($this->commandeRepository->findAll() as $object) {
            $this->manager->remove($object);
        }

        $this->manager->flush();
    }

    public function testIndex(): void
    {
        $this->client->followRedirects();
        $crawler = $this->client->request('GET', $this->path);

        self::assertResponseStatusCodeSame(200);
        self::assertPageTitleContains('Commande index');

        // Use the $crawler to perform additional assertions e.g.
        // self::assertSame('Some text on the page', $crawler->filter('.p')->first()->text());
    }

    public function testNew(): void
    {
        $this->client->request('GET', sprintf('%snew', $this->path));

        self::assertResponseStatusCodeSame(200);

        $this->client->submitForm('Save', [
            'commande[dateCommande]' => 'Testing',
            'commande[nombrePersonnes]' => 'Testing',
            'commande[status]' => 'Testing',
            'commande[commentaire]' => 'Testing',
        ]);

        self::assertResponseRedirects('/commande');

        self::assertSame(1, $this->commandeRepository->count([]));

        $this->markTestIncomplete('This test was generated');
    }

    public function testShow(): void
    {
        $fixture = new Commande();
        $fixture->setDateCommande('My Title');
        $fixture->setNombrePersonnes('My Title');
        $fixture->setStatus('My Title');
        $fixture->setCommentaire('My Title');

        $this->manager->persist($fixture);
        $this->manager->flush();

        $this->client->request('GET', sprintf('%s%s', $this->path, $fixture->getId()));

        self::assertResponseStatusCodeSame(200);
        self::assertPageTitleContains('Commande');

        // Use assertions to check that the properties are properly displayed.
        $this->markTestIncomplete('This test was generated');
    }

    public function testEdit(): void
    {
        $fixture = new Commande();
        $fixture->setDateCommande('Value');
        $fixture->setNombrePersonnes('Value');
        $fixture->setStatus('Value');
        $fixture->setCommentaire('Value');

        $this->manager->persist($fixture);
        $this->manager->flush();

        $this->client->request('GET', sprintf('%s%s/edit', $this->path, $fixture->getId()));

        $this->client->submitForm('Update', [
            'commande[dateCommande]' => 'Something New',
            'commande[nombrePersonnes]' => 'Something New',
            'commande[status]' => 'Something New',
            'commande[commentaire]' => 'Something New',
        ]);

        self::assertResponseRedirects('/commande');

        $fixture = $this->commandeRepository->findAll();

        self::assertSame('Something New', $fixture[0]->getDateCommande());
        self::assertSame('Something New', $fixture[0]->getNombrePersonnes());
        self::assertSame('Something New', $fixture[0]->getStatus());
        self::assertSame('Something New', $fixture[0]->getCommentaire());

        $this->markTestIncomplete('This test was generated');
    }

    public function testRemove(): void
    {
        $fixture = new Commande();
        $fixture->setDateCommande('Value');
        $fixture->setNombrePersonnes('Value');
        $fixture->setStatus('Value');
        $fixture->setCommentaire('Value');

        $this->manager->persist($fixture);
        $this->manager->flush();

        $this->client->request('GET', sprintf('%s%s', $this->path, $fixture->getId()));
        $this->client->submitForm('Delete');

        self::assertResponseRedirects('/commande');
        self::assertSame(0, $this->commandeRepository->count([]));

        $this->markTestIncomplete('This test was generated');
    }
}
