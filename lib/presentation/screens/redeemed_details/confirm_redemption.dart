import 'package:flutter/material.dart';
import 'package:restep/common/constants/collors.dart';
import 'package:restep/common/widgets/separator_widget.dart';
import 'package:restep/config/app_asset.dart';
import 'package:restep/presentation/screens/reward_catalog/reward_reserved.dart';

const bgColor = Color(0xFFF0F0E8);
const greenText = Color(0xFF3A7D44);
const labelColor = Color(0xFF8A8A8A);
const valueColor = Color(0xFF1A1A1A);

// ─────────────────────────────────────────────────────────────────────────────
// SCREEN
// ─────────────────────────────────────────────────────────────────────────────
class ConfirmRedemptionScreen extends StatefulWidget {
  const ConfirmRedemptionScreen({super.key});

  @override
  State<ConfirmRedemptionScreen> createState() =>
      _ConfirmRedemptionScreenState();
}

class _ConfirmRedemptionScreenState extends State<ConfirmRedemptionScreen> {
  int image = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: ProductDetailWidget(imageIndex: image, onImageChanged: (i) => setState(() => image = i)),
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
            'Confirm Redemption',
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

// ─────────────────────────────────────────────────────────────────────────────
// PRODUCT DETAIL WIDGET
// Seluruh halaman (gambar + tab content) di-scroll dalam SATU CustomScrollView.
// Tab hanya mengubah state _selectedTab — tidak ada TabBarView sama sekali.
// ─────────────────────────────────────────────────────────────────────────────
class ProductDetailWidget extends StatefulWidget {
  final int imageIndex;
  final ValueChanged<int>? onImageChanged;

  const ProductDetailWidget({
    super.key,
    this.imageIndex = 0,
    this.onImageChanged,
  });

  @override
  State<ProductDetailWidget> createState() => _ProductDetailWidgetState();
}

class _ProductDetailWidgetState extends State<ProductDetailWidget> {
  // Tab
  int _selectedTab = 0; // 0 = Details, 1 = Reviews

  // Details state
  int _selectedColorIndex = 0;
  String _selectedLocation = 'PLUS - Amsterdam (0.5 km)';
  final TextEditingController _customNameController = TextEditingController();

  // Reviews state
  int _userRating = 0;
  final TextEditingController _reviewController = TextEditingController();

  static const Color _green = Color(0xFF4A7C4E);
  static const Color _textDark = Color(0xFF3A3A3A);
  static const Color _textLight = Color(0xFF8A8A8A);
  static const Color _cardBg = Color(0xFFE4E8DC);
  static const Color _inputBg = Color(0xFFE8ECE0);
  static const Color _orange = Color(0xFFF5A623);

  final List<Color> _colors = [
    const Color(0xFFD4913A),
    const Color(0xFF4A7C4E),
    const Color(0xFF2C2C2C),
    const Color(0xFFD9D9D9),
  ];

  final List<String> _locations = [
    'PLUS - Amsterdam (0.5 km)',
    'PLUS - Utrecht (2.1 km)',
    'PLUS - Rotterdam (3.4 km)',
  ];

  final List<_Review> _reviews = [
    _Review(
      name: 'Example Name',
      text: 'Surprisingly strong for a recycled product.',
      rating: 5,
      timeAgo: '2 weeks ago',
      avatarColor: const Color(0xFF4A7C4E),
    ),
    _Review(
      name: 'Example Name',
      text: 'Love the concept of recycled materials.',
      rating: 5,
      timeAgo: '3 weeks ago',
      avatarColor: const Color(0xFFD45A5A),
    ),
  ];

