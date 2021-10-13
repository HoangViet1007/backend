<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class CoursePlanes extends Model
{
    use HasFactory;
    use SoftDeletes;

    protected $table = 'course_planes';
    protected $primaryKey = 'id';
    protected $guarded = [];
<<<<<<< HEAD
    protected $fillable = ['name', 'content', 'descreption', 'video_link', 'stage_id','status'];
=======
    protected $fillable = ['name', 'content', 'descreption', 'video_link', 'stage_id'];
>>>>>>> 65474b75a689dd68328775a646690eaab3d27b76

    public function stage()
    {
        return $this->belongsTo(Stage::class, 'stage_id');
    }
}
