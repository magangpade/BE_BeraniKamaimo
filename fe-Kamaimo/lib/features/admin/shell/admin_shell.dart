import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/constants.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../models/admin_user.dart';
import '../dashboard/dashboard_screen.dart';
import '../crud/crud_screen.dart';
import '../profil/profil_dialog.dart';
import 'widgets/date_time_widget.dart';

class AdminShell extends StatefulWidget {
  const AdminShell({super.key});

  @override
  State<AdminShell> createState() => _AdminShellState();
}

class _AdminShellState extends State<AdminShell> {
  int _selectedIndex = 0;
  AdminUser? _userOverride;

  AdminUser _currentAdmin(BuildContext context) {
    if (_userOverride != null) return _userOverride!;
    final fromRepo = context.read<AuthRepository>().currentUser;
    return fromRepo ??
        const AdminUser(
          id: 1,
          nama_Lengkap: 'Super Admin Kamaimo',
          username: 'superadmin',
          jenis_kelamin: 'Laki-laki',
          role: 'superAdmin',
        );
  }

  final _menuItems = [
    (icon: Icons.dashboard_outlined, label: 'Dashboard', requiresSuperAdmin: false),
    (icon: Icons.map_outlined, label: 'Desa Wisata', requiresSuperAdmin: false),
    (icon: Icons.alt_route_outlined, label: 'Jalur Desa', requiresSuperAdmin: false),
    (icon: Icons.event_outlined, label: 'Atraksi & Event', requiresSuperAdmin: false),
    (icon: Icons.card_travel_outlined, label: 'Paket Wisata', requiresSuperAdmin: false),
    (icon: Icons.restaurant_outlined, label: 'Kuliner', requiresSuperAdmin: false),
    (icon: Icons.store_outlined, label: 'Rumah Makan', requiresSuperAdmin: false),
    (icon: Icons.hotel_outlined, label: 'Hotel', requiresSuperAdmin: false),
    (icon: Icons.rate_review_outlined, label: 'Ulasan Pengunjung', requiresSuperAdmin: false),
    (icon: Icons.admin_panel_settings_outlined, label: 'Super Admin', requiresSuperAdmin: true),
  ];

