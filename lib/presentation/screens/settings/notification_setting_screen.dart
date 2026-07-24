import 'package:flutter/material.dart';
import 'package:restep/common/widgets/separator_widget.dart';

class NotificationSettingScreen extends StatefulWidget {
  const NotificationSettingScreen({super.key});

  @override
  State<NotificationSettingScreen> createState() =>
      _NotificationSettingScreenState();
}

class _NotificationSettingScreenState extends State<NotificationSettingScreen> {
  bool pushNotification = true;
  bool orderUpdates = true;
  bool promoOffers = false;
  bool rewardUpdates = true;
  bool newsletter = false;

  @override
  Widget build(BuildContext context) {
    const bgColor = Color(0xFFF0F0E8);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                children: [
                  const Text(
                    'Notification Preferences',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF111111),
                    ),
                  ),
                  SeparatorWidget.height10(),

                  _notificationSwitchCard(
                    icon: Icons.notifications_active_outlined,
                    title: 'Push Notifications',
                    subtitle: 'Allow notifications from this app',
                    value: pushNotification,
                    onChanged: (value) {
                      setState(() => pushNotification = value);
                    },
                  ),

                  _notificationSwitchCard(
                    icon: Icons.inventory_2_outlined,
                    title: 'Order Updates',
                    subtitle: 'Get notified when your order status changes',
                    value: orderUpdates,
                    onChanged: pushNotification
                        ? (value) {
                            setState(() => orderUpdates = value);
                          }
                        : null,
                  ),

                  _notificationSwitchCard(
                    icon: Icons.local_offer_outlined,
                    title: 'Promo & Offers',
                    subtitle: 'Receive special deals and promotions',
                    value: promoOffers,
                    onChanged: pushNotification
                        ? (value) {
                            setState(() => promoOffers = value);
                          }
                        : null,
                  ),

                  _notificationSwitchCard(
                    icon: Icons.card_giftcard_outlined,
                    title: 'Reward Updates',
                    subtitle: 'Notify me about points and rewards',
                    value: rewardUpdates,
                    onChanged: pushNotification
                        ? (value) {
                            setState(() => rewardUpdates = value);
                          }
                        : null,
                  ),

                  _notificationSwitchCard(
                    icon: Icons.mail_outline_rounded,
                    title: 'Newsletter',
                    subtitle: 'Receive news and product updates',
                    value: newsletter,
                    onChanged: pushNotification
                        ? (value) {
                            setState(() => newsletter = value);
                          }
                        : null,
                  ),

                  SeparatorWidget.height10(),

                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF7ED),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFFF97316).withValues(alpha: 0.25),
                      ),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          size: 20,
                          color: Color(0xFFF97316),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'You can change your notification preferences anytime.',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF9A3412),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
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
}

Widget _notificationSwitchCard({
  required IconData icon,
  required String title,
  required String subtitle,
  required bool value,
  required Function(bool)? onChanged,
}) {
  final bool disabled = onChanged == null;

  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: BoxDecoration(
      color: disabled ? Colors.white.withValues(alpha: 0.65) : Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 6,
          offset: const Offset(0, 1),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF7ED),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            size: 19,
            color: disabled
                ? const Color(0xFFF97316).withValues(alpha: 0.4)
                : const Color(0xFFF97316),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: disabled
                      ? const Color(0xFF111111).withValues(alpha: 0.4)
                      : const Color(0xFF111111),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: disabled
                      ? const Color(0xFF6B7280).withValues(alpha: 0.45)
                      : const Color(0xFF6B7280),
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: const Color(0xFFF97316),
        ),
      ],
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
          'Notifications',
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