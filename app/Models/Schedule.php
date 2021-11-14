<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Schedule extends Model
{
    use HasFactory;

    protected $table    = 'schedules';
    protected $guarded  = [];
    protected $fillable = ['title', 'date', 'time_start', 'time_end', 'status', 'link_room', 'link_record', 'course_plan_id', 'course_student_id'];

    public function course_student()
    {
        return $this->belongsTo(CourseStudent::class, 'course_student_id', 'id');
    }

    public function course_planes()
    {
        return $this->belongsTo(CoursePlanes::class,'course_plan_id','id');
    }
}
