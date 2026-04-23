import 'dart:ui';

import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:restep/common/constants/collors.dart';
import 'package:restep/common/widgets/separator_widget.dart';
import 'dart:math' as math;

import 'package:restep/config/app_asset.dart';
import 'package:restep/presentation/screens/co2e_report/co2e_report_screen.dart';
import 'package:restep/presentation/screens/details/index.dart';
import 'package:restep/presentation/screens/my_bags/index.dart';
import 'package:restep/presentation/screens/my_ordered_bag/index.dart';
import 'package:restep/presentation/screens/promo_details/indes.dart';
import 'package:restep/presentation/screens/redeemed_details/confirm_redemption.dart';
import 'package:restep/presentation/screens/reward_catalog/index.dart';
import 'package:restep/presentation/screens/settings/index.dart';
import 'package:restep/presentation/screens/special_deals_list/index.dart';
import 'package:restep/presentation/screens/tutorials/index.dart';
import 'package:restep/presentation/widgets/points.dart';

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
    locationLabel: 'PostNL — Sorting centre, Utrecht',
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
  _ShipStep('Order\nplaced', BagOrderStatus.placed),
  _ShipStep('Packed', BagOrderStatus.packed),
  _ShipStep('Ready for\n pick up', BagOrderStatus.readyForPickup),
  _ShipStep('Picked\nup', BagOrderStatus.placed),
];  

// ─── Widgets (paste into _DashboardScreenState) ───────────────────────────────

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
              'My bag orders',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF111111),
              ),
            ),
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MyBagScreenOrders()),
              ),
              child: Text(
                'View all',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: ConstColors.green,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...bagOrders.map((order) => _buildBagOrderCard(context, order)),
        const SizedBox(height: 6),
      ],
    ),
  );
}

