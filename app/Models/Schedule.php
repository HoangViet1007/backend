<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Schedule extends Model
{
    use HasFactory, SoftDeletes;

    protected $table    = 'schedules';
    protected $guarded  = [];
    protected $fillable = ['title', 'date', 'time_start', 'time_end', 'status', 'link_room', 'link_record', 'course_plan_id', 'course_student_id'];
}
