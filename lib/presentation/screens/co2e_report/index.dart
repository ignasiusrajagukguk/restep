import 'package:flutter/material.dart';
import 'package:restep/common/constants/collors.dart';
import 'package:restep/presentation/screens/co2e_report/index.dart';


class PeriodData {
  final String totalCo2;
  final String badge;
  final String equiv;
  final int items;
  final int bags;
  final int points;
  final List<BarData> bars;
  final List<CategoryData>? categories;

  const PeriodData({
    required this.totalCo2,
    required this.badge,
    required this.equiv,
    required this.items,
    required this.bags,
    required this.points,
    required this.bars,
    this.categories,
  });
}

class BarData {
  final String label;
  final double recycling;
  final double ecoBags;
  const BarData(this.label, this.recycling, this.ecoBags);
}

class CategoryData {
  final String icon;
  final String name;
  final String subtitle;
  final String kg;
  final int percent;
  final Color color;
  const CategoryData({
    required this.icon,
    required this.name,
    required this.subtitle,
    required this.kg,
    required this.percent,
    required this.color,
  });
}

// ── Static data ───────────────────────────────────────────────────────────────

const _weekData = PeriodData(
  totalCo2: '2.8',
  badge: '+22% vs last week',
  equiv: '≈ 14 km not driven by a petrol car',
  items: 5,
  bags: 11,
  points: 68,
  bars: [
    BarData('Mon', 0.15, 0.08),
    BarData('Tue', 0.12, 0.12),
    BarData('Wed', 0.08, 0.18),
    BarData('Thu', 0.10, 0.05),
    BarData('Fri', 0.22, 0.18),
    BarData('Sat', 0.25, 0.35),
    BarData('Sun', 0.18, 0.32),
  ],
  categories: [
    CategoryData(icon: '👟', name: 'Shoes', subtitle: '2 pairs', kg: '1.4', percent: 50, color: Color(0xFF4CD964)),
    CategoryData(icon: '🛍️', name: 'Plastic bags', subtitle: '11 uses', kg: '0.8', percent: 29, color: Color(0xFF4A90D9)),
    CategoryData(icon: '👕', name: 'Clothing', subtitle: '1 item', kg: '0.4', percent: 14, color: Color(0xFFFF9F0A)),
    CategoryData(icon: '📦', name: 'Other', subtitle: '2 items', kg: '0.2', percent: 7, color: Color(0xFF8E8E93)),
  ],
);

const _monthData = PeriodData(
  totalCo2: '12.4',
  badge: '+18% vs last month',
  equiv: '≈ 62 km not driven by a petrol car',
  items: 23,
  bags: 47,
  points: 310,
  bars: [
    BarData('Nov', 0.45, 0.30),
    BarData('Dec', 0.60, 0.55),
    BarData('Jan', 0.50, 0.40),
    BarData('Feb', 0.55, 0.45),
    BarData('Mar', 0.70, 0.75),
    BarData('Apr', 0.65, 0.85),
  ],
);

const _yearData = PeriodData(
  totalCo2: '94.7',
  badge: '+34% vs last year',
  equiv: '≈ 474 km not driven by a petrol car',
  items: 142,
  bags: 310,
  points: 2140,
  bars: [
    BarData('Jan', 0.40, 0.30),
    BarData('Feb', 0.50, 0.40),
    BarData('Mar', 0.60, 0.50),
    BarData('Apr', 0.50, 0.70),
    BarData('May', 0.70, 0.60),
    BarData('Jun', 0.65, 0.80),
    BarData('Jul', 0.80, 0.75),
    BarData('Aug', 0.75, 0.85),
    BarData('Sep', 0.70, 0.90),
    BarData('Oct', 0.85, 0.80),
    BarData('Nov', 0.60, 0.70),
    BarData('Dec', 0.55, 0.50),
  ],
  categories: [
    CategoryData(icon: '👟', name: 'Shoes', subtitle: '52 pairs', kg: '40.2', percent: 42, color: Color(0xFF4CD964)),
    CategoryData(icon: '👕', name: 'Clothing', subtitle: '44 items', kg: '22.1', percent: 23, color: Color(0xFFFF9F0A)),
    CategoryData(icon: '🛍️', name: 'Plastic bags', subtitle: '310 uses', kg: '18.5', percent: 20, color: Color(0xFF4A90D9)),
    CategoryData(icon: '👜', name: 'Bags & pouches', subtitle: '24 items', kg: '13.9', percent: 15, color: Color(0xFFFF453A)),
  ],
);

// ── Colors ───────────────────────────────────────────────────────────────────

