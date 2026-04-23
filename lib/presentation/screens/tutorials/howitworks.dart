import 'package:flutter/material.dart';
import 'package:restep/common/constants/collors.dart';

class OnboardingHowItWorksPage extends StatelessWidget {
  const OnboardingHowItWorksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                Icons.park_outlined,
                color: Color(0xFF2E7D32),
                size: 30,
              ),
            ),
      
            const SizedBox(height: 20),
      
            // Label
            Text(
              "HOW IT WORKS — RECYCLING",
              style: TextStyle(
                color: ConstColors.green,
                letterSpacing: 1.2,
                fontSize: 12,
              ),
            ),
      
            const SizedBox(height: 10),
      
            // Title
            const Text(
              "Drop it off. Earn points instantly.",
              style: TextStyle(
                color: ConstColors.green,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
      
            const SizedBox(height: 12),
      
            // Description
            Text(
              "Bring your worn-out shoes, bags, or accessories to any ReStep drop-off point. Our partners verify and process the materials, and your points land in your account the same day.",
              style: TextStyle(
                color: ConstColors.dark40,
                height: 1.5,
              ),
            ),
      
            const SizedBox(height: 20),
      
            // 🔥 Category Cards
            Row(
              children: const [
                Expanded(
                  child: CategoryCard(
                    icon: Icons.north,
                    title: "Shoes",
                    subtitle: "Sneakers, boots, any footwear",
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CategoryCard(
                    icon: Icons.shopping_bag_outlined,
                    title: "Bags",
                    subtitle: "Backpacks, totes, handbags",
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CategoryCard(
                    icon: Icons.add_circle_outline,
                    title: "Accessories",
                    subtitle: "Belts, wallets, small leather goods",
                  ),
                ),
              ],
            ),
      
            const SizedBox(height: 20),
      
            // 🔥 Sample Points Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: ConstColors.green),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Sample points earned",
                    style: TextStyle(color: ConstColors.green),
                  ),
                  SizedBox(height: 12),
      
                  PointRow(
                    icon: Icons.north,
                    title: "Running shoes",
                    subtitle: "Pair dropped off",
                    points: "+12 pts",
                  ),
                  Divider(),
      
                  PointRow(
                    icon: Icons.shopping_bag,
                    title: "Leather bag",
                    subtitle: "Single item dropped off",
                    points: "+8 pts",
                  ),
                  Divider(),
      
                  PointRow(
                    icon: Icons.circle_outlined,
                    title: "Belt",
                    subtitle: "Accessory item",
                    points: "+4 pts",
                  ),
                ],
              ),
            ),
      
            const SizedBox(height: 16),
      
            // 🔥 Highlight Banner
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFDCE8D4),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.access_time, color: Color(0xFF2E7D32)),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "1 point = €0.25 — redeemable at checkout or transferred to your account",
                      style: TextStyle(
                        color: Color(0xFF2E7D32),
                        fontWeight: FontWeight.w500,
                      ),
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
}
class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const CategoryCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ConstColors.green),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: ConstColors.green, size: 20),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: ConstColors.green,
              fontWeight: FontWeight.bold,
              fontSize: 13
            ),
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
class PointRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String points;

  const PointRow({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: ConstColors.green,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: ConstColors.dark40)),
              Text(
                subtitle,
                style: TextStyle(color: ConstColors.dark40, fontSize: 11),
              ),
            ],
          ),
        ),
        Text(
          points,
          style: const TextStyle(
            color: ConstColors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}