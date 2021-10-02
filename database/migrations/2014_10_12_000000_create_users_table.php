<?php

use App\Constants\SexConstant;
use App\Constants\StatusConstant;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUsersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('users', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('image');
            $table->string('address');
            $table->string('phone',50);
            $table->string('email')->unique();
            $table->timestamp('email_verified_at')->nullable();
            $table->string('password');
            $table->enum('status', [StatusConstant::ACTIVE, StatusConstant::INACTIVE])->default(StatusConstant::INACTIVE);
            $table->enum('sex', [SexConstant::MALE, SexConstant::FEMALE])->default(SexConstant::MALE);
            $table->float('money', 12, 2);
            $table->rememberToken();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('users');
    }
}
