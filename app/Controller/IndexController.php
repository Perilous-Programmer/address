<?php

declare(strict_types=1);
/**
 * This file is part of Simps.
 *
 * @link     https://simps.io
 * @document https://doc.simps.io
 * @license  https://github.com/simple-swoole/simps/blob/master/LICENSE
 */
namespace App\Controller;

class IndexController
{
    public function index($request, $response)
    {
        $response->header('Content-Type', 'application/json');
        $response->end(
            json_encode(
                [
                    'ip' => $request->header['x-forwarded-for'] ?? '127.0.0.1',
                ]
            )
        );
    }

    public function hello($request, $response, $data)
    {
        $name = $data['name'] ?? 'Simps';

        $response->end(
            json_encode(
                [
                    'method' => $request->server['request_method'],
                    'message' => "Hello {$name}.",
                ]
            )
        );
    }
}
