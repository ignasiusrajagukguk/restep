import 'package:flutter/material.dart';
import 'package:restep/common/constants/collors.dart';
import 'package:restep/config/app_asset.dart';
import 'package:restep/presentation/screens/earning_details/index.dart';
import 'package:restep/presentation/widgets/points.dart';

// ─── Data ───────────────────────────────────────────────────────────────────

class EarningItem {
  final String title;
  final String sub;
  final int pts;
  final DateTime date;
  final String img;
  final bool isAsset;

  const EarningItem({
    required this.title,
    required this.sub,
    required this.pts,
    required this.date,
    required this.img,
    this.isAsset = false,
  });
}
// ─── Data ────────────────────────────────────────────────────────────────────
// Total: 3,480 ESG pts

final List<EarningItem> allEarnings = [
  // ── April 2026 ──
  EarningItem(
    title: 'Recycle Shoes',
    sub: 'PLUS Supermarket',
    pts: 250,
    date: DateTime(2026, 4, 1, 9, 10),
    img: ImageAsset.shopping,
    isAsset: true,
  ),
  EarningItem(
    title: 'Speciale Ambiedingen',
    sub: 'PLUS Supermarket',
    pts: 20,
    date: DateTime(2026, 4, 1, 8, 45),
    img: ImageAsset.shopping,
    isAsset: true,
  ),

  // ── March 2026 ──
  EarningItem(
    title: 'Recycle Electronics',
    sub: 'GreenDrop Station',
    pts: 400,
    date: DateTime(2026, 3, 28, 14, 0),
    img: ImageAsset.item1,
    isAsset: true,
  ),
  EarningItem(
    title: 'Shopping',
    sub: 'PLUS Supermarket',
    pts: 120,
    date: DateTime(2026, 3, 25, 11, 30),
    img: ImageAsset.shopping,
    isAsset: true,
  ),
  EarningItem(
    title: 'Eco Purchase',
    sub: 'EcoMart',
    pts: 90,
    date: DateTime(2026, 3, 20, 10, 15),
    img: ImageAsset.item3,
    isAsset: true,
  ),
  EarningItem(
    title: 'Speciale Ambiedingen',
    sub: 'Nike Store',
    pts: 20,
    date: DateTime(2026, 3, 18, 9, 0),
    img: ImageAsset.item3,
    isAsset: true,
  ),
  EarningItem(
    title: 'Recycle Cardboard',
    sub: 'GreenDrop Station',
    pts: 60,
    date: DateTime(2026, 3, 14, 13, 45),
    img: ImageAsset.item1,
    isAsset: true,
  ),
  EarningItem(
    title: 'Shopping',
    sub: 'EcoMart',
    pts: 110,
    date: DateTime(2026, 3, 10, 15, 20),
    img: ImageAsset.shopping,
    isAsset: true,
  ),
  EarningItem(
    title: 'Recycle Shoes',
    sub: 'PLUS Supermarket',
    pts: 250,
    date: DateTime(2026, 3, 5, 10, 0),
    img: ImageAsset.shopping,
    isAsset: true,
  ),

  // ── February 2026 ──
  EarningItem(
    title: 'Recycle Shoes',
    sub: 'PLUS Supermarket',
    pts: 250,
    date: DateTime(2026, 2, 18, 10, 30),
    img: ImageAsset.shopping,
    isAsset: true,
  ),
  EarningItem(
    title: 'Shopping',
    sub: 'PLUS Supermarket',
    pts: 120,
    date: DateTime(2026, 2, 16, 14, 5),
    img: ImageAsset.shopping,
    isAsset: true,
  ),
  EarningItem(
    title: 'Speciale Ambiedingen',
    sub: 'PLUS Supermarket',
    pts: 20,
    date: DateTime(2026, 2, 15, 9, 15),
    img: ImageAsset.shopping,
    isAsset: true,
  ),
  EarningItem(
    title: 'Recycle Bottle',
    sub: 'GreenDrop Station',
    pts: 80,
    date: DateTime(2026, 2, 12, 11, 0),
    img: ImageAsset.item1,
    isAsset: true,
  ),
  EarningItem(
    title: 'Eco Purchase',
    sub: 'EcoMart',
    pts: 90,
    date: DateTime(2026, 2, 8, 16, 30),
    img: ImageAsset.item3,
    isAsset: true,
  ),
  EarningItem(
    title: 'Recycle Cardboard',
    sub: 'GreenDrop Station',
    pts: 60,
    date: DateTime(2026, 2, 4, 8, 0),
    img: ImageAsset.item1,
    isAsset: true,
  ),

  // ── January 2026 ──
  EarningItem(
    title: 'Recycle Electronics',
    sub: 'GreenDrop Station',
    pts: 400,
    date: DateTime(2026, 1, 28, 13, 0),
    img: ImageAsset.item1,
    isAsset: true,
  ),
  EarningItem(
    title: 'Shopping',
    sub: 'PLUS Supermarket',
    pts: 120,
    date: DateTime(2026, 1, 22, 10, 45),
    img: ImageAsset.shopping,
    isAsset: true,
  ),
  EarningItem(
    title: 'Eco Purchase',
    sub: 'EcoMart',
    pts: 90,
    date: DateTime(2026, 1, 18, 15, 30),
    img: ImageAsset.item3,
    isAsset: true,
  ),
  EarningItem(
    title: 'Speciale Ambiedingen',
    sub: 'Nike Store',
    pts: 20,
    date: DateTime(2026, 1, 15, 9, 0),
    img: ImageAsset.item3,
    isAsset: true,
  ),
  EarningItem(
    title: 'Recycle Bottle',
    sub: 'GreenDrop Station',
    pts: 80,
    date: DateTime(2026, 1, 10, 11, 15),
    img: ImageAsset.item1,
    isAsset: true,
  ),
  EarningItem(
    title: 'Recycle Shoes',
    sub: 'Nike Store',
    pts: 250,
    date: DateTime(2026, 1, 5, 14, 0),
    img: ImageAsset.item1,
    isAsset: true,
  ),
  EarningItem(
    title: 'Recycle Cardboard',
    sub: 'GreenDrop Station',
    pts: 60,
    date: DateTime(2026, 1, 2, 9, 30),
    img: ImageAsset.item1,
    isAsset: true,
  ),

  // ── December 2025 ──
  EarningItem(
    title: 'Recycle Electronics',
    sub: 'GreenDrop Station',
    pts: 400,
    date: DateTime(2025, 12, 30, 14, 0),
    img: ImageAsset.item1,
    isAsset: true,
  ),
  EarningItem(
    title: 'Shopping',
    sub: 'EcoMart',
    pts: 110,
    date: DateTime(2025, 12, 24, 12, 0),
    img: ImageAsset.shopping,
    isAsset: true,
  ),
];

