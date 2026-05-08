import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_theme.dart';
import '../../providers/cart_provider.dart';
import '../../cards/cart/cart_item_card.dart';
import '../../cards/cart/delivery_details_card.dart';
import '../../cards/cart/bill_summary_card.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(IconsaxPlusLinear.arrow_left_2, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Your Cart', style: AppTextStyles.header.copyWith(fontSize: 20)),
            Text('${cart.items.length} Items added', style: AppTextStyles.caption),
          ],
        ),
      ),
      body: cart.items.isEmpty
          ? _buildEmptyState(context)
          : Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 120),
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      
                      // Items List
                      ...cart.items.map((item) => CartItemCard(
                        item: item,
                        onQuantityChanged: (qty) => cartNotifier.updateQuantity(item.medicine.id, qty),
                        onRemove: () => cartNotifier.removeFromCart(item.medicine.id),
                      )),
                      
                      const SizedBox(height: 16),
                      
                      // Delivery Details
                      DeliveryDetailsCard(
                        initialName: cart.receiverName,
                        initialPhone: cart.phone,
                        initialAddress: cart.address,
                        onDetailsChanged: (name, phone, latLng) {
                          cartNotifier.updateDeliveryDetails(
                            name: name,
                            phone: phone,
                            latitude: latLng?.latitude,
                            longitude: latLng?.longitude,
                            address: latLng != null 
                              ? "Lat: ${latLng.latitude.toStringAsFixed(4)}, Long: ${latLng.longitude.toStringAsFixed(4)}"
                              : null,
                          );
                        },
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Bill Summary
                      BillSummaryCard(cart: cart),
                    ],
                  ),
                ),
                
                // Proceed Button
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(AppSpacing.screenPadding),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(10),
                          blurRadius: 20,
                          offset: const Offset(0, -10),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Implement Payment
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing payment...')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryAccent,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'PROCEED WITH PAYMENT',
                            style: AppTextStyles.tagline.copyWith(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Icon(IconsaxPlusLinear.arrow_right_3, color: Colors.white, size: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(10),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              IconsaxPlusLinear.shopping_cart,
              size: 64,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Your cart is empty',
            style: AppTextStyles.header.copyWith(fontSize: 22),
          ),
          const SizedBox(height: 8),
          Text(
            'Browse our catalog to find your medicines',
            style: AppTextStyles.caption,
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => context.pop(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            child: Text(
              'BROWSE NOW',
              style: AppTextStyles.tagline.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
