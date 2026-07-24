import 'package:flutter/material.dart';
import 'package:restep/common/widgets/separator_widget.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const bgColor = Color(0xFFF0F0E8);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                children: [
                  _headerCard(),
                  SeparatorWidget.height16(),

                  const Text(
                    'Privacy Policy',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF111111),
                    ),
                  ),
                  SeparatorWidget.height10(),

                  _policySection(
                    icon: Icons.person_outline_rounded,
                    title: 'Information We Collect',
                    description:
                        'ReStep may collect basic account information such as your name, email address, phone number, and profile details to manage your account and personalize your app experience.',
                  ),
                  _policySection(
                    icon: Icons.recycling_outlined,
                    title: 'Recycling Activity Data',
                    description:
                        'We may record your recycling activity, including submitted items, drop-off locations, points earned, rewards redeemed, and campaign participation to support app features.',
                  ),
                  _policySection(
                    icon: Icons.location_on_outlined,
                    title: 'Location Data',
                    description:
                        'Location information may be used to show nearby recycling points, supported store locations, and relevant sustainability activities. You can control location access from your device settings.',
                  ),
                  _policySection(
                    icon: Icons.card_giftcard_outlined,
                    title: 'Rewards & Points',
                    description:
                        'Your reward history, point balance, voucher redemptions, and campaign progress may be stored to provide accurate benefit tracking inside the app.',
                  ),
                  _policySection(
                    icon: Icons.notifications_outlined,
                    title: 'Notifications',
                    description:
                        'We may send notifications about recycling reminders, point updates, campaign announcements, reward availability, and important account information.',
                  ),
                  _policySection(
                    icon: Icons.lock_outline_rounded,
                    title: 'Data Protection',
                    description:
                        'We aim to protect user data with reasonable security practices. Your personal information is not intended to be sold or shared for unrelated purposes.',
                  ),
                  _policySection(
                    icon: Icons.delete_outline_rounded,
                    title: 'Account Deletion',
                    description:
                        'You may request account deletion through the app support channel. Some activity records may be retained when required for operational, legal, or reporting purposes.',
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
                            'This is dummy privacy policy content for UI presentation. Replace it with the official policy before production release.',
                            style: TextStyle(
                              fontSize: 13,
                              height: 1.35,
                              color: Color(0xFF9A3412),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SeparatorWidget.height16(),

                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF97316),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        Navigator.maybePop(context);
                      },
                      child: const Text(
                        'I Understand',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),

                  SeparatorWidget.height20(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _headerCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF7ED),
            borderRadius: BorderRadius.circular(13),
          ),
          child: const Icon(
            Icons.privacy_tip_outlined,
            size: 23,
            color: Color(0xFFF97316),
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your privacy matters',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF111111),
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Learn how ReStep handles account data, recycling activity, rewards, and location-based features.',
                style: TextStyle(
                  fontSize: 12.5,
                  height: 1.35,
                  color: Color(0xFF6B7280),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _policySection({
  required IconData icon,
  required String title,
  required String description,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    decoration: BoxDecoration(
      color: Colors.white,
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
      crossAxisAlignment: CrossAxisAlignment.start,
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
            color: const Color(0xFFF97316),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111111),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 12.5,
                  height: 1.4,
                  color: Color(0xFF6B7280),
                ),
              ),
            ],
          ),
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
          'Privacy & Policy',
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