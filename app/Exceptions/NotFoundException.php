<?php

namespace App\Exceptions;


use Exception;
use Symfony\Component\HttpFoundation\Response;


class NotFoundException extends BaseException
{
    public function __construct(string|array $message, Exception $e = null)
    {
        parent::__construct($message, $e, Response::HTTP_NOT_FOUND);
    }
}
