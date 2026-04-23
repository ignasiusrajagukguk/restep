import 'package:flutter/material.dart';
import 'package:restep/common/widgets/separator_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const bgColor = Color(0xFFF0F0E8);

    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(context),
      
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // {'label': 'Notification', 'icon': Icons.notifications_outlined},
                    // {'label': 'Privacy', 'icon': Icons.lock_outlined},
                    // {'label': 'Language', 'icon': Icons.language_outlined},
                    // {'label': 'Terms & Conditions', 'icon': Icons.description_outlined},
                    const Text(
                      'Preferences',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111111),
                      ),
                    ),
                    SeparatorWidget.height10(),
                    menuWidget(Icons.notifications, 'Notifications', () {}),
                    menuWidget(Icons.language_outlined, 'Languages', () {}),
                    menuWidget(Icons.nightlight_outlined, 'Appearances', () {}),
                    SeparatorWidget.height10(),
                    const Text(
                      'Accounts',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111111),
                      ),
                    ),
                    SeparatorWidget.height10(),
                    menuWidget(Icons.person, 'Profile', () {}),
                    menuWidget(Icons.lock, 'Change Password', () {}),
                    menuWidget(Icons.security, 'Privacy & Security', () {}),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

menuWidget(IconData icon, String label, Function() action) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
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
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: const Color(0xFFFFF7ED),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, size: 18, color: const Color(0xFFF97316)),
      ),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFF111111),
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        size: 20,
        color: Color(0xFF9CA3AF),
      ),
      onTap: action,
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
          'Settings',
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