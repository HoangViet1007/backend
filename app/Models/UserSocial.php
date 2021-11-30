<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserSocial extends Model
{
    use HasFactory;

    protected $table    = 'user_socials';
    protected $fillable = ['link', 'user_id', 'social_id'];

    public function socials()
    {
        return $this->belongsTo(Social::class,'social_id','id');
    }
}
