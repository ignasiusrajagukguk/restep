import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:restep/config/app_asset.dart';

// ── Data Models ───────────────────────────────────────────────────────────────

class _RescueProduct {
  final String emoji;
  final String name;
  final String meta;
  final double originalPrice;
  final double rescuePrice;
  final int pointsToRedeem; // points needed to get for free
  final int pointsEarned;   // points earned when paying with money
  final String expiryLabel;
  final bool isFavourite;

  const _RescueProduct({
    required this.emoji,
    required this.name,
    required this.meta,
    required this.originalPrice,
    required this.rescuePrice,
    required this.pointsToRedeem,
    required this.pointsEarned,
    required this.expiryLabel,
    this.isFavourite = false,
  });
}

// ── Screen ────────────────────────────────────────────────────────────────────

class StoreDetailsScreen extends StatefulWidget {
  const StoreDetailsScreen({super.key});

  @override
  State<StoreDetailsScreen> createState() => _StoreDetailsScreenState();
}

class _StoreDetailsScreenState extends State<StoreDetailsScreen> {
  /// User's current point balance (would come from a provider/bloc in a real app)
  int _userPoints = 120;

  static const List<_RescueProduct> _products = [
    _RescueProduct(
      emoji: ImageAsset.broccoli,
      name: 'Organic broccoli · 500g',
      meta: 'Fresh produce · Size: one head',
      originalPrice: 1.89,
      rescuePrice: 0.90,
      pointsToRedeem: 45,
      pointsEarned: 9,
      expiryLabel: 'Exp. in 3 days',
    ),
    _RescueProduct(
      emoji: ImageAsset.sourdough,
      name: 'Sourdough loaf · 800g',
      meta: 'Bakery · Whole or sliced',
      originalPrice: 3.49,
      rescuePrice: 1.75,
      pointsToRedeem: 87,
      pointsEarned: 17,
      expiryLabel: 'Exp. in 2 days',
    ),
    _RescueProduct(
      emoji: ImageAsset.milk,
      name: 'Whole milk · 1L',
      meta: 'Dairy · Full fat',
      originalPrice: 1.20,
      rescuePrice: 0.60,
      pointsToRedeem: 30,
      pointsEarned: 6,
      expiryLabel: 'Exp. in 2 days',
    ),
    _RescueProduct(
      emoji: ImageAsset.tomatoes,
      name: 'Tomatoes · 6-pack',
      meta: 'Fresh produce · Vine tomatoes',
      originalPrice: 2.49,
      rescuePrice: 1.20,
      pointsToRedeem: 60,
      pointsEarned: 12,
      expiryLabel: 'Exp. in 3 days',
    ),
  ];

