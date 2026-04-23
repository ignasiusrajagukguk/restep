import 'package:flutter/material.dart';
import 'package:restep/config/app_asset.dart';

// ─── Data ────────────────────────────────────────────────────────────────────

class RewardItem {
  final String title;
  final String description;
  final int pts;
  final int? disc;
  final String imageUrl;
  final Color bgColor;

  const RewardItem({
    required this.title,
    this.disc,
    required this.description,
    required this.pts,
    required this.imageUrl,
    required this.bgColor,
  });
}

final List<RewardItem> rewards = [
  RewardItem(
    title: 'Recycled Shopping Bag',
    description: 'Made from recovered materials.',
    pts: 100,
    imageUrl: ImageAsset.bag1,
    bgColor: const Color(0xFFF3E8E8),
  ),
  RewardItem(
    title: 'Air Zoom Pegasus 41',
    description: 'Manufactured with verified recycled content.',
    pts: 2000,
    imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=300&q=80',
    bgColor: const Color(0xFFE8EFF3),
  ),
  RewardItem(
    title: 'Air Zoom Pegasus 41',
    description: 'Manufactured with verified recycled content.',
    pts: 2000,
    imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=300&q=80',
    bgColor: const Color(0xFFE8EFF3),
  ),
  RewardItem(
    title: 'Recycled Shopping Bag',
    description: 'Made from recovered materials.',
    pts: 100,
    imageUrl: ImageAsset.bag1,
    bgColor: const Color(0xFFF3E8E8),
  ),
  RewardItem(
    title: 'Recycled Shopping Bag',
    description: 'Made from recovered materials.',
    pts: 100,
    imageUrl: ImageAsset.bag1,
    bgColor: const Color(0xFFF3E8E8),
  ),
  RewardItem(
    title: 'Air Zoom Pegasus 41',
    description: 'Manufactured with verified recycled content.',
    pts: 2000,
    imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=300&q=80',
    bgColor: const Color(0xFFE8EFF3),
  ),
];

// ─── Screen ──────────────────────────────────────────────────────────────────

class RewardsCatalogScreen extends StatelessWidget {
  const RewardsCatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F0),
        body: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.78,
                ),
                itemCount: rewards.length,
                itemBuilder: (context, i) => _buildRewardCard(context,rewards[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── AppBar ───────────────────────────────────────────────────────────────
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
            'Rewards Catalog',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Color(0xFF111111),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
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
                Icons.search_rounded,
                size: 20,
                color: Color(0xFF111111),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Reward Card ──────────────────────────────────────────────────────────
  Widget _buildRewardCard(context, RewardItem item) {
    return GestureDetector(
      onTap: () {
        
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => ConfirmRedemptionScreen()),
        // );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image area
            Expanded(
              child: Container(
                width: double.infinity,
                color: item.bgColor,
                child: Image.network(
                  item.imageUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.image,
                    color: Color(0xFF9CA3AF),
                    size: 40,
                  ),
                ),
              ),
            ),
      
            // Info area
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF111111),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF9CA3AF),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${item.pts}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF16A34A),
                            ),
                          ),
                          Text(
                            ' ESG pts',
                            style: const TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF16A34A),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF16A34A),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Redeem',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
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