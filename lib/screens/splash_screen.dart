import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../core/theme/app_spacing.dart';
import '../providers/app_provider.dart';
import 'onboarding_screen.dart';

/// Splash Screen
/// Displays app logo with animations for 2.5 seconds
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _heartController;
  late AnimationController _textController;
  late AnimationController _dotsController;

  late Animation<double> _heartScale;
  late Animation<double> _heartRotation;
  late Animation<double> _nameOpacity;
  late Animation<double> _nameSlide;
  late Animation<double> _taglineOpacity;

  @override
  void initState() {
    super.initState();

    // Heart animation
    _heartController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _heartScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _heartController, curve: Curves.elasticOut),
    );
    _heartRotation = Tween<double>(
      begin: -180.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _heartController, curve: Curves.easeOut));

    // Text animations
    _textController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _nameOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(_textController);
    _nameSlide = Tween<double>(begin: 20.0, end: 0.0).animate(_textController);
    _taglineOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_textController);

    // Dots animation
    _dotsController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();

    // Start animations
    Future.delayed(const Duration(milliseconds: 200), () {
      _heartController.forward();
    });

    Future.delayed(const Duration(milliseconds: 600), () {
      _textController.forward();
    });

    // Navigate after 2.5 seconds
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const OnboardingScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _heartController.dispose();
    _textController.dispose();
    _dotsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightPrimary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Heart icon with animation
            AnimatedBuilder(
              animation: _heartController,
              builder: (context, child) {
                return Transform.scale(
                  scale: _heartScale.value,
                  child: Transform.rotate(
                    angle: _heartRotation.value * 3.14159 / 180,
                    child: const Icon(
                      LucideIcons.heart,
                      size: 80,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: AppSpacing.lg),

            // App name
            AnimatedBuilder(
              animation: _textController,
              builder: (context, child) {
                return Opacity(
                  opacity: _nameOpacity.value,
                  child: Transform.translate(
                    offset: Offset(0, _nameSlide.value),
                    child: const Text(
                      'ConnectMe',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: AppSpacing.sm),

            // Tagline
            AnimatedBuilder(
              animation: _textController,
              builder: (context, child) {
                return Opacity(
                  opacity: _taglineOpacity.value,
                  child: Text(
                    'Find your people',
                    style: TextStyle(
                      fontSize: AppTypography.fontLG,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: AppSpacing.xl),

            // Loading dots
            AnimatedBuilder(
              animation: _dotsController,
              builder: (context, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    final delay = index * 0.2;
                    final value = (_dotsController.value + delay) % 1.0;
                    final scale = value < 0.5
                        ? 1.0 + (value * 2 * 0.5)
                        : 1.5 - ((value - 0.5) * 2 * 0.5);

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Transform.scale(
                        scale: scale,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
