import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:pinput/pinput.dart';
import '../../theme/app_theme.dart';
import '../../cards/auth/support_bottomsheet.dart';
import '../../providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final PageController _pageController = PageController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _showSupport() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const SupportBottomSheet(),
    );
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
    );
    setState(() => _currentPage = 1);
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
    );
    setState(() => _currentPage = 0);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation Bar
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPadding,
                vertical: AppSpacing.elementGap,
              ),
              child: Row(
                children: [
                  if (_currentPage == 1)
                    IconButton(
                      onPressed: _previousPage,
                      icon: const Icon(IconsaxPlusLinear.arrow_left_2),
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.surface,
                        padding: const EdgeInsets.all(12),
                      ),
                    ).animate().fadeIn().scale(),
                  const Spacer(),
                  // Optional: Step Indicator or Logo
                ],
              ),
            ),

            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  // Slide 1: Phone Number
                  _buildSlide(
                    header: 'Join us via phone number',
                    tagline:
                        'We will send a 4 digit verification code to your phone number',
                    inputField: TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      style: AppTextStyles.cardTitle.copyWith(
                        fontSize: 16,
                        letterSpacing: 1.5,
                      ),
                      decoration: InputDecoration(
                        hintText: '92459 49446',
                        prefixIcon: IntrinsicHeight(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(width: 16),
                              const Text(
                                '🇮🇳',
                                style: TextStyle(fontSize: 20),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '+91',
                                style: AppTextStyles.cardTitle.copyWith(
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const VerticalDivider(
                                color: AppColors.divider,
                                thickness: 1,
                                indent: 12,
                                endIndent: 12,
                              ),
                              const SizedBox(width: 8),
                            ],
                          ),
                        ),
                      ),
                    ),
                    buttonText: 'Send OTP',
                    onButtonPressed: _nextPage,
                    footer: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text.rich(
                          TextSpan(
                            style: AppTextStyles.caption,
                            children: [
                              const TextSpan(
                                text: "By signing in, you accept our ",
                              ),
                              TextSpan(
                                text: "Terms and Conditions",
                                style: TextStyle(
                                  color: AppColors.primaryAccent,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    isLoading: authState.isLoading,
                  ),

                  // Slide 2: OTP Verification
                  _buildSlide(
                    header: 'Verify OTP',
                    tagline:
                        'Please enter the 4-digit code received on your mobile',
                    inputField: Pinput(
                      controller: _otpController,
                      length: 4,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      defaultPinTheme: PinTheme(
                        width: 60,
                        height: 70,
                        textStyle: AppTextStyles.cardTitle.copyWith(
                          fontSize: 20,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.divider),
                        ),
                      ),
                      focusedPinTheme: PinTheme(
                        width: 56,
                        height: 56,
                        textStyle: AppTextStyles.cardTitle.copyWith(
                          fontSize: 20,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.primary,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withAlpha(20),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                      submittedPinTheme: PinTheme(
                        width: 56,
                        height: 56,
                        textStyle: AppTextStyles.cardTitle.copyWith(
                          fontSize: 20,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withAlpha(10),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.primaryAccent),
                        ),
                      ),
                    ),
                    buttonText: 'Verify',
                    onButtonPressed: () {
                      context.go('/home');
                    },
                    footer: Center(
                      child: GestureDetector(
                        onTap: _showSupport,
                        child: RichText(
                          text: TextSpan(
                            style: AppTextStyles.description.copyWith(
                              fontSize: 14,
                            ),
                            children: [
                              const TextSpan(text: "Didn't receive the OTP? "),
                              TextSpan(
                                text: "Contact Support",
                                style: TextStyle(
                                  color: AppColors.primaryAccent,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    isLoading: authState.isLoading,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlide({
    required String header,
    required String tagline,
    required Widget inputField,
    required String buttonText,
    required VoidCallback onButtonPressed,
    required Widget footer,
    required bool isLoading,
  }) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.sectionGap),

          Text(
            header,
            style: AppTextStyles.header,
          ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2, end: 0),

          const SizedBox(height: 8),

          Text(tagline, style: AppTextStyles.description)
              .animate()
              .fadeIn(delay: 200.ms, duration: 600.ms)
              .slideX(begin: -0.1, end: 0),

          const SizedBox(height: AppSpacing.sectionGap * 1.5),

          inputField
              .animate()
              .fadeIn(delay: 400.ms)
              .scale(begin: const Offset(0.98, 0.98)),

          const SizedBox(height: AppSpacing.sectionGap),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isLoading ? null : onButtonPressed,
              child: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(buttonText),
            ),
          ).animate().fadeIn(delay: 600.ms),

          const SizedBox(height: AppSpacing.sectionGap),

          footer.animate().fadeIn(delay: 800.ms),
        ],
      ),
    );
  }
}
