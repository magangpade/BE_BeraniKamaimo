/// Rundown contoh untuk kartu Event. Sesuaikan dengan jadwal resmi sebelum publikasi.
class EventRundownData {
  EventRundownData._();

  static List<Map<String, dynamic>> _parse(String text) {
    final days = <Map<String, dynamic>>[];
    List<Map<String, dynamic>>? items;
    for (final rawLine in text.trim().split('\n')) {
      final line = rawLine.trim();
      if (line.isEmpty) continue;
      if (line.startsWith('@')) {
        items = <Map<String, dynamic>>[];
        days.add({'hari': line.substring(1), 'items': items});
        continue;
      }
      final parts = line.split('|');
      if (items == null || parts.length != 4) {
        throw FormatException('Rundown tidak valid: $line');
      }
      final index = items.length;
      final color = index == 0
          ? 'mint'
          : index == 1
          ? 'slate'
          : 'earth';
      items.add({
        'jam': '${parts[0]} WITA',
        'chip': parts[1],
        'chipColor': color,
        'dotColor': color == 'earth' ? 'earth' : 'mint',
        'judul': parts[2],
        'deskripsi': parts[3],
      });
    }
    return days;
  }

  static final pasarKreatif = _parse('''
@Hari 1 (31 Okt)
09.00 – 11.30|Area Pasar Kreatif|Pembukaan & Jelajah Stan|Pengunjung mulai menjelajahi produk kriya, fesyen, dan kuliner lokal.
13.00 – 15.30|Area Workshop|Demo Kriya Lokal|Perajin memperlihatkan proses pembuatan produk dan berbagi cerita tentang karyanya.
16.00 – 18.00|Panggung Utama|Musik Senja|Penampilan musik lokal menutup kegiatan hari pertama.
@Hari 2 (1 Nov)
08.30 – 10.30|Area Kuliner|Cerita Rasa Sulteng|Jelajah sajian khas dan perkenalan singkat dengan pelaku usaha kuliner.
12.30 – 15.00|Panggung Utama|Showcase Produk Kreatif|Pelaku UMKM memperkenalkan produk pilihan dan inspirasi di balik usahanya.
16.30 – 18.30|Panggung Utama|Apresiasi UMKM & Penutupan|Rangkuman kegiatan, apresiasi peserta, dan pertunjukan penutup.
''');

  static final telukTomini = _parse('''
@Hari 1 (18 Nov)
08.00 – 09.30|Gerbang Festival|Registrasi & Penyambutan|Pengunjung menerima informasi lokasi kegiatan dan agenda festival.
10.00 – 12.00|Panggung Pesisir|Pembukaan Festival|Sambutan pembuka dan pertunjukan budaya masyarakat pesisir.
15.30 – 18.00|Area Pantai|Parade Bahari|Peragaan bertema laut dan aktivitas komunitas di tepi pantai.
@Hari 2 (19 Nov)
07.30 – 10.00|Titik Kumpul Pantai|Jelajah Pesisir|Kegiatan berpemandu untuk mengenal lingkungan dan kehidupan pesisir.
11.00 – 13.00|Area Komunitas|Cerita Laut Tomini|Sesi berbagi tentang tradisi bahari dan upaya menjaga laut.
16.00 – 18.30|Panggung Pesisir|Seni & Musik Bahari|Pertunjukan seni yang terinspirasi dari budaya pesisir.
@Hari 3 (20 Nov)
08.30 – 10.30|Area Pantai|Aksi Bersih Pesisir|Pengunjung dan komunitas bersama-sama membersihkan area kegiatan.
13.00 – 15.00|Area Kuliner|Jelajah Rasa Pesisir|Menikmati pilihan kuliner lokal dan mengenal pelaku usahanya.
17.00 – 19.00|Panggung Utama|Malam Apresiasi & Penutupan|Penampilan terakhir dan penutupan rangkaian festival.
''');

  static final megalitikumLore = _parse('''
@Hari 1 (28 Nov)
07.00 – 08.00|Titik Kumpul|Registrasi & Arahan Perjalanan|Pengenalan rute, aturan kunjungan, dan persiapan peserta.
08.30 – 11.30|Kawasan Megalitikum|Jelajah Situs|Mengunjungi peninggalan megalitikum bersama pemandu lokal.
14.00 – 16.00|Area Komunitas|Cerita Sejarah Lore|Sesi berbagi tentang warisan budaya dan kehidupan masyarakat setempat.
@Hari 2 (29 Nov)
06.30 – 08.30|Jalur Lanskap|Jalan Pagi di Lembah Bada|Menikmati pemandangan lembah sambil mengenal bentang alamnya.
09.30 – 12.00|Kawasan Megalitikum|Jelajah Situs Lanjutan|Kunjungan ke titik situs berikutnya dengan waktu untuk bertanya dan mendokumentasikan perjalanan.
13.30 – 15.00|Titik Kumpul|Refleksi & Penutupan|Peserta berbagi pengalaman sebelum perjalanan berakhir.
''');

