import 'dart:ui';

import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:restep/common/constants/collors.dart';
import 'package:restep/common/widgets/separator_widget.dart';
import 'dart:math' as math;

import 'package:restep/config/app_asset.dart';
import 'package:restep/presentation/screens/activity_log/activity_log.dart';
import 'package:restep/presentation/screens/co2e_report/co2e_report_screen.dart';
import 'package:restep/presentation/screens/details/index.dart';
import 'package:restep/presentation/screens/login/index.dart';
import 'package:restep/presentation/screens/my_bags/index.dart';
import 'package:restep/presentation/screens/my_ordered_bag/index.dart';
import 'package:restep/presentation/screens/notifications/index.dart';
import 'package:restep/presentation/screens/promo_details/indes.dart';
import 'package:restep/presentation/screens/redeemed_details/confirm_redemption.dart';
import 'package:restep/presentation/screens/reward_catalog/index.dart';
import 'package:restep/presentation/screens/settings/index.dart';
import 'package:restep/presentation/screens/special_deals_list/index.dart';
import 'package:restep/presentation/screens/splash_screen/index.dart';
import 'package:restep/presentation/screens/support/index.dart';
import 'package:restep/presentation/screens/tutorials/index.dart';
import 'package:restep/presentation/widgets/points.dart';

const Color plusBg = Color(0xFFF5F3EE);

// ─── Data Model ────────────────────────────────────────────────────────────────

class RecycledItem {
  final String name;
  final String id;
  final int percent;
  final String status;
  final Color statusColor;
  final Color progressColor;
  final String imageUrl;

  const RecycledItem({
    required this.name,
    required this.id,
    required this.percent,
    required this.status,
    required this.statusColor,
    required this.progressColor,
    required this.imageUrl,
  });
}

enum BagOrderStatus { placed, packed, readyForPickup, delivered }

class BagOrder {
  final String orderId;
  final String bagName;
  final String imageAsset;
  final int points;
  final String dateOrdered;
  final String courier;
  final String trackTrace;
  final String locationLabel;
  final String deliveryDateLabel;
  final BagOrderStatus status;

  const BagOrder({
    required this.orderId,
    required this.bagName,
    required this.imageAsset,
    required this.points,
    required this.dateOrdered,
    required this.courier,
    required this.trackTrace,
    required this.locationLabel,
    required this.deliveryDateLabel,
    required this.status,
  });
}

// ─── Sample data (Netherlands) ────────────────────────────────────────────────

final List<BagOrder> bagOrders = [
  BagOrder(
    orderId: 'ORD-8812',
    bagName: 'Premium Circular Bag',
    imageAsset: ImageAsset.bag1,
    points: 1200,
    dateOrdered: '05 Jan 2026',
    courier: 'PostNL Standaard',
    trackTrace: '3SBOL123456789',
    locationLabel: 'Packed',
    deliveryDateLabel: '19 Jan 2026',
    status: BagOrderStatus.readyForPickup,
  ),
  BagOrder(
    orderId: 'ORD-7743',
    bagName: 'Premium Circular Bag',
    imageAsset: ImageAsset.bag2,
    points: 1500,
    dateOrdered: '28 Dec 2025',
    courier: 'DHL Pakket NL',
    trackTrace: 'JD014600009876',
    locationLabel: 'Keizersgracht 42, 1015 CT Amsterdam',
    deliveryDateLabel: '10 Jan 2026',
    status: BagOrderStatus.delivered,
  ),
];

// ─── Helper ───────────────────────────────────────────────────────────────────

class _ShipStep {
  final String label;
  final BagOrderStatus value;
  const _ShipStep(this.label, this.value);
}

const _shipSteps = [
  _ShipStep('Ordered', BagOrderStatus.placed),
  _ShipStep('Packed', BagOrderStatus.packed),
  _ShipStep('on the\nway', BagOrderStatus.readyForPickup),
  _ShipStep('Ready for\npick up', BagOrderStatus.delivered),
];

// ─── Category tile model ──────────────────────────────────────────────────────

