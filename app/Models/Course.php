<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;

class Course extends Model
{
    use HasFactory, SoftDeletes;

    protected $table    = 'courses';
    protected $guarded  = [];
    protected $fillable = ['name', 'image', 'lessons', 'time_a_lessons', 'price', 'description', 'content', 'status', 'specialize_detail_id', 'customer_level_id'];

    public function customerLevel(): BelongsTo
    {
        return $this->belongsTo(CustomerLevel::class,'customer_level_id','id');
    }
}
