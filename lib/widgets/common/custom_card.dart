import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
// import '../../core/theme/app_typography.dart';
import '../../providers/theme_provider.dart';

/// Custom Card Component
/// Displays content in an elevated card with optional tap interaction
class CustomCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final bool elevated;
  final EdgeInsetsGeometry? padding;

  const CustomCard({
    super.key,
    required this.child,
    this.onTap,
    this.elevated = false,
    this.padding,
  });

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard>
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

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    final backgroundColor = widget.elevated
        ? (isDark
              ? AppColors.darkSurfaceElevated
              : AppColors.lightSurfaceElevated)
        : (isDark ? AppColors.darkSurface : AppColors.lightSurface);

    final shadows = widget.elevated
        ? (isDark ? AppColors.darkShadowMedium : AppColors.lightShadowMedium)
        : (isDark ? AppColors.darkShadowSmall : AppColors.lightShadowSmall);

    final cardContent = Container(
      padding: widget.padding ?? const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: shadows,
      ),
      child: widget.child,
    );

    if (widget.onTap != null) {
      return GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) => _controller.reverse(),
        onTapCancel: () => _controller.reverse(),
        onTap: widget.onTap,
        child: ScaleTransition(scale: _scaleAnimation, child: cardContent),
      );
    }

    return cardContent;
  }
}
