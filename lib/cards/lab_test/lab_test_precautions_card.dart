import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../theme/app_theme.dart';

class LabTestPrecautionsCard extends StatelessWidget {
  final List<String> precautions;

  const LabTestPrecautionsCard({super.key, required this.precautions});

  @override
  Widget build(BuildContext context) {
    if (precautions.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(AppSpacing.screenPadding),
      padding: const EdgeInsets.all(20),
      decoration: AppCardStyles.sleekCard.copyWith(
        color: AppColors.errorLight.withAlpha(50),
        border: Border.all(color: AppColors.error.withAlpha(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(IconsaxPlusBold.info_circle, color: AppColors.error, size: 20),
              const SizedBox(width: 10),
              Text(
                'Pre-test Precautions',
                style: AppTextStyles.cardTitle.copyWith(fontSize: 16, color: AppColors.error),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...precautions.map((precaution) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Icon(Icons.circle, size: 4, color: AppColors.error),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        precaution,
                        style: AppTextStyles.caption.copyWith(color: AppColors.textPrimary, height: 1.4),
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
