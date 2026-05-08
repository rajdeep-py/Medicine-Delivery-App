import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../cards/medicine/order_medicine_with_prescription_card.dart';
import '../../notifiers/medicine_notifier.dart';
import '../../theme/app_theme.dart';
import '../../providers/lab_test_provider.dart';
import '../../providers/cart_provider.dart';
import '../../cards/home/home_app_bar.dart';
import '../../cards/home/explore_medicine_category_card.dart';
import '../../cards/home/explore_lab_test_category_card.dart';
import '../../cards/lab_test/nearby_patho_lab_card.dart';
import '../../cards/home/explore_lab_test_card.dart';
import '../../cards/home/explore_medicine_card.dart';
import '../../cards/home/footer_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medState = ref.watch(medicineProvider);
    final labState = ref.watch(labTestProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // Modern App Bar with Search
            const HomeAppBar(),

            const SizedBox(height: 24),

            // Medicine Categories
            ExploreMedicineCategoryCard(categories: medState.categories),

            const SizedBox(height: 24),

            // Lab Test Categories
            ExploreLabTestCategoryCard(categories: labState.categories),

            const SizedBox(height: 32),

            // Nearby Patho Labs Branding
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPadding,
              ),
              child: NearbyPathoLabCard(
                onTap: () => context.push('/patho-labs'),
              ),
            ),

            const SizedBox(height: 32),

            // Popular Lab Tests Carousel
            ExploreLabTestCard(
              labTests: labState.tests.take(5).toList(),
              onAddToCart: (test) {
                // Since lab tests aren't in the medicine cart yet, we'll show a snackbar
                // In a real app, you'd have a unified cart or separate ones.
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${test.name} added to lab basket')),
                );
              },
            ),

            const SizedBox(height: 32),

            // Order with Prescription Branding
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPadding,
              ),
              child: OrderMedicineWithPrescriptionCard(
                onTap: () => context.push('/medicine/order-prescription'),
              ),
            ),

            const SizedBox(height: 32),

            // Best Seller Medicines Carousel
            ExploreMedicineCard(
              medicines: medState.medicines.take(5).toList(),
              onAddToCart: (medicine) {
                cartNotifier.addToCart(medicine);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${medicine.name} added to cart'),
                    action: SnackBarAction(
                      label: 'VIEW CART',
                      onPressed: () => context.push('/cart'),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 48),

            // Professional Footer
            const FooterCard(),
          ],
        ),
      ),
    );
  }
}
