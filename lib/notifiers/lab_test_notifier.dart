import 'package:flutter_riverpod/legacy.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../models/lab_test.dart';

class LabTestState {
  final List<LabTestCategory> categories;
  final bool isLoading;

  LabTestState({this.categories = const [], this.isLoading = false});

  LabTestState copyWith({List<LabTestCategory>? categories, bool? isLoading}) {
    return LabTestState(
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class LabTestNotifier extends StateNotifier<LabTestState> {
  LabTestNotifier() : super(LabTestState()) {
    _loadCategories();
  }

  void _loadCategories() {
    state = state.copyWith(isLoading: true);

    // Mock data for 3x3 layout (9 items)
    final categories = [
      LabTestCategory(
        id: '1',
        name: 'Full Body',
        icon: IconsaxPlusLinear.health,
      ),
      LabTestCategory(
        id: '2',
        name: 'Diabetes',
        icon: IconsaxPlusLinear.activity,
      ),
      LabTestCategory(id: '3', name: 'Heart', icon: IconsaxPlusLinear.heart),
      LabTestCategory(id: '4', name: 'Kidney', icon: IconsaxPlusLinear.filter),
      LabTestCategory(id: '5', name: 'Liver', icon: IconsaxPlusLinear.lifebuoy),
      LabTestCategory(id: '6', name: 'Thyroid', icon: IconsaxPlusLinear.flash),
      LabTestCategory(
        id: '7',
        name: 'Bones',
        icon: IconsaxPlusLinear.grammerly, // Mock icon
      ),
      LabTestCategory(
        id: '8',
        name: 'Fever',
        icon: IconsaxPlusLinear.cloud_drizzle, // Mock icon
      ),
      LabTestCategory(
        id: '9',
        name: 'Cancer',
        icon: IconsaxPlusLinear.radar, // Mock icon
      ),
    ];

    state = state.copyWith(categories: categories, isLoading: false);
  }
}
