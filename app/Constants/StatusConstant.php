<?php

namespace App\Constants;
/**
 * @Author apple
 * @Date   Sep 29, 2021
 */
class StatusConstant
{
    const ACTIVE    = 'Active';
    const INACTIVE  = 'Inactive';
    const PROCESS   = 'Process';
    const PROCESSED = 'Processed';

    const All
        = [
            self::ACTIVE,
            self::INACTIVE,
            self::PROCESS,
            self::PROCESSED,
        ];
}