Widget _buildBagOrderCard(BuildContext context, BagOrder order) {
  final statusIndex = order.status.index;
  final isDelivered = order.status == BagOrderStatus.delivered;

  // Badge styling
  final Color badgeBg;
  final Color badgeFg;
  final String badgeLabel;
  switch (order.status) {
    case BagOrderStatus.delivered:
      badgeLabel = 'Picked Up';
      badgeBg = const Color(0xFFEAF3DE);
      badgeFg = const Color(0xFF3B6D11);
      break;
    case BagOrderStatus.readyForPickup:
      badgeLabel = 'Ready for Pick Up';
      badgeBg = const Color(0xFFFAEEDA);
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
      borderRadius: BorderRadius.circular(16),
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
        // ── Top row ──────────────────────────────────────────────────────────
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
                  // Badges
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
                  // Points
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
                        style: TextStyle(
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

        // ── Shipping steps ────────────────────────────────────────────────────
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

        // Location
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
                    ? 'Delivered to: ${order.locationLabel}'
                    : 'Current location: ${order.locationLabel}',
                style: const TextStyle(fontSize: 10, color: Color(0xFF6B7280)),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        // Date
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
                  ? 'Delivered on: ${order.deliveryDateLabel}'
                  : 'Est. delivery: ${order.deliveryDateLabel}',
              style: const TextStyle(fontSize: 10, color: Color(0xFF6B7280)),
            ),
          ],
        ),

        const SizedBox(height: 12),
        const Divider(height: 1, color: Color(0xFFF3F4F6)),
        const SizedBox(height: 10),

        // ── Bottom meta ───────────────────────────────────────────────────────
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _metaCol('Date ordered', order.dateOrdered),
            _metaCol('Courier', order.courier),
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
    description: 'Freshly baked goods from yesterday, still soft and tasty. Perfect for a quick bite or toast.',
    pts: 100,
    disc: 11,
    imageUrl:
        ImageAsset.bread,
    bgColor: const Color(0xFFF3E8E8),
  ),
  RewardItem(
    title: 'Rescue Pack – Wij Redden Dit Eten Samen',
    description: 'A bundle of products saved from being thrown away. Join us in reducing food waste',
    pts: 2000,
    disc: 20,
    imageUrl:
        ImageAsset.sandwich,
    bgColor: const Color(0xFFE8EFF3),
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

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey _avatarKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF0F0EB),
        body: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 90),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PointsCard(),
                    _buildImpactSection(),
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Special Deals Near You',
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
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          SpecialDealsScreen(),
                                    ),
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
                          SeparatorWidget.height10(),
                          SizedBox(
                            height: 230,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: deals.length,
                              itemBuilder: (context, index) {
                                return _buildRewardCard(context, deals[index]);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SeparatorWidget.height10(),
                    buildBagOrdersSection(context),
                    SeparatorWidget.height10(),
                    _buildRecycledItemsSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRewardCard(context, RewardItem item) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ConfirmPromoRedemptionScreen()),
          );
        },
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image area
              Container(
                width: double.infinity,
                color: item.bgColor,
                height: 140,
                child: Image.asset(
                  item.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.image,
                    color: Color(0xFF9CA3AF),
                    size: 40,
                  ),
                ),
              ),

              // Info area
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111111),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF9CA3AF),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${item.pts} ESG pts',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: item.disc != null
                                    ? ConstColors.grayMedium20
                                    : ConstColors.green,
                                decoration: item.disc != null
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  '${item.disc != null ? (item.pts - (item.disc! / 100 * item.pts).toInt()) : item.pts}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: ConstColors.green,
                                  ),
                                ),
                                Text(
                                  ' ESG pts',
                                  style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w500,
                                    color: ConstColors.green,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          '0.5 km',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
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
        ),
      ),
    );
  }

  // ── Header ─────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 16, 15, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hi, John Doe!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111111),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: ConstColors.white, width: 5),
                  color: ConstColors.white,
                ),
                padding: EdgeInsets.all(2),
                child: Icon(Icons.notifications_none_outlined, size: 35),
              ),
              SeparatorWidget.width10(),
              GestureDetector(
                onTap: () => _showProfileMenu(), // no context needed
                child: Container(
                  key: _avatarKey, // ← add this key
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: ConstColors.green, width: 2),
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
    );
  }

  // ── Circular Impact ────────────────────────────────────────────────────────

  Widget _buildImpactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 14),
          child: Text(
            'Circular Impact',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF111111),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 24),
          child: Container(
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  _buildImpactStat('Items', '3', null),
                  const VerticalDivider(color: Color(0xFFF3F4F6), width: 24),
                  _buildImpactStat('Returned', '3.6', 'kg'),
                  const VerticalDivider(color: Color(0xFFF3F4F6), width: 24),
                  _buildImpactStat('CO₂e Saved', '18.4', 'kg'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImpactStat(String label, String value, String? unit) {
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

  // ── Recycled Items ─────────────────────────────────────────────────────────

  Widget _buildRecycledItemsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Currently Recycling',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111111),
                ),
              ),
              InkWell(
                onTap: () {},
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
          ...recycledItems.map((item) => _buildShoeCard(item)),
        ],
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
          iconColor: const Color(0xFF10B981),
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
          iconColor: const Color(0xFF10B981),
          title: 'My Bags',
          subtitle: 'Recent actions',
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
          icon: Icons.eco,
          iconBg: const Color(0xFFD1FAE5),
          iconColor: const Color(0xFF10B981),
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
          borderRadius: BorderRadius.circular(16),
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
            // Shoe image
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
            // Name & ID
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
            // Circular progress
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

    // Background track
    final trackPaint = Paint()
      ..color = const Color(0xFFE5E7EB)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);

    // Progress arc
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

class MyQRCodeModal extends StatelessWidget {
  const MyQRCodeModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Blurred background
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Container(color: Colors.black.withOpacity(0.3)),
        ),
        // Modal sheet
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
                      color: ConstColors.dark40,
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
        color: ConstColors.green10,
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
            child: CircleAvatar(
              radius: 3,
              backgroundColor: ConstColors.green10,
            ),
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
            color: ConstColors.green10,
            shape: BoxShape.circle,
            border: Border.all(color: ConstColors.green),
          ),
          child: const Icon(Icons.close, size: 16, color: ConstColors.green),
        ),
      ),
    );
  }
}
