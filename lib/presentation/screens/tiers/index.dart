import 'package:flutter/material.dart';
import 'package:restep/common/constants/collors.dart';
// ─── Tier Data ──────────────────────────────────────────────────────────────

class TierInfo {
  final String name, subLabel, range, description;
  final Color color, lightColor, darkColor;
  final List<Color> gradColors;
  final List<TierStat> stats;
  final List<TierPerk> perks;
  final bool isCurrent;
  final int minPts, maxPts;

  const TierInfo({
    required this.name, required this.subLabel, required this.range,
    required this.description, required this.color, required this.lightColor,
    required this.darkColor, required this.gradColors, required this.stats,
    required this.perks, required this.minPts, required this.maxPts,
    this.isCurrent = false,
  });
}

class TierStat { final String value, label; const TierStat(this.value, this.label); }
class TierPerk { final IconData icon; final String title, sub; final bool locked; const TierPerk({required this.icon, required this.title, required this.sub, required this.locked}); }

final List<TierInfo> allTiers = [
  TierInfo(name: 'Starter', subLabel: 'TIER 1 OF 5', range: '0 – 999 pts',
    description: 'You\'ve just joined the circular economy. Every small action counts — start recycling to earn your first points!',
    color: const Color(0xFF6B7280), lightColor: const Color(0xFFF9FAFB), darkColor: const Color(0xFF6B7280),
    gradColors: [const Color(0xFF9CA3AF), const Color(0xFF6B7280)], minPts: 0, maxPts: 999,
    stats: [TierStat('1×','Multiplier'), TierStat('0%','Discount'), TierStat('Basic','Access')],
    perks: [TierPerk(icon: Icons.recycling, title: 'Item tracking', sub: 'Track all recycled items', locked: false), TierPerk(icon: Icons.star_outline, title: 'Base Ecopunten', sub: '1× on every action', locked: false)]),
  TierInfo(name: 'Explorer', subLabel: 'TIER 2 OF 5', range: '1,000 – 1,999 pts',
    description: 'You\'re building great recycling habits. Keep it up to unlock even better perks at the next tier.',
    color: const Color(0xFFD6D6D6), lightColor: const Color(0xFFEFF6FF), darkColor: const Color(0xFFD6D6D6),
    gradColors: [const Color(0xFF7F7F7F), const Color(0xFFD6D6D6)], minPts: 1000, maxPts: 1999,
    stats: [TierStat('1.2×','Multiplier'), TierStat('5%','Discount'), TierStat('Early','Notifs')],
    perks: [TierPerk(icon: Icons.recycling, title: 'Item tracking', sub: 'Track all recycled items', locked: false), TierPerk(icon: Icons.star_outline, title: '1.2× Ecopunten boost', sub: 'On every recycling action', locked: false), TierPerk(icon: Icons.local_offer_outlined, title: '5% reward discount', sub: 'On all catalog items', locked: false)]),
  TierInfo(name: 'Guardian', subLabel: 'TIER 3 OF 5', range: '2,000 – 4,999 pts',
    description: 'You\'re a true sustainability guardian. Your recycling impact is making a real difference to our planet.',
    color: ConstColors.green30, lightColor: const Color(0xFFF0FDF4), darkColor: ConstColors.green30,
    gradColors: [ConstColors.green30, ConstColors.green], minPts: 2000, maxPts: 4999,
    isCurrent: true,
    stats: [TierStat('1.5×','Multiplier'), TierStat('10%','Discount'), TierStat('Priority','Queue')],
    perks: [TierPerk(icon: Icons.recycling, title: 'Priority recycling', sub: 'Skip the standard queue', locked: false), TierPerk(icon: Icons.star_outline, title: '1.5× Ecopunten boost', sub: 'On every recycling action', locked: false), TierPerk(icon: Icons.local_offer_outlined, title: '10% reward discount', sub: 'On all catalog items', locked: false), TierPerk(icon: Icons.bolt_outlined, title: 'Early access deals', sub: 'Special offers before others', locked: false)]),
  TierInfo(name: 'Champion', subLabel: 'TIER 4 OF 5', range: '5,000 – 9,999 pts',
    description: 'An elite recycler leading by example. You champion the circular economy with every action you take.',
    color: const Color(0xFF49497C), lightColor: const Color(0xFFFFFBEB), darkColor: const Color(0xFF49497C),
    gradColors: [const Color(0xFF6060A0), const Color(0xFF49497C)], minPts: 5000, maxPts: 9999,
    stats: [TierStat('2×','Multiplier'), TierStat('15%','Discount'), TierStat('VIP','Lane')],
    perks: [TierPerk(icon: Icons.recycling, title: 'VIP recycling lane', sub: 'Instant drop-off service', locked: true), TierPerk(icon: Icons.star_outline, title: '2× points boost', sub: 'Double on all actions', locked: true), TierPerk(icon: Icons.local_offer_outlined, title: '15% reward discount', sub: 'On all catalog items', locked: true), TierPerk(icon: Icons.bolt_outlined, title: 'Exclusive rewards', sub: 'Champion-only catalog items', locked: true)]),
  TierInfo(name: 'Legend', subLabel: 'TIER 5 OF 5', range: '10,000+ pts',
    description: 'The pinnacle of the circular economy. You are an absolute legend — inspiring others with every single action.',
    color: const Color(0xFFEC1C34), lightColor: const Color(0xFFF5F3FF), darkColor: const Color(0xFFEC1C34),
    gradColors: [const Color(0xFF630517), const Color(0xFFEC1C34)], minPts: 10000, maxPts: 999999,
    stats: [TierStat('3×','Multiplier'), TierStat('25%','Discount'), TierStat('Legend','Status')],
    perks: [TierPerk(icon: Icons.recycling, title: 'Dedicated recycling', sub: 'White-glove drop-off', locked: true), TierPerk(icon: Icons.star_outline, title: '3× points boost', sub: 'Triple on every action', locked: true), TierPerk(icon: Icons.local_offer_outlined, title: '25% reward discount', sub: 'On all catalog items', locked: true), TierPerk(icon: Icons.bolt_outlined, title: 'Legend exclusives', sub: 'Rarest catalog rewards', locked: true), TierPerk(icon: Icons.card_giftcard_outlined, title: 'Annual eco gift box', sub: 'Curated sustainable products', locked: true)]),
];

