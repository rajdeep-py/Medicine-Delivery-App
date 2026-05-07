import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../theme/app_theme.dart';
import '../../models/lab_test.dart';
import '../../providers/lab_test_provider.dart';
import '../../cards/lab_test/lab_test_description_card.dart';
import '../../cards/lab_test/lab_test_precautions_card.dart';
import '../../cards/lab_test/lab_test_sample_collection_card.dart';

class LabTestDetailsScreen extends ConsumerStatefulWidget {
  final LabTest test;

  const LabTestDetailsScreen({super.key, required this.test});

  @override
  ConsumerState<LabTestDetailsScreen> createState() =>
      _LabTestDetailsScreenState();
}

class _LabTestDetailsScreenState extends ConsumerState<LabTestDetailsScreen> {
  late ScrollController _scrollController;
  bool _showTitle = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset > 200 && !_showTitle) {
        setState(() => _showTitle = true);
      } else if (_scrollController.offset <= 200 && _showTitle) {
        setState(() => _showTitle = false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final labTestState = ref.watch(labTestProvider);
    final category = labTestState.categories.firstWhere(
      (c) => c.id == widget.test.categoryId,
      orElse: () =>
          LabTestCategory(id: '', name: 'General', icon: Icons.science),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Modern Collapsing App Bar
              SliverAppBar(
                expandedHeight: 320,
                pinned: true,
                elevation: 0,
                backgroundColor: AppColors.surface,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: _showTitle
                        ? Colors.transparent
                        : Colors.black.withAlpha(50),
                    child: IconButton(
                      icon: Icon(
                        IconsaxPlusLinear.arrow_left_2,
                        color: _showTitle
                            ? AppColors.textPrimary
                            : Colors.white,
                        size: 20,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                title: AnimatedOpacity(
                  opacity: _showTitle ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: Text(
                    widget.test.name,
                    style: AppTextStyles.cardTitle.copyWith(fontSize: 18),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Test Image
                      Image.network(
                        widget.test.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: AppColors.blush,
                          child: const Center(
                            child: Icon(
                              IconsaxPlusLinear.image,
                              color: AppColors.textTertiary,
                              size: 48,
                            ),
                          ),
                        ),
                      ),
                      // Gradient Overlays
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black26,
                              Colors.transparent,
                              Colors.transparent,
                              Colors.black54,
                            ],
                            stops: [0.0, 0.3, 0.7, 1.0],
                          ),
                        ),
                      ),
                      // Bottom Info Overlay (visible when expanded)
                      Positioned(
                        bottom: 30,
                        left: AppSpacing.screenPadding,
                        right: AppSpacing.screenPadding,
                        child: AnimatedOpacity(
                          opacity: _showTitle ? 0.0 : 1.0,
                          duration: const Duration(milliseconds: 200),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryAccent,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  category.name.toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                widget.test.name,
                                style: AppTextStyles.header.copyWith(
                                  color: Colors.white,
                                  fontSize: 28,
                                  shadows: [
                                    const Shadow(
                                      color: Colors.black45,
                                      blurRadius: 10,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(
                                    IconsaxPlusLinear.hospital,
                                    size: 16,
                                    color: Colors.white70,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    widget.test.pathoLabName,
                                    style: AppTextStyles.cardTitle.copyWith(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Content Sections
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    // Price Card Integrated in Scroll
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.screenPadding,
                      ),
                      padding: const EdgeInsets.all(20),
                      decoration: AppCardStyles.sleekCard.copyWith(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.success.withAlpha(30),
                            Colors.white,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Exclusive Price',
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '₹${widget.test.price.toInt()}',
                                style: AppTextStyles.header.copyWith(
                                  color: AppColors.success,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.success.withAlpha(40),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              IconsaxPlusBold.wallet_check,
                              color: AppColors.success,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    LabTestDescriptionCard(test: widget.test),
                    LabTestPrecautionsCard(
                      precautions: widget.test.precautions,
                    ),
                    const LabTestSampleCollectionCard(),
                    const SizedBox(height: 120), // Bottom padding for FAB
                  ],
                ),
              ),
            ],
          ),

          // Floating Book Now Button
          Positioned(
            bottom: 30,
            left: AppSpacing.screenPadding,
            right: AppSpacing.screenPadding,
            child: InkWell(
              onTap: () =>
                  context.push('/lab-tests/list/book', extra: widget.test),
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withAlpha(80),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'BOOK NOW',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
