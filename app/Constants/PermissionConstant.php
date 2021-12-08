<?php

namespace App\Constants;

class PermissionConstant
{
    public static function course(string $action): string
    {
        return 'course' . ':' . $action;
    }

    public static function user(string $action): string
    {
        return 'user' . ':' . $action;
    }

    public static function setting(string $action): string
    {
        return 'setting' . ':' . $action;
    }

    public static function specialize(string $action): string
    {
        return 'specialize' . ':' . $action;
    }

    public static function account_level(string $action): string
    {
        return 'account_level' . ':' . $action;
    }

    public static function complain(string $action): string
    {
        return 'complain' . ':' . $action;
    }

    public static function order(string $action): string
    {
        return 'order' . ':' . $action;
    }

}

?>
