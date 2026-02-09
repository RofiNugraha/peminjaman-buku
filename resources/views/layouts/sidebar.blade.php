<aside id="sidebar" class="sidebar bg-light text-warning">
    <div class="sidebar-header d-flex align-items-center justify-content-between px-3 py-3">
        <span class="sidebar-title fw-bold">{{ auth()->user()->role }}</span>
        <button id="toggleSidebar" class="btn btn-sm btn-outline-light">
            <i class="bi bi-list"></i>
        </button>
    </div>

    <ul class="nav flex-column px-2 mt-2">
        <li class="nav-item">
            <a href="{{ route('dashboard') }}" class="nav-link text-warning">
                <i class="bi bi-house"></i>
                <span class="menu-text">Dashboard</span>
            </a>
        </li>

        @if(auth()->user()->role === 'admin')
        <li class="nav-item">
            <a href="{{ url('/admin/users') }}" class="nav-link text-warning">
                <i class="bi bi-people"></i>
                <span class="menu-text">Manajemen User</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="{{ url('/admin/kategori') }}" class="nav-link text-warning">
                <i class="bi bi-folder"></i>
                <span class="menu-text">Kategori</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="{{ url('/admin/alat') }}" class="nav-link text-warning">
                <i class="bi bi-tools"></i>
                <span class="menu-text">Data Alat</span>
            </a>
        </li>
        @endif
        @if(auth()->user()->role === 'Peminjam')
        <li class="nav-item">
            <a href="{{ url('/peminjamn/daftar-alat') }}" class="nav-link text-warning">
                <i class="bi bi-people"></i>
                <span class="menu-text">Daftar Alat</span>
            </a>
        </li>
        @endif
    </ul>

    <div class="mt-auto px-3 py-3">
        <button class="btn btn-danger w-100" onclick="document.getElementById('logout-form').submit()">
            <i class="bi bi-box-arrow-right"></i>
            <span class="menu-text">Logout</span>
        </button>
    </div>
</aside>