  void _onBuyWithMoney(_RescueProduct product) {
    setState(() => _userPoints += product.pointsEarned);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Ordered! +${product.pointsEarned} pts earned. Pick up at this store.',
        ),
        backgroundColor: const Color(0xFF2E7D32),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _onRedeemWithPoints(_RescueProduct product) {
    if (_userPoints >= product.pointsToRedeem) {
      setState(() => _userPoints -= product.pointsToRedeem);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Redeemed for free! −${product.pointsToRedeem} pts used.',
          ),
          backgroundColor: const Color(0xFF2E7D32),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      _showPartialPayDialog(product);
    }
  }

  /// When the user doesn't have enough points, offer a partial pay option.
  void _showPartialPayDialog(_RescueProduct product) {
    final int available = _userPoints;
    final int missing = product.pointsToRedeem - available;
    // 1 pt = €0.02  →  missing pts converted back to euros
    final double extraEuros = missing * 0.02;

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFFEFF5EE),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Not enough points',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              'You have $available pts but need ${product.pointsToRedeem} pts. '
              'Use all your points and pay €${extraEuros.toStringAsFixed(2)} to complete the order.',
              style: const TextStyle(color: Colors.black54, fontSize: 14, height: 1.5),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() => _userPoints = 0);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Ordered! Used $available pts + €${extraEuros.toStringAsFixed(2)}.',
                      ),
                      backgroundColor: const Color(0xFF2E7D32),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  'Pay €${extraEuros.toStringAsFixed(2)} + use $available pts',
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black54, fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFEFF5EE),
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  CustomScrollView(
                    slivers: [
                      // ── App Bar ──────────────────────────────────────────
                      SliverAppBar(
                        expandedHeight: 240,
                        pinned: true,
                        backgroundColor: const Color(0xFFEFF5EE),
                        leading: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              icon: const Icon(
                                Icons.chevron_left,
                                color: Colors.black,
                                size: 22,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ),
                        centerTitle: true,
                        title: const Text(
                          'Store Details',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        actions: [
                          // Points balance badge
                          Padding(
                            padding: const EdgeInsets.only(right: 14),
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2E7D32),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.star_rounded,
                                        color: Color(0xFFFDD835), size: 14),
                                    const SizedBox(width: 4),
                                    Text(
                                      '$_userPoints pts',
                                      style: const TextStyle(
                                        color: Color(0xFFC8E6C9),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                        flexibleSpace: FlexibleSpaceBar(
                          background: Stack(
                            fit: StackFit.expand,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 90),
                                decoration:
                                    const BoxDecoration(color: Color(0xFFCCD9CC)),
                                child: ClipRRect(
                                  child: Image.asset(
                                    ImageAsset.store,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      color: const Color(0xFFCCD9CC),
                                      child: const Icon(Icons.store,
                                          size: 60, color: Colors.white54),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // ── Content ──────────────────────────────────────────
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '1.2 km',
                                style: TextStyle(
                                  color: Color(0xFF4CAF50),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'PLUS Amsterdam',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: const [
                                  Text('Open',
                                      style: TextStyle(
                                          color: Color(0xFF4CAF50),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500)),
                                  Text(' • Closes 22:00',
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 14)),
                                ],
                              ),
                              const SizedBox(height: 20),
                              const Divider(
                                  color: Color(0xFFDDE8DD), thickness: 1),
                              const SizedBox(height: 16),

                              // Address & Recycle Box
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text('Address',
                                            style: TextStyle(
                                                color: Colors.black45,
                                                fontSize: 12)),
                                        SizedBox(height: 4),
                                        Text('Kinkerstraat 120,\nAmsterdam',
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                height: 1.4)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 1,
                                    height: 60,
                                    color: const Color(0xFFDDE8DD),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text('Recycle Box Location',
                                            style: TextStyle(
                                                color: Colors.black45,
                                                fontSize: 12)),
                                        SizedBox(height: 4),
                                        Text(
                                            'Near the main entrance, next to the shopping carts',
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                height: 1.4)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20),

                              // Map
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: SizedBox(
                                  height: 180,
                                  child: FlutterMap(
                                    options: MapOptions(
                                      initialCenter: LatLng(52.3676, 4.8945),
                                      initialZoom: 15,
                                    ),
                                    children: [
                                      TileLayer(
                                        urlTemplate:
                                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                        userAgentPackageName:
                                            'com.yourapp.restep',
                                      ),
                                      MarkerLayer(
                                        markers: [
                                          Marker(
                                            point: LatLng(52.3676, 4.8945),
                                            child: const Icon(
                                                Icons.location_pin,
                                                color: Colors.red,
                                                size: 36),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(height: 32),

                              // ── Rescue Products ──────────────────────────
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Rescue products',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'See all',
                                    style: TextStyle(
                                        color: Color(0xFF4CAF50),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Near-expiry items · Pick up at this store',
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 13),
                              ),
                              const SizedBox(height: 16),

                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _products.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(height: 16),
                                itemBuilder: (context, index) =>
                                    _ProductCard(
                                  product: _products[index],
                                  userPoints: _userPoints,
                                  onBuyWithMoney: () =>
                                      _onBuyWithMoney(_products[index]),
                                  onRedeemWithPoints: () =>
                                      _onRedeemWithPoints(_products[index]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // ── Get Directions button ────────────────────────────────
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
                      decoration:
                          const BoxDecoration(color: Color(0xFFEFF5EE)),
                      child: SizedBox(
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () {
                            // Launch maps
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4CAF50),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: const Text(
                            'Get Directions',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
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

// ── Product Card ──────────────────────────────────────────────────────────────

class _ProductCard extends StatefulWidget {
  final _RescueProduct product;
  final int userPoints;
  final VoidCallback onBuyWithMoney;
  final VoidCallback onRedeemWithPoints;

  const _ProductCard({
    required this.product,
    required this.userPoints,
    required this.onBuyWithMoney,
    required this.onRedeemWithPoints,
  });

  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard> {
  bool _isFav = false;

  bool get _hasEnoughPoints =>
      widget.userPoints >= widget.product.pointsToRedeem;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Image area ────────────────────────────────────────────────
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: Container(
                  height: 180,
                  width: double.infinity,
                  color: const Color(0xFFEFF5EE),
                  child: Image.asset(product.emoji,fit: BoxFit.cover,),
                ),
              ),

              // Expiry badge
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: const BoxDecoration(
                    color: Color(0xFFCC3300),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Text(
                    product.expiryLabel,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              // Favourite toggle
              Positioned(
                bottom: 10,
                right: 12,
                child: GestureDetector(
                  onTap: () => setState(() => _isFav = !_isFav),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.85),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _isFav ? Icons.favorite : Icons.favorite_border,
                      size: 18,
                      color: _isFav ? Colors.red : Colors.black54,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // ── Card body ─────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      height: 1.35),
                ),
                const SizedBox(height: 2),
                Text(
                  product.meta,
                  style: const TextStyle(color: Colors.black45, fontSize: 12),
                ),
                const SizedBox(height: 12),

                // Pricing row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Left: prices + earn label
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '€${_formatPrice(product.originalPrice)}',
                            style: const TextStyle(
                                color: Colors.black38,
                                fontSize: 12,
                                decoration: TextDecoration.lineThrough),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '€${_formatPrice(product.rescuePrice)}',
                            style: const TextStyle(
                                color: Color(0xFF2E7D32),
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                width: 14,
                                height: 14,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF4CAF50),
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: Text('+',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Earn ${product.pointsEarned} pts when buying',
                                style: const TextStyle(
                                    color: Color(0xFF4CAF50),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 10),

                    // Right: action buttons
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Buy with money
                        SizedBox(
                          height: 36,
                          child: ElevatedButton(
                            onPressed: widget.onBuyWithMoney,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4CAF50),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Buy €${_formatPrice(product.rescuePrice)}',
                              style: const TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),

                        // Redeem with points
                        SizedBox(
                          height: 36,
                          child: OutlinedButton(
                            onPressed: widget.onRedeemWithPoints,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF2E7D32),
                              side: const BorderSide(
                                  color: Color(0xFF4CAF50), width: 1.5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFF9A825),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  '${product.pointsToRedeem} pts for free',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Partial pay hint when points are insufficient
                        if (!_hasEnoughPoints) ...[
                          const SizedBox(height: 4),
                          Text(
                            'Or use ${widget.userPoints} pts + pay extra',
                            style: const TextStyle(
                                color: Colors.black38,
                                fontSize: 10),
                          ),
                        ],
                      ],
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

  String _formatPrice(double price) {
    if (price == price.truncateToDouble()) return price.toInt().toString();
    return price.toStringAsFixed(2).replaceAll('.', ',');
  }
}