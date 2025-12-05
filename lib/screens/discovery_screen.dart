import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_typography.dart';
import '../providers/theme_provider.dart';
import '../providers/app_provider.dart';
import '../models/user_profile.dart';
import 'chat_screen.dart';
import 'user_detail_screen.dart';

/// Discovery Screen
/// Swipeable card interface for discovering people with infinite looping
class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({super.key});

  @override
  State<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreen> {
  int _currentIndex = 0;

  void _handlePass() {
    final appProvider = context.read<AppProvider>();
    setState(() {
      // Loop back to start if we've reached the end (infinite loop)
      _currentIndex = (_currentIndex + 1) % appProvider.users.length;
    });
  }

  void _handleLike() {
    final appProvider = context.read<AppProvider>();
    final currentUser = appProvider.users[_currentIndex];

    // Find the conversation for this user
    final conversation = appProvider.conversations.firstWhere(
      (conv) => conv.userId == currentUser.id,
      orElse: () =>
          appProvider.conversations.first, // Fallback to first conversation
    );

    // Navigate to chat screen
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (_) => ChatScreen(conversation: conversation),
          ),
        )
        .then((_) {
          // After returning from chat, switch to Chats tab
          appProvider.setTabIndex(1);
        });

    // Move to next card
    setState(() {
      _currentIndex = (_currentIndex + 1) % appProvider.users.length;
    });
  }

  void _handleInfo() {
    final appProvider = context.read<AppProvider>();
    final currentUser = appProvider.users[_currentIndex];

    // Navigate to user detail screen
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => UserDetailScreen(user: currentUser)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final users = appProvider.users;

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
                    'Discover',
                    style: TextStyle(
                      fontSize: AppTypography.fontXL,
                      fontWeight: FontWeight.w700,
                      color: isDark ? AppColors.darkText : AppColors.lightText,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'People nearby who share your interests',
                    style: TextStyle(
                      fontSize: AppTypography.fontSM,
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                    ),
                  ),
                ],
              ),
            ),

            // Card stack (always shows a card due to infinite looping)
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 448),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                    ),
                    child: _UserCard(
                      key: ValueKey(users[_currentIndex].id),
                      user: users[_currentIndex],
                      isDark: isDark,
                      onPass: _handlePass,
                      onLike: _handleLike,
                      onInfo: _handleInfo,
                    ),
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

class _UserCard extends StatelessWidget {
  final UserProfile user;
  final bool isDark;
  final VoidCallback onPass;
  final VoidCallback onLike;
  final VoidCallback onInfo;

  const _UserCard({
    super.key,
    required this.user,
    required this.isDark,
    required this.onPass,
    required this.onLike,
    required this.onInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 580,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        boxShadow: isDark
            ? AppColors.darkShadowLarge
            : AppColors.lightShadowLarge,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section
          Stack(
            children: [
              Container(
                height: 384,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AppRadius.xl),
                    topRight: Radius.circular(AppRadius.xl),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(user.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: 384,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AppRadius.xl),
                    topRight: Radius.circular(AppRadius.xl),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                  ),
                ),
              ),
              Positioned(
                bottom: AppSpacing.md,
                left: AppSpacing.md,
                right: AppSpacing.md,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${user.name}, ${user.age}',
                      style: const TextStyle(
                        fontSize: AppTypography.fontXL,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Row(
                      children: [
                        const Icon(
                          LucideIcons.mapPin,
                          size: 14,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${user.location} • ${user.distance}',
                          style: TextStyle(
                            fontSize: AppTypography.fontSM,
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

          // Info section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md + 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Bio
                  Text(
                    user.bio,
                    style: TextStyle(
                      fontSize: AppTypography.fontSM,
                      color: isDark ? AppColors.darkText : AppColors.lightText,
                      height: AppTypography.lineHeightRelaxed,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: AppSpacing.md - 4),

                  // Interest tags
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: user.interests.take(3).map((interest) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md - 4,
                          vertical: AppSpacing.xs + 2,
                        ),
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppColors.darkSurfaceElevated
                              : AppColors.lightSurfaceElevated,
                          borderRadius: BorderRadius.circular(AppRadius.full),
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
                            fontSize: AppTypography.fontXS,
                            fontWeight: FontWeight.w500,
                            color: isDark
                                ? AppColors.darkText
                                : AppColors.lightText,
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const Spacer(),

                  // Action buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _ActionButton(
                        icon: LucideIcons.x,
                        color: const Color(0xFF2D3436),
                        onTap: onPass,
                      ),
                      const SizedBox(width: AppSpacing.md),
                      _ActionButton(
                        icon: LucideIcons.info,
                        color: isDark
                            ? AppColors.darkPrimary
                            : AppColors.lightPrimary,
                        onTap: onInfo,
                      ),
                      const SizedBox(width: AppSpacing.md),
                      _ActionButton(
                        icon: LucideIcons.heart,
                        color: isDark
                            ? AppColors.darkSecondary
                            : AppColors.lightSecondary,
                        onTap: onLike,
                        filled: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatefulWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final bool filled;

  const _ActionButton({
    required this.icon,
    required this.color,
    required this.onTap,
    this.filled = false,
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton>
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
      end: 0.9,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: widget.color,
            shape: BoxShape.circle,
          ),
          child: Icon(
            widget.icon,
            size: widget.filled ? 24 : 28,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
