<?php

namespace App\Services;

use GuzzleHttp\Client as GuzzleClient;
use Illuminate\Support\Facades\Log;

class GoogleDriveService
{
    public static function isEnabled(): bool
    {
        return !empty(env('GOOGLE_DRIVE_CLIENT_ID'))
            && !empty(env('GOOGLE_DRIVE_CLIENT_SECRET'))
            && !empty(env('GOOGLE_DRIVE_REFRESH_TOKEN'))
            && !empty(env('GOOGLE_DRIVE_FOLDER_ID'));
    }

    public static function uploadLatestBackup(): bool
    {
        $storageRoot = storage_path('app');

        if (!is_dir($storageRoot)) {
            Log::warning('Google Drive upload failed: storage/app directory does not exist.');
            return false;
        }

        $zipFiles = [];
        $iterator = new \RecursiveIteratorIterator(
            new \RecursiveDirectoryIterator($storageRoot, \FilesystemIterator::SKIP_DOTS)
        );

        foreach ($iterator as $file) {
            if ($file->isFile() && str_ends_with($file->getFilename(), '.zip')) {
                $zipFiles[] = $file->getPathname();
            }
        }

        if (empty($zipFiles)) {
            Log::warning('Google Drive upload failed: no backup archive found.');
            return false;
        }

        usort($zipFiles, function ($a, $b) {
            return filemtime($b) <=> filemtime($a);
        });

        $latestBackup = $zipFiles[0];

        return self::uploadFile($latestBackup, basename($latestBackup));
    }

    public static function uploadFile(string $localPath, string $remoteName, ?string $folderId = null): bool
    {
        $folderId = $folderId ?: env('GOOGLE_DRIVE_FOLDER_ID');

        if (!file_exists($localPath)) {
            Log::warning('Google Drive upload failed: local file does not exist: ' . $localPath);
            return false;
        }

        if (empty($folderId)) {
            Log::warning('Google Drive upload failed: GOOGLE_DRIVE_FOLDER_ID is not configured.');
            return false;
        }

        try {
            $accessToken = self::getAccessToken();

            if (empty($accessToken)) {
                Log::warning('Google Drive upload failed: unable to obtain access token.');
                return false;
            }

            $guzzle = new GuzzleClient(['timeout' => 120]);
            $response = $guzzle->post('https://www.googleapis.com/upload/drive/v3/files?uploadType=multipart&fields=id', [
                'headers' => [
                    'Authorization' => 'Bearer ' . $accessToken,
                ],
                'multipart' => [
                    [
                        'name' => 'metadata',
                        'contents' => json_encode([
                            'name' => $remoteName,
                            'parents' => [$folderId],
                        ]),
                        'headers' => [
                            'Content-Type' => 'application/json; charset=UTF-8',
                        ],
                    ],
                    [
                        'name' => 'file',
                        'contents' => fopen($localPath, 'r'),
                        'headers' => [
                            'Content-Type' => 'application/zip',
                        ],
                    ],
                ],
            ]);

            $body = json_decode((string) $response->getBody(), true);

            if (empty($body['id'])) {
                Log::warning('Google Drive upload failed: no file ID returned.');
                return false;
            }

            Log::info('Google Drive upload completed: ' . $remoteName);

            return true;
        } catch (\Exception $exception) {
            Log::error('Google Drive upload failed: ' . $exception->getMessage());

            return false;
        }
    }

    private static function getAccessToken(): ?string
    {
        $refreshToken = env('GOOGLE_DRIVE_REFRESH_TOKEN');
        $clientId = env('GOOGLE_DRIVE_CLIENT_ID');
        $clientSecret = env('GOOGLE_DRIVE_CLIENT_SECRET');

        if (empty($refreshToken) || empty($clientId) || empty($clientSecret)) {
            return null;
        }

        try {
            $guzzle = new GuzzleClient(['timeout' => 30]);
            $response = $guzzle->post('https://oauth2.googleapis.com/token', [
                'form_params' => [
                    'client_id' => $clientId,
                    'client_secret' => $clientSecret,
                    'refresh_token' => $refreshToken,
                    'grant_type' => 'refresh_token',
                ],
            ]);

            $data = json_decode((string) $response->getBody(), true);

            return $data['access_token'] ?? null;
        } catch (\Exception $exception) {
            Log::error('Google Drive token refresh failed: ' . $exception->getMessage());
            return null;
        }
    }
}
