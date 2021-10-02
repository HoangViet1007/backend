<?php

use App\Constants\StatusConstant;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateSlidesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('slides', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('image');
            $table->string('alt');
            $table->enum('status', [StatusConstant::ACTIVE, StatusConstant::INACTIVE])->default(StatusConstant::INACTIVE);
            $table->string('link')->nullable();
            $table->string('title')->nullable();
            $table->text('short_content')->nullable();
            $table->text('content')->nullable();
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
        Schema::dropIfExists('slides');
    }
}
