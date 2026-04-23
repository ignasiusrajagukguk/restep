import 'package:flutter/material.dart';
import 'package:restep/common/constants/collors.dart';
import 'package:restep/config/app_asset.dart';
import 'package:restep/presentation/screens/redeemed_details/voucher_issued.dart';

const kBgColor = Color(0xFFEEEDE6);
const kGreen = Color(0xFF4A7C59);
const kGreenLight = Color(0xFF5A9B6A);
const kGreenDark = Color(0xFF3A6347);
const kRed = Color(0xFFD94F3D);
const kTextDark = Color(0xFF1A1A1A);
const kTextMid = Color(0xFF6B6B6B);
const kTextLight = Color(0xFF9E9E9E);
const kCardBg = Color(0xFFFFFFFF);
const kDivider = Color(0xFFE0DFDA);

/// Pass these from the previous screen (product detail / cart).
class RewardReservedScreen extends StatefulWidget {
  /// Product name shown in the confirmation.
  final String productName;

  /// Pickup store chosen by the user.
  final String pickupStore;

  /// Full point cost of the item.
  final int totalPoints;

  /// How many points the user actually has available.
  final int userPoints;

  /// Euro value per point (e.g. 0.02 means 1 pt = €0.02).
  final double pointValueInEuros;

  const RewardReservedScreen({
    super.key,
    this.productName = 'Premium Circular Tote',
    this.pickupStore = 'PLUS - Amsterdam',
    this.totalPoints = 150,
    this.userPoints = 100,
    this.pointValueInEuros = 0.25,
  });

  @override
  State<RewardReservedScreen> createState() => _RewardReservedScreenState();
}

class _RewardReservedScreenState extends State<RewardReservedScreen> {
  // Whether the user chose to top up with money for the missing points.
  bool _usePartialPay = false;

  bool get _hasEnoughPoints => widget.userPoints >= widget.totalPoints;

  int get _missingPoints =>
      (_hasEnoughPoints ? 0 : widget.totalPoints - widget.userPoints);

  double get _extraEuros => _missingPoints * widget.pointValueInEuros;

