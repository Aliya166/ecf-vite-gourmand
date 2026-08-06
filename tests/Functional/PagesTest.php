<?php

namespace App\Tests\Functional;

use Symfony\Bundle\FrameworkBundle\Test\WebTestCase;

class PagesTest extends WebTestCase
{
    public function testHomePage(): void
    {
        $client = static::createClient();
        $client->request('GET', '/');

        self::assertResponseIsSuccessful();
    }

    public function testMenusPage(): void
    {
        $client = static::createClient();
        $client->request('GET', '/menus');

        self::assertResponseIsSuccessful();
    }

    public function testContactPage(): void
    {
        $client = static::createClient();
        $client->request('GET', '/contact');

        self::assertResponseIsSuccessful();
    }

    public function testAboutPage(): void
    {
        $client = static::createClient();
        $client->request('GET', '/a-propos');

        self::assertResponseIsSuccessful();
    }

    public function testLivraisonPage(): void
    {
        $client = static::createClient();
        $client->request('GET', '/livraison');

        self::assertResponseIsSuccessful();
    }

    public function testLoginPage(): void
    {
        $client = static::createClient();

        $client->request('GET', '/login');

        self::assertResponseIsSuccessful();
    }

    public function testRegisterPage(): void
    {
        $client = static::createClient();

        $client->request('GET', '/register');

        self::assertResponseIsSuccessful();
    }
}
