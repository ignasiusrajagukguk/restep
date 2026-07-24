import 'package:flutter/material.dart';
import 'package:restep/common/constants/collors.dart';
import 'package:restep/config/app_asset.dart';

class EarningDetailsScreen extends StatelessWidget {
  const EarningDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const bgColor = Color(0xFFF0F0E8);
    const greenText = Color(0xFF3A7D44);
    const labelColor = Color(0xFF8A8A8A);
    const valueColor = Color(0xFF1A1A1A);

    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            _buildAppBar(context),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Store image ──
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        color: const Color(0xFFD0D8C8),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Container(
                              decoration: const BoxDecoration(),
                              child: Image.asset(
                                ImageAsset.dummyAsset1,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: Image.asset(IconsAsset.plus, height: 12,),
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
                    const SizedBox(height: 4),
                    const Text(
                      'Kinkerstraat 120, Amsterdam',
                      style: TextStyle(fontSize: 13, color: labelColor),
                    ),

                    Divider(),

                    // ── Details card ──
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _DetailRow(
                            icon: IconsAsset.calendar,
                            label: 'Date & Time',
                            value: '12 Mar 2026 • 14:32',
                            valueColor: valueColor,
                          ),
                          const Divider(height: 24, color: Color(0xFFEEEEEE)),
                          _DetailRow(
                            icon: IconsAsset.medal,
                            label: 'Points Earned',
                            value: '+250',
                            valueColor: greenText,
                          ),
                          const Divider(height: 24, color: Color(0xFFEEEEEE)),
                          _DetailRow(
                            icon: IconsAsset.arrowSwapHorizontal,
                            label: 'Transaction ID',
                            value: 'TRX-PLS-8291',
                            valueColor: valueColor,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ── Notes card ──
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: ConstColors.grayLight.withValues(alpha: .5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Notes',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: labelColor,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _BulletItem(
                            'Points are awarded based on eligible purchases',
                          ),
                          const SizedBox(height: 6),
                          _BulletItem(
                            'Each transaction can only be counted once',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
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
          'Transactie Details',
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

class _DetailRow extends StatelessWidget {
  final String icon;
  final String label;
  final String value;
  final Color valueColor;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: ConstColors.grayLight,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Image.asset(icon, height: 16, color: const Color(0xFF8A8A8A)),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 14, color: Color(0xFF5A5A5A)),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}

class _BulletItem extends StatelessWidget {
  final String text;
  const _BulletItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '• ',
          style: TextStyle(fontSize: 14, color: Color(0xFF5A5A5A)),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 14, color: Color(0xFF5A5A5A)),
          ),
        ),
      ],
    );
  }
}
