import 'package:flutter/material.dart';
import 'package:restep/common/widgets/separator_widget.dart';

class ActivityLogScreen extends StatelessWidget {
  const ActivityLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const bgColor = Color(0xFFF0F0E8);
    final logs = [
      {
        'title': 'Recycling Drop-off Completed',
        'description':
            'You submitted 12 plastic bottles at Intersport Grand Indonesia.',
        'time': 'Today, 10:24 AM',
        'icon': Icons.recycling_outlined,
        'status': 'Completed',
      },
      {
        'title': 'Points Added',
        'description':
            'You earned 250 ReStep Points from your recycling activity.',
        'time': 'Today, 10:25 AM',
        'icon': Icons.stars_outlined,
        'status': '+250 pts',
      },
      {
        'title': 'Reward Redeemed',
        'description':
            'You redeemed a 10% discount voucher for your next purchase.',
        'time': 'Yesterday, 04:12 PM',
        'icon': Icons.card_giftcard_outlined,
        'status': 'Redeemed',
      },
      {
        'title': 'Drop-off Location Viewed',
        'description':
            'You checked the nearest recycling point at Intersport Senayan City.',
        'time': '12 Jun 2026, 09:30 AM',
        'icon': Icons.location_on_outlined,
        'status': 'Location',
      },
      {
        'title': 'Sustainability Mission Joined',
        'description':
            'You joined the monthly “Recycle More, Earn More” campaign.',
        'time': '10 Jun 2026, 01:45 PM',
        'icon': Icons.eco_outlined,
        'status': 'Campaign',
      },
    ];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                children: [
                  const Text(
                    'Recent Activity',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF111111),
                    ),
                  ),
                  SeparatorWidget.height10(),

                  ...logs.map((item) {
                    return _activityLogCard(
                      icon: item['icon'] as IconData,
                      title: item['title'] as String,
                      description: item['description'] as String,
                      time: item['time'] as String,
                      status: item['status'] as String,
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _activityLogCard({
  required IconData icon,
  required String title,
  required String description,
  required String time,
  required String status,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(14),
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
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF7ED),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 21, color: const Color(0xFFF97316)),
        ),
        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111111),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF7ED),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      status,
                      style: const TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFF97316),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 12.5,
                  height: 1.4,
                  color: Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(
                    Icons.access_time_rounded,
                    size: 14,
                    color: Color(0xFF9CA3AF),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    time,
                    style: const TextStyle(
                      fontSize: 11.5,
                      color: Color(0xFF9CA3AF),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

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
          'Activity Log',
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
