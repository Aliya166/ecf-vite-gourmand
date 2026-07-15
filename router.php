<?php

use App\Kernel;
use Symfony\Component\Dotenv\Dotenv;
use Symfony\Component\HttpFoundation\Request;

require_once __DIR__ . '/vendor/autoload.php';

$path = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
$publicFile = __DIR__ . '/public' . $path;

// CSS, JavaScript, изображения и другие реальные файлы
// встроенный сервер PHP отдаёт самостоятельно.
if ($path !== '/' && is_file($publicFile)) {
    return false;
}

(new Dotenv())->bootEnv(__DIR__ . '/.env');

$kernel = new Kernel(
    $_SERVER['APP_ENV'] ?? 'dev',
    (bool) ($_SERVER['APP_DEBUG'] ?? true)
);

$request = Request::createFromGlobals();
$response = $kernel->handle($request);

$response->send();
$kernel->terminate($request, $response);