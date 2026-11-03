# PRD — Berani Kamaimo

**Product Requirements Document**
**Versi:** 1.3
**Platform:** Mobile — Flutter
**Konsep:** Konversi 3 repo web (Dinas Pariwisata Sulawesi Tengah) → satu aplikasi mobile, mode User (publik) + mode Admin.

_Riwayat versi:_
- **1.3** — §8 dirapikan ulang: ternyata v1.2 menyasar mockup yang salah (`assets/images/desain_1_beranda.png`). Struktur Beranda kini diambil **persis dari Figma node `4273:55`** (file `MAGANG-PADE`) yang sudah ter-implementasi di `user_shell.dart` dan lolos smoke test: NavBar → Hero Card (headline + weather + search) → Quick Pills → Peta Interaktif (chips kabupaten + Desa Card) → Carousel **Wisata Unggulan Sulteng** (3 kartu) → **Atraksi & Event Budaya** (2 kartu) → Footer. ❗Design spec lama `design-specs/flutter_handoff_spec.md` (node `2:8522`, Poppins/Playfair) terbukti desain lain — **stale, jangan dipakai**; font resmi = **Plus Jakarta Sans**.
- **1.2** — Home tidak menampilkan Statistik Wisman, Testimoni, Concierge WhatsApp Banner (semuanya memang tidak ada di Figma); Ulasan Pengunjung hanya di Detail Desa.
- **1.1** — Tambah layar **Halaman Sambutan** (§7) sebagai layar pembuka sebelum Home; **Ranking Asal Turis dipindah** dari Home ke layar itu (semula §7.8, sekarang §8.8 sebagai penunjuk). Section 7-30 di-shift menjadi 8-31.
- **1.0** — Versi awal.

---

## 1. Product Overview

**Berani Kamaimo** adalah aplikasi mobile promosi pariwisata Sulawesi Tengah yang dikonversi dari tiga web yang sudah ada:

| Sumber | Repo | Stack asli | Dipakai jadi |
|---|---|---|---|
| Web user (publik) | `mgading13/projek_dinas_pariwisata_sulteng` | React + Vite, shadcn/ui, Tailwind, react-leaflet, i18n (id/en) | Mode user di aplikasi |
| Web admin | `mgading13/admin_dinas_pariwisata` | React + Vite, shadcn/ui, recharts | Mode admin di aplikasi |
| Backend | `manda2712/Backend_Dinas_Pariwisata` | Node.js Express + Prisma + PostgreSQL, JWT, multer | Dipakai ulang apa adanya (API sudah siap) |

Aplikasi hasil konversi adalah **satu aplikasi Flutter** berisi:

- **Mode User** (default, tanpa login): halaman sambutan saat aplikasi dibuka, lalu browsing desa wisata, event/atraksi, paket wisata, kuliner, hotel, peta, dan menambah ulasan.
- **Mode Admin** (setelah login tersembunyi): dashboard grafik pengunjung + CRUD 9 entitas + manajemen admin (super admin).

Backend lama **tidak perlu ditulis ulang** — API-nya dipakai ulang apa adanya (endpoint sudah lengkap).

---

## 2. Product Vision

> **"Seluruh destinasi Sulawesi Tengah dalam satu aplikasi: publik bisa menjelajah, Dinas bisa mengelola."**

Satu source of truth (backend Pariwisata Sulteng yang sudah live di `https://beranikamaimo.sultengprov.go.id/`) disajikan ulang sebagai aplikasi mobile yang:

- Bisa dibuka siapa saja **tanpa login** untuk menjelajah destinasi.
- Membuka dengan **halaman sambutan** yang menyapa pengguna (identitas aplikasi + dari mana turis datang) sebelum masuk ke isi.
- Memberi pintu **admin tersembunyi** di dalam aplikasi yang sama — tetap dijamin keamanan asli (username + password + JWT + role check).
- Mendukung 2 bahasa: **Indonesia** (default) dan **Inggris**.

---

## 3. Target User

### Primary User (mode user)

Publik/Wisatawan yang:

- Mencari informasi desa wisata, event, dan destinasi Sulawesi Tengah saat berwisata.
- Ingin melihat petunjuk akses (Dari Palu / Dari Luwuk) dan transportasi.
- Ingin melihat paket wisata, kuliner, dan hotel beserta kontak (WhatsApp/telepon/Google Maps).
- Ingin membaca dan memberi ulasan pengunjung.
- Ingin melihat dari negara mana saja turis asing berkunjung (ranking top 5) — sudah langsung tampil di **halaman Sambutan** sebelum masuk Home.

### Secondary User (mode admin)

Dinas Pariwisata Sulteng / Admin yang:

- Mengelola konten (desa wisata, atraksi, paket wisata, kuliner, rumah makan, hotel, jarak desa).
- Menginput data kunjungan turis per negara (dipakai untuk ranking di Halaman Sambutan) — **satu pool nasional**, semua admin mengisi data yang sama.
- Melihat grafik pengunjung.
- SuperAdmin mengelola akun admin.