  @override
  void dispose() {
    _customNameController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  // ── Image list (reuse same URL for demo, replace with your real list) ──
  final List<String> _images = [
    ImageAsset.bag1,
    ImageAsset.bag1,
    ImageAsset.bag1,
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Product main image ──────────────────────────
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.asset(
                _images[widget.imageIndex],
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 10),

          // ── Thumbnail row ───────────────────────────────
          SizedBox(
            height: 80,
            child: Row(
              spacing: 10,
              children: List.generate(_images.length, (i) {
                final selected = widget.imageIndex == i;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => widget.onImageChanged?.call(i),
                    child: Container(
                      decoration: BoxDecoration(
                        border: selected
                            ? Border.all(color: ConstColors.green, width: 3)
                            : null,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: Image.asset(_images[i], fit: BoxFit.cover),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          const SizedBox(height: 20),

          // ── Points + rating row ─────────────────────────
          Row(
            children: [
              const Text(
                '100 pts',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: ConstColors.green,
                ),
              ),
              const Text(
                ' / ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: ConstColors.grayMedium20,
                ),
              ),
              const Icon(Icons.star, color: Color(0xffFFA33F), size: 20),
              const Text(
                '5.0',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: ConstColors.grayMedium20,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          const Text(
            'Premium Circular Bag',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: valueColor,
            ),
          ),

          const SizedBox(height: 4),

          const Text(
            'Produced from recycled footwear materials.',
            style: TextStyle(fontSize: 13, color: labelColor),
          ),

          const SizedBox(height: 20),

          // ── Tab Bar (manual, bukan TabBarView) ──────────
          _buildTabBar(),

          const Divider(height: 1, color: Color(0xFFCED4C4)),

          const SizedBox(height: 16),

          // ── Tab content (inline, bisa scroll) ───────────
          _selectedTab == 0 ? _buildDetailsContent() : _buildReviewsContent(),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  // ── Tab bar ──────────────────────────────────────────────
  Widget _buildTabBar() {
    return Row(
      children: [
        _tabItem('Details', 0),
        _tabItem('Reviews', 1),
      ],
    );
  }

  Widget _tabItem(String label, int index) {
    final selected = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selected ? _green : Colors.transparent,
              width: 2.5,
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            color: selected ? _green : _textLight,
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────
  // DETAILS CONTENT
  // ─────────────────────────────────────────────────────────
  Widget _buildDetailsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Select Colors
        _sectionLabel('Select Colors'),
        const SizedBox(height: 12),
        Row(
          children: List.generate(_colors.length, (i) {
            final selected = _selectedColorIndex == i;
            return GestureDetector(
              onTap: () => setState(() => _selectedColorIndex = i),
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _colors[i],
                  shape: BoxShape.circle,
                ),
                child: selected
                    ? const Icon(Icons.check, color: Colors.white, size: 22)
                    : null,
              ),
            );
          }),
        ),

        const SizedBox(height: 28),

        // Select Pickup Locations
        _sectionLabel('Select Pickup Locations'),
        const SizedBox(height: 12),
        _styledDropdown(),

        const SizedBox(height: 28),

        // Custom Name
        _sectionLabel('Custom Name'),
        const SizedBox(height: 12),
        _styledTextField(controller: _customNameController, hint: 'Type here...'),

        const SizedBox(height: 24),

        // ── Points calculation card ──
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Points Calculation',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: valueColor,
                ),
              ),
              const SizedBox(height: 16),
              _PointsRow(label: 'Current Balance', value: '3480', valueColor: greenText),
              const SizedBox(height: 12),
              _PointsRow(label: 'Points to Redeem', value: '100', valueColor: greenText),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Divider(color: Color(0xFFEEEEEE)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F0E8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  children: [
                    Text(
                      'Remaining Balance',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: greenText,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '3380',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: greenText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),
        _buildSpecialDealsSection(),
        const SizedBox(height: 24),

        // ── Confirm button ──
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RewardReservedScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3A7D44),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              elevation: 0,
            ),
            child: const Text(
              'Confirm Redemption',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
        ),

        const SizedBox(height: 12),

        // ── Cancel button ──
        SizedBox(
          width: double.infinity,
          height: 52,
          child: OutlinedButton(
            onPressed: () => Navigator.maybePop(context),
            style: OutlinedButton.styleFrom(
              foregroundColor: valueColor,
              side: const BorderSide(color: Color(0xFFCCCCCC)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────
  // REVIEWS CONTENT
  // ─────────────────────────────────────────────────────────
  Widget _buildReviewsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Write a review ──
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage('https://i.pravatar.cc/56?img=8'),
              backgroundColor: _cardBg,
            ),
            const SizedBox(width: 16),
            Row(
              children: List.generate(5, (i) {
                return GestureDetector(
                  onTap: () => setState(() => _userRating = i + 1),
                  child: Icon(
                    i < _userRating ? Icons.star : Icons.star_border,
                    color: i < _userRating ? _orange : const Color(0xFFCCCCCC),
                    size: 32,
                  ),
                );
              }),
            ),
          ],
        ),

        const SizedBox(height: 16),

        _styledTextField(
          controller: _reviewController,
          hint: 'Type here...',
          maxLines: 3,
        ),

        const SizedBox(height: 24),
        const Divider(color: Color(0xFFCED4C4)),

        // ── Existing reviews ──
        ..._reviews.map((r) => _buildReviewItem(r)),
      ],
    );
  }

  Widget _buildReviewItem(_Review review) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: review.avatarColor.withOpacity(0.25),
              child: Icon(Icons.person, color: review.avatarColor, size: 28),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: _textDark,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(review.text,
                      style: const TextStyle(fontSize: 14, color: _textDark)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      ...List.generate(
                        5,
                        (i) => Icon(
                          i < review.rating ? Icons.star : Icons.star_border,
                          color: _orange,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        review.rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 14,
                          color: _textDark,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(review.timeAgo,
                      style: const TextStyle(fontSize: 12, color: _textLight)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Divider(color: Color(0xFFCED4C4), height: 1),
      ],
    );
  }

  // ── Shared helpers ───────────────────────────────────────
  Widget _sectionLabel(String text) => Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          color: _textLight,
          fontWeight: FontWeight.w400,
        ),
      );

  Widget _styledDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      decoration: BoxDecoration(
        color: _inputBg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedLocation,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: _textDark),
          style: const TextStyle(
              color: _textDark, fontSize: 15, fontWeight: FontWeight.w400),
          dropdownColor: _inputBg,
          borderRadius: BorderRadius.circular(14),
          items: _locations
              .map((l) => DropdownMenuItem(value: l, child: Text(l)))
              .toList(),
          onChanged: (v) => setState(() => _selectedLocation = v!),
        ),
      ),
    );
  }

  Widget _styledTextField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: _inputBg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(color: _textDark, fontSize: 15),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: _textLight, fontSize: 15),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared sub-widgets & models