// Quick check: 250+20 + 400+120+90+20+60+110+250 + 250+120+20+80+90+60 + 400+120+90+20+80+250+60 + 400+110 = 3,480 ✓

// ─── Helpers ─────────────────────────────────────────────────────────────────

Map<String, List<EarningItem>> _groupByMonth(List<EarningItem> items) {
  final Map<String, List<EarningItem>> map = {};
  final sorted = [...items]..sort((a, b) => b.date.compareTo(a.date));
  for (final item in sorted) {
    final key = _monthLabel(item.date);
    map.putIfAbsent(key, () => []).add(item);
  }
  return map;
}

String _monthLabel(DateTime dt) {
  const months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  return '${months[dt.month - 1]} ${dt.year}';
}

/// e.g. "18 Feb · 10:30"
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

// ─── Screen ──────────────────────────────────────────────────────────────────

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final grouped = _groupByMonth(allEarnings);

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF0F0EB),
        body: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const PointsCard(),
                    _buildEarningOverview(context,grouped),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Grouped Earning Overview ─────────────────────────────────────────────
  Widget _buildEarningOverview(context,Map<String, List<EarningItem>> grouped) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...grouped.entries.map(
            (entry) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Month + year header
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    entry.key,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF6B7280),
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                // Card group
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
                    children: entry.value.asMap().entries.map((e) {
                      final isLast = e.key == entry.value.length - 1;
                      return _buildEarningRow(context, e.value, isLast: isLast);
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Single Row ───────────────────────────────────────────────────────────
  Widget _buildEarningRow(context, EarningItem item, {required bool isLast}) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EarningDetailsScreen()),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          border: isLast
              ? null
              : const Border(bottom: BorderSide(color: Color(0xFFF3F4F6))),
        ),
        child: Row(
          children: [
            // Thumbnail
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(item.img, fit: BoxFit.contain)
                   
              ),
            ),
            const SizedBox(width: 12),

            // Title, subtitle, date+time
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111111),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.sub,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF9CA3AF),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    _formatDate(item.date), // ← date + time here
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFFB0B7BF),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),

            // Vertical divider
            Container(height: 40, width: 1, color: const Color(0xFFD9DDDF)),
            const SizedBox(width: 10),

            // ESG points only
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '+${item.pts}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: ConstColors.green,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Ecopunten',
                  style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ── AppBar ───────────────────────────────────────────────────────────────
  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => Navigator.maybePop(context),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.07),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.chevron_left_rounded,
                  size: 24,
                  color: Color(0xFF111111),
                ),
              ),
            ),
          ),
          const Text(
            'Transactie Overzicht',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Color(0xFF111111),
            ),
          ),
        ],
      ),
    );
  }
}