class _CategoryTile {
  final String title;
  final String? subtitle;
  final Color bgColor;
  final Color textColor;
  final String imageUrl;
  final bool isPromoBanner;

  const _CategoryTile({
    required this.title,
    this.subtitle,
    required this.bgColor,
    required this.textColor,
    required this.imageUrl,
    this.isPromoBanner = false,
  });
}

// ─── Bag orders section ────────────────────────────────────────────────────────

Widget buildBagOrdersSection(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Onderweg',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Color(0xFF111111),
              ),
            ),
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MyBagScreenOrders()),
              ),
              child: Row(
                children: const [
                  Text(
                    'Meer',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: ConstColors.green,
                    ),
                  ),
                  SizedBox(width: 2),
                  Icon(Icons.chevron_right, size: 16, color: ConstColors.green),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...bagOrders.map((order) => buildBagOrderCard(context, order)),
        const SizedBox(height: 6),
      ],
    ),
  );
}

Widget buildBagOrderCard(BuildContext context, BagOrder order) {
  final statusIndex = order.status.index;
  final isDelivered = order.status == BagOrderStatus.delivered;

  final Color badgeBg;
  final Color badgeFg;
  final String badgeLabel;
  switch (order.status) {
    case BagOrderStatus.delivered:
      badgeLabel = 'Picked Up';
      badgeBg = const Color(0xFFE8F5E9);
      badgeFg = ConstColors.green;
      break;
    case BagOrderStatus.readyForPickup:
      badgeLabel = 'Ready for Pick Up';
      badgeBg = const Color(0xFFFFF8E1);
      badgeFg = const Color(0xFF854F0B);
      break;
    default:
      badgeLabel = 'Processing';
      badgeBg = const Color(0xFFF3F4F6);
      badgeFg = const Color(0xFF6B7280);
  }

  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 6,
          offset: const Offset(0, 1),
        ),
      ],
    ),
    padding: const EdgeInsets.all(14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                order.imageAsset,
                width: 72,
                height: 72,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.bagName,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF111111),
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Produced from recycled footwear materials',
                    style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF)),
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 6,
                    children: [
                      _badge(badgeLabel, badgeBg, badgeFg),
                      _badge(
                        '#${order.orderId}',
                        const Color(0xFFF3F4F6),
                        const Color(0xFF6B7280),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        Icons.emoji_events_outlined,
                        size: 12,
                        color: Color(0xFF9CA3AF),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Points collected: ',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                      Text(
                        '${order.points} pts',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: ConstColors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Divider(height: 1, color: Color(0xFFF3F4F6)),
        const SizedBox(height: 12),
        const Text(
          'SHIPPING STATUS',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Color(0xFF9CA3AF),
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 10),
        EasyStepper(
          activeStep: statusIndex,
          lineStyle: const LineStyle(
            lineLength: 40,
            lineThickness: 2,
            finishedLineColor: ConstColors.green,
            unreachedLineColor: Color(0xFFE5E7EB),
          ),
          stepShape: StepShape.circle,
          borderThickness: 2,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          stepRadius: 10,
          finishedStepBackgroundColor: ConstColors.green,
          activeStepBackgroundColor: Colors.white,
          unreachedStepBackgroundColor: const Color(0xFFE5E7EB),
          finishedStepBorderColor: ConstColors.green,
          activeStepBorderColor: ConstColors.green,
          unreachedStepBorderColor: const Color(0xFFE5E7EB),
          showLoadingAnimation: false,
          titleTextStyle: const TextStyle(fontSize: 10),
          steps: List.generate(_shipSteps.length, (i) {
            final isDone = i < statusIndex;
            return EasyStep(
              customStep: isDone
                  ? const Icon(Icons.check, size: 12, color: Colors.white)
                  : null,
              icon: isDone
                  ? null
                  : const Icon(Icons.circle, size: 8, color: Colors.white),
              title: _shipSteps[i].label,
              topTitle: false,
            );
          }),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Icon(
              Icons.location_on_outlined,
              size: 12,
              color: Color(0xFF9CA3AF),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                isDelivered
                    ? 'Picked up on: ${order.locationLabel}'
                    : 'Current Status: ${order.locationLabel}',
                style: const TextStyle(fontSize: 10, color: Color(0xFF6B7280)),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Row(
          children: [
            const Icon(
              Icons.access_time_outlined,
              size: 12,
              color: Color(0xFF9CA3AF),
            ),
            const SizedBox(width: 4),
            Text(
              isDelivered
                  ? 'Picked up at: ${order.deliveryDateLabel}'
                  : 'Est. packing: ${order.deliveryDateLabel}',
              style: const TextStyle(fontSize: 10, color: Color(0xFF6B7280)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Divider(height: 1, color: Color(0xFFF3F4F6)),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _metaCol('Date ordered', order.dateOrdered),
            _metaCol('Track & trace', order.trackTrace),
          ],
        ),
      ],
    ),
  );
}

Widget _badge(String label, Color bg, Color fg) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      label,
      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: fg),
    ),
  );
}

