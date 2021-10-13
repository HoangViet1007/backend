<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Certificate extends Model
{
    use HasFactory;
    use HasFactory, softDeletes;

    protected $table = 'certificates';
    protected $primaryKey = 'id';
    protected $guarded = [];
    protected $fillable = ['name', 'image', 'specialize_detail_id','status'];

    public function specializes()
    {
        return $this->belongsTo(Specialize::class,'specialize_detail_id');
    }

    public function user(){
        return $this->hasOneThrough(
            User::class,
            SpecializeDetail::class,
            'user_id', // Foreign key on the cars table...
            'id', // Foreign key on the owners table...
            'id', // Local key on the mechanics table...
            'id' // Local key on the cars table...
        );
    }
}
