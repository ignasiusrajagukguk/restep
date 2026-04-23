import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restep/common/constants/collors.dart';
import 'package:restep/presentation/screens/qrcode/app_top_bar.dart';
import 'package:restep/presentation/screens/qrcode/entities/scanner_entity.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

// ─────────────────────────────────────────
// ENUMS & MODELS
// ─────────────────────────────────────────

enum ScanMode { qr, barcode, manual }

enum ScanResultStatus { inTransit, delivered, inStorage, damaged }

class ScannerState {
  final ScanMode mode;
  final bool torchOn;
  final bool isLooking;
  final List<RecentScanEntity> recentScans;
  final bool showSuccess;
  final bool showManual;
  final dynamic result;
  final String manualInput;

  const ScannerState({
    required this.mode,
    required this.torchOn,
    required this.isLooking,
    required this.recentScans,
    required this.showSuccess,
    required this.showManual,
    required this.result,
    required this.manualInput,
  });

  factory ScannerState.initial() => const ScannerState(
        mode: ScanMode.qr,
        torchOn: false,
        isLooking: false,
        recentScans:[],
        showSuccess:false,
        showManual: false,
        result: null,
        manualInput: '',
      );

  ScannerState copyWith({
    ScanMode? mode,
    bool? torchOn,
    bool? isLooking,
    bool? showManual,
    List<RecentScanEntity>? recentScans,
    bool? showSuccess,
    dynamic result,
    String? manualInput,
  }) {
    return ScannerState(
      mode: mode ?? this.mode,
      torchOn: torchOn ?? this.torchOn,
      isLooking: isLooking ?? this.isLooking,
      recentScans:recentScans??this.recentScans,
      showSuccess:showSuccess?? this.showSuccess,
      showManual: showManual ?? this.showManual,
      result: result ?? this.result,
      manualInput: manualInput ?? this.manualInput,
    );
  }
}

// ─────────────────────────────────────────
// CONTROLLER
// ─────────────────────────────────────────

class ScannerController extends ChangeNotifier {
  ScannerState _state = ScannerState.initial();

  ScannerState get state => _state;

  void _update(ScannerState newState) {
    _state = newState;
    notifyListeners();
  }

  // ─────────────────────────

  void toggleTorch() {
    _update(_state.copyWith(torchOn: !_state.torchOn));
  }

  void setMode(ScanMode mode) {
    _update(_state.copyWith(
      mode: mode,
      showManual: mode == ScanMode.manual,
    ));
  }

  // ─────────────────────────

  void scan(String value) async {
    if (_state.isLooking) return;

    _update(_state.copyWith(isLooking: true));

    await Future.delayed(const Duration(milliseconds: 800));

    _update(_state.copyWith(
      isLooking: false,
      result: value, // <-- replace with real API result
    ));
  }

  void clearResult() {
    _update(_state.copyWith(result: null));
  }

  // ─────────────────────────
  // MANUAL INPUT
  // ─────────────────────────

  void manualKeyPress(String key) {
    _update(_state.copyWith(
      manualInput: _state.manualInput + key,
    ));
  }

  void manualBackspace() {
    if (_state.manualInput.isEmpty) return;

    _update(_state.copyWith(
      manualInput:
          _state.manualInput.substring(0, _state.manualInput.length - 1),
    ));
  }

  void manualConfirm() {
    if (_state.manualInput.isEmpty) return;

    scan(_state.manualInput);
  }
}
class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  late ScannerController ctrl;
  late ScannerState state;

  @override
  void initState() {
    super.initState();

    ctrl = ScannerController();
    state = ctrl.state;

    ctrl.addListener(_onStateChanged);
  }

  void _onStateChanged() {
    setState(() {
      state = ctrl.state;
    });
  }

  @override
  void dispose() {
    ctrl.removeListener(_onStateChanged);
    ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ConstColors.green10,
        body: SafeArea(
          child: Stack(
            children: [
              _ScanScreen(state: state, ctrl: ctrl),
              _SuccessOverlay(state: state, ctrl: ctrl),
              _ManualOverlay(state: state, ctrl: ctrl),
            ],
          ),
        ),
      ),
    );
  }
}



// ─────────────────────────────────────────────────────────────────────────────
// Scan Screen — viewfinder state
// ─────────────────────────────────────────────────────────────────────────────