  int get _pointsUsed =>
      _hasEnoughPoints ? widget.totalPoints : widget.userPoints;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ConstColors.green10,
        body: Column(
          children: [
            _buildBackButton(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    _buildIllustration(),
                    const SizedBox(height: 28),
                    _buildTitle(),
                    const SizedBox(height: 28),
                    _buildInfoCard(),
                    // Only show the partial-pay panel when points are insufficient
                    if (!_hasEnoughPoints) ...[
                      const SizedBox(height: 16),
                      _buildPartialPayCard(),
                    ],
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            _buildButtons(context),
          ],
        ),
      ),
    );
  }

  // ── Back button ─────────────────────────────────────────────────────────────

  Widget _buildBackButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: GestureDetector(
          onTap: () => Navigator.maybePop(context),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: kCardBg,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(Icons.chevron_left, color: kTextDark, size: 22),
          ),
        ),
      ),
    );
  }

  // ── Illustration ─────────────────────────────────────────────────────────────

  Widget _buildIllustration() {
    return SizedBox(
      height: 200,
      child: Image.asset(ImageAsset.shopIllustration),
    );
  }

  // ── Title block ──────────────────────────────────────────────────────────────

  Widget _buildTitle() {
    final bool enough = _hasEnoughPoints;
    return Column(
      children: [
        Text(
          enough ? 'Confirm Order' : 'Almost There',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: kGreen,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          enough
              ? 'Review your order and confirm.\nPick it up at the selected store.'
              : 'You don\'t have enough points.\nTop up with money to complete your order.',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            color: kTextMid,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  // ── Info card ────────────────────────────────────────────────────────────────

  Widget _buildInfoCard() {
    return Container(
      decoration: BoxDecoration(
        color: kCardBg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildInfoRow(
            icon: Icons.shopping_bag_outlined,
            label: 'Product',
            value: widget.productName,
            valueColor: kTextDark,
          ),
          Divider(height: 1, color: kDivider, indent: 48),
          _buildInfoRow(
            icon: Icons.store_outlined,
            label: 'Pickup location',
            value: widget.pickupStore,
            valueColor: kTextDark,
          ),
          Divider(height: 1, color: kDivider, indent: 48),
          _buildInfoRow(
            icon: Icons.monetization_on_outlined,
            label: 'Points required',
            value: '${widget.totalPoints} pts',
            valueColor: kTextDark,
          ),
          Divider(height: 1, color: kDivider, indent: 48),
          _buildInfoRow(
            icon: Icons.account_balance_wallet_outlined,
            label: 'Your balance',
            value: '${widget.userPoints} pts',
            valueColor: _hasEnoughPoints ? kGreen : kRed,
          ),
          // Only show shortfall row when points are insufficient
          if (!_hasEnoughPoints) ...[
            Divider(height: 1, color: kDivider, indent: 48),
            _buildInfoRow(
              icon: Icons.remove_circle_outline,
              label: 'Shortfall',
              value: '$_missingPoints pts',
              valueColor: kRed,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: ConstColors.grayLight,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(icon, size: 18, color: kTextMid),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(label,
                style: const TextStyle(fontSize: 14, color: kTextMid)),
          ),
          Text(
            value,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: valueColor),
          ),
        ],
      ),
    );
  }

  // ── Partial pay card ─────────────────────────────────────────────────────────

  Widget _buildPartialPayCard() {
    return Container(
      decoration: BoxDecoration(
        color: kCardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _usePartialPay ? kGreen : kDivider,
          width: _usePartialPay ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header toggle row
          InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => setState(() => _usePartialPay = !_usePartialPay),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: _usePartialPay
                          ? kGreen.withOpacity(0.12)
                          : ConstColors.grayLight,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Icon(Icons.euro_outlined,
                        size: 18,
                        color: _usePartialPay ? kGreen : kTextMid),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Top up with money',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: kTextDark),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Use all ${widget.userPoints} pts + pay €${_extraEuros.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 12, color: kTextMid),
                        ),
                      ],
                    ),
                  ),
                  // Checkbox
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: _usePartialPay ? kGreen : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: _usePartialPay ? kGreen : kTextLight,
                        width: 1.5,
                      ),
                    ),
                    child: _usePartialPay
                        ? const Icon(Icons.check,
                            size: 14, color: Colors.white)
                        : null,
                  ),
                ],
              ),
            ),
          ),

          // Expanded breakdown when selected
          if (_usePartialPay) ...[
            Divider(height: 1, color: kDivider),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
              child: Column(
                children: [
                  _buildBreakdownRow(
                    label: 'Points used',
                    value: '−$_pointsUsed pts',
                    valueColor: kRed,
                  ),
                  const SizedBox(height: 8),
                  _buildBreakdownRow(
                    label: 'Extra payment',
                    value: '€${_extraEuros.toStringAsFixed(2)}',
                    valueColor: kTextDark,
                  ),
                  const SizedBox(height: 10),
                  const Divider(color: kDivider),
                  const SizedBox(height: 10),
                  _buildBreakdownRow(
                    label: 'Total to pay now',
                    value: '€${_extraEuros.toStringAsFixed(2)}',
                    valueColor: kGreen,
                    bold: true,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBreakdownRow({
    required String label,
    required String value,
    required Color valueColor,
    bool bold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 13,
                color: bold ? kTextDark : kTextMid,
                fontWeight:
                    bold ? FontWeight.w600 : FontWeight.normal)),
        Text(value,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: valueColor)),
      ],
    );
  }

  // ── Buttons ──────────────────────────────────────────────────────────────────

  Widget _buildButtons(BuildContext context) {
    // Determine if confirming is allowed:
    // - enough points: always allowed
    // - not enough: only if user toggled top-up
    final bool canConfirm = _hasEnoughPoints || _usePartialPay;

    final String confirmLabel = _hasEnoughPoints
        ? 'Confirm & View QR Code'
        : _usePartialPay
            ? 'Pay €${_extraEuros.toStringAsFixed(2)} & Confirm'
            : 'Select a payment option above';

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: canConfirm
                  ? () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (_) => const QRCodeModal(),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: kGreen,
                foregroundColor: Colors.white,
                disabledBackgroundColor: kGreen.withOpacity(0.35),
                disabledForegroundColor: Colors.white70,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: Text(
                confirmLabel,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: OutlinedButton(
              onPressed: () => Navigator.maybePop(context),
              style: OutlinedButton.styleFrom(
                foregroundColor: kGreen,
                side: const BorderSide(color: kGreen, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                'Back',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}