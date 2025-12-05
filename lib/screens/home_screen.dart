import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_typography.dart';
import '../providers/theme_provider.dart';
import '../providers/app_provider.dart';
import '../data/mock_data.dart';
import 'discovery_screen.dart';
import 'chat_list_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';

/// Home Screen
/// Main screen with bottom navigation
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _screens = [
    const DiscoveryScreen(),
    const ChatListScreen(),
    const ProfileScreen(),
    const SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    // Initialize mock data
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.setUsers(MockData.users);
    appProvider.setConversations(MockData.conversations);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, _) {
        return Scaffold(
          body: IndexedStack(
            index: appProvider.currentTabIndex,
            children: _screens,
          ),
          bottomNavigationBar: const _BottomNavBar(),
        );
      },
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
            width: 2,
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md - 4,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: LucideIcons.heart,
                label: 'Discover',
                isActive: appProvider.currentTabIndex == 0,
                onTap: () => appProvider.setTabIndex(0),
                isDark: isDark,
              ),
              _NavItem(
                icon: LucideIcons.messageCircle,
                label: 'Chats',
                isActive: appProvider.currentTabIndex == 1,
                onTap: () => appProvider.setTabIndex(1),
                isDark: isDark,
              ),
              _NavItem(
                icon: LucideIcons.user,
                label: 'Profile',
                isActive: appProvider.currentTabIndex == 2,
                onTap: () => appProvider.setTabIndex(2),
                isDark: isDark,
              ),
              _NavItem(
                icon: LucideIcons.settings,
                label: 'Settings',
                isActive: appProvider.currentTabIndex == 3,
                onTap: () => appProvider.setTabIndex(3),
                isDark: isDark,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final bool isDark;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
    required this.isDark,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    if (widget.isActive) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(_NavItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive != oldWidget.isActive) {
      if (widget.isActive) {
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
    final color = widget.isActive
        ? (widget.isDark ? AppColors.darkPrimary : AppColors.lightPrimary)
        : (widget.isDark
              ? AppColors.darkTextTertiary
              : AppColors.lightTextTertiary);

    return GestureDetector(
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ScaleTransition(
              scale: _scaleAnimation,
              child: Icon(widget.icon, size: 24, color: color),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              widget.label,
              style: TextStyle(
                fontSize: AppTypography.fontXS,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
            if (widget.isActive) ...[
              const SizedBox(height: 2),
              Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
