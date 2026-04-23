import 'package:flutter/material.dart';
import 'package:restep/common/constants/collors.dart';
import 'dart:math' as math;

import 'package:restep/config/app_asset.dart';


// ─── Data ──────────────────────────────────────────────────────────────────────

class MaterialItem {
  final String name;
  final double percent;
  final double grams;
  final Color color;

  const MaterialItem({
    required this.name,
    required this.percent,
    required this.grams,
    required this.color,
  });
}

final List<MaterialItem> materials = [
  MaterialItem(name: 'Polyester', percent: 40, grams: 168, color: const Color(0xFF3B82F6)),
  MaterialItem(name: 'Rubber',    percent: 25, grams: 105, color: const Color(0xFF1F2937)),
  MaterialItem(name: 'EVA Foam',  percent: 20, grams: 84,  color: const Color(0xFF22C55E)),
  MaterialItem(name: 'Leather',   percent: 5,  grams: 21,  color: const Color(0xFFF97316)),
  MaterialItem(name: 'Metal',     percent: 3,  grams: 12,  color: const Color(0xFF9CA3AF)),
  MaterialItem(name: 'Others',    percent: 7,  grams: 30,  color: const Color(0xFFD1D5DB)),
];

// ─── Screen ────────────────────────────────────────────────────────────────────

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:  ConstColors.green10,
        body: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildShoeImage(),
                    _buildProductInfo(),
                    Divider(),
                    _buildSpecsGrid(),
                    Divider(),
                    _buildRecyclingStatus(),
                    Divider(),
                    _buildEnvironmentalInfo(),
                    Divider(),
                    _buildMaterialComposition(),
                    Divider(),
                    _buildRecycledBreakdown(),
                    _buildRecycledSummary(),
                    _buildVerificationSection(),
                    _buildBackButton(context),
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

  // ── AppBar ─────────────────────────────────────────────────────────────────

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
            'Product Passport',
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

  // ── Shoe Image ─────────────────────────────────────────────────────────────

  Widget _buildShoeImage() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      height: 180,
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          ImageAsset.item1,
          width: double.infinity,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => const Center(
            child: Icon(Icons.directions_run, size: 80, color: Color(0xFFF9F9F9)),
          ),
        ),
      ),
    );
  }
  // ── Product Info ───────────────────────────────────────────────────────────

  Widget _buildProductInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Nike Air Zoom Pegasus 41',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF111111),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'ID: NK-AZP40-ID-2409',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF9CA3AF),
            ),
          ),
        ],
      ),
    );
  }

  // ── Specs Grid ─────────────────────────────────────────────────────────────

  Widget _buildSpecsGrid() {
    final specs = [
      ['Brand', 'Nike'],
      ['Model', 'Air Zoom Pegasus 41'],
      ['Colorway', 'Black / Anthracite'],
      ['Size', 'EU 42'],
      ['Manufacturing Country', 'Indonesia'],
      ['Batch ID', 'ID-JKT-0924-B17'],
    ];

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          for (int i = 0; i < specs.length; i += 2)
            _buildSpecRow(specs[i], i + 1 < specs.length ? specs[i + 1] : null, i == specs.length - 2),
        ],
      ),
    );
  }

  Widget _buildSpecRow(List<String> left, List<String>? right, bool isLast) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(bottom: BorderSide(color: Color(0xFFF3F4F6))),
      ),
      child: Row(
        children: [
          Expanded(child: _buildSpecCell(left[0], left[1])),
          if (right != null) Expanded(child: _buildSpecCell(right[0], right[1])),
        ],
      ),
    );
  }

  Widget _buildSpecCell(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
        const SizedBox(height: 3),
        Text(value,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF111111))),
      ],
    );
  }

  // ── Recycling Status ───────────────────────────────────────────────────────

  Widget _buildRecyclingStatus() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recycling Status',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF111111),
            ),
          ),
          const SizedBox(height: 14),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                // Circular progress ring
                SizedBox(
                  width: 52,
                  height: 52,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomPaint(
                        size: const Size(52, 52),
                        painter: _CircularProgressPainter(
                          percent: 0.20,
                          color: const Color(0xFF6B7280),
                          strokeWidth: 4,
                        ),
                      ),
                      const Text(
                        '20%',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF111111),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Dropped',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111111),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'PLUS - Amsterdam, 18 Feb 2026',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Environmental Info ─────────────────────────────────────────────────────

  Widget _buildEnvironmentalInfo() {
    final rows = [
      ['carbon', 'Carbon Footprint', '9.8 kg CO₂e'],
      ['factory', 'Manufactured In', 'Tangerang, Indonesia'],
      ['calendar_mfg', 'Date of Manufacturing', '12 Sep 2025'],
      ['calendar_pur', 'Date of Purchase', '18 Feb 2026'],
    ];

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: rows.asMap().entries.map((entry) {
          final i = entry.key;
          final row = entry.value;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
            decoration: BoxDecoration(
              border: i < rows.length - 1
                  ? const Border(bottom: BorderSide(color: Color(0xFFF3F4F6)))
                  : null,
            ),
            child: Row(
              children: [
                _buildEnvIcon(row[0]),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(row[1],
                      style: const TextStyle(fontSize: 13, color: ConstColors.grayMedium20)),
                ),
                Text(row[2],
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF111111))),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEnvIcon(String type) {
    IconData icon;
    switch (type) {
      case 'carbon':
        icon = Icons.eco_rounded;
        break;
      case 'factory':
        icon = Icons.factory_outlined;
        break;
      default:
        icon = Icons.calendar_today_outlined;
    }
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color:  ConstColors.grayLight,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Icon(icon, size: 16, color: ConstColors.grayMedium20),
    );
  }

  // ── Material Composition ───────────────────────────────────────────────────

  Widget _buildMaterialComposition() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Material Composition',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF111111)),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Donut chart
                SizedBox(
                  width: 130,
                  height: 130,
                  child: CustomPaint(
                    painter: _DonutChartPainter(materials: materials),
                  ),
                ),
                const SizedBox(width: 20),
                // Legend
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: materials
                        .map((m) => _buildLegendItem(m))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(MaterialItem m) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: m.color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            '${m.percent.toInt()}% ${m.name}',
            style: const TextStyle(fontSize: 12, color: Color(0xFF374151)),
          ),
        ],
      ),
    );
  }

  // ── Recycled Breakdown ─────────────────────────────────────────────────────

  Widget _buildRecycledBreakdown() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recycled Breakdown',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF111111)),
              ),
              const Text(
                'Total: 420 g',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF22C55E)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...materials.map((m) => _buildBreakdownBar(m)),
        ],
      ),
    );
  }

  Widget _buildBreakdownBar(MaterialItem m) {
    // Special case for Rubber: show recycled fraction
    final bool isRubber = m.name == 'Rubber';
    final double recycledPct = isRubber ? 0.4 : 1.0; // 42g out of 105g ≈ 40%

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(m.name,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF374151))),
          const SizedBox(height: 6),
          Stack(
            children: [
              // background track
              Container(
                height: 9,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              // filled portion
              FractionallySizedBox(
                widthFactor: (m.percent / 100) * recycledPct,
                child: Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: m.color,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isRubber
                    ? '${m.percent.toInt()}% / 42 g'
                    : '${m.percent.toInt()}%',
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF374151)),
              ),
              Text(
                '${m.grams.toInt()} g',
                style: const TextStyle(
                    fontSize: 12, color: Color(0xFF9CA3AF)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Recycled Summary ───────────────────────────────────────────────────────
  Widget _buildRecycledSummary() {
    return Container(
      decoration: BoxDecoration(
        color: ConstColors.green.withValues(alpha: .1),
      ),
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          _buildSummaryRow('Recycled Weight', '210 g', isLast: false),
          _buildSummaryRow('Verified Recycled Content', '50%', isLast: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {required bool isLast}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(bottom: BorderSide(color: Color(0xFFF3F4F6))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 14, color: ConstColors.green)),
          Text(value,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: ConstColors.green)),
        ],
      ),
    );
  }

  // ── Verification Section ───────────────────────────────────────────────────

  Widget _buildVerificationSection() {
    final rows = [
      ['Verified by', 'TRACE', false],
      ['Audit Date', '30 Sept 2025', false],
      ['Certificate ID', 'GRS-ID-458923', false],
      ['Milieu Punten', '+120', true],
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Verification & Audit Section',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF111111)),
          ),
          const SizedBox(height: 14),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: rows.asMap().entries.map((entry) {
                final i = entry.key;
                final row = entry.value;
                final isLast = i == rows.length - 1;
                final isGreen = row[2] as bool;

                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    border: isLast
                        ? null
                        : const Border(
                            bottom: BorderSide(color: Color(0xFFF3F4F6))),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(row[0] as String,
                          style:  TextStyle(
                              fontSize: 14, color: isGreen
                                  ?  ConstColors.green
                                  : ConstColors.grayMedium20)),
                      Text(row[1] as String,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: isGreen
                                  ?  ConstColors.green
                                  : const Color(0xFF111111))),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // ── Back to Home Button ────────────────────────────────────────────────────

  Widget _buildBackButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: GestureDetector(
        onTap: () => Navigator.maybePop(context),
        child: Container(
          width: double.infinity,
          height: 52,
          decoration: BoxDecoration(
            color: ConstColors.green,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: ConstColors.green.withValues(alpha: 0.35),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: const Text(
            'View Material Journey',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Circular Progress Painter ─────────────────────────────────────────────────

class _CircularProgressPainter extends CustomPainter {
  final double percent;
  final Color color;
  final double strokeWidth;

  const _CircularProgressPainter({
    required this.percent,
    required this.color,
    this.strokeWidth = 4,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final trackPaint = Paint()
      ..color = const Color(0xFFE5E7EB)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, trackPaint);

    final progressPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * percent,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_CircularProgressPainter old) =>
      old.percent != percent || old.color != color;
}

// ─── Donut Chart Painter ───────────────────────────────────────────────────────

class _DonutChartPainter extends CustomPainter {
  final List<MaterialItem> materials;

  const _DonutChartPainter({required this.materials});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = size.width / 2;
    final strokeWidth = outerRadius * 0.38;
    final radius = outerRadius - strokeWidth / 2;

    double startAngle = -math.pi / 2;
    final gaps = 0.03; // radians gap between segments

    for (final m in materials) {
      final sweepAngle = (m.percent / 100) * 2 * math.pi - gaps;

      final paint = Paint()
        ..color = m.color
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.butt;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );

      startAngle += sweepAngle + gaps;
    }
  }

  @override
  bool shouldRepaint(_DonutChartPainter oldDelegate) => false;
}
