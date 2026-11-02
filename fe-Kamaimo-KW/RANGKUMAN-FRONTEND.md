# Rangkuman Progress Frontend — Berani Kamaimo

_Tanggal: 2026-10-24_

Rangkuman untuk teman satu tim: apa yang sudah dikerjakan di sisi frontend (aplikasi Flutter) dan apa yang belum. Sumber: STATUS.md + verifikasi langsung ke kode di `lib/`.

## Gambaran besar

Satu aplikasi Flutter: mode user (publik, tanpa login) dengan 4 tab (Beranda, Destinasi, Event, Paket, Eksplor) + mode admin (pintu rahasia, M3). Backend memakai ulang API Express yang sudah ada.

## Struktur kode frontend (lib/)

| Folder | Isi | Status |
|---|---|---|
| `core/theme/` | Tema, warna, tipografi, spacing | Selesai |
| `core/network/` | API client, config, error, token store | Selesai |
| `core/config/` | Env (base URL API) | Selesai |
| `data/repositories/` | 10 repository (desa wisata, atraksi, paket, kuliner, rumah makan, hotel, jarak, ulasan, visitor, kunjungan turis) | Selesai |
| `models/` | 13 model termasuk `LocalizedText` untuk i18n (field `_id`/`_en`, fallback `_id`) | Selesai |
| `features/user/sambutan/` | Halaman Sambutan (layar pembuka sebelum Home) | Selesai |
| `features/user/home/` | Beranda lengkap + shell/user nav | Selesai |
| `features/user/destinasi/` | Tab Destinasi | Selesai |

Font Plus Jakarta Sans sudah terpasang (5 weight, terdaftar di pubspec).

## Yang SUDAH dikerjakan

1. **M0 — Skeleton + kontrak data** (~85%): struktur folder, tema (warna, tipografi, spacing), API client, 10 repository, 13 model.
2. **Halaman Sambutan** — layar pembuka sebelum Home, termasuk konten Ranking Asal Turis (pindahan dari PRD lama).
3. **Beranda (Figma 4273:55)** — sudah dicocokkan ulang ke desain Figma:
   - NavBar melayang bergaya kaca (glassmorphic), sticky dipakai bersama halaman Destinasi
   - Hero, QuickFilters, Carousel Wisata Unggulan, Section Peta (masih gambar placeholder), Section Event, Footer
   - "Lihat Semua" navigasi ke Semua Destinasi
4. **Tab Destinasi (Figma 4258:1619)** — selesai.
5. **Bottom nav melayang** dengan 4 tab: Destinasi, Event, Paket, Eksplor.
6. **Font** Plus Jakarta Sans sudah diunduh dan aktif (dulu pending, sekarang beres).

## Yang BELUM / masih terbuka

1. **3 tab masih placeholder** (ditulis literal di `user_shell.dart`):
   - Tab Event — kandidat desain: `AREA EVENT 5055:1830` atau set `4995:*` (perlu pilih frame final dari Figma)
   - Tab Paket Wisata — desain Figma `4965:1243` sudah di-render & diukur, tinggal dibangun
   - Tab Eksplor — `AREA EXPLORE 5055:1831` + Explorer per kota
2. **Detail Wisata (Luk Panenteng)** masih pakai screen lama; perlu rebuild ke desain `4714:452` + modal Tulis Ulasan `4896:2146` + Bagikan `4890:1847`.
3. **Data masih dummy/aset placeholder** — semua card (carousel, event, destinasi) diisi aset lokal, belum conn ke API. Repository & model sudah siap, tinggal dipasang.
4. **`flutter run` belum diverifikasi** — visual aset (thumb + featured) harus dicek di device/emulator untuk crop yang pas.
5. **M0 sisa ~15%** (cek file STATUS.md untuk detail sisa itemnya).
6. **M2 — Mode user lengkap**: belum mulai (Paket, Kuliner, Hotel, Ulasan, Ranking Turis via API).
7. **M3 — Mode admin**: belum mulai (login rahasia via kode di kolom pencarian, dashboard, CRUD 9 entitas).

## Posisi dalam milestone

| Fase | Status |
|---|---|
| M0 — Skeleton + kontrak | In progress, ~85% |
| M1 — Mode user inti | In progress: Beranda selesai, Destinasi selesai, 3 tab + Detail Wisata belum |
| M2 — Mode user lengkap | Belum mulai |
| M3 — Mode admin | Belum mulai |

## Referensi

- STATUS.md di root proyek — sumber kebenaran terkini (dipakai juga lintas AI)
- Desain Figma: MAGANG-PADE (node-id mulai 4273-55)
- Dokumen lengkap: PRD.md, ~/Dokumen/Obsidian/BRAIN/01_Projects/berani_kamaimo/
