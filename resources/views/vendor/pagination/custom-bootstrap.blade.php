@if ($paginator->hasPages())
<nav>
    <ul class="pagination justify-content-end mb-0">
        {{-- Previous Page Link --}}
        @if ($paginator->onFirstPage())
        <li class="page-item disabled"><span class="page-link">&laquo;</span></li>
        @else
        <li class="page-item">
            <a class="page-link" href="{{ $paginator->previousPageUrl() }}" rel="prev">&laquo;</a>
        </li>
        @endif

        {{-- Sliding Pagination --}}
        @php
        $start = max($paginator->currentPage() - 1, 1);
        $end = min($start + 2, $paginator->lastPage());
        @endphp

        {{-- Tampilkan nomor halaman pertama jika start > 1 --}}
        @if ($start > 1)
        <li class="page-item"><a class="page-link" href="{{ $paginator->url(1) }}">1</a></li>
        @if ($start > 2)
        <li class="page-item disabled"><span class="page-link">...</span></li>
        @endif
        @endif

        {{-- Loop nomor halaman sliding --}}
        @for ($i = $start; $i <= $end; $i++) <li class="page-item @if($i == $paginator->currentPage()) active @endif">
            <a class="page-link" href="{{ $paginator->url($i) }}">{{ $i }}</a>
            </li>
            @endfor

            {{-- Tampilkan halaman terakhir --}}
            @if ($end < $paginator->lastPage())
                @if ($end < $paginator->lastPage() - 1)
                    <li class="page-item disabled"><span class="page-link">...</span></li>
                    @endif
                    <li class="page-item"><a class="page-link"
                            href="{{ $paginator->url($paginator->lastPage()) }}">{{ $paginator->lastPage() }}</a></li>
                    @endif

                    {{-- Next Page Link --}}
                    @if ($paginator->hasMorePages())
                    <li class="page-item">
                        <a class="page-link" href="{{ $paginator->nextPageUrl() }}" rel="next">&raquo;</a>
                    </li>
                    @else
                    <li class="page-item disabled"><span class="page-link">&raquo;</span></li>
                    @endif
    </ul>
</nav>
@endif