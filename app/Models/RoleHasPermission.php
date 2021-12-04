<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class RoleHasPermission extends Model
{
    use HasFactory;

    protected $table    = 'role_has_permissions';
    protected $fillable = ['name', 'display_name', 'is_mutable'];
}
