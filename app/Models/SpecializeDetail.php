<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SpecializeDetail extends Model
{
    use HasFactory, softDeletes;

    protected $table = 'specialize_details';
    protected $guarded = [];
    protected $fillable = ['experience', 'specialize_id', 'user_id'];

    public function specialize(): object
    {
        return $this->belongsTo(Specialize::class, 'specialize_id');
    }

    public function user(): object
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function certificates(): object
    {
        return $this->hasMany(Certificate::class, 'specialize_detail_id', 'id');
    }
}