// ─────────────────────────────────────────────────────────────────────────────
class _PointsRow extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;

  const _PointsRow({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label,
            style: const TextStyle(fontSize: 14, color: Color(0xFF5A5A5A))),
        const Spacer(),
        Text(value,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: valueColor)),
      ],
    );
  }
}

class _Review {
  final String name;
  final String text;
  final int rating;
  final String timeAgo;
  final Color avatarColor;

  const _Review({
    required this.name,
    required this.text,
    required this.rating,
    required this.timeAgo,
    required this.avatarColor,
  });
}
// ── Speciale Aanbiedingen ────────────────────────────────
Widget _buildSpecialDealsSection() {
  final List<_DealItem> deals = [
    _DealItem(name: 'Circular Bag',   pts: 80,  originalPts: 100, discount: '-20%', imageUrl: 'https://images.unsplash.com/photo-1590874103328-eac38a683ce7?w=200&q=60'),
    _DealItem(name: 'Eco Sneakers',   pts: 170, originalPts: 200, discount: '-15%', imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=200&q=60'),
    _DealItem(name: 'Reusable Cup',   pts: 35,  originalPts: 50,  discount: '-30%', imageUrl: 'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=200&q=60'),
    _DealItem(name: 'Tote Bag',       pts: 45,  originalPts: 50,  discount: '-10%', imageUrl: 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=200&q=60'),
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Header row
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Speciale Aanbiedingen',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: valueColor),
          ),
          GestureDetector(
            onTap: () { /* navigate to all deals */ },
            child: const Text(
              'See more',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: greenText),
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
      // Horizontal scroll
      SizedBox(
        height: 158,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: deals.length,
          separatorBuilder: (_, __) => const SizedBox(width: 10),
          itemBuilder: (context, i) => _buildDealCard(deals[i]),
        ),
      ),
    ],
  );
}

Widget _buildDealCard(_DealItem deal) {
  return Container(
    width: 140,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: const Color(0xFFE0E4D8), width: 0.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                height: 80,
                width: double.infinity,
                child: Image.network(deal.imageUrl, fit: BoxFit.cover),
              ),
            ),
            Positioned(
              top: 6, left: 6,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF3A7D44),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  deal.discount,
                  style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          deal.name,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: valueColor),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 3),
        Row(
          children: [
            Text(
              '${deal.pts} pts',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: greenText),
            ),
            const SizedBox(width: 5),
            Text(
              '${deal.originalPts} pts',
              style: const TextStyle(
                fontSize: 11,
                color: labelColor,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// Model
class _DealItem {
  final String name, imageUrl, discount;
  final int pts, originalPts;
  const _DealItem({required this.name, required this.pts, required this.originalPts, required this.discount, required this.imageUrl});
}