---

## 4. Core User Journey

```text
OPEN APP
   │
   ▼
HALAMAN SAMBUTAN (pembuka, tiap kali app dibuka)
   │  logo + nama + tagline + bahasa ID/EN
   │  Ranking Asal Turis (Top 5 Negara)
   │  [ Masuk ]
   │
   ▼
HOME (mode user)
    │
    ├── Hero Card (headline + weather + search)
    ├── Quick Pills → filter destinasi
    ├── Peta Interaktif Wisata → Detail Desa (via Desa Card)
    ├── Carousel Wisata Unggulan → Detail Desa
    ├── Atraksi & Event Budaya → Detail Event
    └── Footer
          │
          ▼
┌──────────────────────────────────────────────┐
│  PINTU RAHASIA ADMIN (login tersembunyi)      │
│  → dashboard, grafik, CRUD, super admin       │
└──────────────────────────────────────────────┘
```

---

## 5. Information Architecture

Aplikasi satu layar utama (Home dengan section-scroll, meniru web user) + halaman-halaman detail + area admin tersembunyi. Sebelum Home ada **Halaman Sambutan** sebagai layar pembuka.

```text
BERANI KAMAIMO (satu app)
├── MODE USER (tanpa login)
│   ├── Halaman Sambutan (pembuka: identitas, bahasa, Ranking Turis, tombol Masuk)
│   ├── Home (scroll, Figma `4273:55`: NavBar → Hero Card (headline+weather+search) → Quick Pills → Peta Interaktif (chips + Desa Card) → Carousel Wisata Unggulan → Atraksi & Event → Footer)
│   ├── Detail Desa Wisata
│   ├── Detail Event / Atraksi
│   ├── Paket Wisata (search, carousel↔grid, modal detail)
│   ├── Kuliner (search, carousel↔grid, modal detail + Rumah Makan)
│   ├── Hotel (search, carousel↔grid, modal detail)
│   └── Modal Tambah Ulasan
│
└── MODE ADMIN (pintu rahasia + login)
    ├── Login (tersembunyi)
    ├── Dashboard Grafik Pengunjung
    ├── CRUD: Desa Wisata · Jarak Desa · Atraksi · Paket Wisata · Kuliner · Rumah Makan · Hotel · Kunjungan Turis · Ulasan
    ├── Super Admin (kelola akun admin)
    └── Profil Admin
```

Navigasi utama memakai **bottom navigation floating** 5 tab: Beranda, Destinasi, Event, Paket, Eksplor.

---

## 6. Keputusan Desain (Wajib)

1. **User publik TIDAK perlu login.** Semua fitur browsing terbuka.
2. **Admin TETAP login.** Pintu masuknya **tersembunyi** dari sudut pandang user biasa — bukan link "Login" yang terlihat.
3. **Kandidat pintu rahasia (belum final):**
   - **A:** ketik kode rahasia di kolom pencarian (misal `admin` / `@@`/ kata kunci) → memunculkan form login.
   - **B:** tap berulang / long-press pada elemen tertentu (logo) sekian kali.
   - **C:** kombinasi (tap logo beberapa kali + ketik kode di kolom pencarian).
   - Pengaman **tetap wajib**: username + password + JWT + role check (sama dengan web admin). "Tersembunyi" hanya menyembunyikan pintu UI, **bukan** mengganti keamanan.
4. Satu aplikasi Flutter = mode user (default) + mode admin (setelah login rahasia).
5. Aplikasi dibuka ke **Halaman Sambutan** (§7) tiap kali dibuka; Home hanya bisa dimasuki lewat tombol "Masuk". Halaman Sambutan tidak memuat pintu admin.
6. Backend yang ada dipakai ulang **apa adanya**.

---

## 7. Screen — HALAMAN SAMBUTAN (Pembuka)

Layar **pertama** setiap aplikasi dibuka, **sebelum** Home. Fungsinya jadi halaman pengantar, bukan halaman jelajah: identitas aplikasi + ajakan masuk.

- **Muncul tiap kali aplikasi dibuka** (tidak hanya install pertama).
- Isi: logo + nama **Berani Kamaimo**, tagline (sama dengan hero Home, §8.2), pilihan bahasa **ID / EN**, **Ranking Asal Turis**, dan tombol besar **"Masuk"**.
- **Tombol "Masuk"** satu-satunya jalan ke Home. Tidak ada auto-dismiss, tidak ada geser, tidak ada skip.
- Ranking Asal Turis **dipindah ke sini** dari Home (lihat §8.8) — Home jadi bersih.
- Tanpa NavBar, tanpa menu, **tanpa pintu admin** di layar ini (pintu admin tetap di Home/area admin, lihat §6).
- Bahasa yang dipilih di sini **disimpan** dan dipakai NavBar Home.
- Error saat ambil data ranking tidak boleh menghalangi tombol "Masuk" (tombol selalu aktif).
- Empty: bila belum ada data kunjungan turis, section ranking **disembunyikan** supaya halaman tetap bersih.
- Tracking: pageview halaman ini tetap dicatat sebagai halaman tersendiri (§16).

