<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('bukus', function (Blueprint $table) {
            $table->string('penulis')->nullable()->after('judul');
            $table->string('penerbit')->nullable()->after('penulis');
            $table->integer('tahun_terbit')->nullable()->after('penerbit');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('bukus', function (Blueprint $table) {
            $table->dropColumn(['penulis', 'penerbit', 'tahun_terbit']);
        });
    }
};
