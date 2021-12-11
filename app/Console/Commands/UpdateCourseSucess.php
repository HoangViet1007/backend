<?php

namespace App\Console\Commands;

use App\Models\Schedule;
use App\Services\ScheduleService;
use Illuminate\Console\Command;

class UpdateCourseSucess extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'command:update-course-sucess';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Command description';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    protected $scheduleService;

    public function __construct(ScheduleService $scheduleService)
    {
        parent::__construct();
        $this->scheduleService = $scheduleService;

    }

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        return $this->scheduleService->updateCourseSucces();
    }
}
