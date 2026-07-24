import 'package:flutter/material.dart';
import 'package:restep/common/constants/collors.dart';
import 'package:restep/common/widgets/separator_widget.dart';
import 'package:restep/config/app_asset.dart';
import 'package:restep/presentation/screens/activity_log/activity_log.dart';
import 'package:restep/presentation/screens/co2e_report/co2e_report_screen.dart';
import 'package:restep/presentation/screens/dashboard/index.dart';
import 'package:restep/presentation/screens/login/index.dart';
import 'package:restep/presentation/screens/my_bags/index.dart';
import 'package:restep/presentation/screens/notifications/index.dart';
import 'package:restep/presentation/screens/settings/index.dart';
import 'package:restep/presentation/screens/store_details/index.dart';
import 'package:restep/presentation/screens/support/index.dart';
import 'package:restep/presentation/screens/tutorials/index.dart';
import 'package:restep/presentation/screens/welcome_screen/index.dart';

class RecycleScreen extends StatefulWidget {
  const RecycleScreen({super.key});

  @override
  State<RecycleScreen> createState() => _RecycleScreenState();
}

class _RecycleScreenState extends State<RecycleScreen> {
  final GlobalKey _avatarKey = GlobalKey();
  @override
  Widget build(BuildContext context) {final stores = [
  {
    'dist': '0.3 km',
    'city': 'Amsterdam',
    'img':
        'https://images.unsplash.com/photo-1534723452862-4c874018d66d?w=400&q=80',
  },
  {
    'dist': '0.5 km',
    'city': 'Rotterdam',
    'img':
        'https://images.unsplash.com/photo-1604719312566-8912e9227c6a?w=400&q=80',
  },
  {
    'dist': '0.8 km',
    'city': 'Utrecht',
    'img':
        'https://images.unsplash.com/photo-1542838132-92c53300491e?w=400&q=80',
  },
  {
    'dist': '1.2 km',
    'city': 'The Hague',
    'img':
        'https://images.unsplash.com/photo-1578916171728-46686eac8d58?w=400&q=80',
  },
  {
    'dist': '1.7 km',
    'city': 'Eindhoven',
    'img':
        'https://images.unsplash.com/photo-1555529669-e69e7aa0ba9a?w=400&q=80',
  },
  {
    'dist': '2.5 km',
    'city': 'Groningen',
    'img':
        'https://images.unsplash.com/photo-1583258292688-d0213dc5a3a8?w=400&q=80',
  },
];

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF0F0EB),
        body: Column(
          children: [
            // AppBar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Text(
                    'In De Buurt',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF111111),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.07),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.info_outline_rounded,
                        size: 18,
                        color: Color(0xFF374151),
                      ),
                    ),
                  ),
              
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotificationsScreen(),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: ConstColors.white,
                              width: 5,
                            ),
                            color: ConstColors.white,
                          ),
                          padding: EdgeInsets.all(2),
                          child: Icon(
                            Icons.notifications_none_outlined,
                            size: 35,
                          ),
                        ),
                      ),
                      SeparatorWidget.width10(),
                      GestureDetector(
                        onTap: () => _showProfileMenu(), // no context needed
                        child: Container(
                          key: _avatarKey, // ← add this key
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: ConstColors.green,
                              width: 2,
                            ),
                          ),
                          child: const CircleAvatar(
                            radius: 22,
                            backgroundImage: NetworkImage(
                              'https://i.pravatar.cc/100?img=12',
                            ),
                            backgroundColor: Color(0xFFE5E7EB),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section title
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 14),
                      child: Text(
                        'In De Buurt',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF111111),
                        ),
                      ),
                    ),
                    // Grid
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GridView.builder(
                        padding: const EdgeInsets.only(bottom: 90),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: stores.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 0.85,
                            ),
                        itemBuilder: (_, i) => _storeCard(
                          context,
                          stores[i]['img']!,
                          stores[i]['dist']!,
                          stores[i]['city']!
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProfileMenu() {
    final RenderBox renderBox =
        _avatarKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    showMenu(
      context: context,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      position: RelativeRect.fromLTRB(
        offset.dx, // left — aligns with avatar left edge
        offset.dy + size.height + 8, // top — just below the avatar
        offset.dx + size.width, // right
        0,
      ),
      items: [
        _buildPopupHeader(),
        _buildDividerItem(),
        _buildPopupItem(
          icon: Icons.qr_code,
          iconBg: const Color(0xFFD1FAE5),
          iconColor: ConstColors.green,
          title: 'Show My QR',
          subtitle: 'Recent actions',
          value: 'activity',
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => const MyQRCodeModal(),
            );
          },
        ),
        _buildPopupItem(
          icon: Icons.shopping_bag_outlined,
          iconBg: const Color(0xFFD1FAE5),
          iconColor: ConstColors.green,
          title: 'My Shopping Bags',
          subtitle: 'Circular bags',
          value: 'activity',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyBagsScreen()),
            );
          },
        ),
        _buildPopupItem(
          icon: Icons.access_time_outlined,
          iconBg: const Color(0xFFD1FAE5),
          iconColor: ConstColors.green,
          title: 'Activity log',
          subtitle: 'Recent actions',
          value: 'activity',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ActivityLogScreen()),
            );
          },
        ),
        _buildPopupItem(
          icon: Icons.chat_bubble_outline,
          iconBg: const Color(0xFFD1FAE5),
          iconColor: ConstColors.green,
          title: 'Tutorials',
          subtitle: 'How to use',
          value: 'tutorials',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OnboardingScreen()),
            );
          },
        ),
        _buildPopupItem(
          icon: Icons.eco,
          iconBg: const Color(0xFFD1FAE5),
          iconColor: ConstColors.green,
          title: 'CO2E Report',
          subtitle: 'Your impact',
          value: 'activity',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Co2eReportScreen2()),
            );
          },
        ),
        _buildPopupItem(
          icon: Icons.settings_outlined,
          iconBg: const Color(0xFFD1FAE5),
          iconColor: ConstColors.green,
          title: 'Settings',
          subtitle: 'Account, security',
          value: 'settings',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsScreen()),
            );
          },
        ),
        _buildPopupItem(
          icon: Icons.headset_mic_outlined,
          iconBg: const Color(0xFFD1FAE5),
          iconColor: ConstColors.green,
          title: 'Support',
          subtitle: 'Helpdesk',
          value: 'support',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SupportScreen()),
            );
          },
        ),
        _buildPopupItem(
          icon: Icons.logout,
          iconBg: const Color(0xFFFEE2E2),
          iconColor: const Color(0xFFEF4444),
          title: 'Sign Out',
          subtitle: 'Sign out from app',
          titleColor: const Color(0xFFEF4444),
          value: 'signout',
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
              (route) => true,
            );
          },
        ),
      ],
    ).then((value) {
      if (value == null) return;
      switch (value) {
        case 'activity': /* navigate */
          break;
        case 'tutorials': /* navigate */
          break;
        case 'settings': /* navigate */
          break;
        case 'support': /* navigate */
          break;
        case 'signout': /* sign out logic */
          break;
      }
    });
  }

  PopupMenuItem _buildPopupHeader() {
    return PopupMenuItem(
      enabled: false,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage('https://i.pravatar.cc/100?img=12'),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'John Doe',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111111),
                ),
              ),
              SizedBox(height: 2),
              Text(
                'johndoe@gmail.com',
                style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
              ),
              Text(
                '+31 63173912030',
                style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  PopupMenuItem _buildDividerItem() {
    return PopupMenuItem(
      enabled: false,
      height: 1,
      padding: EdgeInsets.zero,
      child: const Divider(height: 1),
    );
  }

  PopupMenuItem _buildPopupItem({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String value,
    Color? titleColor,
    onTap,
  }) {
    return PopupMenuItem(
      value: value,
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: titleColor ?? const Color(0xFF111111),
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, size: 16, color: Color(0xFFD1D5DB)),
        ],
      ),
    );
  }

  Widget _impactStat(String label, String value, String? unit) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF9CA3AF),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF111111),
                  ),
                ),
                if (unit != null)
                  TextSpan(
                    text: ' $unit',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF6B7280),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _storeCard(context, String imgUrl, String dist, String city) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StoreDetailsScreen()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(14),
                ),
                child: Image.network(
                  imgUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: const Color(0xFFE5E7EB),
                    child: const Icon(Icons.store, color: Color(0xFF9CA3AF)),
                  ),
                ),
              ),
            ),
            // Info
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: Image.asset(IconsAsset.plus, height: 12,),
                      ),
                      const Text(
                        'PLUS',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF111111),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        dist,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.map_outlined,
                            size: 12,
                            color: ConstColors.green,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            city,
                            style: TextStyle(
                              fontSize: 11,
                              color: ConstColors.green,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
