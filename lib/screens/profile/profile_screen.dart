import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_bar.dart';
import '../../cards/profile/profile_header_card.dart';
import '../../cards/profile/profile_options_card.dart';
import '../../providers/profile_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(
        title: 'Profile',
        subtitle: 'Manage your account',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.screenPadding),
        child: Column(
          children: [
            // Header Card
            ProfileHeaderCard(user: profileState.user),

            const SizedBox(height: AppSpacing.sectionGap),

            // Options Card
            const ProfileOptionsCard(),

            const SizedBox(height: AppSpacing.sectionGap),

            const SizedBox(height: 100), // Bottom padding for floating nav
          ],
        ),
      ),
    );
  }
}