### 7.1 Ranking Asal Turis — Top 5 Negara (dipindah dari Home)

Menampilkan asal wisatawan asing; ini sorotan utama halaman sambutan.

- Data diinput admin di mode admin (CRUD **Kunjungan Turis**, satu pool nasional).
- Tampilan: **Top 5 negara** terbanyak jumlah turis, diurutkan menurun, dengan nomor peringkat + nama negara + jumlah turis. Podium sederhana (peringkat 1–3 beda warna, peringkat 1 lebih tinggi dari 4–5).
- Header section: mis. "Dari Mana Tamu Kami Datang?" / "Negara Asal Wisatawan".
- Data: GET `/kunjunganTuris` → agregasi `SUM(jumlah)` per negara, ambil 5 teratas.
- State: LoadingCard / ErrorCard (Empty disembunyikan, lihat §7).

---

## 8. Screen — HOME (Mode User)

Home adalah halaman scroll panjang, ditempuh lewat tombol "Masuk" dari Halaman Sambutan (§7). **Struktur & copy diambil persis dari Figma node `4273:55`** (file `MAGANG-PADE`), sudah ter-implementasi di `lib/features/user/home/user_shell.dart` + smoke test `test/beranda_smoke_test.dart`. Aset potongan Figma di `assets/images/beranda/`. Font **Plus Jakarta Sans** (bukan Poppins).

Urutan section:

1. NavBar (pinned)
2. Hero Card — headline + weather + search
3. Quick Activity Pills
4. Peta Interaktif Wisata (chips kabupaten + Desa Card)
5. Carousel Wisata Unggulan Sulteng
6. Atraksi & Event Budaya
7. Footer

> **Tidak ada di Beranda** (memang tidak ada di Figma): Statistik Wisman, Testimoni/Ulasan Pengunjung, Concierge WhatsApp Banner, Ranking Asal Turis (pindah ke §7.1). Ulasan tetap di Detail Desa (§14).

### 8.1 NavBar (Sticky Header)

- Tinggi 64dp, pinned saat scroll, efek blur ketika shrinkOffset > 4.
- Logo kiri: icon landscape dalam rounded-square pine600 + teks 2 baris "BERANI" / "KAMAIMO" (pine900).
- **Language pill** kanan: toggle **ID/EN** — segmen aktif pill gelap `#15442D` teks putih.

### 8.2 Hero Card (Headline + Weather + Search)

- Kartu gradient muda (`#ECFDF5 → #F2F4EE → #FFFFFF`), radius 28, margin 16, shadow lembut.
- Headline 26px w800 pine900, 3 baris: **"Jelajahi Surga Tersembunyi di Jantung Sulawesi"**.
- **Weather widget** putih@90 (96×88, r16) di kanan atas kartu: ikon matahari (kotak `#FEF3C7`), **29°C**, "📍 Palu", "Cerah Berawan".
  - MVP: data statis — `ponytail:` real weather API menyusul.
- Body copy 13px w500: "Temukan pesona bahari kristal, labirin karst megah, dan keagungan peradaban megalitikum tertua di Nusantara."
- **Search bar** pills putih tinggi 46, placeholder *"Cari destinasi atau kabupaten..."* → submit membuka `SemuaDestinasiScreen`.

### 8.3 Quick Activity Pills

Pills horizontal 34dp, aktif `#2E5C43` teks putih, tidak aktif putih ber-border `#E2E8E0`:
**Semua** (aktif) · **Bahari & Karst** · **Megalitikum** · **Danau & Air Terjun**.
(Di M2+, pill memfilter daftar destinasi.)

### 8.4 Peta Interaktif Wisata

- Judul section: "Peta Interaktif Wisata" (18 w800).
- **Chips kabupaten** (25dp, aktif `#2E5C43` putih): Semua (43) · Banggai (14) · Poso (11) · Morowali (9) · Palu & Sigi (9) — angka di belakang = jumlah desa.
- Kartu background `#EAF2EB` r26 tinggi 320:
  - Ilustrasi peta (crop Figma `peta_placeholder.png`, offset top) — `ponytail:` M2 ganti **flutter_map** + CartoDB tiles + marker desa interaktif (klik marker → Detail Desa), legend/zoom control ikut hidup.
  - **Desa Card** overlay bawah (putih@95, r16): badge "**DESA UNGGULAN**" (`#D1FAE5`/emerald600), ★ 4.9, chip jarak "**2.4 km**", nama "**Desa Luk Panenteng**", tombol **"Buka"** (62×28, `#2E5C43`, r12) → Detail Desa.

### 8.5 Carousel Wisata Unggulan Sulteng

