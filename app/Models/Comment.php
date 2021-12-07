<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Comment extends Model
{
    use HasFactory;
    protected $table = 'comments';
    protected $fillable = ['id_course','user_id','content','number_stars','status'];

    public function course(){
        return $this->belongsTo(Course::class,'id_course','id');
    }

    public function user_comment(){
        return $this->belongsTo(User::class, 'user_id', 'id');

    }
}
