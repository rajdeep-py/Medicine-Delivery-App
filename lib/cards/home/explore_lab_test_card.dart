import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../theme/app_theme.dart';
import '../../models/lab_test.dart';

class ExploreLabTestCard extends StatelessWidget {
  final List<LabTest> labTests;
  final Function(LabTest) onAddToCart;

  const ExploreLabTestCard({
    super.key,
    required this.labTests,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
          child: Text('Popular Lab Tests', style: AppTextStyles.subHeader.copyWith(fontSize: 18)),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding - 8),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: labTests.length,
            itemBuilder: (context, index) {
              final test = labTests[index];
              return Container(
                width: 200,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.all(12),
                decoration: AppCardStyles.sleekCard,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            'https://img.freepik.com/free-photo/doctor-working-with-microscope_23-2148816223.jpg',
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                test.name,
                                style: AppTextStyles.cardTitle.copyWith(fontSize: 14),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Naiyo24 Labs',
                                style: AppTextStyles.caption.copyWith(fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Includes ${test.parameters.length} parameters',
                      style: AppTextStyles.caption.copyWith(color: AppColors.primary),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₹${test.price.toInt()}',
                          style: AppTextStyles.header.copyWith(
                            fontSize: 18,
                            color: AppColors.primaryAccent,
                          ),
                        ),
                        InkWell(
                          onTap: () => onAddToCart(test),
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.primaryAccent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(IconsaxPlusLinear.add, color: Colors.white, size: 20),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
