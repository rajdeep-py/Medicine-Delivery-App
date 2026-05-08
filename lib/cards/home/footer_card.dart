import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../theme/app_theme.dart';

class FooterCard extends StatelessWidget {
  const FooterCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      color: AppColors.surface,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(IconsaxPlusBold.health, color: AppColors.primary, size: 32),
              const SizedBox(width: 12),
              Text(
                'Naiyo24',
                style: AppTextStyles.header.copyWith(fontSize: 24, letterSpacing: 1),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Your 24/7 Digital Healthcare Partner',
            style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          const Divider(),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildFooterLink(IconsaxPlusLinear.info_circle, 'About Us'),
              _buildFooterLink(IconsaxPlusLinear.shield_tick, 'Privacy'),
              _buildFooterLink(IconsaxPlusLinear.message_question, 'Help'),
            ],
          ),
          const SizedBox(height: 40),
          Text(
            '© 2026 Naiyo24 Healthcare. All Rights Reserved.',
            style: AppTextStyles.caption.copyWith(fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterLink(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: AppColors.textSecondary, size: 24),
        const SizedBox(height: 8),
        Text(label, style: AppTextStyles.caption.copyWith(fontSize: 12)),
      ],
    );
  }
}
