import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../theme/app_theme.dart';

class MedicineCompositionCard extends StatelessWidget {
  final String composition;
  final String quantity;

  const MedicineCompositionCard({
    super.key,
    required this.composition,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPadding,
        vertical: 8,
      ),
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
              const Icon(
                IconsaxPlusLinear.activity,
                color: AppColors.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Composition & Quantity',
                style: AppTextStyles.cardTitle.copyWith(fontSize: 16),
              ),
            ],
          ),
          const Divider(height: 24),
          Text(
            'Composition:',
            style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(composition, style: AppTextStyles.description),
          const SizedBox(height: 12),
          Text(
            'Quantity:',
            style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(quantity, style: AppTextStyles.description),
        ],
      ),
    );
  }
}
