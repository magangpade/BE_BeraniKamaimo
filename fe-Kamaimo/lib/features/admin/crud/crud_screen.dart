import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:berani_kamaimo/core/network/api_client.dart';
import 'package:berani_kamaimo/core/network/api_config.dart';
import 'package:berani_kamaimo/core/theme/app_colors.dart';

/// CRUD Screen per entitas dengan kartu yang presisi sesuai data asli user + sinkron ke be-kamaimo.
class CrudScreen extends StatefulWidget {
  final String title;
  final String entityType;
  final List<Map<String, dynamic>> initialData;

  const CrudScreen({
    super.key,
    required this.title,
    required this.entityType,
    this.initialData = const [],
  });

  @override
  State<CrudScreen> createState() => _CrudScreenState();
}

class _CrudScreenState extends State<CrudScreen> {
  late List<Map<String, dynamic>> _data;
  final _searchCtrl = TextEditingController();
  String _filter = '';

  @override
  void initState() {
    super.initState();
    _data = widget.initialData.isNotEmpty ? List.from(widget.initialData) : _seedData();
    WidgetsBinding.instance.addPostFrameCallback((_) => _syncFromBackend());
  }

  @override
  void didUpdateWidget(covariant CrudScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.entityType != widget.entityType) {
      setState(() {
        _filter = '';
        _searchCtrl.clear();
        _data = widget.initialData.isNotEmpty ? List.from(widget.initialData) : _seedData();
      });
      _syncFromBackend();
    }
  }

  Future<void> _syncFromBackend() async {
    try {
      final api = context.read<ApiClient>();
      if (widget.entityType == 'adminUser') {
        final json = await api.get(ApiConfig.user);
        final list = json['data'] as List<dynamic>? ?? [];
        if (list.isNotEmpty && mounted) {
          setState(() {
            _data = list.map((u) {
              final m = u as Map<String, dynamic>;
              return {
                'id': m['id'],
                'name': m['nama_Lengkap'] ?? m['username'] ?? 'Admin',
                'loc': 'Username: ${m['username']}',
                'badge': (m['role'] == 'superAdmin') ? 'SUPER ADMIN' : 'ADMIN',
                'tag': 'Gender: ${m['jenis_kelamin'] ?? 'Laki-laki'}',
                'desc': 'Akun pengelola aktif sistem Berani Kamaimo.',
              };
            }).toList();
          });
        }
      }
    } catch (_) {}
  }

  List<Map<String, dynamic>> _seedData() {
    switch (widget.entityType) {
      case 'desaWisata':
        return [
          {
            'id': 1,
            'image': 'assets/images/beranda/thumb_luk_panenteng.png',
            'name': 'Desa Luk Panenteng & Danau Paisu Pok',
            'loc': 'Banggai Kepulauan',
            'badge': 'KOLAM KACA',
            'tag': 'DESA UNGGULAN',
            'rating': '4.9 (1.4k ulasan)',
            'price': 'Mulai Rp 15.000/org',
            'desc': 'Air danau sejernih kaca dengan vegetasi hutan lebat dan kano tradisional.',
          },
          {
            'id': 2,
            'image': 'assets/images/beranda/kartu_sombori.png',
            'name': 'Kepulauan Sombori',
            'loc': 'Morowali',
            'badge': 'THE SECRET PARADISE',
            'tag': 'DESA UNGGULAN',
            'rating': '4.95 (840 ulasan)',
            'price': 'Paket Tur Rp 350.000',
            'desc': 'Karst megah, tebing cadas, dan laguna toska memikat.',
          },
          {
            'id': 3,
            'image': 'assets/images/destinasi/card_saluopa.png',
            'name': 'Air Terjun Saluopa & Pasir Emas',
            'loc': 'Tentena, Poso',
            'badge': 'PASIR EMAS',
            'tag': 'DESA WISATA',
            'rating': '4.88 (920 ulasan)',
            'price': 'Mulai Rp 10.000/org',
            'desc': 'Air terjun 12 tingkat dengan air jernih dari pegunungan Poso.',
          },
          {
            'id': 4,
            'image': 'assets/images/destinasi/card_togean.png',
            'name': 'Kepulauan Togean',
            'loc': 'Tojo Una-Una',
            'badge': 'CAGAR BIOSFER UNESCO',
            'tag': 'DESA UNGGULAN',
            'rating': '4.92 (1.1k ulasan)',
            'price': 'Mulai Rp 50.000/org',
            'desc': 'Danau ubur-ubur tanpa sengat dan gugusan pulau koral tropis.',
          },
        ];

      case 'jarakDesa':
        return [
          {
            'id': 1,
            'name': 'Akses Menuju Luk Panenteng',
            'loc': 'Banggai Kepulauan',
            'tag': 'RUTE TRANSPORTASI',
            'desc': 'Pilihan jalur akses wisata dari dua pintu masuk utama Sulteng.',
            'dariPalu': 'Darat: 14 Jam (Mobil/Travel) • Laut: 8 Jam Kapal Feri • Udara: Palu ke Luwuk (1 Jam) lanjut kapal.',
            'dariLuwuk': 'Laut: 2 Jam Speedboat langsung dari Pelabuhan Luwuk.',
          },
          {
            'id': 2,
            'name': 'Akses Menuju Sombori',
            'loc': 'Morowali',
            'tag': 'RUTE TRANSPORTASI',
            'desc': 'Jalur darat & laut via Bungku dan Kendari.',
            'dariPalu': 'Darat: 11 Jam menuju Bungku • Laut: 2.5 Jam Perahu Lokal.',
            'dariLuwuk': 'Darat: 8 Jam menuju Bungku • Laut: Speedboat 2 Jam.',
          },
          {
            'id': 3,
            'name': 'Akses Menuju Danau Poso',
            'loc': 'Poso',
            'tag': 'RUTE TRANSPORTASI',
            'desc': 'Jalur utama Trans-Sulawesi beraspal mulus.',
            'dariPalu': 'Darat: 5 Jam via Kebun Kopi & Parigi • Udara: Pesawat ke Bandara Kasiguncu Poso (45 Mnt).',
            'dariLuwuk': 'Darat: 7 Jam via Ampana.',
          },
        ];

      case 'atraksi':
        return [
          {
            'id': 1,
            'image': 'assets/images/beranda/thumb_event1.png',
            'name': 'Festival Danau Poso ke-24',
            'loc': 'Tentena, Poso',
            'badge': 'KARISMA EVENT NUSANTARA 2025',
            'tag': '24 OKT • H-45 Hari',
            'desc': 'Parade budaya, tari mogele, karnaval pakaian adat, dan lomba perahu naga tradisional.',
          },
          {
            'id': 2,
            'image': 'assets/images/beranda/thumb_event2.png',
            'name': 'Festival Teluk Tomini (FTT)',
            'loc': 'Parigi Moutong',
            'badge': 'KARISMA EVENT NUSANTARA 2025',
            'tag': '18 NOV • H-45 Hari',
            'desc': 'Eksplorasi bawah laut, karnaval kostum bahari spektakuler & expo UMKM unggulan daerah.',
          },
        ];

      case 'tourPackage':
        return [
          {
            'id': 1,
            'image': 'assets/images/paket/paket_togean.png',
            'name': 'Eksotisme Kepulauan Togean',
            'loc': 'Tojo Una-Una',
            'badge': 'CAGAR BIOSFER UNESCO',
            'tag': '4 Hari 3 Malam • Water Cottage',
            'price': 'Rp 2.850.000 /orang',
            'rating': '★ 4.9 (86 ulasan)',
            'desc': 'Berenang bersama ubur-ubur tanpa sengat Danau Mariona, snorkeling di gosong, dan pulau pribadi.',
            'extra': 'Makan Lengkap • Guide HPI • Perahu Pribadi • Drone',
          },
          {
            'id': 2,
            'image': 'assets/images/paket/paket_sambori.png',
            'name': 'Sombori Secret Paradise',
            'loc': 'Morowali',
            'badge': 'THE SECRET PARADISE',
            'tag': '3 Hari 2 Malam • Open Trip',
            'price': 'Rp 350.000 /orang',
            'rating': '★ 4.95 (54 ulasan)',
            'desc': 'Laguna toska karst megah, tebing cadas, dan pasir putih Kepulauan Sombori eksklusif.',
            'extra': 'Guide HPI • Perahu Pribadi • Snorkeling Set • Drone',
          },
          {
            'id': 3,
            'image': 'assets/images/paket/paket_megalitikum.png',
            'name': 'Misteri Lembah Bada & Megalitikum',
            'loc': 'Poso',
            'badge': 'SITUS MEGALITIKUM',
            'tag': '2 Hari 1 Malam • Homestay',
            'price': 'Rp 650.000 /orang',
            'rating': '★ 4.8 (112 ulasan)',
            'desc': 'Menelusuri patung megalitik seribu tahun, rumah adat, dan tradisi api abadi Lembah Bada.',
            'extra': 'Guide HPI • Makan Lengkap • Homestay Lokal • Transport',
          },
          {
            'id': 4,
            'image': 'assets/images/paket/paket_poso.png',
            'name': 'Trekking Air Terjun Saluopa',
            'loc': 'Poso',
            'badge': 'DANAU & AIR TERJUN',
            'tag': '1 Hari • Paket Harian',
            'price': 'Rp 250.000 /orang',
            'rating': '★ 4.7 (78 ulasan)',
            'desc': 'Jemput dari Tentena, petualangan di 12 tangga air jernih menuju puncak Air Terjun Saluopa.',
            'extra': 'Guide HPI • Tiket Masuk • Makan Siang',
          },
        ];

      case 'kuliner':
        return [
          {
            'id': 1,
            'image': 'assets/images/eksplor/kuliner2.jpg',
            'name': 'Kaledo (Kaki Lemboe Asli)',
            'loc': 'Palu & Donggala',
            'badge': 'KULINER LEGENDARIS',
            'tag': 'Khas Suku Kaili',
            'desc': 'Sup sumsum tulang sapi empuk berkuah asam pedas dari asam jawa segar dan cabai rawit hijau, disedot bambu.',
            'extra': 'Bahan: Asam Jawa Segar • Cabai Rawit Hijau • Singkong Rebus',
          },
          {
            'id': 2,
            'image': 'assets/images/eksplor/kuliner1.jpg',
            'name': 'Onyop (Kuah Asam Ikan Segar)',
            'loc': 'Luwuk, Banggai',
            'badge': 'FAVORIT PESISIR',
            'tag': 'Khas Luwuk Banggai',
            'desc': 'Kuah asam pedas segar dari asam muda, potongan ikan segar kakap/tenggiri, dan sagu kenyal.',
            'extra': 'Bahan: Asam Jawa Muda • Cabai Rawit • Sagu/Ubi',
          },
          {
            'id': 3,
            'image': 'assets/images/eksplor/kuliner3.jpg',
            'name': 'Lalampa (Ketan Bakar Isi Tuna)',
            'loc': 'Toboli, Parigi Moutong',
            'badge': 'OLEH-OLEH KHAS',
            'tag': 'Jajanan Jalur Trans',
            'desc': 'Beras ketan pulen berisi ikan tuna bakar bumbu pedas gurih, dibungkus daun pisang lalu dibakar arang.',
            'extra': 'Bahan: Beras Ketan • Ikan Tuna Pedas • Daun Pisang',
          },
          {
            'id': 4,
            'image': 'assets/images/eksplor/kuliner4.jpg',
            'name': 'Uta Dada (Ayam Kuah Santan Kuning)',
            'loc': 'Palu',
            'badge': 'AUTENTIK',
            'tag': 'Khas Kaili',
            'desc': 'Ayam kampung bakar dimasak kuah santan kuning rempah pedas yang wangi dan gurih.',
            'extra': 'Bahan: Ayam Kampung Bakar • Kunyit • Santan Kental',
          },
        ];

      case 'rumahMakan':
        return [
          {
            'id': 1,
            'name': 'Warung Kaledo Stereo Palu',
            'loc': 'Jl. Diponegoro, Palu Barat',
            'tag': 'Spesialis Kaledo',
            'badge': 'TERPOPULER',
            'desc': 'Pusat kuliner Kaledo paling ramai di kota Palu dengan sumsum tulang melimpah.',
            'extra': 'Buka: 08.00 - 22.00 WITA • Google Maps Tersedia',
          },
          {
            'id': 2,
            'name': 'R.M TINAKU 2 (Khas Kaili)',
            'loc': 'Jl. Monginsidi, Palu',
            'tag': 'Masakan Tradisional',
            'badge': 'REKOMENDASI LOKAL',
            'desc': 'Menyajikan Onyop, Uta Dada, Duo Sale, dan aneka olahan ikan laut segar.',
            'extra': 'Buka: 09.00 - 21.00 WITA • Google Maps Tersedia',
          },
          {
            'id': 3,
            'name': 'Raja Lalampa Toboli',
            'loc': 'Jalur Kebun Kopi, Toboli',
            'tag': 'Sentra Lalampa',
            'badge': 'WARUNG PERSINGGAHAN',
            'desc': 'Pusat peristirahatan jalur Palu-Poso dengan lalampa hangat langsung dari pembakaran.',
            'extra': 'Buka: 24 Jam • Parkir Luas',
          },
        ];

      case 'hotel':
        return [
          {
            'id': 1,
            'image': 'assets/images/eksplor/hotel1.jpg',
            'name': 'Swiss–Belhotel Silae Palu',
            'loc': 'Teluk Palu, Palu Barat',
            'badge': 'BINTANG 4 RESOR',
            'tag': 'Sea View • 130 Kamar',
            'price': 'Mulai Rp 750.000 /malam',
            'rating': '★ 4.7 (1.2k ulasan)',
            'desc': 'Resor tepi laut dengan kolam renang infinity menghadap Teluk Palu.',
            'extra': 'Kolam View Laut • 2 King Bed • Buffet Sarapan • WiFi',
          },
          {
            'id': 2,
            'image': 'assets/images/eksplor/hotel2.jpg',
            'name': 'Tanjung Karang Beach Resort',
            'loc': 'Donggala',
            'badge': 'RESOR PANTAI',
            'tag': 'Private Beach • 58 Kamar',
            'price': 'Mulai Rp 480.000 /malam',
            'rating': '★ 4.6 (310 ulasan)',
            'desc': 'Akomodasi tepi pantai pasir putih Donggala dengan fasilitas diving and snorkeling.',
            'extra': 'Private Beach • Resto Tepi Pantai • Dive Center',
          },
          {
            'id': 3,
            'image': 'assets/images/eksplor/hotel3.jpg',
            'name': 'Luwuk Bay Guest House',
            'loc': 'Luwuk Timur',
            'badge': 'GUESTHOUSE PESISIR',
            'tag': 'Sunset Deck',
            'price': 'Mulai Rp 320.000 /malam',
            'rating': '★ 4.5 (812 ulasan)',
            'desc': 'Penginapan tenang dengan panorama teluk Luwuk dan akses cepat ke pelabuhan.',
            'extra': 'Sunset Deck • AC • Sarapan Pagi',
          },
          {
            'id': 4,
            'image': 'assets/images/eksplor/hotel4.jpg',
            'name': 'Bukabuka Island Resort',
            'loc': 'Pulau Buka-Buka, Togean',
            'badge': 'ISLAND RETREAT',
            'tag': 'Snorkeling Langsung • 12 Bungalow',
            'price': 'Mulai Rp 950.000 /malam',
            'rating': '★ 4.9 (96 ulasan)',
            'desc': 'Eco-resort terpencil di pulau pribadi dengan terumbu karang hidup tepat di depan kamar.',
            'extra': 'Pantai Privat • Full Board Meals • Snorkeling Gear',
          },
        ];

      case 'ulasan':
        return [
          {
            'id': 1,
            'name': 'Rahmat Hidayat (Wisatawan Domestik)',
            'loc': 'Kunjungan ke Danau Paisu Pok',
            'badge': 'ULASAN TERVERIFIKASI',
            'tag': 'Bintang 5 ★★★★★',
            'desc': 'Airnya benar-benar seperti kaca! Sewa perahu kano cuma 30 ribu dan pemandangannya luar biasa asri. Pengalaman terbaik di Sulteng.',
          },
          {
            'id': 2,
            'name': 'Sarah Jenkins (Turis Asing)',
            'loc': 'Kunjungan ke Kepulauan Sombori',
            'badge': 'ULASAN TERVERIFIKASI',
            'tag': 'Bintang 5 ★★★★★',
            'desc': 'Sombori feels like hidden Raja Ampat. The local guides are so helpful, pristine clear water, and very peaceful.',
          },
          {
            'id': 3,
            'name': 'Andi Tenri (Palu)',
            'loc': 'Kunjungan ke Festival Danau Poso',
            'badge': 'ULASAN TERVERIFIKASI',
            'tag': 'Bintang 4 ★★★★☆',
            'desc': 'Acaranya sangat meriah, tarian daerah memukau. Penataan parkir dan kebersihan area festival perlu ditingkatkan lagi.',
          },
        ];

      case 'adminUser':
        return [
          {
            'id': 1,
            'name': 'Super Admin Kamaimo',
            'loc': 'Username: superadmin',
            'badge': 'SUPER ADMIN',
            'tag': 'Gender: Laki-laki',
            'desc': 'Hak akses penuh (Super Admin) untuk kelola konten dan akun admin Dinas Pariwisata.',
          },
          {
            'id': 2,
            'name': 'Admin Berani Kamaimo',
            'loc': 'Username: admin',
            'badge': 'ADMIN',
            'tag': 'Gender: Laki-laki',
            'desc': 'Pengelola konten destinasi wisata, event, paket, kuliner, dan penginapan.',
          },
        ];

      default:
        return [
          {
            'id': 1,
            'name': 'Konten ${widget.title}',
            'loc': 'Sulawesi Tengah',
            'badge': 'TERDAFTAR',
            'tag': 'Aktif',
            'desc': 'Data resmi dinas pariwisata provinsi Sulawesi Tengah.',
          },
        ];
    }
  }

  List<Map<String, dynamic>> _getFiltered() {
    if (_filter.isEmpty) return _data;
    final q = _filter.toLowerCase();
    return _data.where((e) {
      return e.values.any((v) => v.toString().toLowerCase().contains(q));
    }).toList();
  }

  Future<void> _createOnBackend({
    required String name,
    required String loc,
    required String desc,
  }) async {
    try {
      final api = context.read<ApiClient>();
      switch (widget.entityType) {
        case 'desaWisata':
          await api.post(ApiConfig.desaWisata, body: {
            'namaDesa_id': name,
            'lokasi_id': loc,
            'deskripsi_id': desc,
            'latitude': -1.3275,
            'longitude': 123.4627,
          });
          break;
        case 'atraksi':
          await api.post(ApiConfig.atraksi, body: {
            'nameEvent': name,
            'location_id': loc,
            'description_id': desc,
            'startdate': '2026-11-15',
            'enddate': '2026-11-17',
          });
          break;
        case 'tourPackage':
          await api.post(ApiConfig.tourPackage, body: {
            'nama_wisata_id': name,
            'lokasi_id': loc,
            'deskripsi_id': desc,
            'harga': 350000,
            'kontak': '628114500123',
          });
          break;
        case 'kuliner':
          await api.post(ApiConfig.kuliner, body: {
            'nama_makanan': name,
            'lokasi': loc,
            'deskripsi_id': desc,
          });
          break;
        case 'rumahMakan':
          await api.post(ApiConfig.rumahMakan, body: {
            'resto': name,
            'kulinerId': 1,
            'link_gmaps': loc,
          });
          break;
        case 'hotel':
          await api.post(ApiConfig.hotel, body: {
            'nama_hotel': name,
            'lokasi': loc,
            'telepon': '08114500123',
            'harga_minimum': 450000,
          });
          break;
        case 'adminUser':
          await api.post(ApiConfig.user, body: {
            'nama_Lengkap': name,
            'username': loc.replaceAll('Username:', '').trim(),
            'password': desc.trim().isEmpty ? 'admin123' : desc.trim(),
            'jenis_kelamin': 'L',
            'role': 'Admin',
          });
          break;
      }
    } catch (_) {}
  }

  Future<void> _deleteOnBackend(dynamic id) async {
    if (id == null) return;
    try {
      final api = context.read<ApiClient>();
      switch (widget.entityType) {
        case 'desaWisata':
          await api.delete('${ApiConfig.desaWisata}/$id');
          break;
        case 'jarakDesa':
          await api.delete('${ApiConfig.jarak}/$id');
          break;
        case 'atraksi':
          await api.delete('${ApiConfig.atraksi}/$id');
          break;
        case 'tourPackage':
          await api.delete('${ApiConfig.tourPackage}/$id');
          break;
        case 'kuliner':
          await api.delete('${ApiConfig.kuliner}/$id');
          break;
        case 'rumahMakan':
          await api.delete('${ApiConfig.rumahMakan}/$id');
          break;
        case 'hotel':
          await api.delete('${ApiConfig.hotel}/$id');
          break;
        case 'ulasan':
          await api.delete('${ApiConfig.ulasan}/$id');
          break;
        case 'adminUser':
          await api.delete('${ApiConfig.user}/$id');
          break;
      }
    } catch (_) {}
  }

  void _showAddDialog() {
    final nameCtrl = TextEditingController();
    final locCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    final isAdminEntity = widget.entityType == 'adminUser';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Tambah ${widget.title}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
            fontFamily: 'PlusJakartaSans',
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: InputDecoration(
                  labelText: isAdminEntity ? 'Nama Lengkap' : 'Nama / Judul',
                  filled: true,
                  fillColor: AppColors.background,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: locCtrl,
                decoration: InputDecoration(
                  labelText: isAdminEntity ? 'Username' : 'Lokasi / Kabupaten',
                  filled: true,
                  fillColor: AppColors.background,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descCtrl,
                maxLines: isAdminEntity ? 1 : 3,
                obscureText: isAdminEntity,
                decoration: InputDecoration(
                  labelText: isAdminEntity ? 'Password (default: admin123)' : 'Deskripsi Singkat',
                  filled: true,
                  fillColor: AppColors.background,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Batal', style: TextStyle(fontFamily: 'PlusJakartaSans')),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Operasi Gagal: Modul CRUD Admin belum terhubung ke database (Dalam Pengembangan)'),
                  backgroundColor: AppColors.error,
                ),
              );
            },
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.pine700,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: const Text('Simpan', style: TextStyle(fontWeight: FontWeight.w700, fontFamily: 'PlusJakartaSans')),
          ),
        ],
      ),
    );
  }

  void _showDetail(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.all(24),
        title: Text(
          item['name'] as String? ?? 'Detail',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
            fontFamily: 'PlusJakartaSans',
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (item['image'] != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset(
                    item['image'] as String,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Container(
                      height: 140,
                      color: AppColors.background,
                      child: const Center(
                        child: Icon(Icons.image_not_supported_outlined, color: AppColors.textMuted),
                      ),
                    ),
                  ),
                ),
              if (item['image'] != null) const SizedBox(height: 14),
              if (item['badge'] != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.emerald100,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    item['badge'] as String,
                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.emerald600),
                  ),
                ),
              const SizedBox(height: 8),
              if (item['loc'] != null)
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: AppColors.pine500),
                    const SizedBox(width: 4),
                    Text(item['loc'] as String, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  ],
                ),
              if (item['price'] != null) ...[
                const SizedBox(height: 6),
                Text(item['price'] as String, style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.pine700, fontSize: 14)),
              ],
              const SizedBox(height: 10),
              Text(item['desc'] as String? ?? '', style: const TextStyle(fontSize: 13, height: 1.5, color: AppColors.textBody)),
              if (item['dariPalu'] != null) ...[
                const Divider(height: 20),
                const Text('Dari Palu:', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                const SizedBox(height: 2),
                Text(item['dariPalu'] as String, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                const SizedBox(height: 6),
                const Text('Dari Luwuk:', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                const SizedBox(height: 2),
                Text(item['dariLuwuk'] as String, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ],
              if (item['extra'] != null) ...[
                const Divider(height: 20),
                Text('Fasilitas / Info: ${item['extra']}', style: const TextStyle(fontSize: 12, color: AppColors.pine700, fontWeight: FontWeight.w600)),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Tutup', style: TextStyle(fontFamily: 'PlusJakartaSans')),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Konfirmasi Hapus', style: TextStyle(color: AppColors.error, fontWeight: FontWeight.w800)),
        content: Text('Yakin ingin menghapus "${item['name']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Operasi Gagal: Hak akses hapus dinonaktifkan (Dalam Pengembangan)'),
                  backgroundColor: AppColors.error,
                ),
              );
            },
            style: FilledButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _getFiltered();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header title & count
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        fontFamily: 'PlusJakartaSans',
                      ),
                    ),
                    Text(
                      '${filtered.length} Konten Terdaftar',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        fontFamily: 'PlusJakartaSans',
                      ),
                    ),
                  ],
                ),
              ),
              FilledButton.icon(
                onPressed: _showAddDialog,
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Tambah Data', style: TextStyle(fontFamily: 'PlusJakartaSans', fontWeight: FontWeight.w700)),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.pine700,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Search box
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 8, offset: const Offset(0, 2)),
              ],
            ),
            child: TextField(
              controller: _searchCtrl,
              onChanged: (v) => setState(() => _filter = v),
              decoration: InputDecoration(
                hintText: 'Cari ${widget.title.toLowerCase()}...',
                hintStyle: const TextStyle(fontSize: 13, fontFamily: 'PlusJakartaSans', color: AppColors.textTertiary),
                prefixIcon: const Icon(Icons.search, size: 20, color: AppColors.textTertiary),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // List / Grid kartu
          if (filtered.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  children: [
                    const Icon(Icons.search_off_rounded, size: 48, color: AppColors.textTertiary),
                    const SizedBox(height: 12),
                    Text('Tidak ada ${widget.title.toLowerCase()} yang cocok.',
                        style: const TextStyle(color: AppColors.textSecondary, fontFamily: 'PlusJakartaSans')),
                  ],
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filtered.length,
              separatorBuilder: (_, _) => const SizedBox(height: 16),
              itemBuilder: (_, i) => _buildItemCard(filtered[i]),
            ),
        ],
      ),
    );
  }

  Widget _buildItemCard(Map<String, dynamic> item) {
    final hasImage = item['image'] != null;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.pine900.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasImage)
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
              child: Image.asset(
                item['image'] as String,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  height: 100,
                  color: AppColors.surfaceElevated,
                  child: const Center(child: Icon(Icons.image_outlined, color: AppColors.textTertiary)),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (item['badge'] != null) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.emerald100,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          item['badge'] as String,
                          style: const TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            color: AppColors.emerald600,
                            letterSpacing: 0.3,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    if (item['tag'] != null)
                      Text(
                        item['tag'] as String,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppColors.pine500,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  item['name'] as String? ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.pine900,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
                if (item['loc'] != null) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.place_rounded, size: 13, color: AppColors.pine500),
                      const SizedBox(width: 4),
                      Text(
                        item['loc'] as String,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                      if (item['rating'] != null) ...[
                        const SizedBox(width: 8),
                        const Icon(Icons.star_rounded, size: 14, color: AppColors.warning),
                        const SizedBox(width: 2),
                        Text(
                          item['rating'] as String,
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, fontFamily: 'PlusJakartaSans'),
                        ),
                      ],
                    ],
                  ),
                ],
                const SizedBox(height: 8),
                Text(
                  item['desc'] as String? ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textBody,
                    height: 1.4,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
                if (item['price'] != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    item['price'] as String,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppColors.pine700,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                ],
                const Divider(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () => _showDetail(item),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        side: const BorderSide(color: AppColors.border),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Detail', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: () => _confirmDelete(item),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.error.withValues(alpha: 0.1),
                        foregroundColor: AppColors.error,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Hapus', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }
}
