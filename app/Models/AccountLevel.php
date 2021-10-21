<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AccountLevel extends Model
{
    use HasFactory;

    protected $table    = 'account_levels';
    protected $guarded  = [];
    protected $fillable = ['name', 'image', 'status', 'display_name', 'course_number', 'user_number', 'is_mutable'];
}
