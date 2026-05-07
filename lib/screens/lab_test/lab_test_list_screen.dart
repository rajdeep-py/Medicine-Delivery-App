import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_bar.dart';
import '../../cards/lab_test/lab_test_card.dart';
import '../../models/lab_test.dart';
import '../../providers/lab_test_provider.dart';

class LabTestListScreen extends ConsumerStatefulWidget {
  final LabTestCategory category;

  const LabTestListScreen({
    super.key,
    required this.category,
  });

  @override
  ConsumerState<LabTestListScreen> createState() => _LabTestListScreenState();
}

class _LabTestListScreenState extends ConsumerState<LabTestListScreen> {
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
    
    // Filter tests by category and search query
    final filteredTests = labTestState.tests.where((test) {
      final matchesCategory = test.categoryId == widget.category.id;
      final matchesSearch = test.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                          test.pathoLabName.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _isSearching
          ? _buildSearchAppBar()
          : CustomAppBar(
              title: widget.category.name,
              subtitle: 'Find the best tests for you',
              showBackButton: true,
              actions: [
                IconButton(
                  onPressed: () => setState(() => _isSearching = true),
                  icon: const Icon(IconsaxPlusLinear.search_normal_1, color: AppColors.textPrimary),
                ),
              ],
            ),
      body: filteredTests.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _searchQuery.isEmpty ? IconsaxPlusLinear.search_status : IconsaxPlusLinear.search_status_1,
                    size: 64,
                    color: AppColors.textTertiary.withAlpha(100),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _searchQuery.isEmpty 
                      ? 'No tests found in this category'
                      : 'No results found for "$_searchQuery"',
                    style: AppTextStyles.cardTitle.copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.screenPadding),
              itemCount: filteredTests.length,
              itemBuilder: (context, index) {
                final test = filteredTests[index];
                return LabTestCard(
                  test: test,
                );
              },
            ),
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
                    hintText: 'Search for tests or labs...',
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
