import 'package:flutter/material.dart';
import 'package:restep/common/constants/collors.dart';
import 'package:restep/common/widgets/separator_widget.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.green10,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                children: [
                  _appInfoCard(),
                  SeparatorWidget.height16(),

                  const Text(
                    'About ReStep',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF111111),
                    ),
                  ),
                  SeparatorWidget.height10(),

                  _aboutCard(
                    icon: Icons.recycling_outlined,
                    title: 'Recycle with Purpose',
                    description:
                        'ReStep helps users participate in sustainable recycling activities and track their contribution through the app.',
                  ),
                  _aboutCard(
                    icon: Icons.stars_outlined,
                    title: 'Earn ReStep Points',
                    description:
                        'Users can earn points from supported recycling submissions and use them for available rewards or campaigns.',
                  ),
                  _aboutCard(
                    icon: Icons.location_on_outlined,
                    title: 'Supported Drop-off Points',
                    description:
                        'The app helps users discover supported recycling locations and participating store points.',
                  ),
                  _aboutCard(
                    icon: Icons.card_giftcard_outlined,
                    title: 'Rewards & Campaigns',
                    description:
                        'ReStep connects sustainability actions with reward programs, vouchers, and eco-friendly campaigns.',
                  ),

                  SeparatorWidget.height16(),

                  _supportedByCard(),

                  SeparatorWidget.height20(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _appInfoCard() {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          width: 74,
          height: 74,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF7ED),
            borderRadius: BorderRadius.circular(22),
          ),
          child: const Icon(
            Icons.eco_outlined,
            size: 38,
            color: Color(0xFFF97316),
          ),
        ),
        SeparatorWidget.height12(),
        const Text(
          'ReStep',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Color(0xFF111111),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Recycle. Earn. Make an Impact.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF6B7280),
            fontWeight: FontWeight.w500,
          ),
        ),
        SeparatorWidget.height12(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF7ED),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Version 1.0.0',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFFF97316),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _aboutCard({
  required IconData icon,
  required String title,
  required String description,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 6,
          offset: const Offset(0, 1),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF7ED),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 19, color: const Color(0xFFF97316)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111111),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 12.5,
                  height: 1.4,
                  color: Color(0xFF6B7280),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _supportedByCard() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF7ED),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: const Color(0xFFF97316).withValues(alpha: 0.22),
      ),
    ),
    child: const Column(
      children: [
        Text(
          'Supported by',
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF9A3412),
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'INTERSPORT',
          style: TextStyle(
            fontSize: 18,
            color: Color(0xFF111111),
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
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
          'About',
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