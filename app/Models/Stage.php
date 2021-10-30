<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class Stage extends Model
{
    use HasFactory;
    use SoftDeletes;

    protected $table = 'stages';
    protected $primaryKey = 'id';
    protected $fillable = ['name', 'short_content', 'content', 'status', 'course_id'];

    public function course_planes(): HasMany
    {
        return $this->hasMany(CoursePlanes::class);
    }

    public function course()
    {
        return $this->belongsTo(Course::class);
    }
}
