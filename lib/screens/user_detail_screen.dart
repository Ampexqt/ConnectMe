import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_typography.dart';
import '../providers/theme_provider.dart';
import '../models/user_profile.dart';

/// User Detail Screen
/// Shows full profile details when tapping info button from discovery
class UserDetailScreen extends StatelessWidget {
  final UserProfile user;

  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenHeight < 700 || screenWidth < 400;
    final heroHeight = isSmallScreen ? 280.0 : 400.0;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image Section with Back Button
            Stack(
              children: [
                // Background image
                Container(
                  height: heroHeight,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(user.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Gradient overlay
                Container(
                  height: heroHeight,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.4),
                        Colors.black.withValues(alpha: 0.6),
                        Colors.black.withValues(alpha: 0.8),
                      ],
                    ),
                  ),
                ),
                // Back button
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(
                      isSmallScreen ? AppSpacing.sm : AppSpacing.md,
                    ),
                    child: IconButton(
                      icon: Container(
                        padding: EdgeInsets.all(
                          isSmallScreen ? AppSpacing.xs : AppSpacing.sm,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.5),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          LucideIcons.arrowLeft,
                          color: Colors.white,
                          size: isSmallScreen ? 20 : 24,
                        ),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
                // Content overlay
                Positioned(
                  bottom: isSmallScreen ? AppSpacing.md : AppSpacing.lg,
                  left: isSmallScreen ? AppSpacing.md : AppSpacing.lg,
                  right: isSmallScreen ? AppSpacing.md : AppSpacing.lg,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${user.name}, ${user.age}',
                        style: TextStyle(
                          fontSize: isSmallScreen
                              ? AppTypography.font2XL
                              : AppTypography.font3XL,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: isSmallScreen ? 2 : AppSpacing.xs),
                      Row(
                        children: [
                          const Icon(
                            LucideIcons.mapPin,
                            size: 16,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              user.location,
                              style: TextStyle(
                                fontSize: AppTypography.fontBase,
                                color: Colors.white.withValues(alpha: 0.9),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Content sections
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // About section
                  TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 300),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - value)),
                          child: child,
                        ),
                      );
                    },
                    child: _ProfileSection(
                      title: 'About',
                      isDark: isDark,
                      child: Text(
                        user.bio,
                        style: TextStyle(
                          fontSize: AppTypography.fontBase,
                          color: isDark
                              ? AppColors.darkText
                              : AppColors.lightText,
                          height: AppTypography.lineHeightRelaxed,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  // Interests section
                  TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 400),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - value)),
                          child: child,
                        ),
                      );
                    },
                    child: _ProfileSection(
                      title: 'Interests',
                      isDark: isDark,
                      child: Wrap(
                        spacing: AppSpacing.sm,
                        runSpacing: AppSpacing.sm,
                        children: user.interests.map((interest) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.md,
                              vertical: AppSpacing.sm,
                            ),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColors.darkSurfaceElevated
                                  : AppColors.lightSurfaceElevated,
                              borderRadius: BorderRadius.circular(
                                AppRadius.full,
                              ),
                              border: Border.all(
                                color: isDark
                                    ? AppColors.darkBorder
                                    : AppColors.lightBorder,
                                width: 2,
                              ),
                            ),
                            child: Text(
                              interest,
                              style: TextStyle(
                                fontSize: AppTypography.fontSM,
                                fontWeight: FontWeight.w500,
                                color: isDark
                                    ? AppColors.darkText
                                    : AppColors.lightText,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  // Details section
                  TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 500),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - value)),
                          child: child,
                        ),
                      );
                    },
                    child: _ProfileSection(
                      title: 'Details',
                      isDark: isDark,
                      child: Column(
                        children: [
                          _DetailRow(
                            icon: LucideIcons.briefcase,
                            text: user.work,
                            isDark: isDark,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          _DetailRow(
                            icon: LucideIcons.graduationCap,
                            text: user.education,
                            isDark: isDark,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          _DetailRow(
                            icon: LucideIcons.mapPin,
                            text: '${user.distance} away',
                            isDark: isDark,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.xxl),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileSection extends StatelessWidget {
  final String title;
  final Widget child;
  final bool isDark;

  const _ProfileSection({
    required this.title,
    required this.child,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md + 4),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: isDark
            ? AppColors.darkShadowSmall
            : AppColors.lightShadowSmall,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: AppTypography.fontLG,
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.darkText : AppColors.lightText,
            ),
          ),
          const SizedBox(height: AppSpacing.md - 4),
          child,
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isDark;

  const _DetailRow({
    required this.icon,
    required this.text,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: isDark
              ? AppColors.darkTextSecondary
              : AppColors.lightTextSecondary,
        ),
        const SizedBox(width: AppSpacing.md - 4),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: AppTypography.fontBase,
              color: isDark ? AppColors.darkText : AppColors.lightText,
            ),
          ),
        ),
      ],
    );
  }
}
