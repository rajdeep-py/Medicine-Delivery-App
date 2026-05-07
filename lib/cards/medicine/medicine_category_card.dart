import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_theme.dart';
import '../../models/medicine.dart';

class MedicineCategoryCard extends StatelessWidget {
  final MedicineCategory category;

  const MedicineCategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/medicine/list', extra: category),
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Main Card Container
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            decoration: AppCardStyles.sleekCard.copyWith(
              color: AppColors.surface,
              border: Border.all(color: AppColors.divider.withAlpha(50)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon
                Container(
                  padding: const EdgeInsets.all(10),

                  child: Icon(
                    category.icon,
                    color: AppColors.primaryAccent,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 12),
                // Category Name
                Text(
                  category.name,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Floating Tag (Popular/Top)
          if (category.isPopular || category.isMostOrdered)
            Positioned(
              top: 6,
              right: 30,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: category.isPopular
                      ? AppColors.primaryAccent
                      : AppColors.success,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color:
                          (category.isPopular
                                  ? AppColors.primaryAccent
                                  : AppColors.success)
                              .withAlpha(50),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  category.isPopular ? 'POPULAR' : 'UPTO 30% OFF',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 7,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
