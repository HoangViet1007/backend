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
    protected $fillable = ['name', 'image', 'lessons', 'time_a_lessons', 'price', 'description', 'content', 'status', 'display', 'specialize_detail_id', 'customer_level_id', 'created_by'];

    public function customerLevel(): BelongsTo
    {
        return $this->belongsTo(CustomerLevel::class, 'customer_level_id', 'id');
    }

    public function specializeDetails(): BelongsTo
    {
        return $this->belongsTo(SpecializeDetail::class, 'specialize_detail_id', 'id');
    }

    public function stages()
    {
        return $this->hasMany(Stage::class);
    }


    public function cousre_planes()
    {
        return $this->hasManyThrough(
            CoursePlanes::class,
            Stage::class,
            'course_id',
            'id',
            'stage_id',
            'id'
        );
    }

}
