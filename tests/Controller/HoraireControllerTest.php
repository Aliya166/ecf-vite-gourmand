<?php

namespace App\Tests\Controller;

use App\Entity\Horaire;
use App\Repository\HoraireRepository;
use Doctrine\ORM\EntityManagerInterface;
use Doctrine\ORM\EntityRepository;
use Symfony\Bundle\FrameworkBundle\KernelBrowser;
use Symfony\Bundle\FrameworkBundle\Test\WebTestCase;

final class HoraireControllerTest extends WebTestCase
{
    private KernelBrowser $client;
    private EntityManagerInterface $manager;
    /** @var EntityRepository<Horaire> $horaireRepository */
    private EntityRepository $horaireRepository;
    private string $path = '/horaire/';

    protected function setUp(): void
    {
        $this->client = static::createClient();
        $this->manager = static::getContainer()->get('doctrine')->getManager();
        $this->horaireRepository = $this->manager->getRepository(Horaire::class);

        foreach ($this->horaireRepository->findAll() as $object) {
            $this->manager->remove($object);
        }

        $this->manager->flush();
    }

    public function testIndex(): void
    {
        $this->client->followRedirects();
        $crawler = $this->client->request('GET', $this->path);

        self::assertResponseStatusCodeSame(200);
        self::assertPageTitleContains('Horaire index');

        // Use the $crawler to perform additional assertions e.g.
        // self::assertSame('Some text on the page', $crawler->filter('.p')->first()->text());
    }

    public function testNew(): void
    {
        $this->client->request('GET', sprintf('%snew', $this->path));

        self::assertResponseStatusCodeSame(200);

        $this->client->submitForm('Save', [
            'horaire[jour]' => 'Testing',
            'horaire[heureOverture]' => 'Testing',
            'horaire[heureFermeture]' => 'Testing',
        ]);

        self::assertResponseRedirects('/horaire');

        self::assertSame(1, $this->horaireRepository->count([]));

        $this->markTestIncomplete('This test was generated');
    }

    public function testShow(): void
    {
        $fixture = new Horaire();
        $fixture->setJour('My Title');
        $fixture->setHeureOverture('My Title');
        $fixture->setHeureFermeture('My Title');

        $this->manager->persist($fixture);
        $this->manager->flush();

        $this->client->request('GET', sprintf('%s%s', $this->path, $fixture->getId()));

        self::assertResponseStatusCodeSame(200);
        self::assertPageTitleContains('Horaire');

        // Use assertions to check that the properties are properly displayed.
        $this->markTestIncomplete('This test was generated');
    }

    public function testEdit(): void
    {
        $fixture = new Horaire();
        $fixture->setJour('Value');
        $fixture->setHeureOverture('Value');
        $fixture->setHeureFermeture('Value');

        $this->manager->persist($fixture);
        $this->manager->flush();

        $this->client->request('GET', sprintf('%s%s/edit', $this->path, $fixture->getId()));

        $this->client->submitForm('Update', [
            'horaire[jour]' => 'Something New',
            'horaire[heureOverture]' => 'Something New',
            'horaire[heureFermeture]' => 'Something New',
        ]);

        self::assertResponseRedirects('/horaire');

        $fixture = $this->horaireRepository->findAll();

        self::assertSame('Something New', $fixture[0]->getJour());
        self::assertSame('Something New', $fixture[0]->getHeureOverture());
        self::assertSame('Something New', $fixture[0]->getHeureFermeture());

        $this->markTestIncomplete('This test was generated');
    }

    public function testRemove(): void
    {
        $fixture = new Horaire();
        $fixture->setJour('Value');
        $fixture->setHeureOverture('Value');
        $fixture->setHeureFermeture('Value');

        $this->manager->persist($fixture);
        $this->manager->flush();

        $this->client->request('GET', sprintf('%s%s', $this->path, $fixture->getId()));
        $this->client->submitForm('Delete');

        self::assertResponseRedirects('/horaire');
        self::assertSame(0, $this->horaireRepository->count([]));

        $this->markTestIncomplete('This test was generated');
    }
}
