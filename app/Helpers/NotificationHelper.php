<?php

namespace App\Helpers;

use App\Models\Notification;

class NotificationHelper
{
    public static function create(int $userId, string $judul, string $pesan, $notifiable = null): void
    {
        try {
            Notification::create([
                'id_user' => $userId,
                'judul' => $judul,
                'pesan' => $pesan,
                'notifiable_id' => $notifiable ? $notifiable->id : null,
                'notifiable_type' => $notifiable ? get_class($notifiable) : null,
            ]);
        } catch (\Throwable $e) {
            \Illuminate\Support\Facades\Log::error('Gagal membuat notifikasi: ' . $e->getMessage());
        }
    }
}
