<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class ChangeColumnStatusToBillsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('bills', function (Blueprint $table) {
            DB::statement("ALTER TABLE bills MODIFY status ENUM('Wallet','Direct') NOT NULL");
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('bills', function (Blueprint $table) {
            DB::statement("ALTER TABLE bills MODIFY status ENUM('Thanh toan bang vi','Thanh toan truc tiep') NOT NULL");
        });
    }
}
