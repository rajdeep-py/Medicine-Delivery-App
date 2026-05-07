import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../theme/app_theme.dart';
import '../../notifiers/medicine_notifier.dart';
import '../../cards/medicine/search_medicine_card.dart';

class SearchMedicineScreen extends ConsumerStatefulWidget {
  const SearchMedicineScreen({super.key});

  @override
  ConsumerState<SearchMedicineScreen> createState() =>
      _SearchMedicineScreenState();
}

class _SearchMedicineScreenState extends ConsumerState<SearchMedicineScreen> {
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
      backgroundColor: AppColors.surface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(88),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(5),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPadding,
              ),
              child: Row(
                children: [
                  // Sleek Back Button
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        IconsaxPlusLinear.arrow_left_2,
                        color: AppColors.textPrimary,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Premium Search Bar
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.divider.withAlpha(50),
                        ),
                      ),
                      child: TextField(
                        controller: _searchController,
                        autofocus: true,
                        textAlignVertical: TextAlignVertical.center,
                        style: AppTextStyles.cardTitle.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search for medicines...',
                          hintStyle: AppTextStyles.caption.copyWith(
                            color: AppColors.textTertiary,
                          ),
                          prefixIcon: const Icon(
                            IconsaxPlusLinear.search_normal_1,
                            color: AppColors.primaryAccent,
                            size: 18,
                          ),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(
                                    IconsaxPlusLinear.close_circle,
                                    size: 18,
                                    color: AppColors.textTertiary,
                                  ),
                                  onPressed: () {
                                    _searchController.clear();
                                    ref
                                        .read(medicineProvider.notifier)
                                        .searchAllMedicines('');
                                    setState(() {});
                                  },
                                )
                              : null,
                          isDense: true,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                        ),
                        onChanged: (v) {
                          setState(() {});
                          ref
                              .read(medicineProvider.notifier)
                              .searchAllMedicines(v);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: medState.medicines.isEmpty && _searchController.text.isNotEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    IconsaxPlusLinear.search_status,
                    size: 80,
                    color: AppColors.textTertiary.withAlpha(50),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'No results found',
                    style: AppTextStyles.cardTitle.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Try checking your spelling or search another term',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(top: 16, bottom: 40),
              physics: const BouncingScrollPhysics(),
              itemCount: medState.medicines.length,
              itemBuilder: (context, index) => SearchMedicineCard(
                medicine: medState.medicines[index],
                onAddToCart: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${medState.medicines[index].name} added to cart',
                      ),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: AppColors.primaryAccent,
                    ),
                  );
                },
              ),
            ),
    );
  }
}
