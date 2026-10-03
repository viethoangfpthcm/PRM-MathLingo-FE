import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_colors.dart';

/// TactileButton delivers the 3D toy-like extrusion button affordance specified
/// in the Stitch Design System:
/// - Chunky solid bottom shadow rail
/// - Spring press animation (translate down 3px, shadow rail shrinks)
/// - Pill or rounded-rectangle shape
class TactileButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Color backgroundColor;
  final Color shadowColor;
  final Color? textColor;
  final double height;
  final double? width;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double extrusionDepth;
  final bool isFullPill;

  const TactileButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor = AppColors.primaryContainer,
    this.shadowColor = AppColors.primaryShadow,
    this.textColor = Colors.white,
    this.height = 54,
    this.width,
    this.borderRadius = 9999,
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
    this.extrusionDepth = 4.0,
    this.isFullPill = true,
  });

  /// Factory for Emerald Primary CTA
  factory TactileButton.primary({
    Key? key,
    required VoidCallback? onPressed,
    required Widget child,
    double height = 54,
    double? width,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 20),
  }) {
    return TactileButton(
      key: key,
      onPressed: onPressed,
      backgroundColor: AppColors.primaryContainer,
      shadowColor: AppColors.primaryShadow,
      textColor: Colors.white,
      height: height,
      width: width,
      padding: padding,
      child: child,
    );
  }

  /// Factory for Star Gold Reward CTA
  factory TactileButton.secondary({
    Key? key,
    required VoidCallback? onPressed,
    required Widget child,
    double height = 54,
    double? width,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 20),
  }) {
    return TactileButton(
      key: key,
      onPressed: onPressed,
      backgroundColor: AppColors.secondaryContainer,
      shadowColor: AppColors.secondaryShadow,
      textColor: AppColors.onSecondaryContainer,
      height: height,
      width: width,
      padding: padding,
      child: child,
    );
  }

  /// Factory for Socratic Owl Accent CTA
  factory TactileButton.socratic({
    Key? key,
    required VoidCallback? onPressed,
    required Widget child,
    double height = 54,
    double? width,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 20),
  }) {
    return TactileButton(
      key: key,
      onPressed: onPressed,
      backgroundColor: AppColors.socraticViolet,
      shadowColor: AppColors.socraticShadow,
      textColor: Colors.white,
      height: height,
      width: width,
      padding: padding,
      child: child,
    );
  }

  /// Factory for Light / Outline Tile
  factory TactileButton.neutral({
    Key? key,
    required VoidCallback? onPressed,
    required Widget child,
    double height = 54,
    double? width,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 20),
  }) {
    return TactileButton(
      key: key,
      onPressed: onPressed,
      backgroundColor: AppColors.surfaceContainerLowest,
      shadowColor: AppColors.surfaceDim,
      textColor: AppColors.onSurface,
      height: height,
      width: width,
      padding: padding,
      child: child,
    );
  }

  @override
  State<TactileButton> createState() => _TactileButtonState();
}

class _TactileButtonState extends State<TactileButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = widget.onPressed != null;
    final Color currentBg = isEnabled
        ? widget.backgroundColor
        : AppColors.disabledSurface;
    final Color currentShadow = isEnabled
        ? widget.shadowColor
        : AppColors.disabledShadow;

    final double effectiveTranslate = _isPressed ? widget.extrusionDepth - 1 : 0;
    final double effectiveBottomBorder = _isPressed ? 1.0 : widget.extrusionDepth;

    final BorderRadius radius = BorderRadius.circular(widget.borderRadius);

    return GestureDetector(
      onTapDown: isEnabled
          ? (_) {
              HapticFeedback.selectionClick();
              setState(() => _isPressed = true);
            }
          : null,
      onTapUp: isEnabled
          ? (_) {
              setState(() => _isPressed = false);
              widget.onPressed?.call();
            }
          : null,
      onTapCancel: () {
        if (_isPressed) setState(() => _isPressed = false);
      },
      child: SizedBox(
        width: widget.width,
        height: widget.height + widget.extrusionDepth,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            // Extruded Bottom Rail (Shadow anchor)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: widget.height,
              child: Container(
                decoration: BoxDecoration(
                  color: currentShadow,
                  borderRadius: radius,
                ),
              ),
            ),
            // Tactile Button Body (Translates down when pressed)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 60),
              curve: Curves.easeOutQuad,
              top: effectiveTranslate,
              left: 0,
              right: 0,
              height: widget.height,
              child: Container(
                padding: widget.padding,
                decoration: BoxDecoration(
                  color: currentBg,
                  borderRadius: radius,
                  border: Border(
                    bottom: BorderSide(
                      color: currentShadow,
                      width: effectiveBottomBorder,
                    ),
                  ),
                ),
                child: Center(
                  child: DefaultTextStyle(
                    style: TextStyle(
                      color: isEnabled
                          ? (widget.textColor ?? Colors.white)
                          : AppColors.disabledIcon,
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                    ),
                    child: widget.child,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
