<?php

use Illuminate\Foundation\Inspiring;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Schedule;

Artisan::command('inspire', function () {
    $this->comment(Inspiring::quote());
})->purpose('Display an inspiring quote');

Schedule::command('peminjaman:expire')
    ->everyMinute()
    ->withoutOverlapping()
    ->runInBackground();

/*
 * Database Backup Scheduler
 * Menjalankan backup database otomatis setiap hari pada jam 2 pagi
 */
Schedule::command('backup:run')
    ->daily()
    ->at('02:00')
    ->withoutOverlapping()
    ->runInBackground()
    ->onFailure(function () {
        \Illuminate\Support\Facades\Log::error('Database backup failed at ' . now());
    })
    ->onSuccess(function () {
        \Illuminate\Support\Facades\Log::info('Database backup completed successfully at ' . now());
    });

/*
 * Cleanup Old Backups
 * Menghapus backup lama sesuai dengan retention policy
 * Dijalankan setiap hari pada jam 3 pagi
 */
Schedule::command('backup:monitor')
    ->daily()
    ->at('03:00')
    ->withoutOverlapping()
    ->runInBackground();

Schedule::command('backup:clean')
    ->daily()
    ->at('03:30')
    ->withoutOverlapping()
    ->runInBackground();
