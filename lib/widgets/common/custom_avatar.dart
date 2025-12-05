import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../providers/theme_provider.dart';

enum AvatarSize { small, medium, large, xl }

/// Custom Avatar Component
/// Displays user avatar with online status indicator
class CustomAvatar extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final AvatarSize size;
  final bool showOnlineStatus;
  final bool isOnline;

  const CustomAvatar({
    super.key,
    this.imageUrl,
    required this.name,
    this.size = AvatarSize.medium,
    this.showOnlineStatus = false,
    this.isOnline = false,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    // Size configurations
    double avatarSize;
    double fontSize;
    double onlineIndicatorSize;

    switch (size) {
      case AvatarSize.small:
        avatarSize = 40;
        fontSize = AppTypography.fontSM;
        onlineIndicatorSize = 2.5;
        break;
      case AvatarSize.medium:
        avatarSize = 48;
        fontSize = AppTypography.fontBase;
        onlineIndicatorSize = 3.5;
        break;
      case AvatarSize.large:
        avatarSize = 64;
        fontSize = AppTypography.fontLG;
        onlineIndicatorSize = 4.5;
        break;
      case AvatarSize.xl:
        avatarSize = 96;
        fontSize = AppTypography.fontXL;
        onlineIndicatorSize = 5;
        break;
    }

    final initials = _getInitials(name);
    final primaryColor = isDark
        ? AppColors.darkPrimary
        : AppColors.lightPrimary;

    return Stack(
      children: [
        Container(
          width: avatarSize,
          height: avatarSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: imageUrl == null ? primaryColor : Colors.transparent,
            image: imageUrl != null
                ? DecorationImage(
                    image: NetworkImage(imageUrl!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: imageUrl == null
              ? Center(
                  child: Text(
                    initials,
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                )
              : null,
        ),
        if (showOnlineStatus && isOnline)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: onlineIndicatorSize * 2,
              height: onlineIndicatorSize * 2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDark ? AppColors.darkSuccess : AppColors.lightSuccess,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }

  String _getInitials(String name) {
    final words = name.trim().split(' ');
    if (words.isEmpty) return '';
    if (words.length == 1) return words[0][0].toUpperCase();
    return '${words[0][0]}${words[1][0]}'.toUpperCase();
  }
}
