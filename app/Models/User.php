<?php

namespace App\Models;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Passport\HasApiTokens;

class User extends Authenticatable implements MustVerifyEmail
{
    use HasApiTokens, HasFactory, Notifiable, SoftDeletes;

    /**
     * The attributes that are mass assignable.
     *
     * @var string[]
     */
    protected $fillable
        = [
            'name',
            'image',
            'address',
            'description',
            'phone',
            'status',
            'sex',
            'money',
            'email',
            'password',
            'socialite_id',
            'type_socialite',
            'email_verified_at',
            'account_level_id'
        ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array
     */
    protected $hidden
        = [
            'password',
            'remember_token',
        ];

    /**
     * The attributes that should be cast.
     *
     * @var array
     */
    protected $casts
        = [
            'email_verified_at' => 'datetime',
        ];

    public function roles(): BelongsToMany
    {
        return $this->belongsToMany(Role::class, 'model_has_roles', 'user_id', 'role_id');
    }

    public function coursesPecializeDetails()
    {
        return $this->hasOneThrough(Course::class, SpecializeDetail::class, 'user_id', 'specialize_details', 'id',
                                    'id');
    }

    public function specializeDetails()
    {
        return $this->hasMany(SpecializeDetail::class);
    }

    public function socialAccounts()
    {
        return $this->hasMany(SocialAccount::class);
    }

    public function accountLevels()
    {
        return $this->belongsTo(AccountLevel::class, 'account_level_id', 'id');
    }

    public function socials()
    {
        return $this->belongsToMany(Social::class, 'user_socials', 'user_id', 'social_id');
    }

    public function userSocials()
    {
        return $this->hasMany(UserSocial::class,'user_id','id');
    }

    public function modelHasRoles(){
        return $this->hasMany(ModelHasRole::class,'user_id','id');
    }

    public function course(){
        return $this->hasMany(Course::class,'created_by','id');
    }
}
