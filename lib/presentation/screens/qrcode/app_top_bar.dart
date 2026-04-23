import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ---------------------------------------------------------------------------
// AppTopBar — reusable top navigation bar for the entire project
//
// Usage examples:
//
//   // Minimal — title + back button
//   AppTopBar(title: 'Shipments')
//
//   // With a single right action
//   AppTopBar(
//     title: 'Scanner',
//     actions: [
//       TopBarAction.torch(isOn: torchOn, onTap: ctrl.toggleTorch),
//     ],
//   )
//
//   // With multiple right actions
//   AppTopBar(
//     title: 'Parking',
//     actions: [
//       TopBarAction.icon(icon: Icons.filter_list_rounded, onTap: openFilter),
//       TopBarAction.icon(icon: Icons.more_vert_rounded, onTap: openMenu),
//     ],
//   )
//
//   // Custom back behaviour (e.g. pop with a result)
//   AppTopBar(
//     title: 'Edit Task',
//     onBack: () => Navigator.of(context).pop(true),
//   )
//
//   // No back button (root screens)
//   AppTopBar(title: 'Dashboard', showBack: false)
//
//   // With subtitle
//   AppTopBar(title: 'ISE 2025', subtitle: 'Amsterdam RAI')
//
// ---------------------------------------------------------------------------

// ─── Action model ─────────────────────────────────────────────────────────────

/// Describes a single button on the right side of [AppTopBar].
class TopBarAction {
  const TopBarAction({
    required this.child,
    required this.onTap,
    this.activeColor,
    this.activeBorderColor,
    this.isActive = false,
    this.semanticLabel,
  });

  /// Widget rendered inside the circle button (typically an [Icon]).
  final Widget child;

  /// Tap callback.
  final VoidCallback onTap;

  /// Background color when [isActive] is true.
  final Color? activeColor;

  /// Border color when [isActive] is true.
  final Color? activeBorderColor;

  /// Whether the button is in an "active / toggled on" state.
  final bool isActive;

  /// Accessibility label.
  final String? semanticLabel;

  // ── Named constructors for common actions ──────────────────────────────

  /// Torch / flashlight toggle — pre-wired with amber active state.
  factory TopBarAction.torch({
    required bool isOn,
    required VoidCallback onTap,
  }) => TopBarAction(
    onTap: onTap,
    isActive: isOn,
    activeColor: Colors.amber,
    activeBorderColor: Colors.amber,
    semanticLabel: isOn ? 'Turn torch off' : 'Turn torch on',
    child: Icon(
      Icons.lightbulb_outline_rounded,
      color: isOn ? Colors.white : const Color(0xFF8A95A3),
      size: 18,
    ),
  );

  /// Generic icon action.
  factory TopBarAction.icon({
    required IconData icon,
    required VoidCallback onTap,
    bool isActive = false,
    Color? activeColor,
    String? semanticLabel,
  }) => TopBarAction(
    onTap: onTap,
    isActive: isActive,
    activeColor: activeColor,
    semanticLabel: semanticLabel,
    child: Icon(
      icon,
      color: isActive ? Colors.white : const Color(0xFF8A95A3),
      size: 18,
    ),
  );
}

// ─── AppTopBar ────────────────────────────────────────────────────────────────

class AppTopBar extends StatelessWidget {
  const AppTopBar({
    super.key,
    required this.title,
    this.subtitle,
    this.center = false,
    this.showBack = true,
    this.onBack,
    this.actions = const [],
    this.padding,
  });

  /// Main title displayed in the centre.
  final String title;

  /// Optional subtitle rendered below the title in a smaller muted style.
  final String? subtitle;

  /// Optional subtitle rendered below the title in a smaller muted style.
  final bool center;

  /// Whether to render the back (chevron-left) button on the left.
  /// Set to `false` for root / bottom-nav screens.
  final bool showBack;

  /// Custom back callback. Defaults to [Navigator.of(context).pop()] when null.
  final VoidCallback? onBack;

  /// Zero or more action buttons shown on the right side.
  /// Pass up to ~2 for a clean layout; more will overflow on small screens.
  final List<TopBarAction> actions;

  /// Outer padding override. Defaults to `EdgeInsets.fromLTRB(16, 6, 16, 14)`.
  final EdgeInsetsGeometry? padding;

  // ── Palette (dark scanner theme) ──────────────────────────────────────────
  static const _textPrimary = Color(0xFFF0F2F5);

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    Widget titleSubtitleWidget = subtitle != null
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: tt.titleMedium?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: _textPrimary,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                subtitle!,
                style: const TextStyle(fontSize: 11, color: Color(0xFF8A95A3)),
              ),
            ],
          )
        : Text(
            title,
            style: tt.titleMedium?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: _textPrimary,
              letterSpacing: 0.3,
            ),
          );

    return Padding(
      padding: padding ?? const EdgeInsets.fromLTRB(16, 14, 16, 14),
      child: Row(
        children: [
          // ── Left: back button or placeholder ────────────────────────────
          if (showBack)
            _CircleButton(
              onTap: onBack ?? () => Navigator.of(context).pop(),
              semanticLabel: 'Back',
              child: const Icon(
                Icons.chevron_left_rounded,
                color: Color(0xFF8A95A3),
                size: 22,
              ),
            )
          else
            const SizedBox(width: 38),

          // ── Centre: title (+ optional subtitle) ─────────────────────────
          if (!center) const SizedBox(width: 12),
          Expanded(
            child: center
                ? Center(child: titleSubtitleWidget)
                : titleSubtitleWidget,
          ),

          // ── Right: action buttons or placeholder ─────────────────────────
          if (actions.isEmpty)
            // const SizedBox(width: 38)
            _CircleButton(
              onTap: () {},
              color: Colors.transparent,
              borderColor: Colors.transparent,
              // semanticLabel: actions[i].semanticLabel,
              child: Container(),
            )
          else
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < actions.length; i++) ...[
                  if (i > 0) const SizedBox(width: 8),
                  _CircleButton(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      actions[i].onTap();
                    },
                    color: actions[i].isActive ? actions[i].activeColor : null,
                    borderColor: actions[i].isActive
                        ? actions[i].activeBorderColor
                        : null,
                    semanticLabel: actions[i].semanticLabel,
                    child: actions[i].child,
                  ),
                ],
              ],
            ),
        ],
      ),
    );
  }
}

// ─── Circle button ────────────────────────────────────────────────────────────

class AppTopBarCircleButton extends StatelessWidget {
  const AppTopBarCircleButton({
    super.key,
    required this.onTap,
    required this.child,
    this.color,
    this.borderColor,
    this.semanticLabel,
  });

  final VoidCallback onTap;
  final Widget child;
  final Color? color;
  final Color? borderColor;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      button: true,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color ?? const Color(0xFF1E232B),
            border: Border.all(
              color: borderColor ?? Colors.white.withValues(alpha: 0.14),
            ),
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}

// Internal alias used within this file
typedef _CircleButton = AppTopBarCircleButton;
