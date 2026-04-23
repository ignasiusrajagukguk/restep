import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:latlong2/latlong.dart';
import 'package:restep/common/constants/collors.dart';
import 'package:restep/config/app_asset.dart';

// ─── pubspec.yaml dependencies needed ────────────────────────────────────────
//
//   flutter_map: ^7.0.2
//   flutter_map_animations: ^0.7.0
//   latlong2: ^0.9.1
//
// -----------------------------------------------------------------------------

// ─── Data Models ─────────────────────────────────────────────────────────────

class ShopDeal {
  final String id;
  final String name;
  final String distance;
  final String address;
  final String logoAsset;
  final Color logoColor;
  final String logoText;
  final List<DealItem> deals;
  final double mapLat;
  final double mapLng;

  const ShopDeal({
    required this.id,
    required this.name,
    required this.distance,
    required this.address,
    required this.logoAsset,
    required this.logoColor,
    required this.logoText,
    required this.deals,
    required this.mapLat,
    required this.mapLng,
  });
}

class DealItem {
  final String name;
  final int points;
  final int originalPoints;
  final String imageEmoji;

  const DealItem({
    required this.name,
    required this.points,
    required this.originalPoints,
    required this.imageEmoji,
  });
}

// ─── Sample Data ──────────────────────────────────────────────────────────────

final List<ShopDeal> sampleShops = [
  ShopDeal(
    id: '1',
    name: 'PLUS Amsterdam',
    distance: '0.3 km',
    address: 'Kinkerstraat 120, Amsterdam',
    logoAsset: '',
    logoColor: const Color(0xFF4CAF50),
    logoText: 'PLUS',
    deals: const [
      DealItem(name: 'Whole Wheat Bread', points: 50, originalPoints: 100, imageEmoji: '🍞'),
      DealItem(name: 'Sourdough Loaf', points: 40, originalPoints: 80, imageEmoji: '🥖'),
      DealItem(name: 'Rye Bread', points: 35, originalPoints: 70, imageEmoji: '🍞'),
      DealItem(name: 'Baguette', points: 25, originalPoints: 50, imageEmoji: '🥖'),
      DealItem(name: 'Croissant', points: 20, originalPoints: 40, imageEmoji: '🥐'),
    ],
    mapLat: 52.3676,
    mapLng: 4.9041,
  ),
  ShopDeal(
    id: '2',
    name: 'PLUS Jordaan',
    distance: '0.7 km',
    address: 'Westerstraat 44, Amsterdam',
    logoAsset: '',
    logoColor: const Color(0xFF4CAF50),
    logoText: 'PLUS',
    deals: const [
      DealItem(name: 'Greek Yogurt', points: 60, originalPoints: 120, imageEmoji: '🥛'),
      DealItem(name: 'Fresh Milk', points: 30, originalPoints: 60, imageEmoji: '🥛'),
      DealItem(name: 'Cheese Block', points: 80, originalPoints: 160, imageEmoji: '🧀'),
      DealItem(name: 'Butter', points: 45, originalPoints: 90, imageEmoji: '🧈'),
    ],
    mapLat: 52.3721,
    mapLng: 4.8902,
  ),
  ShopDeal(
    id: '3',
    name: 'PLUS De Pijp',
    distance: '1.2 km',
    address: 'Ferdinand Bolstraat 88, Amsterdam',
    logoAsset: '',
    logoColor: const Color(0xFF4CAF50),
    logoText: 'PLUS',
    deals: const [
      DealItem(name: 'Organic Apples', points: 45, originalPoints: 90, imageEmoji: '🍎'),
      DealItem(name: 'Bananas', points: 20, originalPoints: 40, imageEmoji: '🍌'),
      DealItem(name: 'Mixed Salad', points: 55, originalPoints: 110, imageEmoji: '🥗'),
      DealItem(name: 'Tomatoes', points: 30, originalPoints: 60, imageEmoji: '🍅'),
      DealItem(name: 'Avocado', points: 70, originalPoints: 140, imageEmoji: '🥑'),
    ],
    mapLat: 52.3548,
    mapLng: 4.8993,
  ),
];

// ─── Screen ───────────────────────────────────────────────────────────────────

class SpecialDealsScreen extends StatefulWidget {
  const SpecialDealsScreen({super.key});

  @override
  State<SpecialDealsScreen> createState() => _SpecialDealsScreenState();
}

