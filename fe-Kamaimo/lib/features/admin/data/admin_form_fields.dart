class AdminFormField {
  const AdminFormField(
    this.key,
    this.label, {
    this.required = false,
    this.number = false,
    this.decimal = false,
    this.date = false,
    this.lines = 1,
    this.options = const [],
    this.existingOnly = false,
  });

  final String key;
  final String label;
  final bool required;
  final bool number;
  final bool decimal;
  final bool date;
  final int lines;
  final List<String> options;
  final bool existingOnly;
}

class AdminFormFields {
  static List<AdminFormField> forEntity(
    String type,
    Map<String, dynamic>? row,
  ) {
    final fields = switch (type) {
      'desaWisata' => const [
        AdminFormField('namaDesa_id', 'Nama desa (Indonesia)', required: true),
        AdminFormField('namaDesa_en', 'Nama desa (Inggris)'),
        AdminFormField('lokasi_id', 'Lokasi (Indonesia)', required: true),
        AdminFormField('lokasi_en', 'Lokasi (Inggris)'),
        AdminFormField(
          'deskripsi_id',
          'Deskripsi (Indonesia)',
          required: true,
          lines: 3,
        ),
        AdminFormField('deskripsi_en', 'Deskripsi (Inggris)', lines: 3),
        AdminFormField('latitude', 'Latitude', required: true, decimal: true),
        AdminFormField('longitude', 'Longitude', required: true, decimal: true),
        AdminFormField(
          'jenisDesa',
          'Jenis desa',
          options: ['DESA_WISATA', 'DESA_UNGGULAN'],
        ),
        AdminFormField(
          'kategori',
          'Kategori',
          options: ['EKOWISATA', 'BAHARI', 'BUDAYA', 'UMKM'],
        ),
        AdminFormField('foto', 'Foto (URL atau path aset)'),
        AdminFormField('link_video', 'Link video'),
      ],
      'jarakDesa' => const [
        AdminFormField(
          'desaId',
          'ID desa wisata',
          required: true,
          number: true,
        ),
        AdminFormField(
          'titikKota',
          'Titik kota',
          required: true,
          options: ['PALU', 'LUWUK'],
        ),
        AdminFormField('jalur_darat', 'Jalur darat', lines: 2),
        AdminFormField('jalur_laut', 'Jalur laut', lines: 2),
        AdminFormField('jalur_udara', 'Jalur udara', lines: 2),
      ],
      'atraksi' => const [
        AdminFormField('nameEvent', 'Nama event', required: true),
        AdminFormField('location_id', 'Lokasi (Indonesia)', required: true),
        AdminFormField('location_en', 'Lokasi (Inggris)'),
        AdminFormField(
          'description_id',
          'Deskripsi (Indonesia)',
          required: true,
          lines: 3,
        ),
        AdminFormField('description_en', 'Deskripsi (Inggris)', lines: 3),
        AdminFormField(
          'startdate',
          'Tanggal mulai',
          required: true,
          date: true,
        ),
        AdminFormField(
          'enddate',
          'Tanggal selesai',
          required: true,
          date: true,
        ),
        AdminFormField(
          'kategori',
          'Kategori',
          options: ['BUDAYA', 'BAHARI', 'UMKM', 'EKOWISATA'],
        ),
        AdminFormField('wilayah', 'Wilayah'),
        AdminFormField('harga', 'Harga tiket', number: true),
        AdminFormField('foto', 'Foto (URL atau path aset)'),
        AdminFormField('link_video', 'Link video'),
      ],
      'tourPackage' => const [
        AdminFormField(
          'nama_wisata_id',
          'Nama paket (Indonesia)',
          required: true,
        ),
        AdminFormField('nama_wisata_en', 'Nama paket (Inggris)'),
        AdminFormField('lokasi_id', 'Lokasi (Indonesia)', required: true),
        AdminFormField('lokasi_en', 'Lokasi (Inggris)'),
        AdminFormField(
          'deskripsi_id',
          'Deskripsi (Indonesia)',
          required: true,
          lines: 3,
        ),
        AdminFormField('deskripsi_en', 'Deskripsi (Inggris)', lines: 3),
        AdminFormField('harga', 'Harga paket', required: true, number: true),
        AdminFormField('kontak', 'Kontak agen', required: true),
        AdminFormField('media', 'Foto (URL atau path aset)'),
        AdminFormField('link_video', 'Link video'),
        AdminFormField('kategori', 'Kategori', existingOnly: true),
        AdminFormField('durasi', 'Durasi', existingOnly: true),
        AdminFormField('tipe', 'Tipe', existingOnly: true),
        AdminFormField('fasilitas', 'Fasilitas', existingOnly: true, lines: 2),
      ],
      'kuliner' => const [
        AdminFormField('nama_makanan', 'Nama makanan', required: true),
        AdminFormField('lokasi', 'Lokasi', required: true),
        AdminFormField(
          'deskripsi_id',
          'Deskripsi (Indonesia)',
          required: true,
          lines: 3,
        ),
        AdminFormField('deskripsi_en', 'Deskripsi (Inggris)', lines: 3),
        AdminFormField('foto', 'Foto (URL atau path aset)'),
        AdminFormField('link_video', 'Link video'),
        AdminFormField('wilayah', 'Wilayah', existingOnly: true),
        AdminFormField('warung', 'Warung', existingOnly: true),
        AdminFormField('tag', 'Label', existingOnly: true),
        AdminFormField('bahan', 'Bahan', existingOnly: true, lines: 2),
      ],
      'rumahMakan' => const [
        AdminFormField('resto', 'Nama rumah makan', required: true),
        AdminFormField('kulinerId', 'ID kuliner', required: true, number: true),
        AdminFormField('link_gmaps', 'Link Google Maps', required: true),
        AdminFormField('link_video', 'Link video'),
      ],
      'hotel' => const [
        AdminFormField('nama_hotel', 'Nama hotel', required: true),
        AdminFormField('lokasi', 'Lokasi'),
        AdminFormField('telepon', 'Telepon'),
        AdminFormField('jumlah_kamar', 'Jumlah kamar'),
        AdminFormField('jumlah_tempatTidur', 'Jumlah tempat tidur'),
        AdminFormField('harga_minimum', 'Harga minimum', number: true),
        AdminFormField('harga_maximum', 'Harga maksimum', number: true),
        AdminFormField('website', 'Website'),
        AdminFormField('link_gmaps', 'Link Google Maps'),
        AdminFormField('foto', 'Foto (URL atau path aset)'),
        AdminFormField('link_video', 'Link video'),
        AdminFormField('wilayah', 'Wilayah', existingOnly: true),
        AdminFormField('tag', 'Label', existingOnly: true),
        AdminFormField('highlight', 'Highlight', existingOnly: true),
      ],
      'ulasan' => const [
        AdminFormField('nama', 'Nama pengulas', required: true),
        AdminFormField('desaId', 'ID desa wisata', number: true),
        AdminFormField('rating', 'Rating (1–5)', required: true, number: true),
        AdminFormField('komentar', 'Komentar', required: true, lines: 3),
      ],
      _ => const <AdminFormField>[],
    };
    return fields
        .where(
          (field) =>
              !field.existingOnly || (row?.containsKey(field.key) ?? false),
        )
        .toList();
  }
}
