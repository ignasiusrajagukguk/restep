import 'package:flutter/material.dart';
import 'package:restep/config/app_asset.dart';
import 'package:restep/presentation/screens/redeemed_details/voucher_issued.dart';

// ─── Data ────────────────────────────────────────────────────────────────────

enum RedemptionStatus { voucherIssued, readyForPickup, redeemed }

class RedeemedItem {
  final String title;
  final String description;
  final DateTime date;
  final String location;
  final int pts;
  final RedemptionStatus status;
  final String imageUrl;

  const RedeemedItem({
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    required this.pts,
    required this.status,
    required this.imageUrl,
  });
}

final List<RedeemedItem> redeemedItems = [
  RedeemedItem(
    title: 'Premium Circular Bag',
    description: 'Produced from recycled footwear materials.',
    date: DateTime(2026, 2, 18, 16, 20),
    location: 'PLUS - Amsterdam',
    pts: 300,
    status: RedemptionStatus.voucherIssued,
    imageUrl:
        'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=300&q=80',
  ),
  RedeemedItem(
    title: 'Premium Circular Bag',
    description: 'Produced from recycled footwear materials.',
    date: DateTime(2026, 2, 18, 16, 20),
    location: 'PLUS - Amsterdam',
    pts: 100,
    status: RedemptionStatus.readyForPickup,
    imageUrl:
        'https://images.unsplash.com/photo-1590874103328-eac38a683ce7?w=300&q=80',
  ),
  RedeemedItem(
    title: 'Premium Circular Bag',
    description: 'Produced from recycled footwear materials.',
    date: DateTime(2026, 2, 18, 16, 20),
    location: 'PLUS - Amsterdam',
    pts: 200,
    status: RedemptionStatus.redeemed,
    imageUrl:
        ImageAsset.bag1,
  ),
];

// ─── Helpers ─────────────────────────────────────────────────────────────────

String _formatDateTime(DateTime dt) {
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
  return '${dt.day} ${months[dt.month - 1]} ${dt.year} $h:$m';
}

extension StatusProps on RedemptionStatus {
  String get label {
    switch (this) {
      case RedemptionStatus.voucherIssued:
        return 'Voucher Issued';
      case RedemptionStatus.readyForPickup:
        return 'Ready for Pickup';
      case RedemptionStatus.redeemed:
        return 'Aangeschaft';
    }
  }

  Color get labelColor {
    switch (this) {
      case RedemptionStatus.voucherIssued:
        return const Color(0xFF16A34A);
      case RedemptionStatus.readyForPickup:
        return const Color(0xFFD97706);
      case RedemptionStatus.redeemed:
        return const Color(0xFF16A34A);
    }
  }

  Color get footerBg {
    switch (this) {
      case RedemptionStatus.voucherIssued:
        return const Color(0xFFF0FDF4);
      case RedemptionStatus.readyForPickup:
        return const Color(0xFFFFFBEB);
      case RedemptionStatus.redeemed:
        return const Color(0xFFF0FDF4);
    }
  }
}

// ─── Screen ──────────────────────────────────────────────────────────────────

class RedeemedScreen extends StatelessWidget {
  const RedeemedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F0),
        body: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                itemCount: redeemedItems.length,
                separatorBuilder: (_, __) => const SizedBox(height: 14),
                itemBuilder: (context, i) =>
                    _buildCard(context, redeemedItems[i]),
              ),
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
            'Aangeschaft',
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

  // ── Card ─────────────────────────────────────────────────────────────────
  Widget _buildCard(context, RedeemedItem item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductPassportScreen()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Image + Info row ──
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      item.imageUrl,
                      width: 110,
                      height: 110,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 110,
                        height: 110,
                        color: const Color(0xFFF3F4F6),
                        child: const Icon(
                          Icons.image,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  // Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF111111),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.description,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF6B7280),
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Date row
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today_outlined,
                              size: 13,
                              color: Color(0xFF9CA3AF),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              _formatDateTime(item.date),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF6B7280),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        // Location row
                        Row(
                          children: [
                            const Icon(
                              Icons.storefront_outlined,
                              size: 13,
                              color: Color(0xFF9CA3AF),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              item.location,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF6B7280),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ── Footer ──
            Container(
              color: item.status.footerBg,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.status.label,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: item.status.labelColor,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Ecopunten ',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: item.status.labelColor,
                        ),
                      ),
                      Text(
                        '-${item.pts}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: item.status.labelColor,
                        ),
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