class _ScanScreen extends StatelessWidget {
  final ScannerState state;
  final ScannerController ctrl;

  const _ScanScreen({required this.state, required this.ctrl});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Column(
      children: [
        // MainHeader(),
        AppTopBar(
          title: 'Scan',
          center: true,
          actions: [
            TopBarAction.torch(
              isOn: state.torchOn,
              onTap: () {
                HapticFeedback.lightImpact();
                ctrl.toggleTorch();
              },
            ),
          ],
        ),
        _ModePills(mode: state.mode, ctrl: ctrl),

        // Viewfinder — fills available space
        Expanded(
          child: _Viewfinder(
            mode: state.mode,
            isLooking: state.isLooking,
            torchOn: state.torchOn,
            disabled: state.showSuccess || state.showManual,
            onDetect: (valueScanned) => ctrl.scan(valueScanned),
          ),
        ),

        // Hint text
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 14, 24, 0),
          child: Text(
            state.mode == ScanMode.barcode
                ? 'Keep barcode horizontal · Move closer if needed'
                : 'Hold steady · Auto-detects when label is in focus',
            textAlign: TextAlign.center,
            style: tt.bodySmall?.copyWith(
              fontSize: 12,
              color: const Color(0xFF4A5565),
              letterSpacing: 0,
              height: 1.5,
            ),
          ),
        ),

        if (state.recentScans.isNotEmpty) ...[
          const SizedBox(height: 14),
          _RecentScansStrip(scans: state.recentScans, ctrl: ctrl),
        ],

        _CancelButton(onTap: () => Navigator.of(context).pop()),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Circle button helper
// ─────────────────────────────────────────────────────────────────────────────

class _CircleButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  final Color? color;
  final Color? borderColor;

  const _CircleButton({
    required this.onTap,
    required this.child,
    this.color,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
    );
  }
}

class _ModePills extends StatelessWidget {
  final ScanMode mode;
  final ScannerController ctrl;

