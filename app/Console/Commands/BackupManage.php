<?php

namespace App\Console\Commands;

use App\Services\BackupService;
use Illuminate\Console\Command;

class BackupManage extends Command
{
    protected $signature = 'backup:manage {action=status} {--force}';
    protected $description = 'Manage database backups (status, run, clean, stats)';

    public function handle()
    {
        $action = $this->argument('action');

        match ($action) {
            'status' => $this->status(),
            'run' => $this->runBackup(),
            'clean' => $this->cleanBackups(),
            'stats' => $this->showStats(),
            'monitor' => $this->monitorBackup(),
            default => $this->error("Unknown action: {$action}"),
        };
    }

    private function status(): void
    {
        $this->info('📊 Backup Status');
        $this->newLine();

        $stats = BackupService::getBackupStats();

        $this->table(
            ['Property', 'Value'],
            [
                ['Total Backups', $stats['total_backups']],
                ['Total Size', $stats['total_size']],
                ['Latest Backup', $stats['latest_backup'] ?? 'None'],
                ['Oldest Backup', $stats['oldest_backup'] ?? 'None'],
            ]
        );

        $this->newLine();
        $this->info('💡 Tip: Use "php artisan backup:manage stats" for detailed statistics');
    }

    private function runBackup(): void
    {
        $this->newLine();
        $this->info('🔄 Starting database backup...');
        $this->newLine();

        if (!$this->confirm('Continue with backup?', true)) {
            $this->warn('Backup cancelled');
            return;
        }

        $this->newLine();

        if (BackupService::runBackup()) {
            $this->newLine();
            $this->info('✅ Backup completed successfully!');
            $this->showStats();
        } else {
            $this->newLine();
            $this->error('❌ Backup failed! Check logs for details.');
        }
    }

    private function cleanBackups(): void
    {
        $this->newLine();
        $this->warn('⚠️  This will remove old backups according to retention policy');
        $this->newLine();

        if (!$this->confirm('Continue with cleanup?', false)) {
            $this->warn('Cleanup cancelled');
            return;
        }

        $this->newLine();
        $this->info('🧹 Starting backup cleanup...');
        $this->newLine();

        if (BackupService::cleanupBackups()) {
            $this->newLine();
            $this->info('✅ Cleanup completed successfully!');
            $this->showStats();
        } else {
            $this->newLine();
            $this->error('❌ Cleanup failed! Check logs for details.');
        }
    }

    private function showStats(): void
    {
        $this->newLine();
        $this->info('📈 Backup Statistics');
        $this->newLine();

        $stats = BackupService::getBackupStats();

        $this->table(
            ['Metric', 'Value'],
            [
                ['Total Backups Count', $stats['total_backups']],
                ['Total Storage Used', $stats['total_size']],
                ['Latest Backup Date', $stats['latest_backup'] ?? 'Never'],
                ['Oldest Backup Date', $stats['oldest_backup'] ?? 'N/A'],
            ]
        );

        $this->newLine();
        $this->info('💾 Storage Location: storage/app/backups');
        $this->info('☁️  Cloud Storage: S3');
    }

    private function monitorBackup(): void
    {
        $this->newLine();
        $this->info('🔍 Monitoring backup health...');
        $this->newLine();

        if (BackupService::monitorBackup()) {
            $this->info('✅ Backup health check completed!');
        } else {
            $this->error('❌ Health check failed! Check logs for details.');
        }
    }
}
