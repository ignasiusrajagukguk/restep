import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:restep/config/app_asset.dart';

const kBgColor = Color(0xFFEEEDE6);
const kGreen = Color(0xFF4A7C59);
const kGreenLight = Color(0xFF5A9B6A);
const kGreenDark = Color(0xFF3A6347);
const kRed = Color(0xFFD94F3D);
const kTextDark = Color(0xFF1A1A1A);
const kTextMid = Color(0xFF6B6B6B);
const kTextLight = Color(0xFF9E9E9E);
const kCardBg = Color(0xFFFFFFFF);
const kDivider = Color(0xFFE0DFDA);

class ProductPassportScreen extends StatelessWidget {
  const ProductPassportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFEEEDE6),
        body: Column(
          children: [
            _buildAppBar(context, 'Premium Circular Tote'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    _buildProductImage(),
                    const SizedBox(height: 20),
                    _buildProductInfo(),
                    const SizedBox(height: 16),
                    _buildDetailsCard(),
                    const SizedBox(height: 16),
                    _buildTimeline(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            _buildViewQRButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 300,
        width: double.infinity,
        color: const Color(0xFFEDE8E0),
        child: Image.network(
          'https://images.unsplash.com/photo-1590874103328-eac38a683ce7?w=400&q=80',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProductInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Premium Circular Tote',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A1A),
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Produced from recycled footwear materials.',
          style: TextStyle(fontSize: 14, color: Color(0xFF6B6B6B), height: 1.4),
        ),
      ],
    );
  }

  Widget _buildDetailsCard() {
    return Container(
      decoration: BoxDecoration(
        color: kCardBg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildDetailRow(
            icon: Icons.store_outlined,
            label: 'Pickup Location',
            value: 'PLUS - Amsterdam',
            valueColor: Color(0xFF1A1A1A),
          ),
          Divider(height: 1, color: kDivider, indent: 48),
          _buildDetailRow(
            icon: Icons.monetization_on_outlined,
            label: 'Ecopunt Aangeschaft',
            value: '-100',
            valueColor: kRed,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Color(0xFFEEEDE6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: Color(0xFF6B6B6B)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 14, color: Color(0xFF6B6B6B)),
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
      ),
    );
  }

  Widget _buildTimeline() {
    return Column(
      children: [
        _buildTimelineItem(
          isActive: true,
          isDone: true,
          title: 'Ordered',
          subtitle:
              'Your order has been placed. It will be packed soon.',
          timestamp: '13:28 1 April 2026',
        ),
        _buildTimelineItem(
          isActive: true,
          isDone: true,
          title: 'On The Way',
          subtitle:
              'Your reward is on the way. It will ready for pick up soon.',
          timestamp: '13:08 2 April 2026',
        ),
        _buildTimelineItem(
          isActive: true,
          isDone: true,
          title: 'Ready for Pickup',
          subtitle:
              'Your reward is ready. Please collect it at the selected store.',
          timestamp: '13:08 3 April 2026',
        ),
        _buildTimelineItem(
          isActive: true,
          isDone: true,
          title: 'Picked up',
          subtitle:
              'Your order has been successfully picked up and completed.',
          isLast: true,
          timestamp: '11:00 4 April 2026',
        ),
      ],
    );
  }

  Widget _buildTimelineItem({
    required bool isActive,
    required bool isDone,
    required String title,
    required String subtitle,
    String? timestamp,
    bool isLast = false,
  }) {
    final dotColor = isActive ? Color(0xFF4A7C59) : const Color(0xFFCCCCC8);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 28,
            child: Column(
              children: [
                const SizedBox(height: 2),
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                  ),
                  child: isActive
                      ? const Center(
                          child: Icon(
                            Icons.check,
                            size: 8,
                            color: Colors.white,
                          ),
                        )
                      : null,
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: const Color(0xFFDDDDD8),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isActive ? Color(0xFF1A1A1A) : Color(0xFF6B6B6B),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF6B6B6B),
                      height: 1.4,
                    ),
                  ),
                  if (timestamp != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      timestamp,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4A7C59),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewQRButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      child: SizedBox(
        width: double.infinity,
        height: 54,
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => const QRCodeModal(),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF4A7C59),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 0,
          ),
          child: const Text(
            'View QR Code',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.maybePop(context),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: kCardBg,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.chevron_left,
                color: Color(0xFF1A1A1A),
                size: 22,
              ),
            ),
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1A1A),
              ),
            ),
          ),
          const SizedBox(width: 36),
        ],
      ),
    );
  }
}

class QRCodeModal extends StatelessWidget {
  const QRCodeModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Blurred background
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Container(color: Colors.black.withOpacity(0.3)),
        ),
        // Modal sheet
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.all(28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildCloseButton(context),
                  const SizedBox(height: 8),
                  const Text(
                    'Pick Up QR Code',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: kGreen,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Present this QR code at the store when\nit is ready for pickup',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6B6B6B),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Image.asset(ImageAsset.dummyQr, height: 200),
                  const SizedBox(height: 16),
                  const Text(
                    'Order code',
                    style: TextStyle(fontSize: 13, color: Color(0xFF6B6B6B)),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'VCH-8291-PLS',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: kTextDark,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildInstructions(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInstructions() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kBgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Instructions',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: kTextMid,
            ),
          ),
          const SizedBox(height: 10),
          _instructionItem(
            'Show this QR code at the store when pickup is available',
          ),
          _instructionItem('Make sure to present it before validation'),
          _instructionItem('Each voucher can only be used once'),
        ],
      ),
    );
  }

  Widget _instructionItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 5, right: 8),
            child: CircleAvatar(radius: 3, backgroundColor: kTextMid),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                color: kTextMid,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: kBgColor,
            shape: BoxShape.circle,
            border: Border.all(color: kDivider),
          ),
          child: const Icon(Icons.close, size: 16, color: kTextMid),
        ),
      ),
    );
  }
}
