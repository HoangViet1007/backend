<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use App\Constants\StatusConstant;

class AddColumnParticipationComplainActualStartTimeActualEndTimeToSchedulesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('schedules', function (Blueprint $table) {
            $table->enum('complain', [StatusConstant::COMPLAIN, StatusConstant::NOCOMPLAINTS])->after('status')->default(StatusConstant::NOCOMPLAINTS);
            $table->enum('participation', [StatusConstant::JOIN, StatusConstant::NOJOIN])->after('status')->nullable();
            $table->dateTime('actual_start_time')->nullable()->after('link_record');
            $table->dateTime('actual_end_time')->nullable()->after('link_record');
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
            $table->dropColumn('complain');
            $table->dropColumn('participation');
            $table->dropColumn('actual_start_time');
            $table->dropColumn('actual_end_time');
        });
    }
}
