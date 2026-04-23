<nav class="navbar navbar-expand-lg fixed-top navbar-modern">
    <div class="container-fluid">
        <button id="toggleSidebar" class="btn btn-light me-2">
            <i class="bi bi-list"></i>
        </button>

        <div class="d-flex align-items-center gap-2">
            <img src="{{ asset('storage/logo/logo_putih.png') }}" alt="Logo" style="height: 42px; width: auto;">

            <span class="menu-text fw-semibold">
                Perpustakaan Sekolah Digital
            </span>
        </div>

        <div class="ms-auto d-flex align-items-center gap-3">

            @if(auth()->user()->role === 'peminjam')
            <a class="nav-notif" href="{{ route('peminjam.notifikasi.index') }}">
                <span class="notif-icon">
                    <i class="bi bi-bell"></i>

                    @if(($unreadNotifCount ?? 0) > 0)
                    <span class="notif-badge">
                        {{ $unreadNotifCount > 9 ? '9+' : $unreadNotifCount }}
                    </span>
                    @endif
                </span>
            </a>
            @endif

            <button class="btn btn-outline-light btn-sm" onclick="document.getElementById('logout-form').submit()">
                Logout
            </button>

        </div>
    </div>
</nav>