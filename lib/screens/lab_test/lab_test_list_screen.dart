import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_bar.dart';
import '../../cards/lab_test/lab_test_card.dart';
import '../../models/lab_test.dart';
import '../../providers/lab_test_provider.dart';

class LabTestListScreen extends ConsumerWidget {
  final LabTestCategory category;

  const LabTestListScreen({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final labTestState = ref.watch(labTestProvider);
    
    // Filter tests by category
    final categoryTests = labTestState.tests.where((test) => test.categoryId == category.id).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: category.name,
        subtitle: 'Find the best tests for you',
        showBackButton: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(IconsaxPlusLinear.search_normal_1, color: AppColors.textPrimary),
          ),
        ],
      ),
      body: categoryTests.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(IconsaxPlusLinear.search_status, size: 64, color: AppColors.textTertiary.withAlpha(100)),
                  const SizedBox(height: 16),
                  Text(
                    'No tests found in this category',
                    style: AppTextStyles.cardTitle.copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.screenPadding),
              itemCount: categoryTests.length,
              itemBuilder: (context, index) {
                final test = categoryTests[index];
                return LabTestCard(
                  test: test,
                  onBookNow: () {
                    // Logic for booking
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Booking ${test.name}...')),
                    );
                  },
                );
              },
            ),
    );
  }
}
