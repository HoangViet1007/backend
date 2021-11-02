<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use App\Constants\StatusConstant;


class AddColumnBillIdToPaymentsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('payments', function (Blueprint $table) {
            $table->dropColumn('course_id');
            $table->dropColumn('note');
//            $table->bigInteger('bill_id')->after('user_id');
//            $table->enum('note', [StatusConstant::RECHARGE, StatusConstant::PAY])->after('code_vnp');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('payments', function (Blueprint $table) {
            $table->bigInteger('course_id')->after('user_id');
            $table->enum('note', [StatusConstant::RECHARGE, StatusConstant::PAY])->after('code_vnp');
//            $table->dropColumn('bill_id');
//            $table->dropColumn('note');
        });
    }
}
