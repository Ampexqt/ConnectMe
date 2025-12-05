import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_typography.dart';
import '../providers/theme_provider.dart';
import '../models/chat.dart';
import '../widgets/common/custom_avatar.dart';

/// Chat Screen
/// Individual chat conversation
class ChatScreen extends StatefulWidget {
  final ChatConversation conversation;

  const ChatScreen({super.key, required this.conversation});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    // Add message logic here
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final hasText = _messageController.text.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark
            ? AppColors.darkSurface
            : AppColors.lightSurface,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, size: 24),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [
            CustomAvatar(
              imageUrl: widget.conversation.avatar,
              name: widget.conversation.name,
              size: AvatarSize.medium,
              showOnlineStatus: true,
              isOnline: widget.conversation.online,
            ),
            const SizedBox(width: AppSpacing.md - 4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.conversation.name,
                    style: TextStyle(
                      fontSize: AppTypography.fontBase,
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppColors.darkText : AppColors.lightText,
                    ),
                  ),
                  Text(
                    widget.conversation.online ? 'Online' : 'Offline',
                    style: TextStyle(
                      fontSize: AppTypography.fontSM,
                      color: widget.conversation.online
                          ? (isDark
                                ? AppColors.darkSuccess
                                : AppColors.lightSuccess)
                          : (isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.moreVertical, size: 24),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages area
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: widget.conversation.messages.length,
              itemBuilder: (context, index) {
                return TweenAnimationBuilder<double>(
                  duration: Duration(milliseconds: 300 + (index * 50)),
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
                  child: _ChatBubble(
                    message: widget.conversation.messages[index],
                    isDark: isDark,
                  ),
                );
              },
            ),
          ),

          // Input area
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
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
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.darkBackground
                            : AppColors.lightBackground,
                        borderRadius: BorderRadius.circular(AppRadius.full),
                        border: Border.all(
                          color: isDark
                              ? AppColors.darkBorder
                              : AppColors.lightBorder,
                          width: 2,
                        ),
                      ),
                      child: TextField(
                        controller: _messageController,
                        style: TextStyle(
                          fontSize: AppTypography.fontBase,
                          color: isDark
                              ? AppColors.darkText
                              : AppColors.lightText,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          hintStyle: TextStyle(
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
                        onChanged: (value) => setState(() {}),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md - 4),
                  _SendButton(
                    onTap: _sendMessage,
                    hasText: hasText,
                    isDark: isDark,
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

class _ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isDark;

  const _ChatBubble({required this.message, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final isSent = message.sent;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md - 4),
      child: Row(
        mainAxisAlignment: isSent
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md - 4,
            ),
            decoration: BoxDecoration(
              color: isSent
                  ? (isDark ? AppColors.darkPrimary : AppColors.lightPrimary)
                  : (isDark
                        ? AppColors.darkSurfaceElevated
                        : AppColors.lightSurfaceElevated),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(AppRadius.lg),
                topRight: const Radius.circular(AppRadius.lg),
                bottomLeft: Radius.circular(
                  isSent ? AppRadius.lg : AppRadius.xs,
                ),
                bottomRight: Radius.circular(
                  isSent ? AppRadius.xs : AppRadius.lg,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.message,
                  style: TextStyle(
                    fontSize: AppTypography.fontBase,
                    color: isSent
                        ? Colors.white
                        : (isDark ? AppColors.darkText : AppColors.lightText),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  message.timestamp,
                  style: TextStyle(
                    fontSize: AppTypography.fontXS,
                    color: isSent
                        ? Colors.white.withOpacity(0.7)
                        : (isDark
                              ? AppColors.darkTextTertiary
                              : AppColors.lightTextTertiary),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SendButton extends StatefulWidget {
  final VoidCallback onTap;
  final bool hasText;
  final bool isDark;

  const _SendButton({
    required this.onTap,
    required this.hasText,
    required this.isDark,
  });

  @override
  State<_SendButton> createState() => _SendButtonState();
}

class _SendButtonState extends State<_SendButton>
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
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: widget.hasText
                ? (widget.isDark
                      ? AppColors.darkPrimary
                      : AppColors.lightPrimary)
                : (widget.isDark
                      ? AppColors.darkSurfaceElevated
                      : AppColors.lightSurfaceElevated),
            shape: BoxShape.circle,
          ),
          child: Icon(
            LucideIcons.send,
            size: 20,
            color: widget.hasText
                ? Colors.white
                : (widget.isDark
                      ? AppColors.darkTextTertiary
                      : AppColors.lightTextTertiary),
          ),
        ),
      ),
    );
  }
}
