import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../cards/lab_test/lab_test_category_card.dart';
import '../../cards/lab_test/nearby_patho_lab_card.dart';
import '../../providers/lab_test_provider.dart';

class LabTestCategoryScreen extends ConsumerStatefulWidget {
  const LabTestCategoryScreen({super.key});

  @override
  ConsumerState<LabTestCategoryScreen> createState() =>
      _LabTestCategoryScreenState();
}

class _LabTestCategoryScreenState extends ConsumerState<LabTestCategoryScreen> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final labTestState = ref.watch(labTestProvider);

    // Filter categories based on search query
    final filteredCategories = labTestState.categories.where((category) {
      return category.name.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _isSearching
          ? _buildSearchAppBar()
          : CustomAppBar(
              title: 'Lab Tests',
              subtitle: 'Select a category to explore',
              showBackButton: false,
              actions: [
                IconButton(
                  onPressed: () => setState(() => _isSearching = true),
                  icon: const Icon(
                    IconsaxPlusLinear.search_normal_1,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          if (!_isSearching)
            // Premium Branding Card: Nearby Patho Labs
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.screenPadding),
                child: NearbyPathoLabCard(
                  onTap: () {
                    context.push('/patho-labs');
                  },
                ),
              ),
            ),

          // Categories Title
          if (!_isSearching)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screenPadding,
                  8,
                  AppSpacing.screenPadding,
                  16,
                ),
                child: Text(
                  'Test Categories',
                  style: AppTextStyles.subHeader.copyWith(fontSize: 18),
                ),
              ),
            ),

          // 3x3 Grid of Categories
          labTestState.isLoading
              ? const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
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
                      (context, index) {
                        final category = filteredCategories[index];
                        return LabTestCategoryCard(
                          category: category,
                          onTap: () {
                            context.push('/lab-tests/list', extra: category);
                          },
                        );
                      },
                      childCount: filteredCategories.length,
                    ),
                  ),
                ),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
    );
  }

  PreferredSizeWidget _buildSearchAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight + 10),
      child: AppBar(
        backgroundColor: Colors.transparent,
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
                    hintText: 'Search categories...',
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
                        _searchController.clear();
                        setState(() {
                          _searchQuery = '';
                          _isSearching = false;
                        });
                      },
                    ),
                  ),
                  onChanged: (value) {
                    setState(() => _searchQuery = value);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
