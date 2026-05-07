import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../theme/app_theme.dart';
import '../../models/patho_lab.dart';
import '../../providers/lab_test_provider.dart';
import '../../cards/lab_test/lab_test_card.dart';

class PathoLabDetailScreen extends ConsumerWidget {
  final PathoLab lab;

  const PathoLabDetailScreen({super.key, required this.lab});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final labTestState = ref.watch(labTestProvider);
    // Filter tests that belong to this lab or are in this lab's ID list
    // (Assuming mock data uses the same IDs)
    final labTests = labTestState.tests.where((test) => test.pathoLabName == lab.name).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Cinematic Lab Header
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            elevation: 0,
            backgroundColor: AppColors.surface,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.black.withAlpha(50),
                child: IconButton(
                  icon: const Icon(IconsaxPlusLinear.arrow_left_2, color: Colors.white, size: 20),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(lab.imageUrl, fit: BoxFit.cover),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black26, Colors.transparent, Colors.black87],
                        stops: [0.0, 0.4, 1.0],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 24,
                    left: AppSpacing.screenPadding,
                    right: AppSpacing.screenPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lab.name,
                          style: AppTextStyles.header.copyWith(
                            color: Colors.white,
                            fontSize: 28,
                            shadows: [const Shadow(color: Colors.black45, blurRadius: 10, offset: Offset(0, 4))],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(IconsaxPlusLinear.location, size: 16, color: Colors.white70),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                lab.address,
                                style: AppTextStyles.caption.copyWith(color: Colors.white70),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Section Title
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.screenPadding, 24, AppSpacing.screenPadding, 10),
              child: Row(
                children: [
                  const Icon(IconsaxPlusLinear.health, color: AppColors.primaryAccent, size: 20),
                  const SizedBox(width: 12),
                  Text(
                    'Available Tests (${labTests.length})',
                    style: AppTextStyles.cardTitle.copyWith(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),

          // List of Tests in this lab
          labTests.isEmpty 
          ? const SliverFillRemaining(
              child: Center(child: Text('No tests available in this lab yet.')),
            )
          : SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => LabTestCard(test: labTests[index]),
                childCount: labTests.length,
              ),
            ),
          
          const SliverToBoxAdapter(child: SizedBox(height: 30)),
        ],
      ),
    );
  }
}