Widget _metaCol(String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(fontSize: 10, color: Color(0xFF9CA3AF)),
      ),
      const SizedBox(height: 2),
      Text(
        value,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Color(0xFF111111),
        ),
      ),
    ],
  );
}

final List<RewardItem> deals = [
  RewardItem(
    title: 'Last Chance Bakery – Verspillen? Liever Niet!',
    description: 'Freshly baked goods from yesterday, still soft and tasty.',
    pts: 100,
    disc: 11,
    imageUrl: ImageAsset.bread,
    bgColor: const Color(0xFFF5C6C6),
  ),
  RewardItem(
    title: 'Rescue Pack – Wij Redden Dit Eten Samen',
    description: 'A bundle of products saved from being thrown away.',
    pts: 2000,
    disc: 20,
    imageUrl: ImageAsset.sandwich,
    bgColor: const Color(0xFFC8DDD6),
  ),
];

final List<RecycledItem> recycledItems = [
  RecycledItem(
    name: 'Air Zoom Pegasus 41',
    id: 'NK-AZP40-ID-2409',
    percent: 20,
    status: 'Dropped',
    statusColor: const Color(0xFF6B7280),
    progressColor: const Color(0xFFF59E0B),
    imageUrl: ImageAsset.item1,
  ),
  RecycledItem(
    name: "Air Force 1 '07 Next...",
    id: 'NK-AF1NN-2409',
    percent: 60,
    status: 'Recycled',
    statusColor: const Color(0xFF3B82F6),
    progressColor: const Color(0xFF3B82F6),
    imageUrl: ImageAsset.item2,
  ),
  RecycledItem(
    name: 'Revolution 6 Next Na...',
    id: 'NK-RV6NN-2409',
    percent: 100,
    status: 'Reused',
    statusColor: ConstColors.green,
    progressColor: ConstColors.green,
    imageUrl: ImageAsset.item3,
  ),
];

// ─── Main Screen ───────────────────────────────────────────────────────────────

class NewDashboardScreen extends StatefulWidget {
  const NewDashboardScreen({super.key, required this.winkelNavigation});
  final Function() winkelNavigation;

  @override
  State<NewDashboardScreen> createState() => _NewDashboardScreenState();
}

