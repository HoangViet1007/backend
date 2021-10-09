<?php

namespace Database\Seeders;

use App\Models\CoursePlanes;
use Illuminate\Database\Seeder;
use Illuminate\Support\Str;

class CoursePlanesSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {

        for ($i = 0; $i < 10; $i++) {
            CoursePlanes::create(
                [
                    'name' => Str::random(),
                    'content' => "content" . $i,
                    'descreption' => Str::random(),
                    'video_link' => 'link video' . $i,
                    'stage_id' => '1'
                ]

            );
        }

    }
}