class _SpecialDealsScreenState extends State<SpecialDealsScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController(
    viewportFraction: 0.88,
    initialPage: 0,
  );

  int _currentIndex = 0;

  // AnimatedMapController comes from the flutter_map_animations package.
  // It wraps a regular MapController and drives smooth pan/zoom animations
  // using the TickerProviderStateMixin on this State.
  late final AnimatedMapController _animatedMapController;

  @override
  void initState() {
    super.initState();

    _animatedMapController = AnimatedMapController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );

    _pageController.addListener(_onPageScroll);
  }

  void _onPageScroll() {
    final page = _pageController.page ?? 0;
    final newIndex = page.round().clamp(0, sampleShops.length - 1);
    if (newIndex != _currentIndex) {
      setState(() => _currentIndex = newIndex);
      final shop = sampleShops[newIndex];
      // animateTo smoothly pans + zooms the real map
      _animatedMapController.animateTo(
        dest: LatLng(shop.mapLat, shop.mapLng),
        zoom: 15.0,
      );
      HapticFeedback.lightImpact();
    }
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageScroll);
    _pageController.dispose();
    _animatedMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF0F0EB),
        body: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: Stack(
                children: [
                  // ── Real Map Layer ─────────────────────────────────────────
                  Positioned.fill(
                    child: FlutterMap(
                      // Pass the inner MapController that flutter_map expects.
                      // AnimatedMapController.mapController is that inner controller.
                      mapController: _animatedMapController.mapController,
                      options: MapOptions(
                        initialCenter: LatLng(
                          sampleShops[0].mapLat,
                          sampleShops[0].mapLng,
                        ),
                        initialZoom: 15.0,
                        // Disable user gestures so the map only moves when
                        // the card carousel changes.
                        interactionOptions: const InteractionOptions(
                          flags: InteractiveFlag.none,
                        ),
                      ),
                      children: [
                        // OSM tile layer — no API key needed
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.restep',
                        ),
                        // Markers layer
                        MarkerLayer(
                          markers: [
                            // Fixed user location pin
                            Marker(
                              point: const LatLng(52.366, 4.900),
                              width: 44,
                              height: 44,
                              child: const _UserPin(),
                            ),
                            // One marker per shop
                            ...List.generate(sampleShops.length, (i) {
                              final shop = sampleShops[i];
                              final isActive = i == _currentIndex;
                              return Marker(
                                point: LatLng(shop.mapLat, shop.mapLng),
                                width: 80,
                                height: 44,
                                child: _ShopMarker(
                                  label: shop.logoText,
                                  color: shop.logoColor,
                                  isActive: isActive,
                                ),
                              );
                            }),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // ── Bottom Card Carousel ───────────────────────────────────
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Page indicator dots
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(sampleShops.length, (i) {
                              final isActive = i == _currentIndex;
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.symmetric(horizontal: 3),
                                width: isActive ? 20 : 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: isActive
                                      ? const Color(0xFF4CAF50)
                                      : Colors.white.withValues(alpha: 0.7),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              );
                            }),
                          ),
                        ),
                        // Cards
                        SizedBox(
                          height: 210,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: sampleShops.length,
                            itemBuilder: (context, index) {
                              return _ShopCard(shop: sampleShops[index]);
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
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
            'Special Deals Near You',
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
}

// ─── User Pin ─────────────────────────────────────────────────────────────────

class _UserPin extends StatelessWidget {
  const _UserPin();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFE53935),
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Icon(Icons.person, color: Colors.white, size: 22),
    );
  }
}

// ─── Shop Marker ─────────────────────────────────────────────────────────────

class _ShopMarker extends StatelessWidget {
  final String label;
  final Color color;
  final bool isActive;

  const _ShopMarker({
    required this.label,
    required this.color,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isActive ? color : Colors.transparent,
          width: isActive ? 2 : 0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isActive ? 0.18 : 0.1),
            blurRadius: isActive ? 12 : 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: CircleAvatar(
        backgroundColor: ConstColors.white,
        child: Image.asset(ImageAsset.shopping, fit: BoxFit.cover),
      ),
    );
  }
}

// ─── Shop Card ────────────────────────────────────────────────────────────────

class _ShopCard extends StatelessWidget {
  final ShopDeal shop;

  const _ShopCard({required this.shop});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Shop header
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xFFE8E8E8),
                        width: 1,
                      ),
                    ),
                    child: Image.asset(ImageAsset.shopping, fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          shop.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1A1A1A),
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${shop.distance} • ${shop.address}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF888888),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F9F0),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.near_me_rounded,
                          size: 12,
                          color: Color(0xFF4CAF50),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          shop.distance,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF4CAF50),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(height: 1, color: Color(0xFFF0F0F0)),
              const SizedBox(height: 10),

              // First deal label
              Row(
                children: [
                  Text(
                    shop.deals.first.name,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${shop.deals.first.points} pts',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF4CAF50),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '${shop.deals.first.originalPoints} pts',
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFFBBBBBB),
                      decoration: TextDecoration.lineThrough,
                      decorationColor: Color(0xFFBBBBBB),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Product thumbnails row
              SizedBox(
                height: 56,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: shop.deals.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, i) {
                    return _ProductThumbnail(deal: shop.deals[i]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Product Thumbnail ────────────────────────────────────────────────────────

class _ProductThumbnail extends StatelessWidget {
  final DealItem deal;

  const _ProductThumbnail({required this.deal});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F0),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFEEEEEE), width: 1),
      ),
      child: Center(
        child: Text(deal.imageEmoji, style: const TextStyle(fontSize: 26)),
      ),
    );
  }
}