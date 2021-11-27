<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class ChangeColumnStatusTableCourseStudents extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('course_students', function (Blueprint $table) {
            DB::statement("ALTER TABLE course_students MODIFY status ENUM('Canceled','CanceledByPt','Unscheduled','Schedule','RequestAdmin','Complete') NOT NULL DEFAULT 'Unscheduled'");
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('course_students', function (Blueprint $table) {
            DB::statement("ALTER TABLE course_students MODIFY status ENUM('Canceled','CanceledByPt','Unscheduled','Schedule','Complete') NOT NULL DEFAULT 'Unscheduled'");
        });
    }
}