class _NewDashboardScreenState extends State<NewDashboardScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey _avatarKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: plusBg,
      body: Column(
        children: [
          _buildPlusHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 90),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SeparatorWidget.height10(),

                  PointsCard(),
                  SizedBox(
                    height: 140,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        spacing: 10,
                        children: [
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Image.asset(ImageAsset.dummycard3, height: 130),
                              Container(
                                height: 20,
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.symmetric(
                                  vertical: 3,
                                  horizontal: 7,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(200),
                                  color: Color(0XFF6464A4),
                                ),
                                child: Center(
                                  child: Text(
                                    'RECYCLE NOW',
                                    style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Image.asset(ImageAsset.dummycard1, height: 130),
                              Container(
                                height: 20,
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.symmetric(
                                  vertical: 3,
                                  horizontal: 7,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(200),
                                  color: Color(0XFF6464A4),
                                ),
                                child: Center(
                                  child: Text(
                                    'RECYCLE NOW',
                                    style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Image.asset(ImageAsset.dummycard2, height: 130),
                              Container(
                                height: 20,
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.symmetric(
                                  vertical: 3,
                                  horizontal: 7,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(200),
                                  color: Color(0xff599344),
                                ),
                                child: Center(
                                  child: Text(
                                    'RECYCLE NOW',
                                    style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SeparatorWidget.height10(),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 5,
                          children: [
                            const Text(
                              'Supported by:',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                              ),
                            ),
                            Image.asset(ImageAsset.intersport, height: 10),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SeparatorWidget.height10(),
                  _buildSectionHeader(
                    context,
                    title: 'Impact',
                    onMoreTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => Co2eReportScreen2()),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildImpactSection(),
                  const SizedBox(height: 20),

                  _buildCategoryTiles(context),
                  const SizedBox(height: 20),
                  _buildSectionHeader(
                    context,
                    title: 'Onderweg',
                    onMoreTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MyBagScreenOrders(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: bagOrders
                          .map((order) => buildBagOrderCard(context, order))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 15),
                    child: Text(
                      "Status",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF111111),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildRecycledItemsList(),
                  const SizedBox(height: 20),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── PLUS-style green header ─────────────────────────────────────────────────

  Widget _buildPlusHeader() {
    return SafeArea(
      bottom: false,
      child: Container(
        color: ConstColors.green,
        child: Column(
          children: [
            // Top bar: avatar left, title center, QR right
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Avatar / profile
                  // App name centered

                  // Notification + QR
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotificationsScreen(),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.notifications_none_outlined,
                          color: Color.fromARGB(255, 57, 54, 54),
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () => _showProfileMenu(),
                        child: Container(
                          key: _avatarKey,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const CircleAvatar(
                            radius: 18,
                            backgroundImage: NetworkImage(
                              'https://i.pravatar.cc/100?img=12',
                            ),
                            backgroundColor: Color(0xFFE5E7EB),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Circulair',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),
            // Search bar inside green header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Container(
                height: 46,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 14),
                    const Icon(
                      Icons.search,
                      color: Color(0xFF9CA3AF),
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Waar ben je naar op zoek?',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF9CA3AF),
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

  // ── PLUS-style full-width category tiles ────────────────────────────────────

  Widget _buildCategoryTiles(BuildContext context) {
    final tiles = [
      _CategoryTile(
        title: 'Scan je ReStep QR\ncode in de winkel!',
        bgColor: ConstColors.green,
        textColor: Colors.white,
        imageUrl: ImageAsset.dummyQr,
        isPromoBanner: true,
      ),
      _CategoryTile(
        title: 'Aanbiedingen',
        bgColor: const Color(0xFFF5C6C6),
        textColor: const Color(0xFF374151),
        imageUrl: ImageAsset.bread,
      ),
      _CategoryTile(
        title: 'Beloningscatalogus',
        bgColor: const Color(0xFFF0EDE8),
        textColor: const Color(0xFF374151),
        imageUrl: ImageAsset.dummycard1,
      ),
    ];

    return Column(
      children: [
        const SizedBox(height: 8),
        // Remaining tiles
        ...tiles
            .skip(1)
            .map(
              (tile) => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 4,
                ),
                child: GestureDetector(
                  onTap: () {
                    if (tile.title == 'Aanbiedingen') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => SpecialDealsScreen()),
                      );
                    } else if (tile.title == 'Beloningscatalogus') {
                      widget.winkelNavigation();
                    }
                  },
                  child: _buildCategoryTileWidget(tile),
                ),
              ),
            ),
      ],
    );
  }

  Widget _buildPromoBannerTile(_CategoryTile tile) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: tile.bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Positioned(
            right: -10,
            top: 0,
            bottom: 0,
            child: Image.asset(
              tile.imageUrl,
              width: 120,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const SizedBox(width: 120),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Text(
              tile.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: tile.textColor,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTileWidget(_CategoryTile tile) {
    return Container(
      height: 88,
      decoration: BoxDecoration(
        color: tile.bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.hardEdge,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              child: Text(
                tile.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: tile.textColor,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 110,
            height: 88,
            child: Image.asset(
              tile.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  Container(color: tile.bgColor.withValues(alpha: 0.5)),
            ),
          ),
        ],
      ),
    );
  }

  // ── Section header ──────────────────────────────────────────────────────────

  Widget _buildSectionHeader(
    BuildContext context, {
    required String title,
    required VoidCallback onMoreTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF111111),
            ),
          ),
          InkWell(
            onTap: onMoreTap,
            child: Row(
              children: const [
                Text(
                  'Meer',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: ConstColors.green,
                  ),
                ),
                SizedBox(width: 2),
                Icon(Icons.chevron_right, size: 16, color: ConstColors.green),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImpactSection() {
    // _month is the default period in Co2eReportScreen2 (tabIndex = 1)
    final d = Co2PeriodData(
      totalKg: '12.4',
      changeLabel: '+18% vs last month',
      equiv: '≈ 62 km not driven',
      itemsRecycled: 23,
      bagUses: 47,
      points: 310,
      recyclingData: [1.2, 2.1, 3.0, 2.4, 3.8, 4.0, 3.8, 4.0, 3.8, 4.0],
      bagsData: [0.8, 1.0, 1.5, 1.8, 2.2, 2.4, 2.2, 2.4, 2.2, 2.4],
      chartLabels: ['Date   1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
      categories: [
        Co2Category(
          name: 'Shoes',
          subtitle: '8 pairs',
          kg: '5.2',
          pct: 42,
          color: Color(0xFF1A6B35),
          bgColor: Color(0xFFEAF3DE),
          icon: Icons.inventory_2_outlined,
        ),
        Co2Category(
          name: 'Plastic bags',
          subtitle: '47 uses',
          kg: '3.1',
          pct: 25,
          color: Color(0xFF185FA5),
          bgColor: Color(0xFFE6F1FB),
          icon: Icons.shopping_bag_outlined,
        ),
        Co2Category(
          name: 'Clothing',
          subtitle: '6 items',
          kg: '2.5',
          pct: 20,
          color: Color(0xFFBA7517),
          bgColor: Color(0xFFFAEEDA),
          icon: Icons.checkroom_outlined,
        ),
        Co2Category(
          name: 'Bags & pouches',
          subtitle: '4 items',
          kg: '1.6',
          pct: 13,
          color: Color(0xFF993556),
          bgColor: Color(0xFFFBEAF0),
          icon: Icons.backpack_outlined,
        ),
      ],
    );
    final totalKgDouble = double.tryParse(d.totalKg) ?? 0;
    const double goal = 25;
    final progress = (totalKgDouble / goal).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'ENVIRONMENTAL IMPACT',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFF9CA3AF),
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: d.totalKg, // ← live from _month
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                color: ConstColors.green,
                                height: 1,
                              ),
                            ),
                            const TextSpan(
                              text: ' kg CO₂e saved',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF6B7280),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        d.equiv, // ← live from _month
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEAF3DE),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.eco_outlined,
                    color: Color(0xFF3B6D11),
                    size: 22,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),
            const Divider(height: 1, color: Color(0xFFF3F4F6)),
            const SizedBox(height: 14),

            Row(
              children: [
                _miniStat(
                  'Items recycled',
                  '${d.itemsRecycled}',
                  null,
                ), // ← live
                const SizedBox(width: 8),
                _miniStat('Bag uses', '${d.bagUses}', null), // ← live
                const SizedBox(width: 8),
                _miniStat('Points earned', '${d.points}', 'pts'), // ← live
              ],
            ),

            const SizedBox(height: 14),
            const Divider(height: 1, color: Color(0xFFF3F4F6)),
            const SizedBox(height: 14),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Progress to 25 kg goal',
                  style: TextStyle(fontSize: 11, color: Color(0xFF6B7280)),
                ),
                Text(
                  '${(progress * 100).round()}%', // ← computed from d.totalKg
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF3B6D11),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(99),
              child: LinearProgressIndicator(
                value: progress, // ← computed from d.totalKg
                minHeight: 6,
                backgroundColor: const Color(0xFFF3F4F6),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF639922),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _miniStat(String label, String value, String? unit) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 10, color: Color(0xFF9CA3AF)),
            ),
            const SizedBox(height: 4),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: value,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF111111),
                    ),
                  ),
                  if (unit != null)
                    TextSpan(
                      text: ' $unit',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  // ── Recycled Items ─────────────────────────────────────────────────────────

  Widget _buildRecycledItemsList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: recycledItems.map((item) => _buildShoeCard(item)).toList(),
      ),
    );
  }

  // ── Profile popup ──────────────────────────────────────────────────────────

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
        offset.dx,
        offset.dy + size.height + 8,
        offset.dx + size.width,
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
        case 'activity':
          break;
        case 'tutorials':
          break;
        case 'settings':
          break;
        case 'support':
          break;
        case 'signout':
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
    VoidCallback? onTap,
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

  // ── Shoe card ──────────────────────────────────────────────────────────────

  Widget _buildShoeCard(RecycledItem item) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductDetailScreen()),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 6,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            SizedBox(
              width: 70,
              height: 46,
              child: Image.asset(
                item.imageUrl,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.directions_run,
                  size: 46,
                  color: Color(0xFFD1D5DB),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111111),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.id,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              children: [
                SizedBox(
                  width: 52,
                  height: 52,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomPaint(
                        size: const Size(52, 52),
                        painter: _CircularProgressPainter(
                          percent: item.percent / 100,
                          color: item.progressColor,
                          strokeWidth: 4,
                        ),
                      ),
                      Text(
                        '${item.percent}%',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF111111),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.status,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: item.statusColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Circular Progress Painter ─────────────────────────────────────────────────

class _CircularProgressPainter extends CustomPainter {
  final double percent;
  final Color color;
  final double strokeWidth;

  _CircularProgressPainter({
    required this.percent,
    required this.color,
    this.strokeWidth = 4,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final trackPaint = Paint()
      ..color = const Color(0xFFE5E7EB)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);

    final progressPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * percent,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_CircularProgressPainter oldDelegate) =>
      oldDelegate.percent != percent || oldDelegate.color != color;
}

// ─── QR Code Modal ─────────────────────────────────────────────────────────────

class MyQRCodeModal extends StatelessWidget {
  const MyQRCodeModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Container(color: Colors.black.withOpacity(0.3)),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.all(28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildCloseButton(context),
                  const SizedBox(height: 8),
                  const Text(
                    'QR Code',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: ConstColors.green,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Present this QR code at the store when\nto get some points from your purchase',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6B6B6B),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Image.asset(ImageAsset.dummyQr, height: 200),
                  const SizedBox(height: 16),
                  const Text(
                    'Member ID',
                    style: TextStyle(fontSize: 13, color: Color(0xFF6B6B6B)),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'VCH-8291-PLS',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF374151),
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildInstructions(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInstructions() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Instructions',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: ConstColors.green,
            ),
          ),
          const SizedBox(height: 10),
          _instructionItem(
            'Show this QR code at the store to get points from your purchase',
          ),
          _instructionItem('Make sure to present it before validation'),
          _instructionItem('Every purchase can scan only scan once'),
        ],
      ),
    );
  }

  Widget _instructionItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 5, right: 8),
            child: CircleAvatar(radius: 3, backgroundColor: ConstColors.green),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                color: ConstColors.green,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9),
            shape: BoxShape.circle,
            border: Border.all(color: ConstColors.green),
          ),
          child: const Icon(Icons.close, size: 16, color: ConstColors.green),
        ),
      ),
    );
  }
}
