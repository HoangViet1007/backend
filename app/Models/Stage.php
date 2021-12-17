<?php

namespace App\Models;

use App\Constants\StatusConstant;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Stage extends Model
{
    use HasFactory;

    protected $table      = 'stages';
    protected $primaryKey = 'id';
    protected $fillable   = ['name', 'short_content', 'content', 'status', 'course_id'];

    public function course_planes(): HasMany
    {
        return $this->hasMany(CoursePlanes::class,'stage_id','id');
    }

    public function course_planes_client(): HasMany
    {
        return $this->hasMany(CoursePlanes::class)
                    ->where('status', StatusConstant::ACTIVE)
                    ->select('id','name');
    }

    public function course_planes_off(): HasMany
    {
        return $this->hasMany(CoursePlanes::class)->where('type', 0)->where('status', StatusConstant::ACTIVE);
    }

    public function course()
    {
        return $this->belongsTo(Course::class);
    }
}
