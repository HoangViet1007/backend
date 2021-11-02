<?php

use Illuminate\Database\Migrations\Migration;
use App\Constants\StatusConstant;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateBillsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('bills', function (Blueprint $table) {
            $table->id();
            $table->string('code_bill');
            $table->dateTime('time');
            $table->float('money');
            $table->enum('status', [StatusConstant::WALLET, StatusConstant::DIRECT]);
            $table->bigInteger('course_id');
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
        Schema::dropIfExists('bills');
    }
}
