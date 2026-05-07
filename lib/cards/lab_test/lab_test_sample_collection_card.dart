import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../theme/app_theme.dart';

class LabTestSampleCollectionCard extends StatelessWidget {
  const LabTestSampleCollectionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = [
      {'title': 'Booking Confirmed', 'desc': 'Select your preferred time slot', 'icon': IconsaxPlusLinear.calendar_tick},
      {'title': 'Phlebotomist Assignment', 'desc': 'Certified professional assigned', 'icon': IconsaxPlusLinear.user_tag},
      {'title': 'Sample Collection', 'desc': 'At your doorstep at selected time', 'icon': IconsaxPlusLinear.house},
      {'title': 'Lab Processing', 'desc': 'Samples tested in NABL certified lab', 'icon': IconsaxPlusLinear.microscope},
      {'title': 'Report Delivery', 'desc': 'Digital report in 12-24 hours', 'icon': IconsaxPlusLinear.document_text},
    ];

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
      padding: const EdgeInsets.all(20),
      decoration: AppCardStyles.sleekCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Process Flow', style: AppTextStyles.cardTitle.copyWith(fontSize: 18)),
          const SizedBox(height: 24),
          ...List.generate(steps.length, (index) {
            final step = steps[index];
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withAlpha(20),
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primary.withAlpha(50)),
                      ),
                      child: Icon(step['icon'] as IconData, size: 18, color: AppColors.primaryAccent),
                    ),
                    if (index != steps.length - 1)
                      Container(
                        width: 2,
                        height: 30,
                        color: AppColors.primary.withAlpha(50),
                      ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(
                        step['title'] as String,
                        style: AppTextStyles.cardTitle.copyWith(fontSize: 14),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        step['desc'] as String,
                        style: AppTextStyles.caption.copyWith(fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
