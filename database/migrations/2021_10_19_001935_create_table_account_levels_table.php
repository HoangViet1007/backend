<?php

use App\Constants\StatusConstant;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTableAccountLevelsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('account_levels', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('image');
            $table->string('display_name');
            $table->enum('status', [StatusConstant::ACTIVE, StatusConstant::INACTIVE])->default(StatusConstant::ACTIVE);
            $table->integer('course_number');
            $table->integer('user_number');
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
        Schema::dropIfExists('account_levels');
    }
}
