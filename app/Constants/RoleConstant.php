<?php

namespace App\Constants;
/**
 * @Author apple
 * @Date   Oct 04, 2021
 */
class RoleConstant
{
    const ADMIN    = 'Admin';
    const CUSTOMER = 'Customer';
    const PT       = 'Pt';

    const ALL
        = [
            self::ADMIN,
            self::CUSTOMER,
            self::PT
        ];
}
