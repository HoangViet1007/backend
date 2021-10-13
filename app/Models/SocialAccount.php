<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SocialAccount extends Model
{
    use HasFactory;

    protected $table    = 'social_accounts';
    protected $guarded  = [];
    protected $fillable = ['social_id', 'social_provider', 'user_id'];

    public function user()
    {
        return $this->belongsTo(User::class,'user_id','id');
    }
}
