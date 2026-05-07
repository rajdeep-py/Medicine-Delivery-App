import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_theme.dart';
import '../../models/medicine.dart';

class SearchMedicineCard extends StatelessWidget {
  final Medicine medicine;
  final VoidCallback onAddToCart;

  const SearchMedicineCard({
    super.key,
    required this.medicine,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/medicine/details', extra: medicine),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: AppCardStyles.sleekCard.copyWith(
          color: AppColors.surface,
          border: Border.all(color: AppColors.divider.withAlpha(50)),
        ),
        child: Row(
          children: [
            // Medicine Image with subtle shadow
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(5),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  medicine.images.first,
                  height: 64,
                  width: 64,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 64,
                    width: 64,
                    color: AppColors.blush,
                    child: const Icon(IconsaxPlusLinear.box, color: AppColors.textTertiary, size: 24),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            
            // Info section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    medicine.name,
                    style: AppTextStyles.cardTitle.copyWith(fontSize: 15, fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    medicine.manufacturer,
                    style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary, fontSize: 11),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '₹${medicine.price.toInt()}',
                    style: AppTextStyles.header.copyWith(
                      color: AppColors.primaryAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            
            // Add Button - Sleek and compact
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onAddToCart,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryAccent.withAlpha(20),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.primaryAccent.withAlpha(40)),
                  ),
                  child: Text(
                    'ADD',
                    style: AppTextStyles.tagline.copyWith(
                      color: AppColors.primaryAccent,
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
