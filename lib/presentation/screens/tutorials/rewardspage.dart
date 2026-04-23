import 'package:flutter/material.dart';
import 'package:restep/common/constants/collors.dart';

class OnboardingRewardsPage extends StatelessWidget {
  const OnboardingRewardsPage({super.key});

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
                Icons.account_balance_wallet_outlined,
                color: Color(0xFF2E7D32),
                size: 30,
              ),
            ),

            const SizedBox(height: 20),

            // Label
            Text(
              "YOUR REWARDS",
              style: TextStyle(
                color: ConstColors.green,
                letterSpacing: 1.2,
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 10),

            // Title
            const Text(
              "Points that are actually worth something",
              style: TextStyle(
                color: ConstColors.green,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            // Description
            Text(
              "Every action in ReStep earns points. Points are real money — €0.25 each. Use them to save at checkout, redeem for vouchers, or cash them out.",
              style: TextStyle(color: ConstColors.dark40, height: 1.5),
            ),

            const SizedBox(height: 20),

            // 🔥 Wallet Card
            const WalletCard(),

            const SizedBox(height: 20),

            // 🔥 Actions
            Row(
              children: const [
                Expanded(
                  child: RewardActionCard(
                    icon: Icons.confirmation_number_outlined,
                    title: "Discount vouchers",
                    subtitle: "Redeem in-store at Plus",
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: RewardActionCard(
                    icon: Icons.sync_alt,
                    title: "Cash out",
                    subtitle: "Transfer directly to your bank",
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

class WalletCard extends StatelessWidget {
  const WalletCard({super.key});

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
        children: const [
          Text(
            "Your ReStep wallet",
            style: TextStyle(color: ConstColors.green),
          ),
          SizedBox(height: 12),

          WalletRow("Total points", "142 pts", isHighlight: true),
          Divider(),
          WalletRow("Estimated value", "€35.50"),
          Divider(),
          WalletRow("Items recycled", "18 items"),
          Divider(),
          WalletRow("QR bag scans", "34 trips"),
          Divider(),
          WalletRow("Plastic bags avoided", "~34 bags", isGreen: true),
        ],
      ),
    );
  }
}

class WalletRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isHighlight;
  final bool isGreen;

  const WalletRow(
    this.label,
    this.value, {
    super.key,
    this.isHighlight = false,
    this.isGreen = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(label, style: const TextStyle(color: ConstColors.dark40)),
        ),
        Text(
          value,
          style: TextStyle(
            color: isHighlight
                ? ConstColors.green
                : isGreen
                ? ConstColors.green
                : ConstColors.dark40,
            fontWeight: isGreen ? FontWeight.w800 : FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class RewardActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const RewardActionCard({
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
          Text(title, style: const TextStyle(color: ConstColors.green)),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(color: ConstColors.dark40, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
