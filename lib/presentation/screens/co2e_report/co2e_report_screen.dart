import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:restep/common/constants/collors.dart';

// ─── Data Models ────────────────────────────────────────────────────────────

class Co2PeriodData {
  final String totalKg;
  final String changeLabel;
  final String equiv;
  final int itemsRecycled;
  final int bagUses;
  final int points;
  final List<double> recyclingData;
  final List<double> bagsData;
  final List<String> chartLabels;
  final List<Co2Category> categories;

  const Co2PeriodData({
    required this.totalKg,
    required this.changeLabel,
    required this.equiv,
    required this.itemsRecycled,
    required this.bagUses,
    required this.points,
    required this.recyclingData,
    required this.bagsData,
    required this.chartLabels,
    required this.categories,
  });
}

class Co2Category {
  final String name;
  final String subtitle;
  final String kg;
  final int pct;
  final Color color;
  final Color bgColor;
  final IconData icon;

  const Co2Category({
    required this.name,
    required this.subtitle,
    required this.kg,
    required this.pct,
    required this.color,
    required this.bgColor,
    required this.icon,
  });
}

// ─── Static Data ─────────────────────────────────────────────────────────────

const _week = Co2PeriodData(
  totalKg: '2.8',
  changeLabel: '+22% vs last week',
  equiv: '≈ 14 km not driven',
  itemsRecycled: 5,
  bagUses: 11,
  points: 68,
  recyclingData: [0.3, 0.4, 0.2, 0.5, 0.4, 0.6, 0.4],
  bagsData: [0.1, 0.2, 0.15, 0.2, 0.18, 0.22, 0.2],
  chartLabels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
  categories: [
    Co2Category(name: 'Shoes', subtitle: '2 pairs', kg: '1.4', pct: 50, color: Color(0xFF1A6B35), bgColor: Color(0xFFEAF3DE), icon: Icons.inventory_2_outlined),
    Co2Category(name: 'Plastic bags', subtitle: '11 uses', kg: '0.8', pct: 29, color: Color(0xFF185FA5), bgColor: Color(0xFFE6F1FB), icon: Icons.shopping_bag_outlined),
    Co2Category(name: 'Clothing', subtitle: '1 item', kg: '0.4', pct: 14, color: Color(0xFFBA7517), bgColor: Color(0xFFFAEEDA), icon: Icons.checkroom_outlined),
    Co2Category(name: 'Other', subtitle: '2 items', kg: '0.2', pct: 7, color: Color(0xFF888780), bgColor: Color(0xFFF1EFE8), icon: Icons.category_outlined),
  ],
);

const _month = Co2PeriodData(
  totalKg: '12.4',
  changeLabel: '+18% vs last month',
  equiv: '≈ 62 km not driven',
  itemsRecycled: 23,
  bagUses: 47,
  points: 310,
  recyclingData: [1.2, 2.1, 3.0, 2.4, 3.8, 4.0,3.8, 4.0,3.8, 4.0],
  bagsData: [0.8, 1.0, 1.5, 1.8, 2.2, 2.4, 2.2, 2.4, 2.2, 2.4],
  chartLabels: ['Date   1', '2', '3', '4', '5', '6', '7','8','9','10'],
  categories: [
    Co2Category(name: 'Shoes', subtitle: '8 pairs', kg: '5.2', pct: 42, color: Color(0xFF1A6B35), bgColor: Color(0xFFEAF3DE), icon: Icons.inventory_2_outlined),
    Co2Category(name: 'Plastic bags', subtitle: '47 uses', kg: '3.1', pct: 25, color: Color(0xFF185FA5), bgColor: Color(0xFFE6F1FB), icon: Icons.shopping_bag_outlined),
    Co2Category(name: 'Clothing', subtitle: '6 items', kg: '2.5', pct: 20, color: Color(0xFFBA7517), bgColor: Color(0xFFFAEEDA), icon: Icons.checkroom_outlined),
    Co2Category(name: 'Bags & pouches', subtitle: '4 items', kg: '1.6', pct: 13, color: Color(0xFF993556), bgColor: Color(0xFFFBEAF0), icon: Icons.backpack_outlined),
  ],
);

