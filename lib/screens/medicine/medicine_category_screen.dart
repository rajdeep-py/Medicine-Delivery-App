import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../theme/app_theme.dart';
import '../../notifiers/medicine_notifier.dart';
import '../../cards/medicine/medicine_category_card.dart';
import '../../cards/medicine/order_medicine_with_prescription_card.dart';

class MedicineCategoryScreen extends ConsumerStatefulWidget {
  const MedicineCategoryScreen({super.key});

  @override
  ConsumerState<MedicineCategoryScreen> createState() =>
      _MedicineCategoryScreenState();
}

class _MedicineCategoryScreenState
    extends ConsumerState<MedicineCategoryScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final medState = ref.watch(medicineProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildDefaultAppBar(),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Branding Card: Order with Prescription
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenPadding,
                16,
                AppSpacing.screenPadding,
                8,
              ),
              child: OrderMedicineWithPrescriptionCard(
                onTap: () {
                  // TODO: Navigate to prescription flow
                },
              ),
            ),
          ),

          // Categories Title
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenPadding,
                24,
                AppSpacing.screenPadding,
                16,
              ),
              child: Text(
                'Top Categories',
                style: AppTextStyles.subHeader.copyWith(fontSize: 18),
              ),
            ),
          ),

          // Categories Grid
          medState.categories.isEmpty
              ? SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          IconsaxPlusLinear.search_status,
                          size: 64,
                          color: AppColors.textTertiary.withAlpha(100),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No categories found',
                          style: AppTextStyles.cardTitle.copyWith(
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenPadding,
                    0,
                    AppSpacing.screenPadding,
                    100,
                  ),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.85,
                        ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => MedicineCategoryCard(
                        category: medState.categories[index],
                      ),
                      childCount: medState.categories.length,
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
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Medicines', style: AppTextStyles.header.copyWith(fontSize: 20)),
          Text(
            'Order from your nearest pharmacies',
            style: AppTextStyles.caption,
          ),
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
