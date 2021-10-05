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
    protected $fillable = ['name', 'image', 'specialize_id'];

    public function specializes()
    {
        return $this->belongsTo(Specialize::class);
    }
}