  static final kulinerKaili = _parse('''
@Hari 1 (12 Des)
10.00 – 12.00|Area Kuliner|Pembukaan Pasar Rasa|Stan makanan mulai melayani pengunjung.
14.00 – 15.30|Area Demo|Dapur Kaili|Demonstrasi pengolahan hidangan khas bersama pelaku kuliner.
18.00 – 20.30|Panggung Kuliner|Malam Rasa Kaili|Jelajah makanan ditemani penampilan musik ringan.
@Hari 2 (13 Des)
09.30 – 11.30|Area Kuliner|Sarapan Khas Daerah|Pengunjung mencoba pilihan menu pagi dan mengenal kisah di baliknya.
13.00 – 15.00|Area Komunitas|Cerita Resep Keluarga|Sesi berbagi mengenai resep, bahan, dan tradisi makan masyarakat Kaili.
17.00 – 19.00|Panggung Kuliner|Apresiasi Tenant & Penutupan|Perkenalan pelaku kuliner dan penutupan pekan kuliner.
''');

  static final pantaiPasirPanjang = _parse('''
@Hari 1 (6 Okt)
08.00 – 09.30|Area Pantai|Penyambutan Pengunjung|Registrasi dan pengenalan area kegiatan.
10.00 – 12.00|Tepi Pantai|Permainan Pesisir|Aktivitas rekreasi ringan untuk pengunjung.
16.00 – 18.00|Panggung Pantai|Pertunjukan Senja|Penampilan seni lokal saat sore hari.
@Hari 2 (7 Okt)
07.30 – 09.00|Titik Kumpul|Aksi Bersih Pantai|Kegiatan bersama untuk menjaga kebersihan kawasan.
11.00 – 13.00|Area Bahari|Lomba Kreatif Pantai|Permainan dan tantangan kelompok bertema pesisir.
15.30 – 18.30|Area Kuliner|Kuliner Tepi Laut|Jelajah sajian lokal sambil menikmati suasana pantai.
@Hari 3 (8 Okt)
08.30 – 10.30|Tepi Pantai|Jelajah Alam Pesisir|Kegiatan berpemandu untuk mengenal lingkungan pantai.
13.30 – 15.30|Panggung Pantai|Pentas Komunitas|Penampilan kelompok seni dan komunitas setempat.
16.30 – 18.00|Panggung Pantai|Apresiasi & Penutupan|Pengumuman kegiatan, ucapan terima kasih, dan penutupan festival.
''');

  static final umkmPalu = _parse('''
@Hari 1 (4 Apr)
09.00 – 11.00|Area Bazar|Pembukaan Gelar UMKM|Stan produk, kriya, dan kuliner mulai dibuka.
13.00 – 15.00|Area Showcase|Kenalan dengan Produk Lokal|Pelaku usaha memperkenalkan produk unggulan mereka.
16.00 – 18.00|Panggung Komunitas|Hiburan Sore|Penampilan komunitas kreatif menemani pengunjung berbelanja.
@Hari 2 (5 Apr)
10.00 – 12.00|Area Workshop|Kemasan yang Bercerita|Sesi berbagi ide kemasan dan tampilan produk bersama pelaku UMKM.
14.00 – 16.00|Area Kuliner|Cicip Produk Lokal|Pengunjung mengenal ragam makanan dan minuman dari tenant.
18.30 – 20.00|Panggung Komunitas|Temu Pelaku Usaha|Percakapan santai tentang pengalaman membangun usaha lokal.
@Hari 3 (6 Apr)
09.30 – 11.30|Area Bazar|Belanja Produk Pilihan|Kesempatan terakhir menjelajahi dan membeli produk tenant.
13.30 – 15.00|Area Showcase|Cerita Usaha Inspiratif|Pelaku UMKM berbagi pengalaman dan rencana pengembangan produknya.
16.00 – 17.30|Panggung Utama|Apresiasi Tenant & Penutupan|Rangkuman acara dan penutupan gelar UMKM.
''');

