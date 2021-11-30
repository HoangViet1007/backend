<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Social extends Model
{
    use HasFactory;

    protected $table    = 'socials';
    protected $fillable = ['name', 'display_name'];

    public function userSocials()
    {
        return $this->hasMany(UserSocial::class,'social_id','id');
    }
}
