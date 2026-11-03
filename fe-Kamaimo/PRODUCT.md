# Product

<!-- impeccable:product-schema 1 -->

## Platform

android

## Stack

Flutter (Dart), provider state management, flutter_map (peta), http (networking)

## Users

**Primary:** Wisatawan domestik & internasional yang mencari informasi destinasi wisata Sulawesi Tengah — mencari desa wisata, event, paket wisata, kuliner, hotel. Mereka membuka app tanpa login, ingin browse cepat, lihat peta, dan dapatkan info akses.

**Secondary:** Admin Dinas Pariwisata Sulteng yang mengelola konten melalui pintu rahasia (mode admin tersembunyi).

## Product Purpose

Aplikasi mobile promosi pariwisata Sulawesi Tengah — konversi dari 3 repo web (user + admin + backend) menjadi satu aplikasi Flutter. User publik bisa menjelajah semua destinasi tanpa login; admin mengelola konten via pintu tersembunyi.

## Positioning

Satu-satunya aplikasi resmi Dinas Pariwisata Provinsi Sulawesi Tengah untuk menjelajahi destinasi: desa wisata, bahari/karst, megalitikum, danau/air terjun — dengan data langsung dari backend Pariwisata Sulteng yang sudah live.

## Operating Context

- Aplikasi dibuka → Halaman Sambutan (identitas + ranking turis + tombol Masuk) → Home (scroll sections)
- Home per Figma `4273:55`: NavBar (logo + toggle ID/EN) → Hero Card (headline "Jelajahi Surga Tersembunyi di Jantung Sulawesi" + weather 29°C Palu + search) → Quick Pills → Peta Interaktif (chips kabupaten + Desa Card Luk Panenteng) → Carousel Wisata Unggulan (3 kartu, viewportFraction 0.75) → Atraksi & Event Budaya (2 kartu) → Footer hijau `#2E5C43`
- Mode user: browsing tanpa login, 2 bahasa (ID/EN), tracking visitor background
- Mode admin: pintu rahasia di search bar (kode `adminBK2025`) → login → dashboard + CRUD 9 entitas
- Backend existing di port 3000, reuse apa adanya

## Capabilities and Constraints

- **Platform:** Android (target utama), iOS possible later
- **Font:** Plus Jakarta Sans (5 weights: Regular/Medium/SemiBold/Bold/ExtraBold) — sudah di `fonts/`
- **Color palette:** Pine aesthetic (#1D3A30 pine900, #15442D pine800 nav/toggle, #2E5C43 pine700 primary, #F8FAF4 background, #EAF2EB peta card)
- **Font resmi:** Plus Jakarta Sans — ⚠️ bukan Poppins/Playfair (spec lama `design-specs/flutter_handoff_spec.md` node `2:8522` STALE, jangan dipakai)
- **Navigation:** Floating glassmorphic bottom nav (5 tab: Beranda/Destinasi/Event/Paket/Eksplor)
- **State management:** provider ^6.1.5+1
- **Figma design:** MAGANG-PADE file (fileKey: 37V5bMPHiUkn7YR1Q0cS8j) — Beranda node-id: 4273:55
- **i18n:** ID (default) + EN, field `_id`/`_en` di backend, fallback ke `_id`
- **Admin secret:** `adminBK2025` ketik di search bar (M3 redirect ke admin login)

## Brand Commitments

- **Nama:** Berani Kamaimo
- **Tagline:** "Berani Kamaimo • Gerakan Wisata Berkelanjutan & Ekraf Sulteng" (footer); hero copy: "Jelajahi Surga Tersembunyi di Jantung Sulawesi"
- **Identity:** Pine/nature aesthetic (hijau tua, emerald, putih bersih) — bukan biru provinsi lama
- **Logo:** Icon landscape dalam rounded square pine600 + text "BERANI KAMAIMO" stacked
- **Footer credit:** "Dinas Pariwisata Provinsi Sulawesi Tengah"
- **Voice:** Friendly, inviting, professional — tidak kaku

## Evidence on Hand

- Figma design (sumber kebenaran): https://www.figma.com/design/37V5bMPHiUkn7YR1Q0cS8j/MAGANG-PADE?node-id=4273-55
- Web produksi: https://beranikamaimo.sultengprov.go.id/
- PRD lengkap: `PRD.md`
- Implementasi beranda: `lib/features/user/home/user_shell.dart` + smoke test `test/beranda_smoke_test.dart`
- Aset crop Figma: `assets/images/beranda/` (kartu unggulan, peta, thumb event, thumb desa)
- ⚠️ `assets/images/desain_1_beranda.png` & `design-specs/flutter_handoff_spec.md` = desain lama yang TIDAK akurat — jangan dipakai acuan

## Product Principles

1. **Pine aesthetic consistency** — seluruh UI mengikuti palet hijau alami, bukan biru corporate
2. **Content-first** — destinasi dan budaya Sulteng yang jadi bintang, bukan dekorasi
3. **Zero-friction browsing** — user publik tanpa login, tap sedikit mungkin untuk lihat info
4. **Graceful degradation** — loading/empty/error state di setiap section, ranking kosong disembunyikan
5. **Single app, dual mode** — user + admin hidup dalam satu binary, admin tersembunyi

## Accessibility & Contrast

- WCAG AA minimum untuk teks di atas background
- Touch target minimum 44px
- Font size base 12px, tidak kurang dari 10px untuk label