  static final pulauTogean = _parse('''
@Hari 1 (28 Agu)
07.00 – 08.00|Titik Kumpul|Registrasi & Pemeriksaan Perlengkapan|Pengecekan peserta serta pengarahan keselamatan perjalanan.
08.30 – 12.00|Jalur Laut|Perjalanan Menuju Pulau|Perjalanan laut menuju lokasi kegiatan.
15.00 – 17.00|Area Penginapan|Orientasi Pulau|Pengenalan fasilitas, aturan kunjungan, dan agenda berikutnya.
@Hari 2 (29 Agu)
07.30 – 09.00|Tepi Pantai|Persiapan Snorkeling|Pengarahan keselamatan dan pembagian kelompok.
09.00 – 12.00|Perairan Togean|Jelajah Bawah Laut|Snorkeling berpemandu di titik yang ditentukan penyelenggara.
16.00 – 18.00|Pantai|Menikmati Senja|Waktu santai dan dokumentasi perjalanan.
@Hari 3 (30 Agu)
08.00 – 11.00|Jalur Pulau|Jelajah Alam|Eksplorasi lanskap pulau bersama pemandu.
13.30 – 15.30|Area Komunitas|Cerita Kehidupan Kepulauan|Mengenal keseharian dan budaya masyarakat setempat.
17.00 – 19.00|Area Pantai|Malam Kebersamaan|Makan bersama dan berbagi pengalaman perjalanan.
@Hari 4 (31 Agu)
07.00 – 08.30|Tepi Pantai|Pagi Terakhir di Togean|Waktu bebas menikmati suasana pulau.
09.00 – 10.30|Area Penginapan|Persiapan Pulang|Pemeriksaan barang dan pengarahan perjalanan kembali.
11.00 – 15.00|Jalur Laut|Perjalanan Kembali|Keberangkatan menuju titik akhir perjalanan.
''');

  static final tenunDonggala = _parse('''
@Hari 1 (14 Des)
09.00 – 10.30|Area Bazar|Pembukaan Bazar Tenun|Pengunjung mulai menjelajahi produk dari perajin.
11.00 – 13.00|Area Demo|Mengenal Alat & Benang|Perajin memperkenalkan bahan dan proses awal pembuatan tenun.
15.00 – 17.00|Area Pameran|Cerita Motif Donggala|Pengenalan ragam motif dan makna di balik karya yang dipamerkan.
@Hari 2 (15 Des)
08.30 – 10.30|Area Demo|Menenun Bersama Perajin|Demonstrasi teknik menenun dan kesempatan bertanya.
12.30 – 14.30|Area Bazar|Jelajah Karya Pilihan|Pengunjung melihat koleksi tenun dan berinteraksi dengan pembuatnya.
16.00 – 17.30|Panggung Kriya|Apresiasi Perajin & Penutupan|Cerita singkat para perajin dan penutupan kegiatan.
@Hari 3 (16 Des)
09.00 – 11.00|Area Pameran|Jelajah Motif Donggala|Pengunjung melihat koleksi motif dan mendengar cerita di balik kain pilihan.
13.00 – 15.00|Area Demo|Teknik Warna dan Benang|Perajin menunjukkan pilihan bahan dan proses yang membentuk karakter tenun.
16.00 – 17.30|Area Bazar|Temu Perajin|Percakapan santai bersama pembuat kain tentang karya dan pengalaman mereka.
@Hari 4 (17 Des)
09.00 – 11.00|Area Demo|Praktik Menenun|Peserta mengenal gerak dasar menenun dengan pendampingan perajin.
12.30 – 14.30|Area Bazar|Jelajah Produk Lokal|Pilihan kain dan kriya daerah dipamerkan untuk pengunjung.
15.30 – 17.00|Area Komunitas|Cerita Usaha Kriya|Pelaku usaha berbagi pengalaman membawa karya tenun kepada pembeli.
@Hari 5 (18 Des)
09.00 – 11.00|Area Bazar|Pameran Hari Terakhir|Pengunjung mendapat kesempatan terakhir melihat dan memilih karya perajin.
13.00 – 15.00|Panggung Kriya|Cerita Motif Pilihan|Perajin memperkenalkan makna motif dan proses pembuatannya.
16.00 – 17.30|Panggung Kriya|Apresiasi Perajin & Penutupan|Rangkuman kegiatan, apresiasi karya, dan penutupan bazar.
''');
}