const _bg1 = Color(0xFF1C1C1E);
const _bg2 = Color(0xFF2C2C2E);
const _bg3 = Color(0xFF3A3A3C);
const _green = Color(0xFF4CD964);
const _greenDark = Color(0xFF3A7D44);
const _blue = Color(0xFF4A90D9);
const _textSecondary = Color(0xFF8E8E93);

// ── Main screen ───────────────────────────────────────────────────────────────

class Co2eReportScreen extends StatefulWidget {
  const Co2eReportScreen({super.key});

  @override
  State<Co2eReportScreen> createState() => _Co2eReportScreenState();
}

class _Co2eReportScreenState extends State<Co2eReportScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTab = 1; // 0=week, 1=month, 2=year

  final List<PeriodData> _periods = [_weekData, _monthData, _yearData];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() => _selectedTab = _tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  PeriodData get _current => _periods[_selectedTab];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ConstColors.green10,
        body: Column(
          children: [
            _buildHeader(),
            _buildTabs(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeroCard(),
                    _buildStatsRow(),
                    _buildChartSection(),
                    if (_current.categories != null) _buildBreakdownSection(),
                    _buildTipsSection(),
                    _buildBottomButtons(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Header ─────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: _iconButton(Icons.chevron_left_rounded)),
          const Spacer(),
          Column(
            children: [
               Text(
                'CO₂e Report',
                style: TextStyle(
                  color: ConstColors.dark40,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                'Your carbon footprint saved',
                style: TextStyle(color: _textSecondary, fontSize: 12),
              ),
            ],
          ),
          const Spacer(),
          _iconButton(Icons.ios_share_rounded),
        ],
      ),
    );
  }

  Widget _iconButton(IconData icon) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),border: Border.all(color: ConstColors.green)
      ),
      child: Icon(icon, color: ConstColors.dark40, size: 18),
    );
  }

  // ── Tabs ───────────────────────────────────────────────────────────────────

  Widget _buildTabs() {
    const labels = ['This week', 'This month', 'This year'];
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(2),
        child: Row(
          children: List.generate(3, (i) {
            final active = _selectedTab == i;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  _tabController.animateTo(i);
                  setState(() => _selectedTab = i);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: active ? _greenDark : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    labels[i],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: active ? ConstColors.white : _textSecondary,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  // ── Hero card ──────────────────────────────────────────────────────────────

  Widget _buildHeroCard() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [ConstColors.green30, ConstColors.green],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'TOTAL CO₂E SAVED',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _current.totalCo2,
                    style: const TextStyle(
                      color: ConstColors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.w700,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'kg CO₂ equivalent',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 160,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_downward_rounded,
                          color: _green, size: 12),
                      const SizedBox(width: 4),
                      Text(
                        _current.badge,
                        style: const TextStyle(
                            color: ConstColors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Text(
                  _current.equiv,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 11, height: 1.4),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ── Stats row ──────────────────────────────────────────────────────────────

  Widget _buildStatsRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
      child: Row(
        children: [
          _statCard('♻️', const Color(0xFFEC1C34), '${_current.items}',
              'Items recycled'),
          const SizedBox(width: 10),
          _statCard('🛍️', const Color(0xFF4B4B8C), '${_current.bags}',
              'Bag uses logged'),
          const SizedBox(width: 10),
          _statCard('⭐', const Color(0xFF07A57C),
              _current.points.toString(), 'Points earned'),
        ],
      ),
    );
  }

  Widget _statCard(
      String emoji, Color iconBg, String number, String label) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ConstColors.green)
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration:
                  BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(8)),
              child: Center(child: Text(emoji, style: const TextStyle(fontSize: 16))),
            ),
            const SizedBox(height: 6),
            Text(number,
                style: const TextStyle(
                    color: ConstColors.dark40,
                    fontSize: 20,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 2),
            Text(label,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(color: _textSecondary, fontSize: 10)),
          ],
        ),
      ),
    );
  }

  // ── Bar chart ──────────────────────────────────────────────────────────────

  Widget _buildChartSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('CO₂e saved over time',
                  style: TextStyle(
                      color: ConstColors.dark40,
                      fontSize: 15,
                      fontWeight: FontWeight.w600)),
              Row(
                children: [
                  _legendDot(_greenDark),
                  const SizedBox(width: 4),
                  const Text('Recycling',
                      style: TextStyle(color: ConstColors.dark40, fontSize: 11)),
                  const SizedBox(width: 10),
                  _legendDot(_blue),
                  const SizedBox(width: 4),
                  const Text('Eco bags',
                      style: TextStyle(color: ConstColors.dark40, fontSize: 11)),
                ],
              )
            ],
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), border: Border.all(color: ConstColors.green)),
            padding: const EdgeInsets.all(14),
            child: _BarChart(bars: _current.bars),
          ),
        ],
      ),
    );
  }

  Widget _legendDot(Color color) => Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
      );

  // ── Breakdown ──────────────────────────────────────────────────────────────

  Widget _buildBreakdownSection() {
    final cats = _current.categories!;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Breakdown by category',
                  style: TextStyle(
                      color: ConstColors.dark40,
                      fontSize: 15,
                      fontWeight: FontWeight.w600)),
              const Text('See all ↗️',
                  style: TextStyle(color: _green, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration( borderRadius: BorderRadius.circular(14),border: Border.all(color: ConstColors.green)),
            child: Column(
              children: cats.asMap().entries.map((e) {
                final i = e.key;
                final c = e.value;
                return Column(
                  children: [
                    _categoryRow(c),
                    if (i < cats.length - 1)
                      const Divider(
                          height: 0.5,
                          thickness: 0.5,
                          color: Color(0xFF3A3A3C),
                          indent: 14,
                          endIndent: 14),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _categoryRow(CategoryData c) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
                color: ConstColors.green10, borderRadius: BorderRadius.circular(10), border: Border.all(color: ConstColors.green)),
            child:
                Center(child: Text(c.icon, style: const TextStyle(fontSize: 18))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(c.name,
                    style: const TextStyle(
                        color: ConstColors.dark40,
                        fontSize: 14,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                Text(c.subtitle,
                    style:
                        const TextStyle(color: _textSecondary, fontSize: 11)),
                const SizedBox(height: 5),
                ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: LinearProgressIndicator(
                    value: c.percent / 100,
                    minHeight: 3,
                    backgroundColor: _bg3,
                    valueColor: AlwaysStoppedAnimation<Color>(c.color),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${c.kg} kg',
                  style: const TextStyle(
                      color: ConstColors.dark40,
                      fontSize: 14,
                      fontWeight: FontWeight.w600)),
              Text('${c.percent}%',
                  style:
                      const TextStyle(color: _textSecondary, fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }

  // ── Tips ───────────────────────────────────────────────────────────────────

  Widget _buildTipsSection() {
    const tips = [
      ('Recycle shoes & bags regularly.',
          'Footwear alone saves up to 4.2 kg CO₂e per pair kept out of landfill.'),
      ('Use your eco bag every trip.',
          'Replacing single-use plastic bags saves ~0.06 kg CO₂e per use — it adds up fast.'),
      ('Bring friends.',
          'Refer a friend and earn bonus points — and double the environmental impact.'),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('How to save more CO₂e',
              style: TextStyle(
                  color: ConstColors.dark40,
                  fontSize: 15,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration( borderRadius: BorderRadius.circular(14),border: Border.all(color: ConstColors.green)),
            padding: const EdgeInsets.all(14),
            child: Column(
              children: tips.map((t) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                              color: _green, shape: BoxShape.circle),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                                color: ConstColors.dark40, fontSize: 13, height: 1.5),
                            children: [
                              TextSpan(
                                  text: t.$1,
                                  style: const TextStyle(
                                      color: ConstColors.dark40,
                                      fontWeight: FontWeight.w600)),
                              TextSpan(text: ' ${t.$2}'),
                            ],
                          ),
                        ),
                      ),
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

  // ── Bottom buttons ─────────────────────────────────────────────────────────

  Widget _buildBottomButtons() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        children: [
          _outlineButton('Recycle more & earn points  ↗️',
              onTap: () {}),
          const SizedBox(height: 10),
          _outlineButton('Download full report', onTap: () {}),
        ],
      ),
    );
  }

  Widget _outlineButton(String label, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: ConstColors.green, width: 0.5),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: ConstColors.dark40, fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

// ── Bar chart widget ──────────────────────────────────────────────────────────

class _BarChart extends StatelessWidget {
  final List<BarData> bars;
  const _BarChart({required this.bars});

  @override
  Widget build(BuildContext context) {
    final maxVal = bars.fold<double>(
        0, (prev, b) => (b.recycling + b.ecoBags) > prev ? (b.recycling + b.ecoBags) : prev);

    return Column(
      children: [
        SizedBox(
          height: 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: bars.map((b) {
              final rH = (b.recycling / maxVal) * 90;
              final eH = (b.ecoBags / maxVal) * 90;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Container(
                          height: rH,
                          decoration: const BoxDecoration(
                            color: _greenDark,
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(3)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 1),
                      Expanded(
                        child: Container(
                          height: eH,
                          decoration: const BoxDecoration(
                            color: _blue,
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(3)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: bars.map((b) {
            return Expanded(
              child: Text(
                b.label,
                textAlign: TextAlign.center,
                style: const TextStyle(color: _textSecondary, fontSize: 10),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}