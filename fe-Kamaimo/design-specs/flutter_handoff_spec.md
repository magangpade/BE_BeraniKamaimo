# Desain 1: Beranda (Berani Kamaimo)
Node ID: `2:8522`
Ukuran: 412x2999 (Mobile)

## 🎨 Design Tokens (Colors)
* Primary/Brand: `#1A3A2A` (Pine)
* Secondary/Accent: `#10B981` (Emerald), `#3B6E53`
* Background: `#F6F8F5`
* Card/Surface: `#FFFFFF`
* Text Primary: `#1C241F`, `#1A3A2A`
* Text Secondary: `#616E66`, `#405A32`
* Border/Divider: `#E5EAE2`

## 🖋 Typography (Poppins & Playfair Display)
* **Headline (Hero)**: Playfair Display Italic, 33px / Poppins Bold 29px
* **Card Titles**: Poppins Bold 20px / 19px / 16px
* **Buttons**: Poppins SemiBold 12px
* **Pills/Tags**: Poppins SemiBold 11px (UPPERCASE) / Medium 12px
* **Body/Paragraph**: Poppins Regular 12px / 11.5px

## 📐 Layout & Shadows
* **Global Padding**: `20px` horizontal margins.
* **Shadows (Soft Elevation)**: 
  * `0px 2px 10px 0px rgba(26, 58, 42, 0.04)` (Cards)
  * `0px 16px 36px -6px rgba(26, 58, 42, 0.12)` (Bottom Nav/Floating)
* **Corner Radius (Border Radius)**:
  * Pills/Buttons: `9999px` (Full pill)
  * Large Cards: `26px` - `32px`
  * Image Thumbnails: `16px`
* **Card Image Overlays**: Linear Gradients `rgba(18, 40, 29, 0.8)` to transparent for text legibility.

## 📱 Struktur Section / Frame
1. **Header Sticky**: Logo + Teks "Berani Kamaimo" + Icon Notif + Avatar.
2. **Main Feed**: 
   - Greeting "Halo, Penjelajah" + Cuaca.
   - Headline "Mau jelajah ke mana hari ini?".
   - Category Pills Horizontal Scroll (Semua, Bahari, Megalitikum, dll).
   - Search Bar "Cari Danau Paisu Pok..." + Filter icon.
3. **Hero Card**: Danau Paisu Pok (Large 470px height) + Ticket Info.
4. **Horizontal Scroll (Destinasi Ikonik)**: Kep. Sombori, Danau Poso, Lembah Bada.
5. **Event Promo Card**: Festival Danau Poso 2025.
6. **Quick Access Menu**: Peta Desa Wisata.
7. **Statistik Wisman**: Top 3 Turis (Jerman, Prancis, Australia).
8. **Testimoni**: Lukas Weber.
9. **Footer Banner**: Halo Sulteng Concierge (WA) & Endorsement Dinas Pariwisata.
10. **Bottom Nav Bar (Floating)**: Beranda, Destinasi, Event, Paket, Kuliner (Glassmorphism / Blur backdrop).

## 🚀 Instruksi Handoff ke Flutter (OpenCode)
1. Gunakan `Scaffold` dengan `backgroundColor: Color(0xFFF6F8F5)`.
2. Gunakan `SliverAppBar` untuk Header agar interaktif, atau top static padding.
3. Struktur scrolling dengan `ListView` atau `CustomScrollView`.
4. Untuk UI Cards, gunakan `Container` dengan `BoxDecoration` (color, borderRadius, boxShadow).
5. Load custom fonts (Poppins, Playfair Display) di `pubspec.yaml`.
