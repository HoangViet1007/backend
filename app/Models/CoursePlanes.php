<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class CoursePlanes extends Model
{
    use HasFactory;
    use SoftDeletes;

    protected $table      = 'course_planes';
    protected $primaryKey = 'id';
    protected $guarded    = [];

    protected $fillable = ['name', 'content', 'descreption', 'video_link', 'stage_id', 'status', 'image', 'type'];


    public function stage()
    {
        return $this->belongsTo(Stage::class, 'stage_id');
    }

    public function cousre()
    {
        return $this->hasManyThrough(
            Course::class,
            Stage::class,
            'course_id',
            'id',
            'stage_id',
            'id'
        );
    }

    public function schedules()
    {
        return $this->hasMany(Schedule::class,'course_plan_id','id');
    }
}
