import 'package:flutter/material.dart';
import 'package:restep/common/constants/collors.dart';
import 'package:restep/common/widgets/separator_widget.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.green10,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                children: [
                  _faqHeader(),
                  SeparatorWidget.height16(),

                  const Text(
                    'Frequently Asked Questions',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF111111),
                    ),
                  ),
                  SeparatorWidget.height10(),

                  _faqItem(
                    question: 'How do I submit my recycling activity?',
                    answer:
                        'Open the recycling feature in ReStep, choose the item category, enter the quantity, and follow the submission steps to complete your recycling activity.',
                  ),
                  _faqItem(
                    question: 'How do I earn ReStep points?',
                    answer:
                        'Points are earned after successful recycling submissions, selected campaigns, and other supported activities available in the app.',
                  ),
                  _faqItem(
                    question: 'Where can I see my rewards or vouchers?',
                    answer:
                        'Your available rewards, redeemed vouchers, and point balance can be viewed from the Rewards section in the app.',
                  ),
                  _faqItem(
                    question: 'Can I find nearby recycling drop-off locations?',
                    answer:
                        'Yes. ReStep can show supported recycling points and participating store locations based on your area or selected branch.',
                  ),
                  _faqItem(
                    question: 'What should I do if my points are not updated?',
                    answer:
                        'Please check your Activity Log first. If the recycling activity was completed but the points are still missing, contact the helpdesk for assistance.',
                  ),
                  _faqItem(
                    question: 'How do I change my password or profile details?',
                    answer:
                        'You can update your profile information and password from the Settings page under Profile and Change Password.',
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

Widget _faqHeader() {
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
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF7ED),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(
            Icons.quiz_outlined,
            size: 24,
            color: Color(0xFFF97316),
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Text(
            'Quick answers for common questions about recycling submissions, points, rewards, and account support.',
            style: TextStyle(
              fontSize: 13,
              height: 1.4,
              fontWeight: FontWeight.w500,
              color: Color(0xFF6B7280),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _faqItem({
  required String question,
  required String answer,
}) {
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
    child: Theme(
      data: ThemeData().copyWith(
        dividerColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
        iconColor: const Color(0xFFF97316),
        collapsedIconColor: const Color(0xFF9CA3AF),
        title: Text(
          question,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF111111),
          ),
        ),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              answer,
              style: const TextStyle(
                fontSize: 12.5,
                height: 1.45,
                color: Color(0xFF6B7280),
              ),
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
          'FAQ',
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