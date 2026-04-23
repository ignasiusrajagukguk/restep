
import 'package:flutter/material.dart';
import 'package:restep/common/constants/collors.dart';
import 'package:restep/config/app_asset.dart';
import 'package:restep/presentation/screens/tiers/index.dart';

class PointsCard extends StatefulWidget {
  const PointsCard({
    super.key
  });
  @override
  State<PointsCard> createState() => _PointsCardState();
}

class _PointsCardState extends State<PointsCard>  with SingleTickerProviderStateMixin{

  late AnimationController _animController;
  late Animation<double> _progressAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _progressAnim = Tween<double>(begin: 0, end: 3480 / 5000).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic),
    );
    Future.delayed(const Duration(milliseconds: 300), () {
      _animController.forward();
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 24),
      child: GestureDetector(
        onTap: () {
          
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => const TierDetailSheet(), // 2 = Guardian
      );
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [ConstColors.green30, ConstColors.green],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Stack(
            children: [
              // Decorative circle
              // Recycle icon watermark
              Positioned(
                top: 12,
                right: 20,
                child: Image.asset(
                  ImageAsset.logoNew,
                  color: Colors.white.withValues(alpha: 0.15),
                  width: 50,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: '3,480 ',
                            style: TextStyle(
                              fontSize: 44,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              height: 1,
                            ),
                          ),
                          TextSpan(
                            text: 'ESG points',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Your Tier: GUARDIAN',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Progress bar
                    AnimatedBuilder(
                      animation: _animController,
                      builder: (context, _) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(999),
                              child: Stack(
                                children: [
                                  Container(
                                    height: 8,
                                    color: Colors.white.withValues(alpha: 0.25),
                                  ),
                                  FractionallySizedBox(
                                    widthFactor: _progressAnim.value,
                                    child: Container(
                                      height: 8,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(999),
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFFFBBF24),
                                            Color(0xFFF59E0B),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              '1400 Points left to reach the next tier',
                              style: TextStyle(fontSize: 11, color: Colors.white70),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }}