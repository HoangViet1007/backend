<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use App\Constants\StatusConstant;

class CreateCoursesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('courses', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('image');
            $table->integer('lessons');
            $table->integer('time_a_lessons');
            $table->float('price', 12, 2);
            $table->text('description');
            $table->text('content');
            $table->enum('status', [StatusConstant::PENDING, StatusConstant::HAPPENING, StatusConstant::PAUSE, StatusConstant::REQUEST])->default(StatusConstant::PENDING);
            $table->enum('display', [StatusConstant::ACTIVE, StatusConstant::INACTIVE])->default(StatusConstant::ACTIVE);
            $table->unsignedBigInteger('created_by');
            $table->unsignedBigInteger('specialize_detail_id');
            $table->unsignedBigInteger('customer_level_id');
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
        Schema::dropIfExists('courses');
    }
}