const _year = Co2PeriodData(
  totalKg: '94.7',
  changeLabel: '+34% vs last year',
  equiv: '≈ 474 km not driven',
  itemsRecycled: 142,
  bagUses: 310,
  points: 2140,
  recyclingData: [5.2, 6.1, 7.8, 8.4, 9.2, 11.0, 10.4, 9.8, 8.2, 7.6, 8.1, 3.0],
  bagsData: [2.4, 2.8, 3.1, 3.5, 3.8, 4.0, 3.9, 3.6, 3.2, 2.9, 2.7, 1.4],
  chartLabels: ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'],
  categories: [
    Co2Category(name: 'Shoes', subtitle: '52 pairs', kg: '40.2', pct: 42, color: Color(0xFF1A6B35), bgColor: Color(0xFFEAF3DE), icon: Icons.inventory_2_outlined),
    Co2Category(name: 'Clothing', subtitle: '44 items', kg: '22.1', pct: 23, color: Color(0xFFBA7517), bgColor: Color(0xFFFAEEDA), icon: Icons.checkroom_outlined),
    Co2Category(name: 'Plastic bags', subtitle: '310 uses', kg: '18.5', pct: 20, color: Color(0xFF185FA5), bgColor: Color(0xFFE6F1FB), icon: Icons.shopping_bag_outlined),
    Co2Category(name: 'Bags & pouches', subtitle: '24 items', kg: '13.9', pct: 15, color: Color(0xFF993556), bgColor: Color(0xFFFBEAF0), icon: Icons.backpack_outlined),
  ],
);

// ─── Screen ───────────────────────────────────────────────────────────────────

class Co2eReportScreen2 extends StatefulWidget {
  const Co2eReportScreen2({super.key});

  @override
  State<Co2eReportScreen2> createState() => _Co2eReportScreen2State();
}

