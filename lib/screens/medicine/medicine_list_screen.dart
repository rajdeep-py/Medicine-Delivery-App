import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../providers/cart_provider.dart';
import '../../theme/app_theme.dart';
import '../../models/medicine.dart';
import '../../notifiers/medicine_notifier.dart';
import '../../cards/medicine/medicine_card.dart';

class MedicineListScreen extends ConsumerStatefulWidget {
  final MedicineCategory category;

  const MedicineListScreen({super.key, required this.category});

  @override
  ConsumerState<MedicineListScreen> createState() => _MedicineListScreenState();
}

class _MedicineListScreenState extends ConsumerState<MedicineListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final medState = ref.watch(medicineProvider);

    // Filter medicines by category (Mock logic)
    final filteredMedicines = medState.medicines
        .where((m) => m.categoryId == widget.category.id)
        .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildDefaultAppBar(),
      body: Stack(
        children: [
          filteredMedicines.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        IconsaxPlusLinear.box,
                        size: 64,
                        color: AppColors.textTertiary.withAlpha(100),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No medicines found in this category',
                        style: AppTextStyles.cardTitle.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.only(top: 12, bottom: 100),
                  itemCount: filteredMedicines.length,
                  itemBuilder: (context, index) => MedicineCard(
                    medicine: filteredMedicines[index],
                    onAddToCart: () {
                      final medicine = filteredMedicines[index];
                      ref.read(cartProvider.notifier).addToCart(medicine);
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
                ),

          // Floating Action Button: Order with Prescription
          Positioned(
            bottom: 30,
            right: AppSpacing.screenPadding,
            child: InkWell(
              onTap: () => context.push('/medicine/order-prescription'),
              borderRadius: BorderRadius.circular(30),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withAlpha(80),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      IconsaxPlusLinear.document_text,
                      color: Colors.white,
                      size: 22,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Order with Prescription',
                      style: AppTextStyles.cardTitle.copyWith(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Floating Cart Icon
          if (ref.watch(cartProvider).items.isNotEmpty)
            Positioned(
              bottom: 100,
              right: AppSpacing.screenPadding,
              child: FloatingActionButton(
                onPressed: () => context.push('/cart'),
                backgroundColor: AppColors.primary,
                child: Badge(
                  label: Text('${ref.watch(cartProvider).items.length}'),
                  child: const Icon(
                    IconsaxPlusLinear.shopping_cart,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildDefaultAppBar() {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          IconsaxPlusLinear.arrow_left_2,
          color: AppColors.textPrimary,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.category.name,
            style: AppTextStyles.header.copyWith(fontSize: 20),
          ),
          Text('Browse available medicines', style: AppTextStyles.caption),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(
            IconsaxPlusLinear.search_normal_1,
            color: AppColors.textPrimary,
          ),
          onPressed: () => context.push('/medicine/search'),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
