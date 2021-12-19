<?php

namespace App\Console;

use Illuminate\Console\Scheduling\Schedule;

use Illuminate\Foundation\Console\Kernel as ConsoleKernel;

class Kernel extends ConsoleKernel
{
    /**
     * The Artisan commands provided by your application.
     *
     * @var array
     */
    protected $commands = [
        Commands\SchedulePT::class,
        Commands\ScheduleOfCustorm::class,
        Commands\ScheduleAccountLevel::class,
        Commands\UpdateCourseSucess::class

    ];

    /**
     * Define the application's command schedule.
     *
     * @param \Illuminate\Console\Scheduling\Schedule $schedule
     * @return void
     */
    protected function schedule(Schedule $schedule)
    {
        $schedule->command('command:schedule-pt')->dailyAt('04:30');
        $schedule->command('command:schedule-of-custorm')->dailyAt('04:40');
        $schedule->command('command:update-level')->dailyAt('00:00');
        $schedule->command('command:update-course-sucess')->hourly();

    }

    /**
     * Register the commands for the application.
     *
     * @return void
     */
    protected function commands()
    {
        $this->load(__DIR__ . '/Commands');

        require base_path('routes/console.php');
    }
}