- Judul: "Wisata Unggulan Sulteng" + tombol "Semua" → `SemuaDestinasiScreen`.
- **PageView `viewportFraction: 0.75`**, kartu 290×442 (media + badge kiri-atas + chip rating bawah-kiri), radius 24; kartu aktif lebih gelap; **indicator dots** 6×6 (`#2E5C43` aktif / `#E2E8E0`).
- Konten kartu: nama, kabupaten, deskripsi 2 baris, harga ("MULAI DARI" / "PAKET TUR" + Rp), CTA **"Detail →"** (87×28 pill `#2E5C43`, kartu aktif) atau **"Info Detail"** (82×29 `#E7E9E3`).
- 3 kartu seed (nanti dari API `/desaWisata`):

| Kartu | Badge | Kabupaten | Harga | Rating |
|---|---|---|---|---|
| Luk Panenteng & Danau Paisu Pok | KOLAM KACA | BANGGAI KEPULAUAN | Mulai dari Rp 15.000/orang | 4.9 (1.4k ulasan) |
| Kepulauan Sombori | THE SECRET PARADISE (oranye `#D97706`) | MOROWALI | Paket tur Rp 350.000/tur | 4.95 |
| Danau Poso & Pasir Emas | PASIR EMAS TENTENA | POSO • TENTENA | Mulai dari Rp 10.000/orang | 4.88 |

(Foto kartu 1-2 hasil crop Figma; kartu 3 masih `ponytail:` gradient placeholder sampai ada aset/API.)

### 8.6 Atraksi & Event Budaya

- Judul dengan ikon event: "Atraksi & Event Budaya" (+ "Semua" → layar event).
- 2 kartu horizontal r22 (tinggi ~101): **thumbnail 56×64** + chip tanggal baked (`#2E5C43`), isi: badge **"KARISMA EVENT NUSANTARA 2025"** (`#D1FAE5`), nama, "📍 lokasi", deskripsi 1 baris, chip countdown **"H-45 Hari"** (bg `#FFFBEB`, border `#FDE68A`, teks `#92400E`), tombol **"Detail →"** (66×32, `#EDEFE9`).
- 2 kartu seed (dari `/atraksi`):

| Event | Lokasi | Tanggal | Deskripsi |
|---|---|---|---|
| Festival Danau Poso ke-24 | Tentena, Poso | 24 OKT (H-45 Hari) | Parade budaya, tari mogele, & lomba perahu naga. |
| Festival Teluk Tomini (FTT) | Parigi Moutong | 18 NOV (H-45 Hari) | Eksplorasi bawah laut, karnaval kostum bahari & expo UMKM. |

### 8.7 Footer

- Background full-block `#2E5C43`, teks putih.
- Tagline baris 1 logo mini + **"Berani Kamaimo • Gerakan Wisata Berkelanjutan & Ekraf Sulteng"**.
- Kolom link (`#467A5C`): Destinasi · Kuliner Khas · Hotel & Penginapan · Paket Wisata · Hubungi Kami.
- 3 tombol sosial bulat 32dp (Instagram / YouTube / Facebook) + credit putih: **"© 2026 Dinas Pariwisata Sulawesi Tengah. Hak Cipta Dilindungi."**.
- Bottom nav **floating** putih r28 melayang di atas footer; footer tetap terlihat di bawahnya (nav melayang tidak menutupi scroll akhir).

### 8.8 State Handling

- LoadingCard / EmptyCard / ErrorCard untuk section yang ambil API (peta/kartu/carousel/event); seed konten di M1 statis.
- Cuaca "29°C / Cerah Berawan" masih statis — real API menyusul.

### 8.9 SEO/SEMU (adaptasi mobile)

- Web asli: react-helmet-async + JSON-LD (TouristDestination) + sitemap.xml.
- Mobile: tidak ada SEO klasik; **pembagian tinggal di luar scope** (tidak ditulis ulang).

> **Pintu rahasia admin tetap di Beranda** (Keputusan §6 kandidat A — sudah jalan): ketik **`adminBK2025`** di search bar hero (§8.2) → snackbar "Mode admin" (redirect ke admin login di M3).

---

## 9. Screen — DETAIL DESA WISATA

- Hero parallax full-screen: media = video lokal (auto-play muted loop) / gambar / embed YouTube / Drive / fallback.
- Glass-card: **nama desa** (📌 lokasi), deskripsi (scroll max-height).
- Bagian **"How to Get There"**: 2 kolom **Dari Palu** & **Dari Luwuk**, tiap kolom 3 kartu transport: **Lewat Darat 🚗**, **Lewat Laut 🚢**, **Lewat Udara ✈️** (data dari `jarakDesa` per `titikKota`).
- Bagian **Ulasan Pengunjung** (komponen Ulasan, dapat menambah ulasan).
- Halaman "Desa Tidak Ditemukan" + loading skeleton.

---

## 10. Screen — DETAIL EVENT / ATRAKSI

- Hero parallax (sama pola media).
- Glass-card: nama event, lokasi, **countdown** (Hari/Jam/Menit ke `startdate`, update tiap detik), rentang tanggal start–end, deskripsi.
- Halaman "Event Tidak Ditemukan" + skeleton.

