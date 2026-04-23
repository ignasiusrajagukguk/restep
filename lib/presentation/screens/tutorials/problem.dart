
import 'package:flutter/material.dart';
import 'package:restep/common/constants/collors.dart';

class OnboardingProblemPage extends StatelessWidget {
  const OnboardingProblemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          // Top icon
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: const Color(0xFFDCE8D4),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.eco_outlined,
              color: Color(0xFF2E7D32),
              size: 30,
            ),
          ),

          const SizedBox(height: 20),

          // Label
          Text(
            "THE PROBLEM",
            style: TextStyle(
              color: ConstColors.green,
              letterSpacing: 1.5,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 10),

          // Title
          const Text(
            "Our planet is choking on waste",
            style: TextStyle(
              color: ConstColors.green,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          // Description
          Text(
            "Every year, billions of shoes, bags, and everyday items end up in landfills — many of which are perfectly recyclable. Most people don't throw things away carelessly. They just don't have a better option. Until now.",
            style: TextStyle(
              color: ConstColors.dark40,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 20),

          // 🔥 Stats Grid
          Row(
            children: const [
              Expanded(
                child: StatCard(
                  value: "92M",
                  subtitle: "tonnes of textile waste created globally per year",
                  color: Color(0xFF2E7D32),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: StatCard(
                  value: "500B",
                  subtitle: "plastic bags used worldwide every year",
                  color: Color(0xFFB26A00),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            children: const [
              Expanded(
                child: StatCard(
                  value: "30%",
                  subtitle: "of waste could be recycled but never is",
                  color: Color(0xFF4CAF50),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: StatCard(
                  value: "€0",
                  subtitle: "most people earn back from recyclable items",
                  color: Color(0xFF1976D2),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Footer text
          Text(
            "ReStep exists to close that gap — rewarding you every time you make the responsible choice.",
            style: TextStyle(
              color: Colors.grey.shade300,
            ),
          ),

          const Spacer(),
        ],
      ),
    );
  }
}class StatCard extends StatelessWidget {
  final String value;
  final String subtitle;
  final Color color;

  const StatCard({
    super.key,
    required this.value,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ConstColors.green),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              color: ConstColors.green,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
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