import 'package:flutter/material.dart';
import 'package:restep/common/constants/collors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        "title": "Reward Redeemed",
        "message": "You successfully redeemed a Starbucks voucher.",
        "time": "5 min ago",
      },
      {
        "title": "Points Earned",
        "message": "You earned 250 points from recycling activity.",
        "time": "1 hour ago",
      },
      {
        "title": "Special Deal",
        "message": "New eco-friendly products are available now.",
        "time": "Yesterday",
      },
    ];

    return Scaffold(
        backgroundColor: const Color(0xFFF0F0EB),
      appBar: AppBar(
        leading: BackButton(color: ConstColors.black),
        backgroundColor: const Color(0xFFF0F0EB),
        title: const Text("Notifications", style: TextStyle(color: ConstColors.black),),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = notifications[index];

          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  child: Icon(Icons.notifications_outlined),
                  backgroundColor: ConstColors.green,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item["title"]!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(item["message"]!),
                      const SizedBox(height: 8),
                      Text(
                        item["time"]!,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}