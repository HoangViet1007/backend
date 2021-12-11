<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BillPersonalTrainer extends Model
{
    use HasFactory;
    protected $table = 'bill_personal_trainers';
    protected $guarded = [];
    protected $fillable = ['code_bill', 'time', 'money', 'money_old', 'note', 'image', 'course_student_id', 'user_id'];

    public function CourseStudent()
    {
        return $this->belongsTo(CourseStudent::class, 'course_student_id', 'id');
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id', 'id');
    }
}
