import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../theme/app_theme.dart';

class MedicineDescriptionCard extends StatelessWidget {
  final String description;

  const MedicineDescriptionCard({super.key, required this.description});

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
              const Icon(IconsaxPlusLinear.document_text, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text('Description', style: AppTextStyles.cardTitle.copyWith(fontSize: 16)),
            ],
          ),
          const Divider(height: 24),
          Text(
            description,
            style: AppTextStyles.description.copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }
}
