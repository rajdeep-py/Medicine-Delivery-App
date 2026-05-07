import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../theme/app_theme.dart';
import '../../notifiers/medicine_notifier.dart';
import '../../cards/medicine/medicine_category_card.dart';

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
              child: Container(
                decoration: AppCardStyles.sleekCard.copyWith(
                  color: AppColors.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(5),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryAccent.withAlpha(
                                        20,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      'QUICK SERVICE',
                                      style: AppTextStyles.tagline.copyWith(
                                        fontSize: 10,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    'Order with\nPrescription',
                                    style: AppTextStyles.header.copyWith(
                                      fontSize: 22,
                                      height: 1.1,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Upload and get medicines delivered in minutes',
                                    style: AppTextStyles.caption.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  InkWell(
                                    onTap: () {},
                                    borderRadius: BorderRadius.circular(12),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryAccent,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.primaryAccent
                                                .withAlpha(60),
                                            blurRadius: 12,
                                            offset: const Offset(0, 6),
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        'ORDER NOW',
                                        style: AppTextStyles.tagline.copyWith(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Image.asset(
                                'assets/logo/order_with_prescription.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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
