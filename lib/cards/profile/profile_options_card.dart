import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../theme/app_theme.dart';

class ProfileOptionsCard extends StatelessWidget {
  const ProfileOptionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: Text(
            'ACCOUNT SETTINGS',
            style: AppTextStyles.tagline.copyWith(
              fontSize: 12,
              color: AppColors.textTertiary,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: AppCardStyles.sleekCard,
          child: Column(
            children: [
              _OptionTile(
                icon: IconsaxPlusLinear.bag_2,
                color: AppColors.primary,
                title: 'Order History',
                subtitle: 'Track and manage your orders',
                onTap: () {},
              ),
              _divider(),
              _OptionTile(
                icon: IconsaxPlusLinear.shopping_cart,
                color: AppColors.purple,
                title: 'My Cart',
                subtitle: 'Items you have saved',
                onTap: () {},
              ),
              _divider(),
              _OptionTile(
                icon: IconsaxPlusLinear.notification,
                color: AppColors.warning,
                title: 'Notifications',
                subtitle: 'Manage alerts and updates',
                onTap: () {},
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: Text(
            'SUPPORT & PREFERENCES',
            style: AppTextStyles.tagline.copyWith(
              fontSize: 12,
              color: AppColors.textTertiary,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: AppCardStyles.sleekCard,
          child: Column(
            children: [
              _OptionTile(
                icon: IconsaxPlusLinear.message_question,
                color: AppColors.info,
                title: 'Help and Support',
                subtitle: 'Get assistance and FAQs',
                onTap: () {},
              ),
              _divider(),
              _OptionTile(
                icon: IconsaxPlusLinear.setting_2,
                color: AppColors.secondaryCyan,
                title: 'Settings',
                subtitle: 'App preferences and security',
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.only(left: 70, right: AppSpacing.cardPadding),
      child: Divider(color: AppColors.divider.withAlpha(80), height: 1),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _OptionTile({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withAlpha(15),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(icon, size: 22, color: color),
      ),
      title: Text(
        title,
        style: AppTextStyles.cardTitle.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.caption.copyWith(
          color: AppColors.textTertiary,
          fontSize: 12,
        ),
      ),
      trailing: const Icon(
        IconsaxPlusLinear.arrow_right_3,
        size: 18,
        color: AppColors.textTertiary,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.cardPadding,
        vertical: 6,
      ),
    );
  }
}
