<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Schedule extends Model
{
    use HasFactory;

    protected $table    = 'schedules';
    protected $guarded  = [];

    protected $fillable = ['title', 'date', 'time_start', 'time_end', 'status', 'participation', 'complain', 'reason_complain', 'link_room', 'link_record', 'actual_end_time', 'actual_start_time', 'course_plan_id', 'course_student_id','check_link_record','date_send_link_record'];

    public function course_student()
    {
        return $this->belongsTo(CourseStudent::class, 'course_student_id', 'id');
    }

    public function course_planes()
    {
        return $this->belongsTo(CoursePlanes::class,'course_plan_id','id');
    }
}
