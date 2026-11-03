import 'package:flutter/material.dart';

/// Halaman Sambutan (Opening Screen) sesuai PRD v1.1.
/// Tampil tiap kali aplikasi dibuka sebelum masuk Home.
/// Memuat logo, nama Berani Kamaimo, tagline, pilihan bahasa,
/// Ranking Asal Turis (Top 5 Negara), dan tombol besar "Masuk".
class HalamanSambutan extends StatelessWidget {
  const HalamanSambutan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              // Logo / Icon
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A3A2A),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(
                  Icons.landscape,
                  size: 48,
                  color: Color(0xFF10B981),
                ),
              ),
              const SizedBox(height: 24),
              // Nama Aplikasi
              const Text(
                'Berani Kamaimo',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A3A2A),
                ),
              ),
              const SizedBox(height: 8),
              // Tagline
              const Text(
                'Menunggu petualanganmu di jantung indonesia',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF616E66),
                ),
              ),
              const SizedBox(height: 32),
              // Ranking Asal Turis Placeholder (M2/M1)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF1A3A2A).withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Top 5 Negara Asal Wisatawan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A3A2A),
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Memuat data kunjungan...',
                      style: TextStyle(color: Color(0xFF616E66)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // Tombol Masuk
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    // Navigasi ke UserShell / Home
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  child: const Text(
                    'Masuk',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
