<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ModelHasRole extends Model
{
    use HasFactory;
    protected $table = 'model_has_roles';
    protected $guarded = [] ;
    protected $fillable = ['role_id','user_id'] ;

    public function role(){
        return $this->hasMany(Role::class,'role_id','id');
    }

    public function user(){
        return $this->belongsTo(User::class,'user_id','id');
    }
}