---

## 11. Screen — PAKET WISATA

- Background hero + judul.
- **Search bar** filter by nama.
- Toggle **carousel ↔ grid** (chevron tombol besar).
- Card: media (foto/video/YouTube), nama, deskripsi 2-baris, harga format **Rp Indonesia**, ikon WhatsApp.
- **Modal detail**: media + nama + lokasi + deskripsi + harga + tombol **WhatsApp** (`wa.me/<kontak>`).
- Data: `/tourPackage` (nama/deskripsi/lokasi `_id`/`_en`, harga, kontak, media).

---

## 12. Screen — KULINER

- Search bar ("Kaledo, Onyop, dll...").
- Toggle carousel ↔ grid.
- Card: foto makanan (video/YouTube), nama, lokasi, badge "Lihat Rumah Makan".
- **Modal detail**: header media besar, deskripsi, daftar **Rumah Makan** terkait (nama + tombol **Maps** → `link_gmaps`).
- Data: `/kuliner` + `/rumahMakan` (dihubungkan via `kulinerId`).

---

## 13. Screen — HOTEL

- Search bar "Cari nama hotel...".
- Toggle carousel ↔ grid.
- Card: foto, nama hotel, lokasi, harga **"Mulai Dari Rp X - Rp Y / Malam"**.
- **Modal detail**: foto, nama, lokasi, harga, jumlah kamar, jumlah tempat tidur; CTA: **Telepon** (`tel:`), **Google Maps** (`link_gmaps`), **Website** (`linkWebsite`).
- Data: `/hotel`.

---

## 14. Ulasan (Komponen Bersama)

Tampil di DetailDesa (sebelumnya juga di Home, **dihapus dari Home** sejak PRD v1.2).

- Carousel kartu ulasan: avatar inisial berwarna, nama, komentar (max 4 baris), bintang 1–5.
- **Modal Tambah Ulasan**: input nama, textarea komentar, pilih rating bintang; validasi wajib isi; POST `/ulasan/insert` (**tanpa login**); toast sukses.
- Data: GET `/ulasan` (nama, rating, komentar, createdAt) + POST `/ulasan/insert`.

---

## 15. Bahasa (i18n)

- Hampir semua konten punya **2 field** (`_id` = Indonesia, `_en` = Inggris).
- **Fallback ke `_id`** bila `_en` kosong.
- Bahasa **default = Indonesia**; user bisa ganti via dropdown di NavBar.
- Field UI app (labels/nav) perlu localization manual (terjemahan `_id`/`_en` disediakan backend).

---

## 16. Tracking Analytics (Background)

Adaptasi `trackVisitor.js`:

- Simpan `visitorUid` (`crypto.randomUUID` → Flutter: `uuid`) secara persisten.
- POST `/visitor` (uid) saat pertama aplikasi dibuka.
- POST `/pageview` (page, visitorId) di tiap halaman/section.

---

## 17. Mode Admin — LOGIN (tersembunyi)

- Pintu masuk via mekanisme rahasia (lihat Keputusan Desain §6, kandidat A/B/C).
- Card **"Admin Login"**: input username, password (show/hide 👁), tombol Login.
- POST `/user/login` → simpan `token` & data `admin` (sessionStorage di web → Flutter: secure storage/session in-memory).
- Sukses → redirect ke dashboard **Grafik Pengunjung**.
- Gagal → toast error.

---

## 18. Mode Admin — SIDEBAR / NAVIGASI

- Logo "Admin Dashboard".
- Menu: **Super Admin** (khusus role superAdmin), **Grafik Pengunjung**, **Desa Wisata**, **Jalur Desa**, **Atraksi**, **Paket Wisata**, **Kuliner**, **Rumah Makan**, **Hotel**, **Kunjungan Turis**.
- Widget **tanggal-jam** (DateTimeWidget) — live clock.
- Dropdown akun: avatar berwarna by jenis kelamin, inisial, "Lihat Profil", "Logout" (hapus session → kembali ke awal mode user).
- Mobile: hamburger sheet.
- Semua halaman `/admin/*` diproteksi: cek token + role; `roleRequired` khusus super-admin (adaptasi ProtectedRoute).

---

## 19. Mode Admin — GRAFIK PENGUNJUNG

- 6 kartu metrik gradient: **Today / Yesterday / This Week / Last Week / This Month / All Days** (masing-masing jumlah `visits` + `visitors`).
- Dropdown filter **Per Hari / Bulan / Tahun**.
- **Bar chart** dari GET `/pageview/summary` + GET `/pageview/chart`.

---

## 20. Mode Admin — Pola CRUD (9 Entitas)

Semua menu CRUD mengikuti pola sama:

