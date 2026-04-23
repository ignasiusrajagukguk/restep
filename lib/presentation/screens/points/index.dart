import 'package:flutter/material.dart';
import 'package:restep/common/constants/collors.dart';
import 'package:restep/common/widgets/separator_widget.dart';
import 'package:restep/config/app_asset.dart';
import 'package:restep/presentation/screens/dashboard/index.dart';
import 'package:restep/presentation/screens/earning_details/index.dart';
import 'package:restep/presentation/screens/earnings/index.dart';
import 'package:restep/presentation/screens/redeemed/index.dart';
import 'package:restep/presentation/screens/redeemed_details/confirm_redemption.dart';
import 'package:restep/presentation/screens/redeemed_details/voucher_issued.dart';
import 'package:restep/presentation/screens/reward_catalog/index.dart';
import 'package:restep/presentation/screens/settings/index.dart';
import 'package:restep/presentation/screens/tutorials/index.dart';
import 'package:restep/presentation/screens/welcome_screen/index.dart';
import 'package:restep/presentation/widgets/points.dart';

class PointsScreen extends StatefulWidget {
  const PointsScreen({super.key});

  @override
  State<PointsScreen> createState() => _PointsScreenState();
}

class _PointsScreenState extends State<PointsScreen> {
  final GlobalKey _avatarKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
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
                    'ESG Points',
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
                      Container(
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
                padding: const EdgeInsets.only(bottom: 90),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PointsCard(),
                    _buildEarningOverview(),
                    _buildRedemptionHistory(),
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
          icon: Icons.access_time_outlined,
          iconBg: const Color(0xFFD1FAE5),
          iconColor: const Color(0xFF10B981),
          title: 'Show My QR',
          subtitle: 'Recent actions',
          value: 'activity',
          onTap: (){
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => const MyQRCodeModal(),
            );
          }
        ),
        _buildPopupItem(
          icon: Icons.access_time_outlined,
          iconBg: const Color(0xFFD1FAE5),
          iconColor: const Color(0xFF10B981),
          title: 'Activity log',
          subtitle: 'Recent actions',
          value: 'activity',
        ),
        _buildPopupItem(
          icon: Icons.chat_bubble_outline,
          iconBg: const Color(0xFFD1FAE5),
          iconColor: const Color(0xFF10B981),
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
          icon: Icons.settings_outlined,
          iconBg: const Color(0xFFD1FAE5),
          iconColor: const Color(0xFF10B981),
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
          iconColor: const Color(0xFF10B981),
          title: 'Support',
          subtitle: 'Helpdesk',
          value: 'support',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsScreen()),
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

  String _formatDate(DateTime dt) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '${dt.day} ${months[dt.month - 1]} · $h:$m';
  }

  // ── Earning Overview ────────────────────────────────────────────────────────
  Widget _buildEarningOverview() {
    final earnings = [
      {
        'title': 'Recycle Shoes',
        'sub': 'PLUS Supermarket',
        'pts': '+250',
        'date': DateTime(2026, 4, 1, 9, 10),
        'img': ImageAsset.item1,
        'isAsset': true,
      },
      {
        'title': 'Shopping with bag',
        'sub': 'PLUS Supermarket',
        'pts': '+120',
        'date': DateTime(2026, 4, 1, 9, 10),
        'img': ImageAsset.shopping,
        'isAsset': false,
      },
      {
        'title': 'Speciale Ambiedingen',
        'sub': 'PLUS Supermarket',
        'pts': '+20',
        'date': DateTime(2026, 4, 1, 9, 10),
        'img': ImageAsset.item3,
        'isAsset': true,
      },
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Latest Earnings',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111111),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EarningsScreen()),
                  );
                },
                child: Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: ConstColors.green,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: earnings.asMap().entries.map((e) {
                final i = e.key;
                final item = e.value;
                final isLast = i == earnings.length - 1;
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EarningDetailsScreen(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      border: isLast
                          ? null
                          : const Border(
                              bottom: BorderSide(color: Color(0xFFF3F4F6)),
                            ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              item['img'] as String,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title'] as String,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF111111),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                item['sub'] as String,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF9CA3AF),
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                _formatDate(
                                  item['date'] as DateTime,
                                ), // ← date + time here
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFFB0B7BF),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          height: 40,
                          width: 1,
                          color: Color(0xFFD9DDDF),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              item['pts'] as String,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: ConstColors.green,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'ESG pts',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFF9CA3AF),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // ── Redemption History ──────────────────────────────────────────────────────
  Widget _buildRedemptionHistory() {
    final history = [
      {
        'title': 'Premium Circular Bag',
        'sub': 'Expired in 5 days',
        'subColor': const Color(0xFFF59E0B),
        'pts': '-100',
        'date': '10 Feb 2026',
        'ptsColor': const Color(0xFFEF4444),
        'img':
            'https://images.unsplash.com/photo-1590874103328-eac38a683ce7?w=200&q=80',
      },
      {
        'title': 'Premium Circular Bag',
        'sub': 'Redeemed',
        'subColor': const Color(0xFF9CA3AF),
        'pts': '-200',
        'date': '13 Feb 2026',
        'ptsColor': const Color(0xFFEF4444),
        'img':
            'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=200&q=80',
      },
      {
        'title': 'Premium Circular Bag',
        'sub': 'Expired',
        'subColor': const Color(0xFFEF4444),
        'pts': '+100',
        'date': '10 Feb 2026',
        'ptsColor': ConstColors.green,
        'img':
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&q=80',
      },
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Redeemed',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111111),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RedeemedScreen()),
                  );
                },
                child: Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: ConstColors.green,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: history.asMap().entries.map((e) {
                final i = e.key;
                final item = e.value;
                final isLast = i == history.length - 1;
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductPassportScreen(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      border: isLast
                          ? null
                          : const Border(
                              bottom: BorderSide(color: Color(0xFFF3F4F6)),
                            ),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            item['img'] as String,
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 48,
                              height: 48,
                              color: const Color(0xFFF3F4F6),
                              child: const Icon(
                                Icons.card_giftcard,
                                color: Color(0xFF9CA3AF),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title'] as String,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF111111),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                item['sub'] as String,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: item['subColor'] as Color,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          height: 40,
                          width: 1,
                          color: Color(0xFFD9DDDF),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              item['pts'] as String,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: item['ptsColor'] as Color,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              item['date'] as String,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFF9CA3AF),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
