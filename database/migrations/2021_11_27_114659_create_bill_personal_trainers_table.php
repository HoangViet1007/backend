<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateBillPersonalTrainersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('bill_personal_trainers', function (Blueprint $table) {
            $table->id();
            $table->string('code_bill');
            $table->dateTime('time');
            $table->float('money');
            $table->string('note')->nullable();
            $table->bigInteger('course_student_id');
            $table->bigInteger('user_id');
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
        Schema::dropIfExists('bill_personal_trainers');
    }
}