- Tabel kolom: "No", kolom data, kolom "Aksi": **Detail / Edit / Hapus**.
- **Search bar** + **pagination 5 per halaman** + tombol "Tambah Data".
- Modal **Add** & **Edit** (form per entitas) + modal **Detail** + **konfirmasi hapus**.
- Upload file (foto/video) **ATAU** isi `link_video` YouTube — **eksklusif (pilih salah satu)**.
- **Auto-translate Google** (id→en, debounce ~1.5 detik) untuk field `_en` — tanpa dependency khusus (endpoint gtx).
- Hapus foto via endpoint `/foto/:id`.

### 20.1 Field per entitas

| Entitas | Fields |
|---|---|
| **Desa Wisata** | namaDesa_id/en, lokasi_id/en, deskripsi_id/en, latitude, longitude, jenisDesa (DESA_WISATA/DESA_UNGGULAN), foto/video, link_video |
| **Jarak / Jalur Desa** | pilih desa, titikKota (PALU/LUWUK), jalur_darat, jalur_laut, jalur_udara |
| **Atraksi** | nameEvent, lokasi_id/en, deskripsi_id/en, startdate, enddate (input date), foto/video, link_video |
| **Paket Wisata** | nama_wisata_id/en, harga, deskripsi_id/en, lokasi_id/en, kontak (WhatsApp), media, link_video |
| **Kuliner** | nama_makanan, lokasi, deskripsi_id/en, foto/video, link_video |
| **Rumah Makan** | resto, kulinerId (pilih dari Kuliner), link_gmaps, link_video |
| **Hotel** | nama_hotel, telepon (react-phone-input-2), jumlah_kamar, jumlah_tempatTidur, harga_minimum, harga_maximum, website, link_gmaps, lokasi, foto/video, link_video |
| **Kunjungan Turis** | negara (dropdown/search daftar negara), jumlah (angka turis); createdAt auto |
| **Ulasan** | nama, rating, komentar, createdAt |

**Catatan Kunjungan Turis:** entitas kecil tanpa upload & tanpa auto-translate (negara adalah daftar tetap). Tiap baris = satu catatan admin "negara + jumlah". Ranking di Halaman Sambutan = agregasi `SUM(jumlah)` per negara → urut menurun → ambil 5 teratas. Semua admin mengisi ke **satu pool nasional** (tidak ada field daerah).

---

## 21. Mode Admin — SUPER ADMIN

- Khusus role `"superAdmin"`.
- Tabel **"Daftar Admin"**: No, Nama Lengkap, Username, Jenis Kelamin, Role, Aksi.
- Search; pagination.
- Buat admin (modal Add), edit, hapus, detail.
- **superAdmin tidak bisa diedit/dihapus.**

---

## 22. Mode Admin — PROFIL

- Lihat/edit data admin sendiri: nama_Lengkap, jenis_kelamin (Select), username, password (kosongkan = tidak ganti).
- PATCH `/user/:id`.
- Ubah password → **force logout**.

---

## 23. Backend (Reuse Apa Adanya) — Referensi Rute

Backend lama `manda2712/Backend_Dinas_Pariwisata` (Express 5 + Prisma 6 + PostgreSQL, port 3000) dipakai ulang:

| Prefix | Rute |
|---|---|
| `/api/user` | POST `/login`, POST `/insert` (superAdmin), GET `/`, GET `/:id`, PATCH `/:id`, DELETE `/:id` (superAdmin) |
| `/api/atraksi` | POST `/insert` (upload foto), GET `/`, GET `/:id`, PATCH `/:id` (upload), DELETE `/foto/:id`, DELETE `/:id` |
| `/api/tourPackage` | CRUD |
| `/api/desaWisata` | CRUD + upload |
| `/api/jarak` | CRUD (jarakDesa) |
| `/api/kuliner` | CRUD |
| `/api/rumahMakan` | CRUD |
| `/api/hotel` | CRUD |
| `/api/ulasan` | GET `/`, GET `/:id`, POST `/insert` (**publik, no auth**), PUT `/:id`, DELETE `/:id` |
| `/api/visitor` | POST `/` (register), GET `/summary`, GET `/chart` (daily/monthly/yearly) |
| `/api/pageview` | POST `/` (catat page), GET `/summary`, GET `/chart` |
| `/api/kunjunganTuris` **(BARU — perlu ditambah ke backend)** | POST `/insert` (public/admin auth), GET `/`, GET `/:id`, PATCH `/:id`, DELETE `/:id` |
| `/uploads/*` | file statis (foto/video) |

- Login: bcrypt (username+password) → JWT (payload: id, role) + data admin.
- Middleware: `adminAuth.js` (**ada BUG**: `req.header.authorization` + `startWith` — perlu diperbaiki bila dipakai), `superAdminAuth.js` (benar).
- Upload: multer `upload.single('foto')`.
- Seed: super admin default `superadminPariwsata` (password dari env).
- Env: `DATABASE_URL`, `JWT_SECRET`, `SUPERADMIN_PASSWORD`.

