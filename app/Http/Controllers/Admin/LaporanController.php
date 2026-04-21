<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Peminjaman;
use App\Models\Buku;
use Illuminate\Http\Request;
use App\Services\LaporanPeminjamanService;
use Barryvdh\DomPDF\Facade\Pdf;
use Maatwebsite\Excel\Facades\Excel;
use App\Exports\LaporanPeminjamanExport;

class LaporanController extends Controller
{
    public function index(Request $request, LaporanPeminjamanService $service)
    {
        $perPage = (int) $request->get('per_page', 10);
        if (!in_array($perPage, [5,10,25,50,100])) {
            $perPage = 10;
        }

        $baseQuery = $service->query($request);
        $data = (clone $baseQuery)->latest()->paginate($perPage)->withQueryString();
        $summaryData = (clone $baseQuery)->get();
        
        $totalTransaksi = $summaryData->count();
        $totalDenda = $summaryData->sum('total_denda');
        $totalTelat = $summaryData->filter(fn($d) => $d->is_telat)->count();

        $bukus = Buku::orderBy('judul')->get();

        return view('admin.laporan.index', compact('data', 'bukus', 'perPage', 'totalTransaksi', 'totalDenda', 'totalTelat'));
    }

    public function exportPdf(Request $request, LaporanPeminjamanService $service)
    {
        $data = $service->getData($request);

        $pdf = Pdf::loadView('admin.laporan.pdf', compact('data'))
            ->setPaper('A4', 'landscape');

        return $pdf->download('laporan-peminjaman-buku.pdf');
    }

    public function exportExcel(Request $request)
    {
        return Excel::download(
            new LaporanPeminjamanExport($request),
            'laporan-peminjaman-buku.xlsx'
        );
    }
}
