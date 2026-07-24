import 'package:flutter/material.dart';
import 'package:restep/common/constants/collors.dart';
import 'package:restep/config/app_asset.dart';

class OnboardingSmartBagPage extends StatelessWidget {
  const OnboardingSmartBagPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Icon
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: const Color(0xFFDCE8D4),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.qr_code_2,
                color: Color(0xFF2E7D32),
                size: 30,
              ),
            ),

            const SizedBox(height: 20),

            // Label
            Text(
              "HOW IT WORKS — SMART BAGS",
              style: TextStyle(
                color: ConstColors.green,
                letterSpacing: 1.2,
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 10),

            // Title
            const Text(
              "One bag. Zero plastic. Every shop.",
              style: TextStyle(
                color: ConstColors.green,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            // Description
            Text(
              "Purchase a reusable ReStep QR bag from Plus Supermarket. Each bag has a unique QR code linked to your account. Scan it at checkout and say goodbye to plastic bags — forever.",
              style: TextStyle(
                color: ConstColors.dark40,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 20),

            // 🔥 Bag Preview
            const BagPreviewCard(),

            const SizedBox(height: 20),

            // 🔥 Action Cards
            Row(
              children: const [
                Expanded(
                  child: ActionCard(
                    icon: Icons.shopping_bag,
                    title: "Buy more bags",
                    subtitle: "Forgot yours? Order one in-app",
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ActionCard(
                    icon: Icons.history,
                    title: "Shop history",
                    subtitle: "View every scan, every store",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
class BagPreviewCard extends StatelessWidget {
  const BagPreviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ConstColors.green),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: ConstColors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.qr_code, color: Colors.white),
              ),
              const SizedBox(width: 12),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "ReStep Tote Bag",
                    style: TextStyle(color: ConstColors.green),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Bag ID: #RSB-2847-TG",
                    style: TextStyle(color: ConstColors.dark40, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Status row
          Row(
            children: [
              _badge("Active", Colors.green.shade100, Colors.green.shade800),
              const SizedBox(width: 8),
              _badge("34 uses", Colors.blue.shade100, Colors.blue.shade800),
            ],
          ),

          const SizedBox(height: 14),

          const Text(
            "Shopping log",
            style: TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 10),

          const BagLogRow(
            title: "Plus Amsterdam Noord, 14 Apr 2025",
            points: "+2 pts",
          ),
          const Divider(),
          const BagLogRow(
            title: "Plus Utrecht Centrum, 10 Apr 2025",
            points: "+2 pts",
          ),
          const Divider(),
          const BagLogRow(
            title: "Plus Haarlem, 6 Apr 2025",
            points: "+2 pts",
          ),
        ],
      ),
    );
  }

  Widget _badge(String text, Color bg, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 11, color: textColor),
      ),
    );
  }
}
class BagLogRow extends StatelessWidget {
  final String title;
  final String points;

  const BagLogRow({
    super.key,
    required this.title,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 4,
          backgroundColor: Color(0xFF6BCB3D),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: 
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: Image.asset(IconsAsset.plus, height: 12,),
                      ),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
        ),
        Text(
          points,
          style: const TextStyle(
            color: Color(0xFF6BCB3D),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
class ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const ActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ConstColors.green),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: ConstColors.green),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(color: ConstColors.green),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: ConstColors.dark40,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}