> **Satu pengecualian dari "reuse apa adanya":** fitur Kunjungan Turis §7/§20 tidak ada di backend lama → perlu tambah **1 model Prisma `kunjunganTuris`** (+1 tabel) dan **1 controller+rute `/kunjunganTuris`** untuk CRUD-nya. Sisanya tetap dipakai apa adanya.

### Catatan wajib untuk developer

> Baca sumber kebenaran lengkap di BRAIN → `[[Backend]]` dan `[[Database]]` (detail model Prisma & relasi) sebelum aksi yang menyentuh API/DB.

---

## 24. Functional Requirements

### Mode User

- Masuk lewat **Halaman Sambutan** setiap aplikasi dibuka; pindah ke Home hanya lewat tombol "Masuk".
- Ganti bahasa ID/EN di Halaman Sambutan, pilihan tersimpan dan dipakai di seluruh app.
- Lihat ranking **Top 5 negara asal turis** di Halaman Sambutan.
- Browse Home per Figma `4273:55` (navbar, hero headline+weather+search, pills aktivitas, peta interaktif + chips + desa card, carousel wisata unggulan, atraksi & event, footer).
- Buka detail desa wisata & cara akses (Palu/Luwuk, darat/laut/udara).
- Buka detail event beserta countdown.
- Cari & lihat paket wisata, kuliner (dengan rumah makan + gmaps), hotel (telepon/maps/website).
- Toggle carousel ↔ grid.
- Tambah ulasan (tanpa login).
- Konten memakai field `_id`/`_en` dengan fallback ke `_id`.
- Tracking visitor & pageview (background).

### Mode Admin

- Login rahasia (tersembunyi) + JWT.
- Dashboard grafik pengunjung (6 metrik + filter hari/bulan/tahun + bar chart).
- CRUD penuh 9 entitas dengan search, pagination 5, upload media eksklusif dengan link YouTube, auto-translate id→en.
- Super admin: kelola akun admin.
- Profil: edit data sendiri; ganti password → force logout.

---

## 25. MVP / Fase Implementasi

Prioritas build (paling sederhana dulu, naik kerumitan sesuai kebutuhan):

### Fase 1 — Mode User inti (baca data)
- Kerangka Flutter + tema + navigasi bottom/drawer.
- **Halaman Sambutan**: identitas + tombol "Masuk" ke Home + skeleton ranking.
- Home: NavBar + Hero (headline, weather, search) + Quick Pills + Peta Interaktif (chips + Desa Card, ilustrasi) + Carousel Unggulan (3 kartu, viewportFraction 0.75) + 2 kartu Event + Footer — semua per Figma `4273:55`.
- Detail Desa (glass-card + How to Get There + Ulasan).
- Detail Event (countdown).
- i18n `_id`/`_en` + fallback.
- Tracking visitor/pageview.

### Fase 2 — Mode User fitur lengkap
- Paket Wisata (search, toggle, modal + WhatsApp).
- Kuliner + modal Rumah Makan + Google Maps.
- Hotel + modal detail + CTA telepon/maps/website.
- **Ranking Asal Turis (Top 5 negara) jadi hidup di Halaman Sambutan** (agregasi dari `/kunjunganTuris`; stub dulu kalau backend belum ada).
- Ulasan: form tambah (tanpa login) + toast sukses.
- Loading/Empty/Error states di semua section.
- Skeleton + halaman "Tidak Ditemukan".

### Fase 3 — Mode Admin
- Pintu rahasia (putusan final: A / B / C).
- Login + token + proteksi rute + role check.
- Grafik pengunjung (recharts → chart lib Flutter) + 6 kartu metrik.
- Pola CRUD 9 entitas + upload + auto-translate.
- **Backend (tambahan):** model & rute `/kunjunganTuris` (pengecualian reuse, lihat §23).
- Super admin + profiler.
- Fix bug `adminAuth.js` di backend bila diikuti development backend.

---

## 26. Recommended Tech Stack (Flutter)

| Kebutuhan | Pilihan |
|---|---|
| Networking | `http` / `dio` |
| State | `provider` / `riverpod` (pilih minimal) |
| Map | `flutter_map` (tile CartoDB light) |
| Media play (video auto-mute-loop) | `video_player` |
| YouTube embed | `webview_flutter` / plugin yt |
| Charts (dashboard) | `fl_chart` |
| Storage token | `shared_preferences` / `flutter_secure_storage` |
| UUID (visitor) | `uuid` |
| Tel/WhatApp/Maps link | deep link `tel:` / `wa.me` / `https://maps.google.com/?q=` |
| Android/iOS build | default Flutter |

**Prinsip:** jangan tambah dependency yang belum dibutuhkan; mulai dari `http` + `provider` + `flutter_map` + `video_player`.

---

## 27. Project Structure (Flutter, rencana)

