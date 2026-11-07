import 'package:flutter/material.dart';
import 'package:berani_kamaimo/core/theme/app_colors.dart';

class DashboardScreen extends StatefulWidget {
  final VoidCallback? onNavigateToTab;
  final ValueChanged<int>? onNavigateToTabIndex;

  const DashboardScreen({
    super.key,
    this.onNavigateToTab,
    this.onNavigateToTabIndex,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  void _goToTab(int tabIndex) {
    if (widget.onNavigateToTabIndex != null) {
      widget.onNavigateToTabIndex!(tabIndex);
    } else {
      widget.onNavigateToTab?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Snapshot statistik konten (jumlah entitas) + index tab di AdminShell
    final conteStats = [
      {
        'label': 'Desa Wisata',
        'count': '43',
        'icon': Icons.map_rounded,
        'color': AppColors.pine700,
        'tabIndex': 1,
      },
      {
        'label': 'Jalur Desa',
        'count': '31',
        'icon': Icons.alt_route_rounded,
        'color': AppColors.pine600,
        'tabIndex': 2,
      },
      {
        'label': 'Event & Festival',
        'count': '12',
        'icon': Icons.event_rounded,
        'color': AppColors.emerald500,
        'tabIndex': 3,
      },
      {
        'label': 'Paket Wisata',
        'count': '8',
        'icon': Icons.card_travel_rounded,
        'color': AppColors.pine500,
        'tabIndex': 4,
      },
      {
        'label': 'Kuliner Khas',
        'count': '16',
        'icon': Icons.restaurant_rounded,
        'color': AppColors.emerald600,
        'tabIndex': 5,
      },
      {
        'label': 'Hotel & Penginapan',
        'count': '34',
        'icon': Icons.hotel_rounded,
        'color': AppColors.pine400,
        'tabIndex': 7,
      },
    ];

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header branding ──
            Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.pine900, AppColors.pine800],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.pine900.withValues(alpha: 0.35),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.pine600,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(Icons.admin_panel_settings_outlined,
                            color: Colors.white, size: 28),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Portal Pengelola Berani Kamaimo',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                fontFamily: 'PlusJakartaSans',
                              ),
                            ),
                            Text(
                              'Dinas Pariwisata Provinsi Sulawesi Tengah',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white70,
                                fontFamily: 'PlusJakartaSans',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Status badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle, color: Colors.green, size: 14),
                        SizedBox(width: 6),
                        Text(
                          'Sistem Aktif • Versi 0.1.0',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // ── Seksi 1: Ringkasan Konten Pariwisata ──
            const Text(
              'Ringkasan Konten Pariwisata',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
                fontFamily: 'PlusJakartaSans',
              ),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width < 600 ? 2 : 3,
                childAspectRatio: 0.95,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: conteStats.length,
              itemBuilder: (_, index) {
                final stat = conteStats[index];
                return _buildContentStatCard(
                  label: stat['label'] as String,
                  count: stat['count'] as String,
                  iconData: stat['icon'] as IconData,
                  gradientColor: stat['color'] as Color,
                  onTap: () => _goToTab(stat['tabIndex'] as int),
                );
              },
            ),
            const SizedBox(height: 32),

            // ── Seksi 2: Pintasan Manajemen Cepat ──
            const Text(
              'Pintasan Manajemen',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
                fontFamily: 'PlusJakartaSans',
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _buildQuickActionButton(
                  label: 'Tambah Desa Wisata',
                  icon: Icons.add_circle_outlined,
                  color: AppColors.pine700,
                  onPressed: () => _goToTab(1),
                ),
                _buildQuickActionButton(
                  label: 'Kelola Event & Festival',
                  icon: Icons.calendar_today,
                  color: AppColors.emerald500,
                  onPressed: () => _goToTab(3),
                ),
                _buildQuickActionButton(
                  label: 'Publish Paket Wisata',
                  icon: Icons.publish,
                  color: AppColors.pine500,
                  onPressed: () => _goToTab(4),
                ),
                _buildQuickActionButton(
                  label: 'Moderasi Ulasan',
                  icon: Icons.rate_review,
                  color: AppColors.error,
                  onPressed: () => _goToTab(8),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // ── Seksi 3: Panduan & Kebijakan Kurasi Konten ──
            _buildGuidelinesSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildContentStatCard({
    required String label,
    required String count,
    required IconData iconData,
    required Color gradientColor,
    required VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: gradientColor.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: gradientColor.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: gradientColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(iconData, size: 32, color: gradientColor),
                ),
                const SizedBox(height: 12),
                Text(
                  count,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: gradientColor,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                    fontFamily: 'PlusJakartaSans',
                    height: 1.3,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActionButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        side: BorderSide(color: color, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        minimumSize: const Size.fromHeight(56),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 22, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
                fontFamily: 'PlusJakartaSans',
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGuidelinesSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.pine500.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Panduan Kurasi Konten',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
              fontFamily: 'PlusJakartaSans',
            ),
          ),
          const SizedBox(height: 16),
          _guidelineRow(
            icon: Icons.image,
            title: 'Format Foto',
            detail: 'Minimal 1280 × 720 px (16:9). Gambar jernih, tanpa watermark besar.',
          ),
          _guidelineRow(
            icon: Icons.translate,
            title: 'Bahasa',
            detail: 'Semua deskripsi harus memiliki field _id (Indonesia) dan _en (Inggris). Fallback ke _id bila _en kosong.',
          ),
          _guidelineRow(
            icon: Icons.location_on,
            title: 'Koordinat GPS',
            detail: 'Pastikan latitude & longitude sesuai lokasi literal di peta interaktif. Jangan kosongkan.',
          ),
          _guidelineRow(
            icon: Icons.phone,
            title: 'WhatsApp Deeplink',
            detail: 'Gunakan format internasional (628...). Pastikan link bekerja saat dipublikasikan.',
          ),
        ],
      ),
    );
  }

  Widget _guidelineRow({
    required IconData icon,
    required String title,
    required String detail,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.pine500.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: AppColors.pine500),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  detail,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
