import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../theme/app_theme.dart';

class TestBookingPriceCard extends StatefulWidget {
  final double testAmount;
  final double platformCharges;
  final double collectionCharges;

  const TestBookingPriceCard({
    super.key,
    required this.testAmount,
    required this.platformCharges,
    required this.collectionCharges,
  });

  @override
  State<TestBookingPriceCard> createState() => _TestBookingPriceCardState();
}

class _TestBookingPriceCardState extends State<TestBookingPriceCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final total =
        widget.testAmount + widget.platformCharges + widget.collectionCharges;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppCardStyles.sleekCard.copyWith(
        color: AppColors.surface,
        border: Border.all(color: AppColors.divider.withAlpha(80)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Total Amount Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Payable',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '₹${total.toInt()}',
                    style: AppTextStyles.header.copyWith(
                      color: AppColors.success,
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              // View Breakdown Toggle
              InkWell(
                onTap: () => setState(() => _isExpanded = !_isExpanded),
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryAccent.withAlpha(20),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Text(
                        _isExpanded ? 'Hide Details' : 'View Breakdown',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.primaryAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 4),
                      AnimatedRotation(
                        turns: _isExpanded ? 0.5 : 0,
                        duration: const Duration(milliseconds: 300),
                        child: const Icon(
                          IconsaxPlusLinear.arrow_down_1,
                          size: 14,
                          color: AppColors.primaryAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Animated Breakdown Section
          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity),
            secondChild: Column(
              children: [
                const SizedBox(height: 20),
                Divider(color: AppColors.divider.withAlpha(80)),
                const SizedBox(height: 16),
                _PriceRow(label: 'Test Amount', value: widget.testAmount),
                const SizedBox(height: 12),
                _PriceRow(
                  label: 'Platform Charges',
                  value: widget.platformCharges,
                ),
                const SizedBox(height: 12),
                _PriceRow(
                  label: 'Collection & Delivery',
                  value: widget.collectionCharges,
                  isLast: true,
                ),
              ],
            ),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
            sizeCurve: Curves.easeInOut,
          ),
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final double value;
  final bool isLast;

  const _PriceRow({
    required this.label,
    required this.value,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: AppColors.divider.withAlpha(150),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondary,
                fontSize: 13,
              ),
            ),
          ],
        ),
        Text(
          '₹${value.toInt()}',
          style: AppTextStyles.cardTitle.copyWith(
            fontSize: 14,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
