import 'package:flutter/material.dart';
import 'package:restep/common/constants/collors.dart';
import 'package:restep/config/app_asset.dart';
import 'package:restep/presentation/screens/tutorials/howitworks.dart';
import 'package:restep/presentation/screens/tutorials/problem.dart';
import 'package:restep/presentation/screens/tutorials/rewardspage.dart';
import 'package:restep/presentation/screens/tutorials/smartbag.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  void nextPage() {
    if (currentIndex < 5 - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  final OnboardingModel page1 = OnboardingModel(
    title: "Re-Step",
    subtitle:
        "A smarter way to recycle, shop greener, and earn rewards — all while helping our planet breathe.",
    image: ImageAsset.logoNew, // <-- YOU WILL CHANGE THIS
    features: [
      FeatureModel(
        icon: Icons.access_time,
        title: "Earn points",
        subtitle: "Turn old items into real value",
      ),
      FeatureModel(
        icon: Icons.shopping_bag,
        title: "Smart bags",
        subtitle: "QR bags replace plastic",
      ),
      FeatureModel(
        icon: Icons.star_border,
        title: "Real impact",
        subtitle: "Track your footprint",
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: ConstColors.green10,
        body: Column(
          children: [
            const SizedBox(height: 16),
              
            // Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: currentIndex == index ? 20 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: currentIndex == index
                        ? const Color(0xFF6BCB3D)
                        : Colors.grey.shade700,
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              }),
            ),
              
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (i) => setState(() => currentIndex = i),
                children: [OnboardingPage(data: page1), OnboardingProblemPage(), OnboardingHowItWorksPage(), OnboardingSmartBagPage(), OnboardingRewardsPage()],
              ),
            ),
              
            // Bottom Button
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                spacing: 8,
                children: [
                  if(currentIndex > 0)
                  Expanded(
                    child: GestureDetector(
                      onTap: ()=>Navigator.pop(context),
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade700),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("Skip", style: TextStyle(color: ConstColors.dark40)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: nextPage,
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade700),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("Next", style: TextStyle(color: ConstColors.dark40)),
                            SizedBox(width: 6),
                            Icon(Icons.arrow_forward, color: ConstColors.dark40),
                          ],
                        ),
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

class OnboardingPage extends StatelessWidget {
  final OnboardingModel data;

  const OnboardingPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const Spacer(),

          // 🔥 IMAGE (dynamic — you will replace later)
          Image.asset(data.image, height: 180, fit: BoxFit.contain),

          const SizedBox(height: 30),

          Text(
            "WELCOME TO ReStep",
            style: TextStyle(
              color: ConstColors.grayMedium20,
              letterSpacing: 1.5,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 6),

          const SizedBox(height: 16),

          Text(
            data.subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ConstColors.grayMedium20,
              fontSize: 14,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 30),

          Row(
            children: data.features
                .map((f) => Expanded(child: FeatureCard(data: f)))
                .toList(),
          ),

          const Spacer(),
        ],
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final FeatureModel data;

  const FeatureCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(12),
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ConstColors.green),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(data.icon, color: ConstColors.green, size: 20),
          const SizedBox(height: 12),
          Text(
            data.title,
            style: const TextStyle(
              color: ConstColors.grayMedium20,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            data.subtitle,
            style: TextStyle(color: ConstColors.grayMedium20, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class OnboardingModel {
  final String title;
  final String subtitle;
  final String image;
  final List<FeatureModel> features;

  OnboardingModel({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.features,
  });
}

class FeatureModel {
  final IconData icon;
  final String title;
  final String subtitle;

  FeatureModel({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}
