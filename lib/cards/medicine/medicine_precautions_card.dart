import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../theme/app_theme.dart';

class MedicinePrecautionsCard extends StatelessWidget {
  final List<String> precautions;

  const MedicinePrecautionsCard({super.key, required this.precautions});

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
              const Icon(IconsaxPlusLinear.shield_tick, color: AppColors.error, size: 20),
              const SizedBox(width: 8),
              Text('Precautions', style: AppTextStyles.cardTitle.copyWith(fontSize: 16)),
            ],
          ),
          const Divider(height: 24),
          ...precautions.map((p) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: Icon(Icons.circle, size: 6, color: AppColors.error),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    p,
                    style: AppTextStyles.description.copyWith(color: AppColors.textSecondary),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
