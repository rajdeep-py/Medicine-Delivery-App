import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_theme.dart';
import '../../models/patho_lab.dart';

class PathoLabCard extends StatelessWidget {
  final PathoLab lab;

  const PathoLabCard({super.key, required this.lab});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/patho-labs/details', extra: lab),
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenPadding,
          vertical: 10,
        ),
        decoration: AppCardStyles.sleekCard.copyWith(color: AppColors.surface),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Lab Image with Rating Badge
              Stack(
                children: [
                  Image.network(
                    lab.imageUrl,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 180,
                      alignment: Alignment.center,
                      color: AppColors.blush,
                      child: const Icon(
                        IconsaxPlusLinear.image,
                        color: AppColors.textTertiary,
                        size: 180,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(20),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: Colors.amber,
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            lab.rating.toString(),
                            style: AppTextStyles.cardTitle.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Lab Details
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lab.name,
                      style: AppTextStyles.cardTitle.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          IconsaxPlusLinear.location,
                          size: 16,
                          color: AppColors.primaryAccent,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            lab.address,
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textSecondary,
                              height: 1.4,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(
                          IconsaxPlusLinear.message_text,
                          size: 16,
                          color: AppColors.textTertiary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${lab.reviewsCount} Reviews',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textTertiary,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'View Details',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.primaryAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Icon(
                          IconsaxPlusLinear.arrow_right_3,
                          size: 14,
                          color: AppColors.primaryAccent,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
