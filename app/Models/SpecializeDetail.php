<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class SpecializeDetail extends Model
{
    use HasFactory;

    protected $table = 'specialize_details';
    protected $guarded = [];
    protected $fillable = ['experience', 'specialize_id', 'user_id'];

    public function specialize(): BelongsTo
    {
        return $this->belongsTo(Specialize::class, 'specialize_id');
    }
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function certificates(): object
    {
        return $this->hasMany(Certificate::class, 'specialize_detail_id', 'id');
    }

    public function courses(): object
    {
        return $this->hasMany(Course::class, 'specialize_detail_id', 'id');
    }
}