class _Co2eReportScreen2State extends State<Co2eReportScreen2>
    with SingleTickerProviderStateMixin {
  int _tabIndex = 1;
  late AnimationController _animController;
  late Animation<double> _fadeAnim;

  static const _periods = [_week, _month, _year];
  static const _tabLabels = ['This week', 'This month', 'This year'];

  Co2PeriodData get _current => _periods[_tabIndex];

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeIn);
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _switchTab(int idx) {
    if (idx == _tabIndex) return;
    _animController.reset();
    setState(() => _tabIndex = idx);
    _animController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F0),
        body: Column(
          children: [
            _buildHeader(),
            _buildPeriodTabs(),
            Expanded(
              child: FadeTransition(
                opacity: _fadeAnim,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeroCard(),
                      const SizedBox(height: 16),
                      _buildStatRow(),
                      const SizedBox(height: 20),
                      _buildChartSection(),
                      const SizedBox(height: 20),
                      _buildBreakdownSection(),
                      const SizedBox(height: 20),
                      _buildTipsSection(),
                      const SizedBox(height: 20),
                      _buildCTASection(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Header ────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Row(
        children: [
          _iconButton(
            Icons.chevron_left_rounded,
            () => Navigator.maybePop(context),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('CO₂e Report',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                Text('Your carbon footprint saved',
                    style: TextStyle(fontSize: 12, color: Color(0xFF888780))),
              ],
            ),
          ),
          _iconButton(Icons.share_outlined, () {}),
        ],
      ),
    );
  }

  Widget _iconButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black.withValues(alpha: 0.08), width: 0.5),
        ),
        child: Icon(icon, size: 18, color: const Color(0xFF444441)),
      ),
    );
  }

  // ─── Period Tabs ───────────────────────────────────────────────────────────

  Widget _buildPeriodTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: List.generate(_tabLabels.length, (i) {
          final active = i == _tabIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => _switchTab(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: EdgeInsets.only(right: i < 2 ? 8 : 0, bottom: 14),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: active ? const Color(0xFF1A6B35) : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: active
                        ? const Color(0xFF1A6B35)
                        : Colors.black.withOpacity(0.08),
                    width: 0.5,
                  ),
                ),
                child: Text(
                  _tabLabels[i],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: active ? Colors.white : const Color(0xFF888780),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ─── Hero Card ─────────────────────────────────────────────────────────────

  Widget _buildHeroCard() {
    final d = _current;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [ConstColors.green30, ConstColors.green],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFC0DD97), width: 0.5),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'TOTAL CO₂E SAVED',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  d.totalKg,
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    height: 1.0,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'kg CO₂ equivalent',
                  style: TextStyle(fontSize: 13, color: Colors.white),
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: ConstColors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.arrow_downward_rounded,
                              size: 12, color: Color(0xFF27500A)),
                          const SizedBox(width: 4),
                          Text(
                            d.changeLabel,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${d.equiv}\nby a petrol car',
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                          fontSize: 11, color: Colors.white, height: 1.5),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ─── Stat Row ──────────────────────────────────────────────────────────────

  Widget _buildStatRow() {
    final d = _current;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          _statCard(d.itemsRecycled.toString(), 'Items\nrecycled',
              Icons.recycling_rounded, const Color(0xFFEAF3DE), const Color(0xFF3B6D11)),
          const SizedBox(width: 8),
          _statCard(d.bagUses.toString(), 'Bag uses\nlogged',
              Icons.shopping_bag_outlined, const Color(0xFFE6F1FB), const Color(0xFF185FA5)),
          const SizedBox(width: 8),
          _statCard(d.points.toString(), 'Points\nearned',
              Icons.star_rounded, const Color(0xFFFAEEDA), const Color(0xFFBA7517)),
        ],
      ),
    );
  }

  Widget _statCard(String value, String label, IconData icon,
      Color iconBg, Color iconColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black.withOpacity(0.06), width: 0.5),
        ),
        child: Column(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                  color: iconBg, borderRadius: BorderRadius.circular(8)),
              child: Icon(icon, size: 16, color: iconColor),
            ),
            const SizedBox(height: 8),
            Text(value,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w500)),
            const SizedBox(height: 2),
            Text(label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 10, color: Color(0xFF888780), height: 1.3)),
          ],
        ),
      ),
    );
  }

  // ─── Chart Section ─────────────────────────────────────────────────────────

  Widget _buildChartSection() {
    final d = _current;
    final maxY = List.generate(
      d.recyclingData.length,
      (i) => d.recyclingData[i] + d.bagsData[i],
    ).reduce((a, b) => a > b ? a : b);
    final yInterval = (maxY / 4).ceilToDouble();

    final groups = List.generate(d.recyclingData.length, (i) {
      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: d.recyclingData[i] + d.bagsData[i],
            width: 14,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
            rodStackItems: [
              BarChartRodStackItem(0, d.bagsData[i], const Color(0xFF185FA5)),
              BarChartRodStackItem(
                  d.bagsData[i], d.recyclingData[i] + d.bagsData[i], const Color(0xFF1A6B35)),
            ],
          ),
        ],
      );
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('CO₂e saved over time',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.fromLTRB(8, 14, 14, 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black.withOpacity(0.06), width: 0.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Row(
                    children: [
                      _legendDot(const Color(0xFF1A6B35), 'Recycling'),
                      const SizedBox(width: 14),
                      _legendDot(const Color(0xFF185FA5), 'Eco bags'),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 160,
                  child: BarChart(
                    BarChartData(
                      barGroups: groups,
                      maxY: maxY * 1.15,
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: yInterval,
                        getDrawingHorizontalLine: (_) => FlLine(
                          color: Colors.black.withOpacity(0.06),
                          strokeWidth: 0.5,
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      barTouchData: BarTouchData(
                        touchTooltipData: BarTouchTooltipData(
                          getTooltipColor: (_) => const Color(0xFF1A4D25),
                          getTooltipItem: (group, _, rod, rodIndex) {
                            final recycling = d.recyclingData[group.x];
                            final bags = d.bagsData[group.x];
                            return BarTooltipItem(
                              '${d.chartLabels[group.x]}\n',
                              const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600),
                              children: [
                                TextSpan(
                                  text:
                                      'Recycling: ${recycling.toStringAsFixed(1)} kg\nBags: ${bags.toStringAsFixed(1)} kg',
                                  style: const TextStyle(
                                      color: Color(0xFFC0DD97),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 36,
                            interval: yInterval,
                            getTitlesWidget: (val, _) => Text(
                              '${val.toStringAsFixed(0)}kg',
                              style: const TextStyle(
                                  fontSize: 9, color: Color(0xFF888780)),
                            ),
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 22,
                            getTitlesWidget: (val, _) {
                              final idx = val.toInt();
                              if (idx < 0 || idx >= d.chartLabels.length) {
                                return const SizedBox.shrink();
                              }
                              return Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  d.chartLabels[idx],
                                  style: const TextStyle(
                                      fontSize: 9, color: Color(0xFF888780)),
                                ),
                              );
                            },
                          ),
                        ),
                        topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                      ),
                    ),
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _legendDot(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration:
              BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
        ),
        const SizedBox(width: 5),
        Text(label,
            style: const TextStyle(fontSize: 11, color: Color(0xFF888780))),
      ],
    );
  }

  // ─── Breakdown Section ─────────────────────────────────────────────────────

  Widget _buildBreakdownSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Breakdown by category',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
              Text('Meer',
                  style: const TextStyle(fontSize: 11, color: Color(0xFF1A6B35))),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black.withOpacity(0.06), width: 0.5),
            ),
            child: Column(
              children: _current.categories.asMap().entries.map((e) {
                final last = e.key == _current.categories.length - 1;
                return _breakdownItem(e.value, last);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _breakdownItem(Co2Category cat, bool isLast) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(
                bottom: BorderSide(
                    color: Colors.black.withOpacity(0.06), width: 0.5)),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
                color: cat.bgColor,
                borderRadius: BorderRadius.circular(9)),
            child: Icon(cat.icon, size: 16, color: cat.color),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cat.name,
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w500)),
                Text(cat.subtitle,
                    style: const TextStyle(
                        fontSize: 11, color: Color(0xFF888780))),
                const SizedBox(height: 5),
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: LinearProgressIndicator(
                    value: cat.pct / 100,
                    backgroundColor: const Color(0xFFF1EFE8),
                    valueColor: AlwaysStoppedAnimation(cat.color),
                    minHeight: 5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${cat.kg} kg',
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w500)),
              Text('${cat.pct}%',
                  style: const TextStyle(
                      fontSize: 10, color: Color(0xFF888780))),
            ],
          ),
        ],
      ),
    );
  }

  // ─── Tips Section ──────────────────────────────────────────────────────────

  Widget _buildTipsSection() {
    const tips = [
      _Tip(
          title: 'Recycle shoes & bags regularly.',
          body: 'Footwear alone saves up to 4.2 kg CO₂e per pair kept out of landfill.'),
      _Tip(
          title: 'Use your eco bag every trip.',
          body: 'Replacing single-use plastic saves ~0.06 kg CO₂e per use — it adds up fast.'),
      _Tip(
          title: 'Bring friends.',
          body: 'Refer a friend and earn bonus points — and double the environmental impact.'),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('How to save more CO₂e',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black.withOpacity(0.06), width: 0.5),
            ),
            child: Column(
              children: tips.asMap().entries.map((e) {
                final last = e.key == tips.length - 1;
                return _tipItem(e.value, last);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tipItem(_Tip tip, bool isLast) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(
                bottom: BorderSide(
                    color: Colors.black.withOpacity(0.06), width: 0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              width: 7,
              height: 7,
              decoration: const BoxDecoration(
                  color: Color(0xFF1A6B35), shape: BoxShape.circle),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF888780),
                    height: 1.5,
                    fontFamily: 'sans-serif'),
                children: [
                  TextSpan(
                    text: '${tip.title} ',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2C2C2A)),
                  ),
                  TextSpan(text: tip.body),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── CTA Section ───────────────────────────────────────────────────────────

  Widget _buildCTASection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.star_rounded, size: 16),
              label: const Text('Recycle more & earn Ecopunten'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A6B35),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 0,
                textStyle: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF888780),
                padding: const EdgeInsets.symmetric(vertical: 12),
                side: BorderSide(
                    color: Colors.black.withOpacity(0.15), width: 0.5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Download full report',
                  style: TextStyle(fontSize: 13)),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Helper ───────────────────────────────────────────────────────────────────

class _Tip {
  final String title;
  final String body;
  const _Tip({required this.title, required this.body});
}

// ─── Entry point (for standalone testing) ────────────────────────────────────

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Co2eReportScreen2(),
  ));
}