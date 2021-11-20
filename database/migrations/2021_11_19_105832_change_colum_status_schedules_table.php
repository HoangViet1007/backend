<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class ChangeColumStatusSchedulesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('schedules', function (Blueprint $table) {
            DB::statement("ALTER TABLE schedules MODIFY status ENUM('Complete','unfinished', 'happenning') NOT NULL DEFAULT 'unfinished'");
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('schedules', function (Blueprint $table) {
            DB::statement("ALTER TABLE schedules MODIFY status ENUM('Complete','unfinished') NOT NULL DEFAULT 'unfinished'");
        });
    }
}
