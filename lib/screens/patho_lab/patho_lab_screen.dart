import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../theme/app_theme.dart';
import '../../providers/patho_lab_provider.dart';
import '../../cards/patho_lab/patho_lab_card.dart';

class PathoLabScreen extends ConsumerStatefulWidget {
  const PathoLabScreen({super.key});

  @override
  ConsumerState<PathoLabScreen> createState() => _PathoLabScreenState();
}

class _PathoLabScreenState extends ConsumerState<PathoLabScreen> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final labState = ref.watch(pathoLabProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _isSearching ? _buildSearchAppBar() : _buildDefaultAppBar(),
      body: labState.labs.isEmpty
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
                    'No labs found',
                    style: AppTextStyles.cardTitle.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(top: 10, bottom: 100),
              itemCount: labState.labs.length,
              itemBuilder: (context, index) =>
                  PathoLabCard(lab: labState.labs[index]),
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
          Text(
            'Patho Labs',
            style: AppTextStyles.header.copyWith(fontSize: 20),
          ),
          Text('Find nearby diagnostic centers', style: AppTextStyles.caption),
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
                    hintText: 'Search pathology labs...',
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
                          ref.read(pathoLabProvider.notifier).searchLabs('');
                        });
                      },
                    ),
                  ),
                  onChanged: (v) =>
                      ref.read(pathoLabProvider.notifier).searchLabs(v),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
