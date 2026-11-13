import '../../../core/network/api_client.dart';
import '../../../core/network/api_config.dart';

/// One source for the admin tabs and the dashboard counters.
class AdminContent {
  static const endpoints = <String, String>{
    'desaWisata': ApiConfig.desaWisata,
    'jarakDesa': ApiConfig.jarak,
    'atraksi': ApiConfig.atraksi,
    'tourPackage': ApiConfig.tourPackage,
    'kuliner': ApiConfig.kuliner,
    'rumahMakan': ApiConfig.rumahMakan,
    'hotel': ApiConfig.hotel,
    'ulasan': ApiConfig.ulasan,
    'adminUser': ApiConfig.user,
  };

  static Future<List<Map<String, dynamic>>> load(
    ApiClient api,
    String type,
  ) async {
    final endpoint = endpoints[type];
    if (endpoint == null) {
      throw ArgumentError.value(type, 'type');
    }
    final response = await api.get(endpoint);
    if (response is! List) {
      throw const FormatException('Daftar konten tidak valid');
    }
    return response.map((row) {
      if (row is! Map) {
        throw const FormatException('Item konten tidak valid');
      }
      return Map<String, dynamic>.from(row);
    }).toList();
  }

  static String _endpoint(String type) {
    final endpoint = endpoints[type];
    if (endpoint == null || type == 'adminUser') {
      throw ArgumentError.value(type, 'type');
    }
    return endpoint;
  }

  static Future<void> create(
    ApiClient api,
    String type,
    Map<String, dynamic> body,
  ) async {
    final endpoint = _endpoint(type);
    await api.post(
      type == 'ulasan' ? '$endpoint/insert' : endpoint,
      body: body,
    );
  }

  static Future<void> update(
    ApiClient api,
    String type,
    dynamic id,
    Map<String, dynamic> body,
  ) async {
    if (id == null) throw const FormatException('ID konten tidak tersedia');
    await api.patch('${_endpoint(type)}/$id', body: body);
  }

  static Future<void> delete(ApiClient api, String type, dynamic id) async {
    if (id == null) throw const FormatException('ID konten tidak tersedia');
    await api.delete('${_endpoint(type)}/$id');
  }

  static String? _value(Map<String, dynamic> row, String key) {
    final value = row[key]?.toString().trim();
    return value == null || value.isEmpty ? null : value;
  }

  static String? _first(Map<String, dynamic> row, List<String> keys) {
    for (final key in keys) {
      final value = _value(row, key);
      if (value != null) return value;
    }
    return null;
  }

  static String? _image(Map<String, dynamic> row, String type) {
    final raw = _first(row, type == 'tourPackage' ? ['media'] : ['foto']);
    if (raw == null) return null;
    // Some package media fields contain a JSON array or comma-separated URLs.
    if (raw.startsWith('[')) {
      final match = RegExp(r'"([^"]+)"').firstMatch(raw);
      return match?.group(1);
    }
    return raw.split(',').first.trim();
  }

  static Map<String, dynamic> display(String type, Map<String, dynamic> row) {
    final item = <String, dynamic>{'id': row['id'], 'raw': row};
    void put(String key, String? value) {
      if (value != null && value.isNotEmpty) item[key] = value;
    }

    switch (type) {
      case 'desaWisata':
        put('name', _value(row, 'namaDesa_id'));
        put('loc', _value(row, 'lokasi_id'));
        put('desc', _value(row, 'deskripsi_id'));
        put('badge', _value(row, 'kategori'));
        put('tag', _value(row, 'jenisDesa'));
        break;
      case 'jarakDesa':
        put('name', 'Akses Desa #${row['desaId'] ?? row['id']}');
        put('loc', _value(row, 'titikKota'));
        put('desc', _first(row, ['jalur_darat', 'jalur_laut', 'jalur_udara']));
        put(
          'extra',
          [
            if (_value(row, 'jalur_laut') != null)
              'Laut: ${_value(row, 'jalur_laut')}',
            if (_value(row, 'jalur_udara') != null)
              'Udara: ${_value(row, 'jalur_udara')}',
          ].join(' • '),
        );
        put('tag', 'DESA #${row['desaId'] ?? '-'}');
        break;
      case 'atraksi':
        put('name', _value(row, 'nameEvent'));
        put('loc', _value(row, 'location_id'));
        put('desc', _value(row, 'description_id'));
        put('badge', _value(row, 'kategori'));
        put('tag', _value(row, 'startdate'));
        break;
      case 'tourPackage':
        put('name', _value(row, 'nama_wisata_id'));
        put('loc', _value(row, 'lokasi_id'));
        put('desc', _value(row, 'deskripsi_id'));
        put('badge', _value(row, 'kategori'));
        put('tag', _value(row, 'durasi'));
        put('price', row['harga'] == null ? null : 'Rp ${row['harga']}');
        put('extra', _value(row, 'fasilitas'));
        break;
      case 'kuliner':
        put('name', _value(row, 'nama_makanan'));
        put('loc', _value(row, 'lokasi'));
        put('desc', _value(row, 'deskripsi_id'));
        put('badge', _value(row, 'tag'));
        break;
      case 'rumahMakan':
        put('name', _value(row, 'resto'));
        put('loc', _first(row, ['lokasi', 'link_gmaps']));
        put(
          'tag',
          row['kulinerId'] == null ? null : 'Kuliner #${row['kulinerId']}',
        );
        break;
      case 'hotel':
        put('name', _value(row, 'nama_hotel'));
        put('loc', _value(row, 'lokasi'));
        put('badge', _value(row, 'tag'));
        put(
          'price',
          row['harga_minimum'] == null
              ? null
              : 'Mulai Rp ${row['harga_minimum']}',
        );
        put('extra', _value(row, 'telepon'));
        break;
      case 'ulasan':
        put('name', _value(row, 'nama'));
        put('loc', row['desaId'] == null ? null : 'Desa #${row['desaId']}');
        put('desc', _value(row, 'komentar'));
        put('tag', row['rating'] == null ? null : 'Bintang ${row['rating']}');
        put('balasanAdmin', _value(row, 'balasan_admin') ?? _value(row, 'balasanAdmin'));
        break;
      case 'adminUser':
        put('name', _first(row, ['nama_Lengkap', 'username']));
        put(
          'loc',
          row['username'] == null ? null : 'Username: ${row['username']}',
        );
        put('badge', _value(row, 'role'));
        put('tag', _value(row, 'jenis_kelamin'));
        break;
    }
    put('image', _image(row, type));
    return item;
  }
}
