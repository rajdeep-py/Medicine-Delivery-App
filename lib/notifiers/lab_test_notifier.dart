import 'package:flutter_riverpod/legacy.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../models/lab_test.dart';

class LabTestState {
  final List<LabTestCategory> categories;
  final List<LabTest> tests;
  final bool isLoading;

  LabTestState({
    this.categories = const [],
    this.tests = const [],
    this.isLoading = false,
  });

  LabTestState copyWith({
    List<LabTestCategory>? categories,
    List<LabTest>? tests,
    bool? isLoading,
  }) {
    return LabTestState(
      categories: categories ?? this.categories,
      tests: tests ?? this.tests,
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
        isPopular: true,
      ),
      LabTestCategory(
        id: '2',
        name: 'Diabetes',
        icon: IconsaxPlusLinear.activity,
        isPopular: true,
      ),
      LabTestCategory(
        id: '3',
        name: 'Heart',
        icon: IconsaxPlusLinear.heart,
        isPopular: true,
      ),
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

    final tests = [
      LabTest(
        id: 't1',
        categoryId: '1',
        name: 'Full Body Checkup',
        description: 'Complete screening of all vital organs',
        pathoLabName: 'Apollo Diagnostics',
        imageUrl: 'https://images.unsplash.com/photo-1579152276503-68fe28dc435b?q=80&w=200&auto=format&fit=crop',
        price: 1999,
      ),
      LabTest(
        id: 't2',
        categoryId: '1',
        name: 'Basic Health Package',
        description: 'Essential health screening',
        pathoLabName: 'Thyrocare',
        imageUrl: 'https://images.unsplash.com/photo-1581093588401-fbb62a02f120?q=80&w=200&auto=format&fit=crop',
        price: 999,
      ),
      LabTest(
        id: 't3',
        categoryId: '2',
        name: 'Diabetes Screening',
        description: 'HbA1c and Blood Sugar tests',
        pathoLabName: 'Lal Path Labs',
        imageUrl: 'https://images.unsplash.com/photo-1628114403144-88506085a633?q=80&w=200&auto=format&fit=crop',
        price: 499,
      ),
      LabTest(
        id: 't4',
        categoryId: '3',
        name: 'ECG',
        description: 'Electrocardiogram for heart health',
        pathoLabName: 'Max Labs',
        imageUrl: 'https://images.unsplash.com/photo-1559757175-5700dde675bc?q=80&w=200&auto=format&fit=crop',
        price: 799,
      ),
    ];

    state = state.copyWith(categories: categories, tests: tests, isLoading: false);
  }
}
