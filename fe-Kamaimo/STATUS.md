# STATUS — Berani Kamaimo

> Alat sinkronisasi antar-agent. Update tiap kali selesai/blocked/ganti fase.

## Info Proyek

| Item | Nilai |
|---|---|
| Nama | Berani Kamaimo |
| Root | `~/Dokumen/APL/berani_kamaimo` |
| Backend | Reuse `Backend_Dinas_Pariwisata` (Express + Prisma/PostgreSQL, port 3000) |
| Target | 1 aplikasi Flutter: mode user (publik) + mode admin (pintu rahasia) |

## Fase

| Fase | Status | Owner | Catatan |
|---|---|---|---|
| M0 — Skeleton + kontrak | 🟡 In progress | AI Claude | Setup struktur, tema, model, repository — 85% selesai |
| M1 — Mode user inti | 🟡 In progress | AI Claude | Beranda ✅ + Destinasi (4258) ✅ + Event (3641-2) ✅ + Paket (4965:1243) ✅ — Eksplor masih placeholder; Detail Wisata pakai screen lama; flutter run belum diverifikasi |
| M2 — Mode user lengkap | 🔲 Not started | — | Paket, Kuliner, Hotel, Ulasan, Ranking Turis |
| M3 — Mode admin | 🔲 Not started | — | Login rahasia, dashboard, CRUD 9 entitas, super admin |

Legenda: 🔲 Not started · 🟡 In progress · ✅ Done · 🔴 Blocked

## Next Task

- M1-2.z — **Tab Eksplor** (`AREA EXPLORE 5055:1831` + Explorer per kota) — perlu pilih frame final + PNG export dari user (Figma MCP masih OAuth pending)
- M1-3 — Rebuild **Detail Wisata - Luk Panenteng** (`4714:452`) + Tulis Ulasan (`4896:2146`) + Bagikan (`4890:1847`)
- `flutter run` untuk verifikasi visual aset crop (thumb + featured destinasi & beranda, + kartu paket di device)
- Frame duplikat di Figma perlu dikonfirmasi satu-satu saat mulai tiap tab (user yang memilih node)

## Blocker

- None

## Catatan Sesi 2026-10-28

- Tab **Paket** dibangun dari PNG export user (konvensi feature-folder: `paket_screen` tipis + `paket_data` seed 4 paket + widgets/). Search + filter kategori (Semua/Bahari/Budaya/Trekking) + carousel PageView + kartu fasilitas 2×2 + CTA WhatsApp (placeholder snackbar) + kartu trust. Test: `test/paket_smoke_test.dart` 2/2.
- **Fix file rusak teman tim**: `detail_event_screen.dart` ter-commit dengan syntax error (duplikasi `_jadwal`/`_month`, 3 kurang bracket, `const` ilegal) — semua test gagal loading. Sudah diperbaiki + bersihkan getter tak terpakai; 12/12 test lulus ulang.

## Keputusan Aktif

1. Urutan build resmi: **M0 → M1 → M2 → M3**.
2. **Sleek design system di-skip dulu** (key belum tersedia).
3. Backend reuse apa adanya, kecuali model+rute `kunjunganTuris` (fitur Ranking Asal Turis).
4. Pintu admin pakai **kandidat A**: ketik kode rahasia di kolom pencarian Home.
6. App dibuka ke **Halaman Sambutan** tiap kali dibuka; Home hanya lewat tombol "Masuk" (PRD v1.1, [[Halaman Sambutan]]).
5. State management pakai `provider`.

## Link Penting

- BRAIN overview: `~/Dokumen/Obsidian/BRAIN/berani_kamaimo/proyek.md`
- PRD: `~/Dokumen/APL/berani_kamaimo/PRD.md`
- Perencanaan ini: `~/Dokumen/Obsidian/BRAIN/berani_kamaimo/log/Perencanaan Lengkap Build M0-M3.md`
- Backend API: `~/Dokumen/Obsidian/BRAIN/berani_kamaimo/Backend.md`
- Database: `~/Dokumen/Obsidian/BRAIN/berani_kamaimo/Database.md`
