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
| M1 — Mode user inti | 🟡 In progress | AI Claude | Beranda (Figma 4273:55) ✅ + Tab Destinasi (Figma 4258:1619) ✅ — Event/Paket/Eksplor masih placeholder; Detail Wisata pakai screen lama; flutter run belum diverifikasi |
| M2 — Mode user lengkap | 🔲 Not started | — | Paket, Kuliner, Hotel, Ulasan, Ranking Turis |
| M3 — Mode admin | 🔲 Not started | — | Login rahasia, dashboard, CRUD 9 entitas, super admin |

Legenda: 🔲 Not started · 🟡 In progress · ✅ Done · 🔴 Blocked

## Next Task

- M1-2.x — **Tab Paket Wisata** (`4965:1243` "Paket Wisata Sulteng (Modern)") — design sudah di-render & diukur
- M1-2.y — **Tab Event** (`AREA EVENT 5055:1830` atau set `4995:*`) — perlu pilih frame final
- M1-2.z — **Tab Eksplor** (`AREA EXPLORE 5055:1831` + Explorer per kota)
- M1-3 — Rebuild **Detail Wisata - Luk Panenteng** (`4714:452`) + Tulis Ulasan (`4896:2146`) + Bagikan (`4890:1847`)
- `flutter run` untuk verifikasi visual aset crop (thumb + featured destinasi & beranda)
- Frame duplikat di Figma perlu dikonfirmasi satu-satu saat mulai tiap tab (user yang memilih node)

## Blocker

- None

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
