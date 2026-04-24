<?php

namespace App\Services;

use App\Services\GoogleDriveService;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Mail;

class BackupService
{
    /**
     * Jalankan backup database
     */
    public static function runBackup(): bool
    {
        try {
            Log::info('Starting database backup...');

            Artisan::call('backup:run');

            Log::info('Database backup completed successfully');

            if (GoogleDriveService::isEnabled()) {
                if (GoogleDriveService::uploadLatestBackup()) {
                    Log::info('Latest backup uploaded to Google Drive successfully');
                } else {
                    Log::warning('Latest backup could not be uploaded to Google Drive');
                }
            }

            return true;
        } catch (\Exception $e) {
            Log::error('Backup failed: ' . $e->getMessage());

            self::notifyFailure($e->getMessage());

            return false;
        }
    }

    /**
     * Monitor kesehatan backup
     */
    public static function monitorBackup(): bool
    {
        try {
            Log::info('Starting backup health check...');

            Artisan::call('backup:monitor');

            Log::info('Backup health check completed');

            return true;
        } catch (\Exception $e) {
            Log::error('Backup monitoring failed: ' . $e->getMessage());

            return false;
        }
    }

    /**
     * Bersihkan backup lama
     */
    public static function cleanupBackups(): bool
    {
        try {
            Log::info('Starting backup cleanup...');

            Artisan::call('backup:clean');

            Log::info('Backup cleanup completed');

            return true;
        } catch (\Exception $e) {
            Log::error('Backup cleanup failed: ' . $e->getMessage());

            return false;
        }
    }

    /**
     * Get backup statistics
     */
    public static function getBackupStats(): array
    {
        $backupPath = storage_path('app/backups');

        if (!is_dir($backupPath)) {
            return [
                'total_backups' => 0,
                'total_size' => 0,
                'latest_backup' => null,
                'oldest_backup' => null,
            ];
        }

        $files = array_filter(scandir($backupPath), function ($file) {
            return strpos($file, '.zip') !== false;
        });

        $totalSize = 0;
        foreach ($files as $file) {
            $totalSize += filesize($backupPath . '/' . $file);
        }

        $latestBackup = count($files) > 0 ? max(array_map(function ($file) use ($backupPath) {
            return filemtime($backupPath . '/' . $file);
        }, $files)) : null;

        return [
            'total_backups' => count($files),
            'total_size' => self::formatBytes($totalSize),
            'total_size_bytes' => $totalSize,
            'latest_backup' => $latestBackup ? date('Y-m-d H:i:s', $latestBackup) : null,
            'oldest_backup' => count($files) > 0 ? date('Y-m-d H:i:s', min(array_map(function ($file) use ($backupPath) {
                return filemtime($backupPath . '/' . $file);
            }, $files))) : null,
        ];
    }

    /**
     * Kirim notifikasi backup gagal
     */
    private static function notifyFailure(string $message): void
    {
        $email = config('backup.notifications.mail.to');

        if (!$email) {
            return;
        }

        try {
            Mail::raw(
                "Database backup failed with error:\n\n{$message}\n\nPlease check your logs for more details.",
                function ($message) use ($email) {
                    $message->to($email)
                        ->subject('❌ Database Backup Failed - ' . config('app.name'));
                }
            );
        } catch (\Exception $e) {
            Log::error('Failed to send backup failure notification: ' . $e->getMessage());
        }
    }

    /**
     * Format bytes to human readable format
     */
    private static function formatBytes(int $bytes, int $precision = 2): string
    {
        $units = ['B', 'KB', 'MB', 'GB'];

        for ($i = 0; $bytes > 1024 && $i < count($units) - 1; $i++) {
            $bytes /= 1024;
        }

        return round($bytes, $precision) . ' ' . $units[$i];
    }
}