```text
lib/
├── main.dart
├── core/
│   ├── theme/            # warna, font, tema app
│   ├── config/           # base URL API, konstanta
│   └── network/          # http client, interceptor, auth
├── models/               # desaWisata, atraksi, tourPackage, kuliner, rumahMakan, hotel, kunjunganTuris, ulasan, user, visitor/pageview
├── data/                 # repository (panggil API)
├── features/
│   ├── user/
│   │   ├── sambutan/      # layar pembuka: identitas, ranking turis, tombol Masuk
│   │   ├── home/
│   │   ├── desa_wisata/
│   │   ├── event/
│   │   ├── paket_wisata/
│   │   ├── kuliner/
│   │   ├── hotel/
│   │   └── ulasan/
│   └── admin/
│       ├── login/
│       ├── dashboard/
│       └── crud/         # pola CRUD 9 entitas + super admin + profil
├── widgets/              # carousel, glass_card, countdown, search field, card media, dll.
└── localization/         # id/en
```

---

## 28. Data Model (Ringkasan)

- **DesaWisata**: id, namaDesa_id/en, lokasi_id/en, deskripsi_id/en, latitude, longitude, jenisDesa, foto, link_video.
- **JarakDesa**: id, desaId, titikKota, jalur_darat, jalur_laut, jalur_udara.
- **Atraksi**: id, nameEvent, location_id/en, description_id/en, startdate, enddate, foto, link_video.
- **TourPackage**: id, nama_wisata_id/en, harga, deskripsi_id/en, lokasi_id/en, kontak, media, link_video.
- **Kuliner**: id, nama_makanan, foto, deskripsi_id/en, lokasi, link_video.
- **RumahMakan**: id, resto, kulinerId, link_gmaps, link_video.
- **Hotel**: id, nama_hotel, foto, telepon, jumlah_kamar, jumlah_tempatTidur, harga_minimum, harga_maximum, website, link_gmaps, lokasi, link_video.
- **KunjunganTuris** _(baru, oleh admin, satu pool nasional)_: id, negara, jumlah (int), createdAt.
- **Ulasan**: id, nama, rating, komentar, createdAt.
- **User (admin)**: id, nama_Lengkap, username, password (bcrypt), jenis_kelamin, role.
- **Visitor/Pageview**: uid/session, halaman, timestamp.

> Skema Prisma & relasi lengkap: baca BRAIN → `[[Database]]`.

---

## 29. UX Rules

- Visual mengikuti karakter web **Dinas Pariwisata Sulteng** (biru-putih, cerah, kartu rounded, hero gambar besar), bukan mengganti identitas.
- Semua state pakai Loading/Empty/Error — jangan layar blank.
- Form admin sama pola di semua entitas (konsisten `flow` add/edit/detail/hapus).
- Pintu admin **tidak boleh terlihat** di alur user biasa — termasuk tidak di Halaman Sambutan.
- Halaman Sambutan harus terasa seperti pengantar, bukan dinding konten: tombol "Masuk" selalu terlihat tanpa perlu scroll dan tetap aktif walau data ranking gagal dimuat.
- Harga selalu format **Rp Indonesia** (e.g. Rp 1.500.000).

---

## 30. Success Criteria

Mode User dianggap berhasil apabila user dapat:

1. Membuka aplikasi dan melihat **Halaman Sambutan** (identitas, ranking turis, tombol "Masuk") sebelum Home.
2. Tekan "Masuk" lalu sampai ke Home (hero + weather + search, pills, peta interaktif, carousel unggulan, event, footer).
3. Melihat peta desa wisata dan membuka detail desa dari marker.
4. Melihat detail cara akses (Palu/Luwuk, 3 moda transportasi).
5. Melihat detail event + countdown.
6. Mencari dan membuka paket wisata, kuliner (+rumah makan +maps), hotel (+telepon/maps/website).
7. Menambah ulasan dari layar publik.
8. Mengganti bahasa ID/EN dengan fallback yang benar (dipilih di Halaman Sambutan, tersimpan untuk app).
9. Melihat **Top 5 negara asal turis** di Halaman Sambutan (urut jumlah menurun).

Mode Admin dianggap berhasil apabila admin dapat:

10. Masuk lewat pintu rahasia (tanpa admin-visible login di alur user, dan tidak ada di Halaman Sambutan).
11. Melihat grafik pengunjung (6 metrik + chart).
12. CRUD semua 9 entitas (dengan search, pagination, upload/link, auto-translate) — termasuk **Kunjungan Turis** (pilih negara + jumlah).
13. SuperAdmin mengelola akun admin; admin mengedit profil sendiri.
14. Logout kembali ke mode user.

---

## 31. Referensi Sumber Kebenaran

- Breakdown detail lengkap: **BRAIN → `berani_kamaimo/proyek.md`** (web user A, API B, admin C, stack D).
- Backend API (rute, auth, middleware, env): **BRAIN → `[[Backend]]`**.
- Skema database Prisma/Postgres: **BRAIN → `[[Database]]`**.
- Analisa clone asli: `/tmp/opencode/repo_main|repo_admin|repo_backend`.
- Produksi web user: `https://beranikamaimo.sultengprov.go.id/`.