  const _ModePills({required this.mode, required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
      child: Row(
        children: [
          _Pill(
            label: 'QR / Barcode',
            active: mode == ScanMode.qr,
            onTap: () => ctrl.setMode(ScanMode.qr),
          ),
          const SizedBox(width: 8),
          // _Pill(
          //   label: 'Barcode',
          //   active: mode == ScanMode.barcode,
          //   onTap: () => ctrl.setMode(ScanMode.barcode),
          // ),
          const SizedBox(width: 8),
          _Pill(
            label: 'Manual',
            active: mode == ScanMode.manual,
            onTap: () => ctrl.setMode(ScanMode.manual),
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _Pill({required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 9),
          decoration: BoxDecoration(
            color: active ? ConstColors.green : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: active
                  ? Colors.transparent
                  : ConstColors.dark40.withValues(alpha: 0.14),
            ),
          ),
          child: Text(
            label.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.05,
              color: active ? Colors.white : const Color(0xFF4A5565),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Viewfinder — real MobileScanner camera + animated overlay
// ─────────────────────────────────────────────────────────────────────────────

class _Viewfinder extends StatefulWidget {
  final ScanMode mode;
  final bool isLooking;
  final bool torchOn;
  final bool disabled;
  final ValueChanged<String> onDetect;

  const _Viewfinder({
    required this.mode,
    required this.isLooking,
    required this.torchOn,
    required this.disabled,
    required this.onDetect,
  });

  @override
  State<_Viewfinder> createState() => _ViewfinderState();
}

class _ViewfinderState extends State<_Viewfinder>
    with SingleTickerProviderStateMixin {
  late final MobileScannerController _cameraCtrl;
  late final AnimationController _scanLineCtrl;
  late final Animation<double> _scanLineAnim;

  // Prevent duplicate triggers for the same code
  String? _lastScanned;

  @override
  void initState() {
    super.initState();

    _cameraCtrl = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
      facing: CameraFacing.back,
      torchEnabled: widget.torchOn,
    );

    // Scan line: 0 → 1 over 2.2 s, then auto-reverses
    _scanLineCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);

    _scanLineAnim = CurvedAnimation(
      parent: _scanLineCtrl,
      curve: Curves.easeInOut,
    );
  }

  @override
  void didUpdateWidget(_Viewfinder old) {
    super.didUpdateWidget(old);
    // Sync torch state with the camera controller
    if (old.torchOn != widget.torchOn) {
      _cameraCtrl.toggleTorch();
    }
    // Reset last scanned when result is dismissed (isLooking goes false)
    if (old.isLooking && !widget.isLooking) {
      _lastScanned = null;
    }
  }

  @override
  void dispose() {
    _cameraCtrl.dispose();
    _scanLineCtrl.dispose();
    super.dispose();
  }

  void _onBarcodeDetected(BarcodeCapture capture) {
    if (widget.isLooking || widget.disabled) return;
    final barcode = capture.barcodes.firstOrNull;
    final raw = barcode?.rawValue;
    if (raw == null || raw.isEmpty) return;
    if (raw == _lastScanned) return;
    _lastScanned = raw;
    HapticFeedback.mediumImpact();
    widget.onDetect(raw);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // ── Dark base — prevents any red/white flash before camera warms up
                const ColoredBox(color: Color(0xFF161A20)),

                // ── Real camera feed ──────────────────────────────────
                MobileScanner(
        onDetect: (capture) {
          final barcode = capture.barcodes.first;
          final value = barcode.rawValue;
          if (value != null) {
            Navigator.of(context).pop(value); // return scanned value
          }
        },
      ),

                // ── Dark overlay dimming the area outside the frame ───
                // (the ClipRRect already clips to the square, so this
                // just adds a subtle vignette)
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.center,
                      radius: 0.9,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.35),
                      ],
                    ),
                  ),
                ),

                // ── Barcode hint lines (barcode mode only) ────────────
                if (widget.mode == ScanMode.barcode)
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.06,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          15,
                          (i) => Container(
                            width: i.isEven ? 2 : 1,
                            height: i.isEven ? double.infinity : null,
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                // ── Corner brackets ────────────────────────────────────
                ..._buildCorners(),

                // ── Animated scan line ─────────────────────────────────
                if (!widget.isLooking)
                  LayoutBuilder(
                    builder: (_, constraints) {
                      final h = constraints.maxHeight;
                      return AnimatedBuilder(
                        animation: _scanLineAnim,
                        builder: (_, __) {
                          final top = 12.0 + _scanLineAnim.value * (h - 26.0);
                          return Stack(
                            children: [
                              Positioned(
                                top: top,
                                left: 12,
                                right: 12,
                                child: Container(
                                  height: 2,
                                  decoration: BoxDecoration(
                                    color: ConstColors.green,
                                    borderRadius: BorderRadius.circular(1),
                                    boxShadow: [
                                      BoxShadow(
                                        color: ConstColors.green.withValues(
                                          alpha: 0.8,
                                        ),
                                        blurRadius: 8,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),

                // ── Loading spinner while looking up package ───────────
                if (widget.isLooking)
                  const Center(
                    child: CircularProgressIndicator(
                      color: ConstColors.green,
                      strokeWidth: 2.5,
                    ),
                  ),

                // ── Bottom label ───────────────────────────────────────
                Positioned(
                  bottom: 12,
                  left: 0,
                  right: 0,
                  child: Text(
                    widget.mode == ScanMode.barcode
                        ? 'ALIGN BARCODE WITHIN FRAME'
                        : 'ALIGN QR / BARCODE WITHIN FRAME',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.06,
                      color: Colors.white.withValues(alpha: 0.4),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Four corner bracket decorations — no wrapper widget needed.
  List<Widget> _buildCorners() {
    const double size = 28;
    const double thickness = 3;
    const double radius = 18;
    const Color color = ConstColors.green;

    return [
      Positioned(
        top: 0,
        left: 0,
        child: Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: color, width: thickness),
              left: BorderSide(color: color, width: thickness),
            ),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(radius)),
          ),
        ),
      ),
      Positioned(
        top: 0,
        right: 0,
        child: Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: color, width: thickness),
              right: BorderSide(color: color, width: thickness),
            ),
            borderRadius: BorderRadius.only(topRight: Radius.circular(radius)),
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        child: Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: color, width: thickness),
              left: BorderSide(color: color, width: thickness),
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(radius),
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: color, width: thickness),
              right: BorderSide(color: color, width: thickness),
            ),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(radius),
            ),
          ),
        ),
      ),
    ];
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Recent Scans Strip
// ─────────────────────────────────────────────────────────────────────────────

class _RecentScansStrip extends StatelessWidget {
  final List<RecentScanEntity> scans;
  final ScannerController ctrl;

  const _RecentScansStrip({required this.scans, required this.ctrl});

  Color _dotColor(ScanResultStatus s) => switch (s) {
    ScanResultStatus.inTransit => Colors.green,
    ScanResultStatus.delivered => Colors.green,
    ScanResultStatus.inStorage => Colors.amber,
    ScanResultStatus.damaged => const Color(0xFFE24B4A),
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'RECENT SCANS',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.08,
              color: Color(0xFF4A5565),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 36,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: scans.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final scan = scans[i];
                return GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    ctrl.scan(scan.id);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 11,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E232B),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.07),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 7,
                          height: 7,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _dotColor(scan.status as ScanResultStatus),
                          ),
                        ),
                        const SizedBox(width: 7),
                        Text(
                          scan.id,
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11,
                            color: Color(0xFF8A95A3),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          scan.timeLabel,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Color(0xFF4A5565),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Cancel Button
// ─────────────────────────────────────────────────────────────────────────────

class _CancelButton extends StatelessWidget {
  final VoidCallback onTap;
  const _CancelButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFF1E232B),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.close_rounded, size: 16, color: Color(0xFF8A95A3)),
              SizedBox(width: 8),
              Text(
                'CANCEL',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.06,
                  color: Color(0xFF8A95A3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Success Overlay
// ─────────────────────────────────────────────────────────────────────────────

class _SuccessOverlay extends StatelessWidget {
  final ScannerState state;
  final ScannerController ctrl;

  const _SuccessOverlay({required this.state, required this.ctrl});

  ({Color bg, Color border, Color icon}) _iconColors(ScanResultStatus s) {
    if (s == ScanResultStatus.damaged) {
      return (
        bg: const Color(0xFFE24B4A).withValues(alpha: 0.15),
        border: const Color(0xFFE24B4A),
        icon: const Color(0xFFE24B4A),
      );
    }
    return (
      bg: Colors.green.withValues(alpha: 0.15),
      border: Colors.green,
      icon: Colors.green,
    );
  }

  ({Color text, String label}) _statusStyle(ScanResultStatus s) => switch (s) {
    ScanResultStatus.inTransit => (
      text: Colors.green,
      label: 'In transit',
    ),
    ScanResultStatus.inStorage => (
      text: Colors.amber,
      label: 'In storage',
    ),
    ScanResultStatus.damaged => (
      text: const Color(0xFFE24B4A),
      label: 'Damaged',
    ),
    ScanResultStatus.delivered => (
      text: Colors.green,
      label: 'Delivered',
    ),
  };

  @override
  Widget build(BuildContext context) {
    final result = state.result;
    final tt = Theme.of(context).textTheme;

    Widget bodyUI = SizedBox.expand();
    if (result != null) {
      // if (result.type.toLowerCase() == 'package') {
      //   bodyUI = PackageScan(state: state, ctrl: ctrl);
      // }
      // if (result.type.toLowerCase() == 'booth') {
      //   bodyUI = BoothScan(state: state, ctrl: ctrl);
      // }
      // if (result.type.toLowerCase() == 'parking') {
      //   bodyUI = ParkingScan(state: state, ctrl: ctrl);
      // }
      // if (result.type.toLowerCase() == 'badge') {
      //   bodyUI = BadgeScan(state: state, ctrl: ctrl);
      // }
      // if (result.type.toLowerCase() == 'empties') {
      //   bodyUI = EmptiesScan(state: state, ctrl: ctrl);
      // }

    }

    return AnimatedSlide(
      offset: result != null ? Offset.zero : const Offset(0, 1),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
      child: bodyUI,
    );
  }
}

class _AnimatedSuccessIcon extends StatefulWidget {
  final ScanResultStatus status;
  final ({Color bg, Color border, Color icon}) colors;

  const _AnimatedSuccessIcon({required this.status, required this.colors});

  @override
  State<_AnimatedSuccessIcon> createState() => _AnimatedSuccessIconState();
}

class _AnimatedSuccessIconState extends State<_AnimatedSuccessIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _pop;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _pop = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut));
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _pop,
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.colors.bg,
          border: Border.all(color: widget.colors.border, width: 2),
        ),
        child: Icon(
          widget.status == ScanResultStatus.damaged
              ? Icons.warning_amber_rounded
              : Icons.check_rounded,
          size: 30,
          color: widget.colors.icon,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Manual Entry Overlay
// ─────────────────────────────────────────────────────────────────────────────

class _ManualOverlay extends StatefulWidget {
  final ScannerState state;
  final ScannerController ctrl;

  const _ManualOverlay({required this.state, required this.ctrl});

  @override
  State<_ManualOverlay> createState() => _ManualOverlayState();
}

class _ManualOverlayState extends State<_ManualOverlay> {
  final _cursorCtrl = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    _blinkCursor();
  }

  void _blinkCursor() async {
    while (mounted) {
      await Future.delayed(const Duration(milliseconds: 450));
      if (mounted) _cursorCtrl.value = !_cursorCtrl.value;
    }
  }

  @override
  void dispose() {
    _cursorCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final show = widget.state.showManual;

    return AnimatedSlide(
      offset: show ? Offset.zero : const Offset(0, 1),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
      child: show
          ? Container(
              color: const Color(0xFF0E1014),
              child: Column(
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 52, 16, 14),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Color(0x12FFFFFF)),
                      ),
                    ),
                    child: Row(
                      children: [
                        _CircleButton(
                          onTap: () => widget.ctrl.setMode(ScanMode.qr),
                          child: const Icon(
                            Icons.chevron_left_rounded,
                            color: Color(0xFF8A95A3),
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Enter ID manually',
                          style: tt.titleMedium?.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFF0F2F5),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Display with blinking cursor
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                    padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E232B),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.14),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const Text(
                        //   'PACKAGE ID',
                        //   style: TextStyle(
                        //     fontSize: 11,
                        //     fontWeight: FontWeight.w600,
                        //     letterSpacing: 0.07,
                        //     color: Color(0xFF4A5565),
                        //   ),
                        // ),
                        // const SizedBox(height: 6),
                        Row(
                          children: [
                            Text(
                              widget.state.manualInput,
                              style: const TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 28,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFF0F2F5),
                                letterSpacing: 2,
                              ),
                            ),
                            ValueListenableBuilder<bool>(
                              valueListenable: _cursorCtrl,
                              builder: (_, visible, __) => AnimatedOpacity(
                                opacity: visible ? 1.0 : 0.0,
                                duration: const Duration(milliseconds: 100),
                                child: Container(
                                  width: 2,
                                  height: 28,
                                  margin: const EdgeInsets.only(left: 2),
                                  color: ConstColors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Keypad
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: _Keypad(ctrl: widget.ctrl),
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox.expand(child: ColoredBox(color: Colors.transparent)),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Keypad
// ─────────────────────────────────────────────────────────────────────────────

class _Keypad extends StatelessWidget {
  final ScannerController ctrl;
  const _Keypad({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    const rows = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['PKG-', '0', '⌫'],
    ];

    return Column(
      children: [
        ...rows.map(
          (row) => Expanded(
            child: Row(
              children: row.map((k) {
                final isSpecial = k == 'PKG-' || k == '⌫';
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: _Key(
                      label: k,
                      isSpecial: isSpecial,
                      onTap: () {
                        HapticFeedback.selectionClick();
                        if (k == '⌫') {
                          ctrl.manualBackspace();
                        } else {
                          ctrl.manualKeyPress(k);
                        }
                      },
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        // Full-width confirm
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: GestureDetector(
              onTap: () {
                HapticFeedback.mediumImpact();
                ctrl.manualConfirm();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: ConstColors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_rounded, color: Colors.white, size: 20),
                    SizedBox(width: 10),
                    Text(
                      'Confirm',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Key extends StatelessWidget {
  final String label;
  final bool isSpecial;
  final VoidCallback onTap;

  const _Key({
    required this.label,
    required this.isSpecial,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSpecial ? const Color(0xFF161A20) : const Color(0xFF1E232B),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: label == 'PKG-' ? 13 : 22,
              fontWeight: FontWeight.w700,
              color: isSpecial
                  ? const Color(0xFF8A95A3)
                  : const Color(0xFFF0F2F5),
            ),
          ),
        ),
      ),
    );
  }
}
