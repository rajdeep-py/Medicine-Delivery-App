import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../theme/app_theme.dart';
import '../../models/cart.dart';

class BillSummaryCard extends StatefulWidget {
  final Cart cart;

  const BillSummaryCard({super.key, required this.cart});

  @override
  State<BillSummaryCard> createState() => _BillSummaryCardState();
}

class _BillSummaryCardState extends State<BillSummaryCard> {
  bool _showBreakdown = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: AppCardStyles.sleekCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(IconsaxPlusLinear.receipt_2, color: AppColors.primary, size: 20),
                  const SizedBox(width: 8),
                  Text('Bill Summary', style: AppTextStyles.cardTitle.copyWith(fontSize: 16)),
                ],
              ),
              TextButton(
                onPressed: () => setState(() => _showBreakdown = !_showBreakdown),
                child: Text(
                  _showBreakdown ? 'Hide Breakdown' : 'View Breakdown',
                  style: const TextStyle(fontSize: 12, color: AppColors.primaryAccent),
                ),
              ),
            ],
          ),
          const Divider(height: 12),
          
          if (_showBreakdown) ...[
            _buildRow('Item Total', '₹${widget.cart.subTotal.toInt()}'),
            _buildRow('Delivery Fee', '₹${widget.cart.deliveryFee.toInt()}'),
            _buildRow('Tax & Charges (5%)', '₹${widget.cart.tax.toInt()}'),
            const Divider(height: 24),
          ],
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount',
                style: AppTextStyles.cardTitle.copyWith(fontSize: 16),
              ),
              Text(
                '₹${widget.cart.total.toInt()}',
                style: AppTextStyles.header.copyWith(
                  fontSize: 20,
                  color: AppColors.primaryAccent,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(20),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(IconsaxPlusLinear.info_circle, size: 14, color: AppColors.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Safe and secure payments processed via encrypted gateway.',
                    style: AppTextStyles.caption.copyWith(fontSize: 10, color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
          Text(value, style: AppTextStyles.description.copyWith(fontSize: 14, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
