import 'package:flutter/material.dart';
import 'package:restep/config/app_asset.dart';
import 'package:restep/presentation/screens/dashboard/index.dart';
import 'package:restep/presentation/screens/redeemed_details/confirm_redemption.dart';
import 'package:restep/presentation/screens/reward_catalog/index.dart';
import 'package:restep/presentation/screens/settings/index.dart';
import 'package:restep/presentation/screens/welcome_screen/index.dart';

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
    imageUrl: ImageAsset.item1,
    bgColor: const Color(0xFFE8EFF3),
  ),
  RewardItem(
    title: 'Air Zoom Pegasus 41',
    description: 'Manufactured with verified recycled content.',
    pts: 2000,
    imageUrl: ImageAsset.item1,
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
    imageUrl: ImageAsset.item1,
    bgColor: const Color(0xFFE8EFF3),
  ),
];

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  bool isSearching = false;
  final TextEditingController searchController = TextEditingController();
  final List<String> categories = ['All', 'Bags', 'Shoes', 'Lifestyle', 'Eco'];
  String selectedCategory = 'All';
  String searchQuery = '';

  final GlobalKey _avatarKey = GlobalKey();

  // ── Filtering logic ──────────────────────────────────────────────────────

  List<RewardItem> get filteredRewards {
    return rewards.where((item) {
      final matchesSearch = searchQuery.isEmpty ||
          item.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          item.description.toLowerCase().contains(searchQuery.toLowerCase());

      // Category filter — map chip labels to keywords in the title/description
      final matchesCategory = selectedCategory == 'All' ||
          item.title.toLowerCase().contains(selectedCategory.toLowerCase()) ||
          item.description.toLowerCase().contains(selectedCategory.toLowerCase());

      return matchesSearch && matchesCategory;
    }).toList();
  }

  void _onSearchChanged(String value) {
    setState(() => searchQuery = value);
  }

  void _toggleSearch() {
    setState(() {
      if (isSearching) {
        searchController.clear();
        searchQuery = '';
      }
      isSearching = !isSearching;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final results = filteredRewards;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF0F0EB),
        body: Column(
          children: [
            // ── AppBar ───────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: isSearching
                          ? TextField(
                              key: const ValueKey('search'),
                              controller: searchController,
                              autofocus: true,
                              onChanged: _onSearchChanged,
                              decoration: InputDecoration(
                                hintText: 'Search product...',
                                hintStyle: const TextStyle(
                                  color: Color(0xFF9CA3AF),
                                  fontSize: 15,
                                ),
                                border: InputBorder.none,
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Color(0xFF9CA3AF),
                                  size: 20,
                                ),
                              ),
                            )
                          : const Center(
                              key: ValueKey('title'),
                              child: Text(
                                'Shop',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF111111),
                                ),
                              ),
                            ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _toggleSearch,
                    child: isSearching
                        ? const Icon(Icons.close, color: Color(0xFF111111))
                        : Image.asset(IconsAsset.search),
                  ),
                ],
              ),
            ),

            // ── Category chips ───────────────────────────────────────────
            SizedBox(
              height: 44,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = selectedCategory == category;
                  return ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (_) =>
                        setState(() => selectedCategory = category),
                    selectedColor: const Color(0xFF16A34A),
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(
                      color:
                          isSelected ? Colors.white : const Color(0xFF111111),
                      fontWeight: FontWeight.w500,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Color(0xFFE5E7EB)),
                    ),
                  );
                },
              ),
            ),

            // ── Result count (shown while searching) ─────────────────────
            if (isSearching && searchQuery.isNotEmpty)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${results.length} result${results.length == 1 ? '' : 's'} for "$searchQuery"',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ),
              ),

            // ── Grid or empty state ──────────────────────────────────────
            Expanded(
              child: results.isEmpty
                  ? _buildEmptyState()
                  : GridView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 90),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.78,
                      ),
                      itemCount: results.length,
                      itemBuilder: (context, i) =>
                          _buildRewardCard(context, results[i]),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Empty state ──────────────────────────────────────────────────────────

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.search_off_rounded,
              size: 36,
              color: Color(0xFF9CA3AF),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'No products found',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111111),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Try a different keyword or category',
            style: TextStyle(
              fontSize: 13,
              color: const Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }

  // ── Reward Card ──────────────────────────────────────────────────────────

  Widget _buildRewardCard(BuildContext context, RewardItem item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ConfirmRedemptionScreen()),
        );
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
            Expanded(
              child: Container(
                width: double.infinity,
                color: item.bgColor,
                child: Image.asset(
                  item.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.image,
                    color: Color(0xFF9CA3AF),
                    size: 40,
                  ),
                ),
              ),
            ),
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
                    children: [
                      Text(
                        '${item.pts}',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF16A34A),
                        ),
                      ),
                      const Text(
                        ' ESG pts',
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF16A34A),
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

  // ── Profile popup (unchanged) ────────────────────────────────────────────

  void _showProfileMenu() {
    final RenderBox renderBox =
        _avatarKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    showMenu(
      context: context,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + size.height + 8,
        offset.dx + size.width,
        0,
      ),
      items: [
        _buildPopupHeader(),
        _buildDividerItem(),
        _buildPopupItem(
          icon: Icons.access_time_outlined,
          iconBg: const Color(0xFFD1FAE5),
          iconColor: const Color(0xFF10B981),
          title: 'Show My QR',
          subtitle: 'Recent actions',
          value: 'activity',
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => const MyQRCodeModal(),
            );
          },
        ),
        _buildPopupItem(
          icon: Icons.access_time_outlined,
          iconBg: const Color(0xFFD1FAE5),
          iconColor: const Color(0xFF10B981),
          title: 'Activity log',
          subtitle: 'Recent actions',
          value: 'activity',
        ),
        _buildPopupItem(
          icon: Icons.chat_bubble_outline,
          iconBg: const Color(0xFFD1FAE5),
          iconColor: const Color(0xFF10B981),
          title: 'Tutorials',
          subtitle: 'How to use',
          value: 'tutorials',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WelcomeScreen()),
            );
          },
        ),
        _buildPopupItem(
          icon: Icons.settings_outlined,
          iconBg: const Color(0xFFD1FAE5),
          iconColor: const Color(0xFF10B981),
          title: 'Settings',
          subtitle: 'Account, security',
          value: 'settings',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsScreen()),
            );
          },
        ),
        _buildPopupItem(
          icon: Icons.headset_mic_outlined,
          iconBg: const Color(0xFFD1FAE5),
          iconColor: const Color(0xFF10B981),
          title: 'Support',
          subtitle: 'Helpdesk',
          value: 'support',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsScreen()),
            );
          },
        ),
        _buildPopupItem(
          icon: Icons.logout,
          iconBg: const Color(0xFFFEE2E2),
          iconColor: const Color(0xFFEF4444),
          title: 'Sign Out',
          subtitle: 'Sign out from app',
          titleColor: const Color(0xFFEF4444),
          value: 'signout',
        ),
      ],
    ).then((value) {
      if (value == null) return;
      switch (value) {
        case 'activity':
          break;
        case 'tutorials':
          break;
        case 'settings':
          break;
        case 'support':
          break;
        case 'signout':
          break;
      }
    });
  }

  PopupMenuItem _buildPopupHeader() {
    return PopupMenuItem(
      enabled: false,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage('https://i.pravatar.cc/100?img=12'),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'John Doe',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111111),
                ),
              ),
              SizedBox(height: 2),
              Text(
                'johndoe@gmail.com',
                style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
              ),
              Text(
                '+31 63173912030',
                style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  PopupMenuItem _buildDividerItem() {
    return PopupMenuItem(
      enabled: false,
      height: 1,
      padding: EdgeInsets.zero,
      child: const Divider(height: 1),
    );
  }

  PopupMenuItem _buildPopupItem({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String value,
    Color? titleColor,
    VoidCallback? onTap,
  }) {
    return PopupMenuItem(
      value: value,
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: titleColor ?? const Color(0xFF111111),
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, size: 16, color: Color(0xFFD1D5DB)),
        ],
      ),
    );
  }
}