import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_typography.dart';
import '../providers/theme_provider.dart';
import '../models/user_profile.dart';

/// Profile Screen
/// Displays the current user's profile information
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Mock current user data
  UserProfile get _currentUser => UserProfile(
    id: 'current_user',
    name: 'Sarah Chen',
    age: 26,
    location: 'San Francisco, CA',
    distance: '',
    bio:
        'Coffee enthusiast ☕ | Weekend hiker 🥾 | Always up for exploring new cafes and trails. Love meeting new people who share my passion for the outdoors and good conversation.',
    interests: [
      'Coffee',
      'Hiking',
      'Photography',
      'Travel',
      'Reading',
      'Cooking',
    ],
    work: 'Product Designer at TechCo',
    education: 'BA in Design, UC Berkeley',
    memberSince: 'January 2024',
    email: 'sarah.chen@example.com',
    phone: '+1 234 567 8900',
    instagram: '@sarahchen',
    languages: ['English', 'Mandarin'],
    lookingFor: 'Friends to explore the city and grab coffee with',
    favoriteSpots: ['Blue Bottle Coffee', 'Golden Gate Park', 'The Mill'],
    image: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400',
    photos: [
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400',
      'https://images.unsplash.com/photo-1513721032312-6a18a42c8763?w=400',
      'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400',
    ],
  );

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image Section
            Stack(
              children: [
                // Background image
                Container(
                  height: 320,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(_currentUser.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Gradient overlay
                Container(
                  height: 320,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.4),
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.8),
                      ],
                    ),
                  ),
                ),
                // Content overlay
                Positioned(
                  bottom: AppSpacing.lg,
                  left: AppSpacing.lg,
                  right: AppSpacing.lg,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${_currentUser.name}, ${_currentUser.age}',
                        style: const TextStyle(
                          fontSize: AppTypography.font2XL,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Row(
                        children: [
                          const Icon(
                            LucideIcons.mapPin,
                            size: 16,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _currentUser.location,
                            style: TextStyle(
                              fontSize: AppTypography.fontBase,
                              color: Colors.white.withOpacity(0.9),
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
                        _currentUser.bio,
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
                        children: _currentUser.interests.map((interest) {
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
                            text: _currentUser.work,
                            isDark: isDark,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          _DetailRow(
                            icon: LucideIcons.graduationCap,
                            text: _currentUser.education,
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
      padding: const EdgeInsets.all(AppSpacing.md),
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
