import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../core/theme/app_spacing.dart';
import '../providers/theme_provider.dart';
import '../widgets/common/custom_button.dart';
import 'auth_screen.dart';

class OnboardingSlide {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  OnboardingSlide({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });
}

/// Onboarding Screen
/// Displays 3 slides introducing the app features
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingSlide> _slides = [
    OnboardingSlide(
      icon: LucideIcons.users,
      title: 'Discover People',
      description:
          'Find interesting people nearby who share your passions and interests',
      color: const Color(0xFFFF6B6B),
    ),
    OnboardingSlide(
      icon: LucideIcons.mapPin,
      title: 'Connect Locally',
      description: 'Meet people in your area and build meaningful connections',
      color: const Color(0xFF4ECDC4),
    ),
    OnboardingSlide(
      icon: LucideIcons.messageCircle,
      title: 'Start Chatting',
      description: 'Send messages and get to know your matches better',
      color: const Color(0xFFFFE66D),
    ),
  ];

  void _nextPage() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToAuth();
    }
  }

  void _navigateToAuth() {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const AuthScreen()));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              // Progress indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_slides.length, (index) {
                  final isActive = index == _currentPage;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 4,
                    width: isActive ? 32 : 8,
                    decoration: BoxDecoration(
                      color: isActive
                          ? (isDark
                                ? AppColors.darkPrimary
                                : AppColors.lightPrimary)
                          : (isDark
                                ? AppColors.darkBorder
                                : AppColors.lightBorder),
                      borderRadius: BorderRadius.circular(AppRadius.full),
                    ),
                  );
                }),
              ),

              const SizedBox(height: AppSpacing.xxl),

              // Slides
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: _slides.length,
                  itemBuilder: (context, index) {
                    return _OnboardingSlideWidget(slide: _slides[index]);
                  },
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // Next/Get Started button
              CustomButton(
                text: _currentPage == _slides.length - 1
                    ? 'Get Started'
                    : 'Next',
                onPressed: _nextPage,
                variant: ButtonVariant.primary,
                size: ButtonSize.large,
                fullWidth: true,
              ),

              const SizedBox(height: AppSpacing.md),

              // Skip button
              if (_currentPage < _slides.length - 1)
                TextButton(
                  onPressed: _navigateToAuth,
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: AppTypography.fontSM,
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingSlideWidget extends StatefulWidget {
  final OnboardingSlide slide;

  const _OnboardingSlideWidget({required this.slide});

  @override
  State<_OnboardingSlideWidget> createState() => _OnboardingSlideWidgetState();
}

class _OnboardingSlideWidgetState extends State<_OnboardingSlideWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconScale;
  late Animation<double> _contentOpacity;
  late Animation<Offset> _contentSlide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _iconScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
      ),
    );

    _contentOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
      ),
    );

    _contentSlide = Tween<Offset>(begin: const Offset(100, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
          ),
        );

    _controller.forward();
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

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Icon container
        AnimatedBuilder(
          animation: _iconScale,
          builder: (context, child) {
            return Transform.scale(
              scale: _iconScale.value,
              child: Container(
                width: 128,
                height: 128,
                decoration: BoxDecoration(
                  color: widget.slide.color,
                  shape: BoxShape.circle,
                ),
                child: Icon(widget.slide.icon, size: 64, color: Colors.white),
              ),
            );
          },
        ),

        const SizedBox(height: AppSpacing.xxl),

        // Content
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _contentOpacity.value,
              child: Transform.translate(
                offset: _contentSlide.value,
                child: Column(
                  children: [
                    Text(
                      widget.slide.title,
                      style: TextStyle(
                        fontSize: AppTypography.font2XL,
                        fontWeight: FontWeight.w700,
                        color: isDark
                            ? AppColors.darkText
                            : AppColors.lightText,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                      ),
                      child: Text(
                        widget.slide.description,
                        style: TextStyle(
                          fontSize: AppTypography.fontLG,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                          height: AppTypography.lineHeightRelaxed,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
