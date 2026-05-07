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
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                style: AppTextStyles.cardTitle.copyWith(fontSize: 16),
                decoration: const InputDecoration(
                  hintText: 'Search pathology labs...',
                  border: InputBorder.none,
                ),
                onChanged: (v) =>
                    ref.read(pathoLabProvider.notifier).searchLabs(v),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Patho Labs',
                    style: AppTextStyles.header.copyWith(fontSize: 20),
                  ),
                  Text(
                    'Find nearby diagnostic centers',
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
        actions: [
          IconButton(
            icon: Icon(
              _isSearching
                  ? IconsaxPlusLinear.close_circle
                  : IconsaxPlusLinear.search_normal_1,
              color: AppColors.textPrimary,
            ),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                  ref.read(pathoLabProvider.notifier).searchLabs('');
                }
              });
            },
          ),
        ],
      ),
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
}
