<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Slide extends Model
{
    use HasFactory, softDeletes;

    protected $table = 'slides';
    protected $guarded = [] ;
    protected $fillable = ['name','image','alt','status','link','title','short_content','content'];
}
