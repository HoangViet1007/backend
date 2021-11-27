<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class CourseStudent extends Model
{
    use HasFactory, SoftDeletes;

    protected $table    = 'course_students';
    protected $guarded  = [];
    protected $fillable = ['status','user_consent', 'description', 'user_id', 'course_id'];

        public function users()
    {
        return $this->belongsTo(User::class, 'user_id', 'id');
    }

    public function courses()
    {
        return $this->belongsTo(Course::class, 'course_id', 'id');
    }

    public function schedules()
    {
        return $this->hasMany(Schedule::class,'course_student_id','id');
    }

    // with([course_students.users]) custorm
    // course_student.courses.teach
}
