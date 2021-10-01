<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class CustomerLevel extends Model
{
    use HasFactory, softDeletes;

    protected $table    = 'customer_levels';
    protected $guarded  = [];
    protected $fillable = ['name'];
}
