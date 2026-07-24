import 'package:flutter/material.dart';
import 'package:restep/common/constants/collors.dart';
import 'package:restep/config/app_asset.dart';

class BagDetailScreen extends StatelessWidget {
  const BagDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFE9EFEA),
        appBar: AppBar(
          backgroundColor: const Color(0xFFE9EFEA),
          elevation: 0,
          centerTitle: true,
          leading: const BackButton(color: Colors.black),
          title: const Text(
            "Bag Details",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildImage(),
                    const SizedBox(height: 16),

                    /// Title
                    const Text(
                      "Premium Circular Bag",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// Info Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        _InfoItem(title: "Date Ordered", value: "05 Jan 2026"),
                        _InfoItem(title: "Total Scans", value: "24x"),
                      ],
                    ),

                    const SizedBox(height: 16),

                    /// Points
                    const Text(
                      "Total Points Earned with this bag",
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "1200 pts",
                      style: TextStyle(
                        color: ConstColors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// Usage History
                    const Text(
                      "Usage History",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// List
                    ...List.generate(
                      4,
                      (index) => const Padding(
                        padding: EdgeInsets.only(bottom: 12),
                        child: UsageItem(),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// Bottom Button
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ConstColors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text("View QR Code"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        ImageAsset.bag2,
        height: 300,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}

/// ================= INFO ITEM =================
class _InfoItem extends StatelessWidget {
  final String title;
  final String value;

  const _InfoItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
      ],
    );
  }
}

/// ================= USAGE ITEM =================
class UsageItem extends StatelessWidget {
  const UsageItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          /// Logo
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Image.asset(ImageAsset.shopping),
          ),

          const SizedBox(width: 12),

          /// Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Image.asset(IconsAsset.plus, height: 12),
                    ),
                    Text(
                      'PLUS Amsterdam',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                Text(
                  "TRX-PLS-8291",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),

          /// Divider
          Container(height: 40, width: 1, color: Colors.grey.shade300),

          const SizedBox(width: 12),

          /// Points
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text(
                "+120",
                style: TextStyle(
                  color: ConstColors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 2),
              Text(
                "14 Feb 2026 12:16",
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
