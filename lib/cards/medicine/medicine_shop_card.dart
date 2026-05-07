import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../theme/app_theme.dart';

class MedicineShopCard extends StatelessWidget {
  final String shopName;
  final String shopAddress;

  const MedicineShopCard({
    super.key,
    required this.shopName,
    required this.shopAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: AppCardStyles.sleekCard.copyWith(
        color: AppColors.surface,
        border: Border.all(color: AppColors.divider.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(IconsaxPlusLinear.shop, color: AppColors.primaryAccent, size: 20),
              const SizedBox(width: 8),
              Text('Delivered By', style: AppTextStyles.cardTitle.copyWith(fontSize: 16)),
            ],
          ),
          const Divider(height: 24),
          Text(
            shopName,
            style: AppTextStyles.cardTitle.copyWith(fontSize: 15, color: AppColors.primaryAccent),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(IconsaxPlusLinear.location, size: 16, color: AppColors.textTertiary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  shopAddress,
                  style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
