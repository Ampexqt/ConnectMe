import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../providers/theme_provider.dart';

enum ButtonVariant { primary, secondary, ghost }

enum ButtonSize { small, medium, large }

/// Custom Button Component
/// Implements primary, secondary, and ghost button variants with tap animations
class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final Widget? icon;
  final bool fullWidth;
  final bool disabled;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.icon,
    this.fullWidth = false,
    this.disabled = false,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.98,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (!widget.disabled) {
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (!widget.disabled) {
      _controller.reverse();
    }
  }

  void _handleTapCancel() {
    if (!widget.disabled) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    // Size configurations
    double verticalPadding;
    double horizontalPadding;
    double fontSize;

    switch (widget.size) {
      case ButtonSize.small:
        verticalPadding = AppSpacing.sm;
        horizontalPadding = AppSpacing.md;
        fontSize = AppTypography.fontSM;
        break;
      case ButtonSize.medium:
        verticalPadding = AppSpacing.md - 4;
        horizontalPadding = AppSpacing.lg;
        fontSize = AppTypography.fontBase;
        break;
      case ButtonSize.large:
        verticalPadding = AppSpacing.md;
        horizontalPadding = AppSpacing.xl;
        fontSize = AppTypography.fontLG;
        break;
    }

    // Variant configurations
    Color backgroundColor;
    Color textColor;
    Color? borderColor;

    switch (widget.variant) {
      case ButtonVariant.primary:
        backgroundColor = isDark
            ? AppColors.darkPrimary
            : AppColors.lightPrimary;
        textColor = Colors.white;
        borderColor = null;
        break;
      case ButtonVariant.secondary:
        backgroundColor = isDark
            ? AppColors.darkSurfaceElevated
            : AppColors.lightSurfaceElevated;
        textColor = isDark ? AppColors.darkText : AppColors.lightText;
        borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
        break;
      case ButtonVariant.ghost:
        backgroundColor = Colors.transparent;
        textColor = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
        borderColor = null;
        break;
    }

    if (widget.disabled) {
      backgroundColor = backgroundColor.withOpacity(0.5);
      textColor = textColor.withOpacity(0.5);
    }

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: widget.disabled ? null : widget.onPressed,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: widget.fullWidth ? double.infinity : null,
          padding: EdgeInsets.symmetric(
            vertical: verticalPadding,
            horizontal: horizontalPadding,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(AppRadius.full),
            border: borderColor != null
                ? Border.all(color: borderColor, width: 2)
                : null,
          ),
          child: Row(
            mainAxisSize: widget.fullWidth
                ? MainAxisSize.max
                : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                widget.icon!,
                const SizedBox(width: AppSpacing.sm),
              ],
              Text(
                widget.text,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
