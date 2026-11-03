# Struktur Folder `lib/`

Berani Kamaimo mengikuti clean architecture dengan feature-driven structure.

## Hierarchy

```
lib/
├── main.dart                  # Entry point
├── core/
│   ├── config/               # Env, konstanta
│   ├── network/              # ApiClient, ApiException, TokenStore
│   ├── theme/                # AppColors, AppTypography, AppTheme, AppSpacing
│   └── utils/                # Helper, formatter, extensions
├── models/                   # Domain models: DesaWisata, Atraksi, User, dll
├── data/
│   └── repositories/         # Repository per domain (ApiClient → model)
├── features/
│   ├── user/
│   │   ├── sambutan/         # Screen pembuka: identitas + ranking turis + tombol masuk
│   │   ├── home/             # Screen utama: hero, peta, carousel, ulasan
│   │   ├── desa_wisata/      # Detail desa + how to get there
│   │   ├── event/            # Detail event + countdown
│   │   ├── paket_wisata/     # List + search + modal detail
│   │   ├── kuliner/          # List + modal rumah makan
│   │   ├── hotel/            # List + modal detail + CTA
│   │   └── ulasan/           # Komponen modal tambah ulasan
│   └── admin/
│       ├── login/            # Form login admin (tersembunyi)
│       ├── dashboard/        # Grafik pengunjung
│       └── crud/             # Pola CRUD 9 entitas
├── widgets/                  # Reusable: LoadingCard, GlassCard, Carousel, dll
├── localization/             # Translations id/en
└── utils/                    # Global helpers: formatRupiah, deepLink, dll
```

## Konvensi

- **Features**: satu folder = satu screen/fitur. Setiap feature folder = screen + controller (ChangeNotifier) + widget lokal.
- **Models**: immutable, `fromJson` + `toJson`, field `_id`/`_en` di-handle via `LocalizedText` helper.
- **Repository**: satu file per domain, method `getAll()`, `getById()`, `insert()`, dll. Semua lewat `ApiClient`.
- **State**: `ChangeNotifier` + `Consumer` (provider); setiap screen wajib punya Loading/Empty/Error state.
- **Network**: `http` package + custom `ApiClient` wrapper + `ApiException` untuk error.
- **Storage**: token admin → `flutter_secure_storage`; locale, visitor UID → `shared_preferences`.

## Naming

- File: `snake_case.dart`
- Class: `PascalCase`
- Widget: `PascalCase`, diakhiri dengan `Widget` atau `Screen`
- Method: `camelCase`
- Private field: `_privateName`

## Dependency Flow

```
main.dart
  → App (theme + locale)
    → features/user/sambutan (entry point)
      → HomeScreen (core services)
        → repositories (data layer)
          → ApiClient (network layer)
```

Admin flow terpisah, tertutup di `features/admin/`, diakses lewat pintu rahasia.
