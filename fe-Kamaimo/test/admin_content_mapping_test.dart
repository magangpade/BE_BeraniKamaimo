import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:berani_kamaimo/features/user/event/event_data.dart';
import 'package:berani_kamaimo/features/user/paket/paket_data.dart';
import 'package:berani_kamaimo/features/user/eksplor/eksplor_data.dart';
import 'package:berani_kamaimo/models/atraksi.dart';
import 'package:berani_kamaimo/models/tour_package.dart';
import 'package:berani_kamaimo/models/kuliner.dart';
import 'package:berani_kamaimo/models/hotel.dart';

void main() {
  test(
    'event admin memetakan wilayah, program, rundown, peta, dan countdown',
    () {
      final event = EventItem.fromModel(
        Atraksi.fromJson({
          'id': 901,
          'nameEvent': 'Festival Uji Poso',
          'location_id': 'Tentena, Poso',
          'description_id': 'Tentang festival uji',
          'startdate': '2026-12-01',
          'enddate': '2026-12-03',
          'kategori': 'BAHARI',
          'wilayah': 'Poso',
          'harga': 25000,
          'rating': 4.2,
          'rating_count': 7,
          'program_json': jsonEncode([
            {
              'title': 'Tari',
              'title_en': 'Dance',
              'description': 'Pertunjukan',
              'description_en': 'Performance',
              'image': '/uploads/tari.png',
            },
          ]),
          'rundown_json': jsonEncode([
            {
              'hari': 'Hari 1',
              'items': [
                {'jam': '08.00 WITA', 'judul': 'Pembukaan', 'judul_en': 'Opening'},
              ],
            },
          ]),
          'maps_url': 'https://maps.google.com/?q=Tentena',
          'latitude': -1.8,
          'longitude': 120.6,
        }),
      );
      expect(event.kategori, 'BAHARI');
      expect(event.wilayah, 'Poso');
      expect(event.harga, 25000);
      expect(event.end!.day, 3);
      expect(event.detail!.program.single, 'Tari|Pertunjukan');
      expect(event.detail!.programImages.single, '/uploads/tari.png');
      expect(event.detail!.rundown.single['hari'], 'Hari 1');
      expect(event.programEn!.single, 'Dance|Performance');
      expect(event.rundownEn!.single['items'][0]['judul'], 'Opening');
      expect(event.detail!.mapLatitude, -1.8);
    },
  );

  test('paket admin memetakan kontak, harga, durasi, dan fasilitas', () {
    final package = PaketItem.fromModel(
      TourPackage.fromJson({
        'id': 902,
        'nama_wisata_id': 'Paket Poso',
        'lokasi_id': 'Poso',
        'deskripsi_id': 'Paket baru',
        'harga': 700000,
        'kontak': '628123456789',
        'kategori': 'BUDAYA',
        'wilayah': 'Poso',
        'durasi': '2 Hari 1 Malam',
        'tipe': 'Tur pribadi',
        'fasilitas': 'Transportasi, Pemandu',
        'rating': 0,
        'rating_count': '0',
      }),
    );
    expect(package.kontak, '628123456789');
    expect(package.kategori, 'BUDAYA');
    expect(package.wilayah, 'Poso');
    expect(package.durasi, '2 Hari 1 Malam');
    expect(package.fasilitas.map((e) => e.$2), ['Transportasi', 'Pemandu']);
    expect(package.harga, 700000);
    expect(package.ratingCount, 0);
  });

  test(
    'kuliner dan hotel baru menampilkan data kontak dan lokasi dari backend',
    () {
      final food = KulinerItem.fromModel(
        Kuliner.fromJson({
          'id': 903,
          'nama_makanan': 'Kuliner Poso',
          'lokasi': 'Jl. Uji, Poso',
          'deskripsi_id': 'Makanan lokal',
          'wilayah': 'Poso',
          'warung': 'Warung Uji',
          'telepon': '628123456789',
          'website': 'https://example.com',
          'link_gmaps': 'https://maps.google.com/?q=Poso',
          'bahan': 'Ikan, Rempah',
        }),
      );
      expect(food.warung, 'Warung Uji');
      expect(food.wilayah, 'Poso');
      expect(food.telepon, '628123456789');
      expect(food.website, 'https://example.com');
      expect(food.linkGmaps, contains('maps.google.com'));

      final hotel = HotelItem.fromModel(
        Hotel.fromJson({
          'id': 904,
          'nama_hotel': 'Hotel Poso',
          'lokasi': 'Tentena',
          'wilayah': 'Poso',
          'harga_minimum': 250000,
          'jumlah_kamar': 12,
          'jumlah_tempatTidur': 18,
          'telepon': '628123456789',
          'website': 'https://example.com',
          'link_gmaps': 'https://maps.google.com/?q=Tentena',
        }),
      );
      expect(hotel.wilayah, 'Poso');
      expect(hotel.harga, 250000);
      expect(hotel.chips.length, 2);
      expect(hotel.telepon, '628123456789');
    },
  );
}
