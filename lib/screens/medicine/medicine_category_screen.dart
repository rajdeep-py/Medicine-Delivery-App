import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  bool _isSearching = false;
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
      appBar: _isSearching ? _buildSearchAppBar() : _buildDefaultAppBar(),
      body: medState.categories.isEmpty
          ? Center(
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
            )
          : GridView.builder(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenPadding,
                12,
                AppSpacing.screenPadding,
                100,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.85,
              ),
              itemCount: medState.categories.length,
              itemBuilder: (context, index) =>
                  MedicineCategoryCard(category: medState.categories[index]),
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
          onPressed: () => setState(() => _isSearching = true),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  PreferredSizeWidget _buildSearchAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight + 10),
      child: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Center(
            child: Container(
              height: 50,
              margin: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPadding,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.divider.withAlpha(128)),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF000000).withAlpha(10),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: TextField(
                  controller: _searchController,
                  autofocus: true,
                  textAlignVertical: TextAlignVertical.center,
                  style: AppTextStyles.cardTitle.copyWith(fontSize: 16),
                  decoration: InputDecoration(
                    hintText: 'Search medicine categories...',
                    isDense: true,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    icon: const Icon(
                      IconsaxPlusLinear.search_normal_1,
                      color: AppColors.primaryAccent,
                      size: 20,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        IconsaxPlusLinear.close_circle,
                        color: AppColors.textTertiary,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _isSearching = false;
                          _searchController.clear();
                          ref
                              .read(medicineProvider.notifier)
                              .searchCategories('');
                        });
                      },
                    ),
                  ),
                  onChanged: (v) =>
                      ref.read(medicineProvider.notifier).searchCategories(v),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
