import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../core/theme/app_spacing.dart';
import '../providers/theme_provider.dart';
import '../providers/app_provider.dart';
import '../models/interest.dart';
import '../widgets/common/custom_button.dart';
import '../data/mock_data.dart';
import 'home_screen.dart';

/// Interests Screen
/// Allows users to select at least 3 interests
class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  final List<Interest> _interests = MockData.interests;
  final Set<String> _selectedInterests = {};

  @override
  void initState() {
    super.initState();
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.setAvailableInterests(_interests);
  }

  void _toggleInterest(String interestId) {
    setState(() {
      if (_selectedInterests.contains(interestId)) {
        _selectedInterests.remove(interestId);
      } else {
        _selectedInterests.add(interestId);
      }
    });
  }

  void _continue() {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    for (var id in _selectedInterests) {
      appProvider.toggleInterest(id);
    }
    appProvider.setInterestsSelected(true);

    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final canContinue = _selectedInterests.length >= 3;
    final remaining = 3 - _selectedInterests.length;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What are you into?',
                    style: TextStyle(
                      fontSize: AppTypography.font2XL,
                      fontWeight: FontWeight.w700,
                      color: isDark ? AppColors.darkText : AppColors.lightText,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Select at least 3 interests to help us find your people',
                    style: TextStyle(
                      fontSize: AppTypography.fontBase,
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                    ),
                  ),
                ],
              ),
            ),

            // Interest tags
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Wrap(
                  spacing: AppSpacing.md - 4,
                  runSpacing: AppSpacing.md - 4,
                  children: _interests.asMap().entries.map((entry) {
                    final index = entry.key;
                    final interest = entry.value;
                    final isSelected = _selectedInterests.contains(interest.id);

                    return TweenAnimationBuilder<double>(
                      duration: Duration(milliseconds: 300 + (index * 30)),
                      tween: Tween(begin: 0.0, end: 1.0),
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.scale(
                            scale: 0.8 + (value * 0.2),
                            child: child,
                          ),
                        );
                      },
                      child: _InterestTag(
                        interest: interest,
                        isSelected: isSelected,
                        onTap: () => _toggleInterest(interest.id),
                        isDark: isDark,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            // Bottom section
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                border: Border(
                  top: BorderSide(
                    color: isDark
                        ? AppColors.darkBorder
                        : AppColors.lightBorder,
                    width: 2,
                  ),
                ),
              ),
              child: Column(
                children: [
                  // Selection counter
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        canContinue
                            ? LucideIcons.checkCircle
                            : LucideIcons.alertCircle,
                        size: 16,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        canContinue
                            ? '${_selectedInterests.length} selected'
                            : '$remaining more needed',
                        style: TextStyle(
                          fontSize: AppTypography.fontSM,
                          fontWeight: FontWeight.w500,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // Continue button
                  CustomButton(
                    text: 'Continue',
                    onPressed: _continue,
                    variant: ButtonVariant.primary,
                    size: ButtonSize.large,
                    fullWidth: true,
                    disabled: !canContinue,
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

class _InterestTag extends StatefulWidget {
  final Interest interest;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDark;

  const _InterestTag({
    required this.interest,
    required this.isSelected,
    required this.onTap,
    required this.isDark,
  });

  @override
  State<_InterestTag> createState() => _InterestTagState();
}

class _InterestTagState extends State<_InterestTag>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(_InterestTag oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected && !oldWidget.isSelected) {
      _controller.forward().then((_) => _controller.reverse());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final scale = 1.0 + (_controller.value * 0.1);
          return Transform.scale(scale: scale, child: child);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? (widget.isDark
                      ? AppColors.darkPrimary
                      : AppColors.lightPrimary)
                : (widget.isDark
                      ? AppColors.darkSurfaceElevated
                      : AppColors.lightSurfaceElevated),
            borderRadius: BorderRadius.circular(AppRadius.full),
            border: Border.all(
              color: widget.isSelected
                  ? (widget.isDark
                        ? AppColors.darkPrimary
                        : AppColors.lightPrimary)
                  : (widget.isDark
                        ? AppColors.darkBorder
                        : AppColors.lightBorder),
              width: 2,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.interest.emoji, style: const TextStyle(fontSize: 16)),
              const SizedBox(width: AppSpacing.sm),
              Text(
                widget.interest.label,
                style: TextStyle(
                  fontSize: AppTypography.fontSM,
                  fontWeight: FontWeight.w500,
                  color: widget.isSelected
                      ? Colors.white
                      : (widget.isDark
                            ? AppColors.darkText
                            : AppColors.lightText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
