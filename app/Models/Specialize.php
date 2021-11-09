<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Specialize extends Model
{
    use HasFactory, SoftDeletes;

    protected $table    = 'specializes';
    protected $guarded  = [];
    protected $fillable = ['name', 'status', 'description'];

    public function specializeDetail()
    {
        return $this->hasMany(SpecializeDetail::class);
    }
}
