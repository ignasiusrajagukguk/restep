import 'package:flutter/material.dart';
import 'package:restep/common/constants/collors.dart';
import 'package:restep/config/app_asset.dart';
import 'package:restep/presentation/screens/dashboard/index.dart';
import 'package:restep/presentation/screens/points/index.dart';
import 'package:restep/presentation/screens/qrcode/index.dart';
import 'package:restep/presentation/screens/scanner/index.dart';
import 'package:restep/presentation/screens/shop/shop_screen.dart';
import 'package:restep/presentation/screens/recycle/recycle_screen.dart';

/// Root shell — holds the bottom nav and swaps content screens.
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = [
    DashboardBody(), // index 0 – Home
    RecycleBody(), // index 1 – Recycle
    SizedBox(), // index 2 – Scan (FAB, no full screen)
    PointsBody(), // index 3 – Points
    ProfileBody(), // index 4 – Profile
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF0F0EB),
        body: SafeArea(
          top: false,
          bottom: true,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // Page content
              IndexedStack(
                index: _selectedIndex == 2 ? 0 : _selectedIndex,
                children: _screens,
              ),
              // Bottom nav overlay
              _buildBottomNav(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFF3F4F6))),
      ),
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(0, IconsAsset.home, 'Home', activeIconPath: IconsAsset.homeActive),
          _navItem(1, IconsAsset.recycle, 'Nearby'),
          // Centre FAB
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ScannerPage()),
            ),
            child: Container(
              width: 56,
              height: 56,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: ConstColors.green,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: ConstColors.green.withValues(alpha: 0.4),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.qr_code_scanner_rounded,
                color: Colors.white,
                size: 26,
              ),
            ),
          ),
          _navItem(3, IconsAsset.points, 'Points', activeIconPath: IconsAsset.pointsActive),
          _navItem(4, IconsAsset.cart, 'Shop',activeIconPath: IconsAsset.cartActive),
        ],
      ),
    );
  }

  Widget _navItem(
    int index,
    String iconPath,
    String label, {
    String? activeIconPath,
  }) {
    final isActive = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              isActive ? activeIconPath ?? iconPath : iconPath,
              height: 24,
              color: isActive ? ConstColors.green : const Color(0xFF9CA3AF),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: isActive ? ConstColors.green : const Color(0xFF9CA3AF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Thin wrappers so screens can be used inside IndexedStack ─────────────────
// Each "Body" is the scrollable content WITHOUT a bottom nav of its own.
// The MainScreen provides the single bottom nav for all screens.

class DashboardBody extends StatelessWidget {
  const DashboardBody({super.key});
  @override
  Widget build(BuildContext context) => const DashboardScreen();
}

class RecycleBody extends StatelessWidget {
  const RecycleBody({super.key});
  @override
  Widget build(BuildContext context) => const RecycleScreen();
}

class PointsBody extends StatelessWidget {
  const PointsBody({super.key});
  @override
  Widget build(BuildContext context) => const PointsScreen();
}

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});
  @override
  Widget build(BuildContext context) => const ShopScreen();
}
