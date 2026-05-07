import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/app_theme.dart';

class SupportBottomSheet extends StatelessWidget {
  const SupportBottomSheet({super.key});

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.screenPadding),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppSpacing.borderRadius),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sectionGap),
          const Text(
            'Contact Support',
            style: AppTextStyles.subHeader,
          ),
          const SizedBox(height: AppSpacing.elementGap),
          Text(
            'How would you like to reach us?',
            style: AppTextStyles.description.copyWith(fontSize: 14),
          ),
          const SizedBox(height: AppSpacing.sectionGap),
          _SupportTile(
            icon: IconsaxPlusLinear.call,
            title: 'Call Us',
            subtitle: '+91 1234567890',
            onTap: () => _launchUrl('tel:+911234567890'),
          ),
          _SupportTile(
            icon: IconsaxPlusLinear.sms,
            title: 'Email Us',
            subtitle: 'support@naiyo24.com',
            onTap: () => _launchUrl('mailto:support@naiyo24.com'),
          ),
          _SupportTile(
            icon: IconsaxPlusLinear.global,
            title: 'Website',
            subtitle: 'www.naiyo24.com',
            onTap: () => _launchUrl('https://www.naiyo24.com'),
          ),
          const SizedBox(height: AppSpacing.sectionGap),
        ],
      ),
    );
  }
}

class _SupportTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SupportTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.elementGap),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.cardPadding),
          decoration: AppCardStyles.sleekCard,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withAlpha(20),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: AppColors.primaryAccent, size: 24),
              ),
              const SizedBox(width: AppSpacing.elementGap),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.cardTitle.copyWith(fontSize: 16),
                    ),
                    Text(
                      subtitle,
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ),
              const Icon(
                IconsaxPlusLinear.arrow_right_3,
                color: AppColors.textTertiary,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
