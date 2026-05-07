import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../cards/lab_test/lab_test_category_card.dart';
import '../../providers/lab_test_provider.dart';

class LabTestCategoryScreen extends ConsumerStatefulWidget {
  const LabTestCategoryScreen({super.key});

  @override
  ConsumerState<LabTestCategoryScreen> createState() => _LabTestCategoryScreenState();
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
                  icon: const Icon(IconsaxPlusLinear.search_normal_1, color: AppColors.textPrimary),
                ),
              ],
            ),
      body: Column(
        children: [
          if (!_isSearching)
            // Premium Button: Browse nearby patho labs
            Padding(
              padding: const EdgeInsets.all(AppSpacing.screenPadding),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: AppCardStyles.primaryGradientCard,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(40),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          IconsaxPlusBold.location,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nearby Patho Labs',
                              style: AppTextStyles.cardTitle.copyWith(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'Find certified laboratories near you',
                              style: AppTextStyles.caption.copyWith(
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        IconsaxPlusLinear.arrow_right_3,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // 3x3 Grid of Categories
          Expanded(
            child: labTestState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenPadding,
                      vertical: 8,
                    ),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: filteredCategories.length,
                    itemBuilder: (context, index) {
                      final category = filteredCategories[index];
                      return LabTestCategoryCard(
                        category: category,
                        onTap: () {},
                      );
                    },
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
              margin: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
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
