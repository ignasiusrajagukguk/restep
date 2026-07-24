import 'package:flutter/material.dart';
import 'package:restep/common/constants/collors.dart';
import 'package:restep/config/app_asset.dart';

// ─── Model ────────────────────────────────────────────────────────────────────

enum BagOrderStatus { placed, packed, inTransit, outForDelivery, delivered }

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
    status: BagOrderStatus.inTransit,
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
  _ShipStep('On the\nway', BagOrderStatus.inTransit),
  _ShipStep('Out for\ndelivery', BagOrderStatus.outForDelivery),
  _ShipStep('Delivered', BagOrderStatus.delivered),
];


Widget _buildBagOrderCard(BuildContext context, BagOrder order) {
  final statusIndex = order.status.index;
  final isDelivered = order.status == BagOrderStatus.delivered;

  // Badge styling
  final Color badgeBg;
  final Color badgeFg;
  final String badgeLabel;
  switch (order.status) {
    case BagOrderStatus.delivered:
      badgeLabel = 'Delivered';
      badgeBg = const Color(0xFFEAF3DE);
      badgeFg = const Color(0xFF3B6D11);
      break;
    case BagOrderStatus.outForDelivery:
      badgeLabel = 'Out for delivery';
      badgeBg = const Color(0xFFE6F1FB);
      badgeFg = const Color(0xFF185FA5);
      break;
    case BagOrderStatus.inTransit:
      badgeLabel = 'In transit';
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(_shipSteps.length, (i) {
            final done = i < statusIndex;
            final active = i == statusIndex;
            final lineColor = i < statusIndex
                ? ConstColors.green
                : const Color(0xFFE5E7EB);

            return Expanded(
              child: Column(
                children: [
                  // Dot + connector line row
                  SizedBox(
                    height: 18,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Left connector
                        if (i > 0)
                          Positioned(
                            left: 0,
                            right: 9,
                            child: Container(
                              height: 2,
                              color: i <= statusIndex
                                  ? ConstColors.green
                                  : const Color(0xFFE5E7EB),
                            ),
                          ),
                        // Right connector
                        if (i < _shipSteps.length - 1)
                          Positioned(
                            left: 9,
                            right: 0,
                            child: Container(height: 2, color: lineColor),
                          ),
                        // Dot
                        Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: done
                                ? ConstColors.green
                                : active
                                ? Colors.white
                                : const Color(0xFFE5E7EB),
                            border: active
                                ? Border.all(color: ConstColors.green, width: 2)
                                : null,
                          ),
                          child: done
                              ? const Icon(
                                  Icons.check,
                                  size: 10,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _shipSteps[i].label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: active ? FontWeight.w700 : FontWeight.w400,
                      color: active
                          ? ConstColors.green
                          : const Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              ),
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

class MyBagScreenOrders extends StatelessWidget {
  const MyBagScreenOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFE9EFEA),
        appBar: AppBar(
          backgroundColor: const Color(0xFFE9EFEA),
          elevation: 0,
          centerTitle: true,
          leading: const BackButton(color: ConstColors.green),
          title: const Text(
            "Onderweg",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: ListView(children: [...bagOrders.map((order) => _buildBagOrderCard(context, order)),]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
