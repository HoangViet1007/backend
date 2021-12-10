<?php

namespace App\Models;

use App\Constants\StatusConstant;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasManyThrough;
use Illuminate\Database\Eloquent\SoftDeletes;

class Course extends Model
{
    use HasFactory, SoftDeletes;

    protected $table = 'courses';
    protected $guarded = [];
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

    public function stagesClient(): HasMany
    {
        return $this->hasMany(Stage::class)->where('status', StatusConstant::ACTIVE);
    }

    public function cousre_planes(): HasManyThrough
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

    public function teacher()
    {
        return $this->belongsTo(User::class, 'created_by', 'id');
    }

    public function course_students()
    {
        return $this->hasMany(CourseStudent::class, 'course_id', 'id');
    }

    public function comments()
    {
        return $this->hasMany(Comment::class,'id_course','id');
    }
}
