<?php

namespace App\Console\Commands;

use App\Services\ScheduleService;
use Illuminate\Console\Command;

class SchedulePT extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'command:schedule-pt';
    protected $scheduleService;

    public function __construct(ScheduleService $scheduleService)
    {
        parent::__construct();
        $this->scheduleService = $scheduleService;
    }
    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Command schedule PT';

    /**
     * Create a new command instance.
     *
     * @return void
     */

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        return $this->scheduleService->schedulePT();
    }
}
