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
        return 'account-level' . ':' . $action;
    }

    public static function complain(string $action): string
    {
        return 'complain' . ':' . $action;
    }

    public static function bill(string $action): string
    {
        return 'bill' . ':' . $action;
    }

    public static function dashboard(string $action): string
    {
        return 'dashboard' . ':' . $action;
    }

    public static function student(string $action): string
    {
        return 'student' . ':' . $action;
    }

    public static function payment(string $action): string
    {
        return 'payment' . ':' . $action;
    }

    public static function comment(string $action): string
    {
        return 'comment' . ':' . $action;
    }

    public static function role(string $action): string
    {
        return 'role' . ':' . $action;
    }

    public static function permission(string $action): string
    {
        return 'permission' . ':' . $action;
    }

    public static function contact(string $action): string
    {
        return 'contact' . ':' . $action;
    }


}

?>
