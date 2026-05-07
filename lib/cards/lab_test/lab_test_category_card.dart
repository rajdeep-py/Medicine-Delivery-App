import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/lab_test.dart';

class LabTestCategoryCard extends StatelessWidget {
  final LabTestCategory category;
  final VoidCallback onTap;

  const LabTestCategoryCard({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: AppCardStyles.sleekCard.copyWith(color: AppColors.surface),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon with background
            Container(
              padding: const EdgeInsets.all(8),

              child: Icon(
                category.icon,
                color: AppColors.primaryAccent,
                size: 40,
              ),
            ),
            const SizedBox(height: 8),
            // Category Name
            Text(
              category.name,
              style: AppTextStyles.cardTitle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
