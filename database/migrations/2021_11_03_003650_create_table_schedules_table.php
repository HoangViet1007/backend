<?php

use App\Constants\StatusConstant;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTableSchedulesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('schedules', function (Blueprint $table) {
            $table->id();
            $table->string('title');
            $table->date('date');
            $table->string('time_start');
            $table->string('time_end');
            $table->enum('status', [StatusConstant::COMPLETE, StatusConstant::UNFINISHED])->default(StatusConstant::UNFINISHED);
            $table->string('link_room');
            $table->string('link_record')->nullable();
            $table->unsignedBigInteger('course_plan_id');
            $table->unsignedBigInteger('course_student_id');
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
        Schema::dropIfExists('schedules');
    }
}
