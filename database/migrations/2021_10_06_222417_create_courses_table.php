<?php

use App\Constants\StatusConstant;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

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
            $table->enum('status', [StatusConstant::PENDING, StatusConstant::HAPPENING, StatusConstant::PAUSE])->default(StatusConstant::PENDING);
            $table->unsignedBigInteger('specialize_detail_id');
            $table->unsignedBigInteger('customer_level_id');
            $table->timestamps();
            $table->softDeletes();
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