// ─── Sheet ───────────────────────────────────────────────────────────────────

class TierDetailSheet extends StatefulWidget {
  final int initialIndex;
  const TierDetailSheet({super.key, this.initialIndex = 2});
  @override State<TierDetailSheet> createState() => _TierDetailSheetState();
}

class _TierDetailSheetState extends State<TierDetailSheet> {
  late final PageController _pc;
  late int _idx;

  @override
  void initState() { super.initState(); _idx = widget.initialIndex; _pc = PageController(initialPage: _idx); }
  @override
  void dispose() { _pc.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xFFF8F8F4), borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        // handle
        Container(width: 36, height: 4, margin: const EdgeInsets.only(top: 14), decoration: BoxDecoration(color: const Color(0xFFD1D5DB), borderRadius: BorderRadius.circular(99))),
        // nav
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            _NavBtn(enabled: _idx > 0, left: true, onTap: () { _pc.previousPage(duration: const Duration(milliseconds: 320), curve: Curves.easeInOut); }),
            Row(children: List.generate(allTiers.length, (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: i == _idx ? 20 : 7, height: 7,
              decoration: BoxDecoration(color: i == _idx ? const Color(0xFF3A7D44) : const Color(0xFFE5E7EB), borderRadius: BorderRadius.circular(99)),
            ))),
            _NavBtn(enabled: _idx < allTiers.length - 1, left: false, onTap: () { _pc.nextPage(duration: const Duration(milliseconds: 320), curve: Curves.easeInOut); }),
          ]),
        ),
        // pages
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.72,
          child: PageView.builder(
            controller: _pc, itemCount: allTiers.length,
            onPageChanged: (i) => setState(() => _idx = i),
            itemBuilder: (_, i) => _TierPage(tier: allTiers[i], userPts: 3480),
          ),
        ),
      ]),
    );
  }
}

class _NavBtn extends StatelessWidget {
  final bool enabled, left;
  final VoidCallback onTap;
  const _NavBtn({required this.enabled, required this.left, required this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: enabled ? onTap : null,
    child: Container(
      width: 36, height: 36,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(99), border: Border.all(color: const Color(0xFFE5E7EB), width: 1.5)),
      child: Icon(left ? Icons.chevron_left_rounded : Icons.chevron_right_rounded, size: 22, color: enabled ? const Color(0xFF374151) : const Color(0xFFD1D5DB)),
    ),
  );
}

// ─── Single tier page ────────────────────────────────────────────────────────

