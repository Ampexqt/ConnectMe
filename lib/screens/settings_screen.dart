import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_typography.dart';
import '../providers/theme_provider.dart';
import '../widgets/common/custom_card.dart';

/// Settings Screen
/// App settings and user preferences
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: AppTypography.fontXL,
                    fontWeight: FontWeight.w700,
                    color: isDark ? AppColors.darkText : AppColors.lightText,
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                // Preferences section
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SectionTitle(title: 'PREFERENCES', isDark: isDark),
                      const SizedBox(height: AppSpacing.md - 4),
                      CustomCard(
                        padding: EdgeInsets.zero,
                        child: Column(
                          children: [
                            _SettingItem(
                              icon: isDark ? LucideIcons.moon : LucideIcons.sun,
                              label: 'Dark Mode',
                              isDark: isDark,
                              trailing: _ToggleSwitch(
                                value: isDark,
                                onChanged: (value) {
                                  themeProvider.toggleTheme();
                                },
                                isDark: isDark,
                              ),
                            ),
                            _Divider(isDark: isDark),
                            _SettingItem(
                              icon: LucideIcons.bell,
                              label: 'Notifications',
                              isDark: isDark,
                              trailing: _ToggleSwitch(
                                value: true,
                                onChanged: (value) {},
                                isDark: isDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                // Account section
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SectionTitle(title: 'ACCOUNT', isDark: isDark),
                      const SizedBox(height: AppSpacing.md - 4),
                      CustomCard(
                        padding: EdgeInsets.zero,
                        child: Column(
                          children: [
                            _SettingItem(
                              icon: LucideIcons.user,
                              label: 'Edit Profile',
                              isDark: isDark,
                              onTap: () {},
                            ),
                            _Divider(isDark: isDark),
                            _SettingItem(
                              icon: LucideIcons.shield,
                              label: 'Privacy',
                              isDark: isDark,
                              onTap: () {},
                            ),
                            _Divider(isDark: isDark),
                            _SettingItem(
                              icon: LucideIcons.globe,
                              label: 'Language',
                              isDark: isDark,
                              trailing: Text(
                                'English',
                                style: TextStyle(
                                  fontSize: AppTypography.fontSM,
                                  color: isDark
                                      ? AppColors.darkTextSecondary
                                      : AppColors.lightTextSecondary,
                                ),
                              ),
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                // Support section
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SectionTitle(title: 'SUPPORT', isDark: isDark),
                      const SizedBox(height: AppSpacing.md - 4),
                      CustomCard(
                        padding: EdgeInsets.zero,
                        child: Column(
                          children: [
                            _SettingItem(
                              icon: LucideIcons.helpCircle,
                              label: 'Help & Support',
                              isDark: isDark,
                              onTap: () {},
                            ),
                            _Divider(isDark: isDark),
                            _SettingItem(
                              icon: LucideIcons.logOut,
                              label: 'Logout',
                              isDark: isDark,
                              isDanger: true,
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                // Footer
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Version 1.0.0',
                        style: TextStyle(
                          fontSize: AppTypography.fontSM,
                          color: isDark
                              ? AppColors.darkTextTertiary
                              : AppColors.lightTextTertiary,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'Made with ❤️ by ConnectMe',
                        style: TextStyle(
                          fontSize: AppTypography.fontXS,
                          color: isDark
                              ? AppColors.darkTextTertiary
                              : AppColors.lightTextTertiary,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final bool isDark;

  const _SectionTitle({required this.title, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: AppTypography.fontXS,
        fontWeight: FontWeight.w600,
        color: isDark
            ? AppColors.darkTextSecondary
            : AppColors.lightTextSecondary,
        letterSpacing: 1.2,
      ),
    );
  }
}

class _SettingItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDark;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool isDanger;

  const _SettingItem({
    required this.icon,
    required this.label,
    required this.isDark,
    this.trailing,
    this.onTap,
    this.isDanger = false,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = isDanger
        ? (isDark ? AppColors.darkError : AppColors.lightError)
        : (isDark ? AppColors.darkText : AppColors.lightText);

    final textColor = isDanger
        ? (isDark ? AppColors.darkError : AppColors.lightError)
        : (isDark ? AppColors.darkText : AppColors.lightText);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isDanger
                    ? (isDark ? AppColors.darkError : AppColors.lightError)
                    : (isDark
                          ? AppColors.darkSurfaceElevated
                          : AppColors.lightSurfaceElevated),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 20,
                color: isDanger ? Colors.white : iconColor,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: AppTypography.fontBase,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
            ),
            if (trailing != null)
              trailing!
            else if (onTap != null)
              Icon(
                LucideIcons.chevronRight,
                size: 20,
                color: isDark
                    ? AppColors.darkTextTertiary
                    : AppColors.lightTextTertiary,
              ),
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  final bool isDark;

  const _Divider({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
    );
  }
}

class _ToggleSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool isDark;

  const _ToggleSwitch({
    required this.value,
    required this.onChanged,
    required this.isDark,
  });

  @override
  State<_ToggleSwitch> createState() => _ToggleSwitchState();
}

class _ToggleSwitchState extends State<_ToggleSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _positionAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _positionAnimation = Tween<double>(
      begin: 0.0,
      end: 20.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    if (widget.value) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(_ToggleSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      if (widget.value) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
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
      onTap: () => widget.onChanged(!widget.value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 48,
        height: 28,
        decoration: BoxDecoration(
          color: widget.value
              ? (widget.isDark ? AppColors.darkPrimary : AppColors.lightPrimary)
              : (widget.isDark ? AppColors.darkBorder : AppColors.lightBorder),
          borderRadius: BorderRadius.circular(AppRadius.full),
        ),
        child: AnimatedBuilder(
          animation: _positionAnimation,
          builder: (context, child) {
            return Padding(
              padding: EdgeInsets.only(left: _positionAnimation.value + 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
