import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_typography.dart';
import '../providers/theme_provider.dart';
import '../providers/app_provider.dart';
import '../models/chat.dart';
import '../widgets/common/custom_avatar.dart';
import '../widgets/common/custom_card.dart';
import 'chat_screen.dart';

/// Chat List Screen
/// Displays all chat conversations
class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Messages',
                    style: TextStyle(
                      fontSize: AppTypography.fontXL,
                      fontWeight: FontWeight.w700,
                      color: isDark ? AppColors.darkText : AppColors.lightText,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  // Search input
                  Container(
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.darkSurface
                          : AppColors.lightSurface,
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      border: Border.all(
                        color: isDark
                            ? AppColors.darkBorder
                            : AppColors.lightBorder,
                        width: 2,
                      ),
                    ),
                    child: TextField(
                      style: TextStyle(
                        fontSize: AppTypography.fontBase,
                        color: isDark
                            ? AppColors.darkText
                            : AppColors.lightText,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search messages...',
                        hintStyle: TextStyle(
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                        prefixIcon: Icon(
                          LucideIcons.search,
                          size: 20,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.md - 4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Chat list
            Expanded(
              child: appProvider.conversations.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            LucideIcons.messageCircle,
                            size: 64,
                            color: isDark
                                ? AppColors.darkTextTertiary
                                : AppColors.lightTextTertiary,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            'No messages yet',
                            style: TextStyle(
                              fontSize: AppTypography.fontLG,
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? AppColors.darkText
                                  : AppColors.lightText,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            'Start discovering people to chat with',
                            style: TextStyle(
                              fontSize: AppTypography.fontSM,
                              color: isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.lightTextSecondary,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                      ),
                      itemCount: appProvider.conversations.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: AppSpacing.md),
                      itemBuilder: (context, index) {
                        return TweenAnimationBuilder<double>(
                          duration: Duration(milliseconds: 300 + (index * 50)),
                          tween: Tween(begin: 0.0, end: 1.0),
                          builder: (context, value, child) {
                            return Opacity(
                              opacity: value,
                              child: Transform.translate(
                                offset: Offset(-20 * (1 - value), 0),
                                child: child,
                              ),
                            );
                          },
                          child: _ChatItem(
                            conversation: appProvider.conversations[index],
                            isDark: isDark,
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatItem extends StatelessWidget {
  final ChatConversation conversation;
  final bool isDark;

  const _ChatItem({required this.conversation, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final hasUnread = conversation.unread > 0;

    return CustomCard(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ChatScreen(conversation: conversation),
          ),
        );
      },
      child: Row(
        children: [
          // Avatar
          CustomAvatar(
            imageUrl: conversation.avatar,
            name: conversation.name,
            size: AvatarSize.medium,
            showOnlineStatus: true,
            isOnline: conversation.online,
          ),

          const SizedBox(width: AppSpacing.md),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  conversation.name,
                  style: TextStyle(
                    fontSize: AppTypography.fontBase,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.darkText : AppColors.lightText,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  conversation.lastMessage,
                  style: TextStyle(
                    fontSize: AppTypography.fontSM,
                    color: hasUnread
                        ? (isDark ? AppColors.darkText : AppColors.lightText)
                        : (isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary),
                    fontWeight: hasUnread ? FontWeight.w500 : FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          const SizedBox(width: AppSpacing.md),

          // Metadata
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                conversation.timestamp,
                style: TextStyle(
                  fontSize: AppTypography.fontXS,
                  color: isDark
                      ? AppColors.darkTextTertiary
                      : AppColors.lightTextTertiary,
                ),
              ),
              if (hasUnread) ...[
                const SizedBox(height: 4),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.darkPrimary
                        : AppColors.lightPrimary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${conversation.unread}',
                      style: const TextStyle(
                        fontSize: AppTypography.fontXS,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
