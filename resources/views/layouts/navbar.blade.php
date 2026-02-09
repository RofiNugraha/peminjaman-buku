<nav class="navbar navbar-expand-lg navbar-light bg-dark border-bottom fixed-top">
    <div class="container-fluid">
        <span class="navbar-brand fw-bold text-warning">
            Peminjaman Alat
        </span>

        <div class="ms-auto d-flex align-items-center gap-3">
            {{-- Logout --}}
            <form action="{{ route('logout') }}" method="POST" class="d-inline">
                @csrf
                <button class="btn btn-outline-danger btn-sm">
                    <i class="bi bi-box-arrow-right"></i>
                    Logout
                </button>
            </form>

        </div>
    </div>
</nav>