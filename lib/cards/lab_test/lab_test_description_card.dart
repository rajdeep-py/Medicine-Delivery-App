import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../theme/app_theme.dart';
import '../../models/lab_test.dart';

class LabTestDescriptionCard extends StatefulWidget {
  final LabTest test;

  const LabTestDescriptionCard({super.key, required this.test});

  @override
  State<LabTestDescriptionCard> createState() => _LabTestDescriptionCardState();
}

class _LabTestDescriptionCardState extends State<LabTestDescriptionCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
      padding: const EdgeInsets.all(20),
      decoration: AppCardStyles.sleekCard.copyWith(
        color: AppColors.surface,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Icon
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withAlpha(20),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(IconsaxPlusLinear.document_text, color: AppColors.primaryAccent, size: 18),
              ),
              const SizedBox(width: 12),
              Text(
                'Test Description',
                style: AppTextStyles.cardTitle.copyWith(
                  fontSize: 16, 
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Description Text
          Text(
            widget.test.description,
            style: AppTextStyles.caption.copyWith(
              height: 1.6,
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 24),
          
          // Expandable Parameters Section Header
          InkWell(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.divider.withAlpha(100)),
              ),
              child: Row(
                children: [
                  const Icon(IconsaxPlusLinear.setting_4, color: AppColors.primaryAccent, size: 18),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Parameters Included (${widget.test.parameters.length})',
                      style: AppTextStyles.cardTitle.copyWith(fontSize: 14),
                    ),
                  ),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: const Icon(IconsaxPlusLinear.arrow_down_1, color: AppColors.textSecondary, size: 18),
                  ),
                ],
              ),
            ),
          ),
          
          // Animated List of Parameters
          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity),
            secondChild: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Column(
                children: widget.test.parameters.map((param) => Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.divider.withAlpha(100)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(5),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Modern dot indicator
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              param.name,
                              style: AppTextStyles.cardTitle.copyWith(
                                fontSize: 13, 
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              param.value,
                              style: AppTextStyles.caption.copyWith(
                                fontSize: 11, 
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ),
            ),
            crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
            sizeCurve: Curves.easeInOut,
          ),
        ],
      ),
    );
  }
}
