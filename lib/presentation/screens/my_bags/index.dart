
import 'package:flutter/material.dart';
import 'package:restep/common/constants/collors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:restep/config/app_asset.dart';
import 'package:restep/presentation/screens/bag_details/index.dart';

class MyBagsScreen extends StatelessWidget {
  const MyBagsScreen({super.key});

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
            "My Shopping Bags",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildNewBagButton(),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children:  [
                    BagCard(
                      image:
                          ImageAsset.bag1,
                      title: "Premium Circular Bag",
                      points: "1200 pts",
                      isLimited: true,
                    ),
                    SizedBox(height: 16),
                    BagCard(
                      image:
                          ImageAsset.bag2,
                      title: "Premium Circular Bag",
                      points: "1500 pts",
                    ),
                    SizedBox(height: 16),
                    BagCard(
                      image:
                          ImageAsset.bag2,
                      title: "Premium Circular Bag",
                      points: "1000 pts",
                    ),
                    SizedBox(height: 16),
                    Image.asset(ImageAsset.promoCard)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewBagButton() {
    return DottedBorder(
    borderType: BorderType.RRect,
    radius: const Radius.circular(12),
    dashPattern: const [6, 3],
    color: ConstColors.green,
    strokeWidth: 1.5,
      child: Container(
        decoration: BoxDecoration(color: ConstColors.green.withValues(alpha: .1)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.add, color: ConstColors.green, size: 18,),
              const SizedBox(width: 6),
              Text(
                "Purchase Shopping Bags",
                style: TextStyle(
                  color: ConstColors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BagCard extends StatelessWidget {
  final String image;
  final String title;
  final String points;
  final bool isLimited;

  const BagCard({
    super.key,
    required this.image,
    required this.title,
    required this.points,
    this.isLimited = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BagDetailScreen()),
          );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: .6),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    image,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Produced from recycled footwear materials.",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Icon(Icons.calendar_today, size: 14),
                      SizedBox(width: 6),
                      Text(
                        "Date Ordered: 05 Jan 2026",
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.emoji_events_outlined, size: 14),
                      const SizedBox(width: 6),
                      Text(
                        "Points Collected: ",
                        style: const TextStyle(fontSize: 11),
                      ),
                      Text(
                        points,
                        style: const TextStyle(
                          fontSize: 11,
                          color: ConstColors.green,
                          fontWeight: FontWeight.bold,
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
    );
  }
}