  void _logout() {
    final auth = context.read<AuthRepository>();
    auth.logout();
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppConstants.routeHome,
      (r) => false,
    );
  }

  void _showProfile(AdminUser adminUser) {
    showDialog(
      context: context,
      builder: (_) => ProfilDialog(
        user: adminUser,
        onLogout: _logout,
        onUpdated: (updated) {
          setState(() => _userOverride = updated);
        },
      ),
    );
  }

  Widget _buildContent() {
    switch (_selectedIndex) {
      case 0:
        return DashboardScreen(
          onNavigateToTab: () {
            setState(() => _selectedIndex = 1);
          },
          onNavigateToTabIndex: (tabIndex) {
            setState(() => _selectedIndex = tabIndex);
          },
        );
      case 1:
        return const CrudScreen(
          title: 'Desa Wisata',
          entityType: 'desaWisata',
          initialData: [],
        );
      case 2:
        return const CrudScreen(
          title: 'Jalur Desa',
          entityType: 'jarakDesa',
          initialData: [],
        );
      case 3:
        return const CrudScreen(
          title: 'Atraksi & Event',
          entityType: 'atraksi',
          initialData: [],
        );
      case 4:
        return const CrudScreen(
          title: 'Paket Wisata',
          entityType: 'tourPackage',
          initialData: [],
        );
      case 5:
        return const CrudScreen(
          title: 'Kuliner',
          entityType: 'kuliner',
          initialData: [],
        );
      case 6:
        return const CrudScreen(
          title: 'Rumah Makan',
          entityType: 'rumahMakan',
          initialData: [],
        );
      case 7:
        return const CrudScreen(
          title: 'Hotel',
          entityType: 'hotel',
          initialData: [],
        );
      case 8:
        return const CrudScreen(
          title: 'Ulasan Pengunjung',
          entityType: 'ulasan',
          initialData: [],
        );
      case 9:
        return const CrudScreen(
          title: 'Super Admin',
          entityType: 'adminUser',
          initialData: [],
        );
      default:
        return DashboardScreen(
          onNavigateToTab: () {
            setState(() => _selectedIndex = 1);
          },
          onNavigateToTabIndex: (tabIndex) {
            setState(() => _selectedIndex = tabIndex);
          },
        );
    }
  }

  Widget _buildSidebar(AdminUser adminUser, bool isSuperAdmin, {required bool isDrawer}) {
    return Container(
      width: 260,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.pine800, AppColors.pine900],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.pine600,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.landscape_rounded,
                        color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text('Admin Panel',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            fontFamily: 'PlusJakartaSans')),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: DateTimeWidget(),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _menuItems.length,
                itemBuilder: (ctx, i) {
                  final item = _menuItems[i];
                  if (item.requiresSuperAdmin && !isSuperAdmin) {
                    return const SizedBox.shrink();
                  }
                  final active = i == _selectedIndex;
                  return _menuItem(item.icon, item.label, active, () {
                    setState(() => _selectedIndex = i);
                    if (isDrawer) {
                      Navigator.of(context).pop();
                    }
                  });
                },
              ),
            ),
            const Divider(color: Colors.white24, height: 1),
            const SizedBox(height: 8),
            _buildAccountDropdown(adminUser),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final adminUser = _currentAdmin(context);
    final isSuperAdmin = adminUser.role.toLowerCase() == 'superadmin';
    final isWide = MediaQuery.of(context).size.width >= 840;

    return Scaffold(
      appBar: isWide
          ? null
          : AppBar(
              title: Text(_menuItems[_selectedIndex].label,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'PlusJakartaSans')),
              backgroundColor: AppColors.pine800,
              foregroundColor: Colors.white,
              elevation: 0,
            ),
      drawer: isWide
          ? null
          : Drawer(child: _buildSidebar(adminUser, isSuperAdmin, isDrawer: true)),
      body: Row(
        children: [
          if (isWide) _buildSidebar(adminUser, isSuperAdmin, isDrawer: false),
          Expanded(
            child: Container(
              color: AppColors.background,
              child: _buildContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuItem(IconData icon, String label, bool active, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: Material(
        color: active ? Colors.white.withValues(alpha: 0.15) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          dense: true,
          leading: Icon(icon, size: 19, color: Colors.white),
          title: Text(label,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                  color: Colors.white,
                  fontFamily: 'PlusJakartaSans')),
          onTap: onTap,
        ),
      ),
    );
  }

  Widget _buildAccountDropdown(AdminUser adminUser) {
    final initial = adminUser.nama_Lengkap.isNotEmpty
        ? adminUser.nama_Lengkap[0].toUpperCase()
        : 'A';
    final isMale = !adminUser.jenis_kelamin.toLowerCase().startsWith('p');

    return PopupMenuButton<String>(
      offset: const Offset(0, -110),
      color: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: isMale ? AppColors.emerald500 : Colors.pink.shade400,
              child: Text(initial,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      fontFamily: 'PlusJakartaSans')),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    adminUser.nama_Lengkap,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'PlusJakartaSans'),
                  ),
                  Text(
                    adminUser.role,
                    style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 10,
                        fontFamily: 'PlusJakartaSans'),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_drop_up, color: Colors.white70, size: 20),
          ],
        ),
      ),
      itemBuilder: (_) => [
        const PopupMenuItem(
          value: 'profile',
          child: Row(
            children: [
              Icon(Icons.person_outline, size: 18, color: AppColors.textPrimary),
              SizedBox(width: 10),
              Text('Lihat Profil',
                  style: TextStyle(fontFamily: 'PlusJakartaSans')),
            ],
          ),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem(
          value: 'logout',
          child: Row(
            children: [
              Icon(Icons.logout_outlined, size: 18, color: AppColors.error),
              SizedBox(width: 10),
              Text('Logout',
                  style: TextStyle(
                      color: AppColors.error, fontFamily: 'PlusJakartaSans')),
            ],
          ),
        ),
      ],
      onSelected: (val) {
        if (val == 'profile') {
          _showProfile(adminUser);
        } else if (val == 'logout') {
          _logout();
        }
      },
    );
  }
}