class _TierPage extends StatelessWidget {
  final TierInfo tier;
  final int userPts;
  const _TierPage({required this.tier, required this.userPts});

  double get _progress {
    if (userPts <= tier.minPts) return 0;
    if (userPts >= tier.maxPts) return 1;
    return (userPts - tier.minPts) / (tier.maxPts - tier.minPts);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

        // ── Hero card ──
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: tier.gradColors, begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(children: [
            Positioned(top: -20, right: -20, child: Container(width: 120, height: 120, decoration: BoxDecoration(color: tier.darkColor.withOpacity(0.2), shape: BoxShape.circle))),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Container(
                  width: 52, height: 52, decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(14)),
                  child: const Icon(Icons.star_rounded, color: Colors.white, size: 28),
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text(tier.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: -0.5)),
                  Text(tier.subLabel, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white.withOpacity(0.7), letterSpacing: 0.5)),
                ]),
              ]),
              const SizedBox(height: 12),
              tier.isCurrent
                ? _HeroBadge(icon: Icons.check_circle_rounded, text: 'YOUR CURRENT TIER', active: true)
                : _HeroBadge(icon: userPts >= tier.minPts? Icons.lock_open_sharp: Icons.lock_outline_rounded, text: userPts >= tier.minPts ? 'UNLOCKED' : 'LOCKED — KEEP RECYCLING', active: false),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(99)),
                child: Text(tier.range, style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ]),
          ]),
        ),

        const SizedBox(height: 14),

        // ── Description ──
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFEAEDE6))),
          child: Text(tier.description, style: const TextStyle(fontSize: 13, color: Color(0xFF4B5563), height: 1.6)),
        ),

        // ── Stats ──
        const _SectionTitle('TIER STATS'),
        Row(children: tier.stats.map((s) => Expanded(child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFEAEDE6))),
          child: Column(children: [
            Text(s.value, style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: tier.color)),
            const SizedBox(height: 3),
            Text(s.label, style: const TextStyle(fontSize: 10, color: Color(0xFF9CA3AF), fontWeight: FontWeight.w500)),
          ]),
        ))).toList()),

        // ── Progress (current tier only) ──
        if (tier.isCurrent) ...[
          const _SectionTitle('YOUR PROGRESS'),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFEAEDE6))),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('Points to next tier', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF111111))),
                Text('${(_progress * 100).round()}%', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: tier.color)),
              ]),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(99),
                child: Stack(children: [
                  Container(height: 8, color: const Color(0xFFF3F4F6)),
                  FractionallySizedBox(
                    widthFactor: _progress,
                    child: Container(height: 8, decoration: BoxDecoration(gradient: LinearGradient(colors: tier.gradColors), borderRadius: BorderRadius.circular(99))),
                  ),
                ]),
              ),
              const SizedBox(height: 8),
              Text('3,480 / 5,000 pts · 1,520 pts to Champion', style: const TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
            ]),
          ),
        ],

        // ── Perks ──
        const _SectionTitle('PERKS'),
        ...tier.perks.map((p) => Opacity(
          opacity: p.locked ? 0.55 : 1.0,
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFEAEDE6))),
            child: Row(children: [
              Container(
                width: 40, height: 40,
                decoration: BoxDecoration(color: tier.lightColor, borderRadius: BorderRadius.circular(12)),
                child: Icon(p.icon, color: tier.color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(p.title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF111111))),
                Text(p.sub, style: const TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
              ])),
              Icon(p.locked ? Icons.lock_outline_rounded : Icons.check_circle_rounded, color: p.locked ? const Color(0xFFD1D5DB) : tier.color, size: 20),
            ]),
          ),
        )),
      ]),
    );
  }
}

class _HeroBadge extends StatelessWidget {
  final IconData icon; final String text; final bool active;
  const _HeroBadge({required this.icon, required this.text, required this.active});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: active ? Colors.white.withOpacity(0.3) : Colors.black.withOpacity(0.15),
      border: Border.all(color: active ? Colors.white.withOpacity(0.5) : Colors.white.withOpacity(0.2), width: 1.5),
      borderRadius: BorderRadius.circular(99),
    ),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, color: Colors.white, size: 12),
      const SizedBox(width: 5),
      Text(text, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: active ? Colors.white : Colors.white.withOpacity(0.75))),
    ]),
  );
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 18, bottom: 10),
    child: Text(text, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1, color: Color(0xFF9CA3AF))),
  );
}