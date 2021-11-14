<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class ChangeColumnStatusCoursesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('courses', function (Blueprint $table) {
            DB::statement("ALTER TABLE courses MODIFY status ENUM('Pending', 'Happening', 'Pause', 'Request') NOT NULL DEFAULT 'Pending'");
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('courses', function (Blueprint $table) {
            DB::statement("ALTER TABLE courses MODIFY status ENUM('Pending', 'Happening', 'Pause') NOT NULL DEFAULT 'Pending'");
        });
    }
}
