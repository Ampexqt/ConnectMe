import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../core/theme/app_spacing.dart';
import '../providers/theme_provider.dart';
import '../providers/app_provider.dart';
import '../widgets/common/custom_button.dart';
import 'interests_screen.dart';

/// Auth Screen
/// Handles sign in and sign up with form validation
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isSignUp = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _handleAuth() {
    // Simulate authentication
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.setAuthenticated(true);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const InterestsScreen()),
    );
  }

  void _toggleAuthMode() {
    setState(() {
      _isSignUp = !_isSignUp;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 448),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        LucideIcons.heart,
                        size: 48,
                        color: isDark
                            ? AppColors.darkPrimary
                            : AppColors.lightPrimary,
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Text(
                        'ConnectMe',
                        style: TextStyle(
                          fontSize: AppTypography.fontXL,
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? AppColors.darkText
                              : AppColors.lightText,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSpacing.xxl),

                  // Form fields
                  AnimatedSize(
                    duration: const Duration(milliseconds: 200),
                    child: Column(
                      children: [
                        // Name field (signup only)
                        if (_isSignUp) ...[
                          _InputField(
                            controller: _nameController,
                            icon: LucideIcons.user,
                            hintText: 'Full Name',
                            isDark: isDark,
                          ),
                          const SizedBox(height: AppSpacing.md),
                        ],

                        // Email field
                        _InputField(
                          controller: _emailController,
                          icon: LucideIcons.mail,
                          hintText: 'Email',
                          isDark: isDark,
                        ),

                        const SizedBox(height: AppSpacing.md),

                        // Password field
                        _InputField(
                          controller: _passwordController,
                          icon: LucideIcons.lock,
                          hintText: 'Password',
                          obscureText: true,
                          isDark: isDark,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // Forgot password (sign in only)
                  if (!_isSignUp)
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(
                            fontSize: AppTypography.fontSM,
                            fontWeight: FontWeight.w500,
                            color: isDark
                                ? AppColors.darkPrimary
                                : AppColors.lightPrimary,
                          ),
                        ),
                      ),
                    ),

                  const SizedBox(height: AppSpacing.lg),

                  // Primary auth button
                  CustomButton(
                    text: _isSignUp ? 'Create Account' : 'Sign In',
                    onPressed: _handleAuth,
                    variant: ButtonVariant.primary,
                    size: ButtonSize.large,
                    fullWidth: true,
                  ),

                  const SizedBox(height: AppSpacing.md - 4),

                  // Google sign in
                  CustomButton(
                    text: 'Continue with Google',
                    onPressed: () {},
                    variant: ButtonVariant.secondary,
                    size: ButtonSize.large,
                    fullWidth: true,
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  // Toggle auth mode
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _isSignUp
                            ? 'Already have an account?'
                            : "Don't have an account?",
                        style: TextStyle(
                          fontSize: AppTypography.fontSM,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                      TextButton(
                        onPressed: _toggleAuthMode,
                        child: Text(
                          _isSignUp ? 'Sign In' : 'Sign Up',
                          style: TextStyle(
                            fontSize: AppTypography.fontSM,
                            fontWeight: FontWeight.w500,
                            color: isDark
                                ? AppColors.darkPrimary
                                : AppColors.lightPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String hintText;
  final bool obscureText;
  final bool isDark;

  const _InputField({
    required this.controller,
    required this.icon,
    required this.hintText,
    this.obscureText = false,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 2,
        ),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(
          fontSize: AppTypography.fontBase,
          color: isDark ? AppColors.darkText : AppColors.lightText,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
          ),
          prefixIcon: Icon(
            icon,
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
    );
  }
}
