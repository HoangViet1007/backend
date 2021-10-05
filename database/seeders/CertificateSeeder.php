<?php

namespace Database\Seeders;

use App\Models\Certificate;
use Illuminate\Database\Seeder;
use Illuminate\Support\Str;

class CertificateSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        for ($i = 0; $i < 10; $i++) {
            Certificate::create(
                [
                    'name' => Str::random(),
                    'image' => Str::random(),
                    'specialize_id' => $i,
                ]

            );
        }

    }
}
