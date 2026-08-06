<?php

namespace App\Tests\Controller;

use App\Entity\GalleryImage;
use App\Repository\GalleryImageRepository;
use Doctrine\ORM\EntityManagerInterface;
use Doctrine\ORM\EntityRepository;
use Symfony\Bundle\FrameworkBundle\KernelBrowser;
use Symfony\Bundle\FrameworkBundle\Test\WebTestCase;

final class GalleryImageControllerTest extends WebTestCase
{
    private KernelBrowser $client;
    private EntityManagerInterface $manager;
    /** @var EntityRepository<GalleryImage> $galleryImageRepository */
    private EntityRepository $galleryImageRepository;
    private string $path = '/gallery/image/';

    protected function setUp(): void
    {
        $this->client = static::createClient();
        $this->manager = static::getContainer()->get('doctrine')->getManager();
        $this->galleryImageRepository = $this->manager->getRepository(GalleryImage::class);

        foreach ($this->galleryImageRepository->findAll() as $object) {
            $this->manager->remove($object);
        }

        $this->manager->flush();
    }

    public function testIndex(): void
    {
        $this->client->followRedirects();
        $crawler = $this->client->request('GET', $this->path);

        self::assertResponseStatusCodeSame(200);
        self::assertPageTitleContains('GalleryImage index');

        // Use the $crawler to perform additional assertions e.g.
        // self::assertSame('Some text on the page', $crawler->filter('.p')->first()->text());
    }

    public function testNew(): void
    {
        $this->client->request('GET', sprintf('%snew', $this->path));

        self::assertResponseStatusCodeSame(200);

        $this->client->submitForm('Save', [
            'gallery_image[title]' => 'Testing',
            'gallery_image[description]' => 'Testing',
            'gallery_image[imageUrl]' => 'Testing',
            'gallery_image[isActive]' => 'Testing',
            'gallery_image[createdAt]' => 'Testing',
        ]);

        self::assertResponseRedirects('/gallery/image');

        self::assertSame(1, $this->galleryImageRepository->count([]));

        $this->markTestIncomplete('This test was generated');
    }

    public function testShow(): void
    {
        $fixture = new GalleryImage();
        $fixture->setTitle('My Title');
        $fixture->setDescription('My Title');
        $fixture->setImageUrl('My Title');
        $fixture->setIsActive('My Title');
        $fixture->setCreatedAt('My Title');

        $this->manager->persist($fixture);
        $this->manager->flush();

        $this->client->request('GET', sprintf('%s%s', $this->path, $fixture->getId()));

        self::assertResponseStatusCodeSame(200);
        self::assertPageTitleContains('GalleryImage');

        // Use assertions to check that the properties are properly displayed.
        $this->markTestIncomplete('This test was generated');
    }

    public function testEdit(): void
    {
        $fixture = new GalleryImage();
        $fixture->setTitle('Value');
        $fixture->setDescription('Value');
        $fixture->setImageUrl('Value');
        $fixture->setIsActive('Value');
        $fixture->setCreatedAt('Value');

        $this->manager->persist($fixture);
        $this->manager->flush();

        $this->client->request('GET', sprintf('%s%s/edit', $this->path, $fixture->getId()));

        $this->client->submitForm('Update', [
            'gallery_image[title]' => 'Something New',
            'gallery_image[description]' => 'Something New',
            'gallery_image[imageUrl]' => 'Something New',
            'gallery_image[isActive]' => 'Something New',
            'gallery_image[createdAt]' => 'Something New',
        ]);

        self::assertResponseRedirects('/gallery/image');

        $fixture = $this->galleryImageRepository->findAll();

        self::assertSame('Something New', $fixture[0]->getTitle());
        self::assertSame('Something New', $fixture[0]->getDescription());
        self::assertSame('Something New', $fixture[0]->getImageUrl());
        self::assertSame('Something New', $fixture[0]->getIsActive());
        self::assertSame('Something New', $fixture[0]->getCreatedAt());

        $this->markTestIncomplete('This test was generated');
    }

    public function testRemove(): void
    {
        $fixture = new GalleryImage();
        $fixture->setTitle('Value');
        $fixture->setDescription('Value');
        $fixture->setImageUrl('Value');
        $fixture->setIsActive('Value');
        $fixture->setCreatedAt('Value');

        $this->manager->persist($fixture);
        $this->manager->flush();

        $this->client->request('GET', sprintf('%s%s', $this->path, $fixture->getId()));
        $this->client->submitForm('Delete');

        self::assertResponseRedirects('/gallery/image');
        self::assertSame(0, $this->galleryImageRepository->count([]));

        $this->markTestIncomplete('This test was generated');
    }
}
