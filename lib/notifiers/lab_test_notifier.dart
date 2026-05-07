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
        description: 'Comprehensive health screening covering vital organs like liver, kidney, heart, and metabolic profile.',
        pathoLabName: 'Apollo Diagnostics',
        imageUrl: 'https://images.unsplash.com/photo-1581093588401-fbb62a02f120?q=80&w=800&auto=format&fit=crop',
        price: 1999,
        parameters: [
          TestParameter(name: 'Complete Blood Count', value: '24 parameters'),
          TestParameter(name: 'Liver Function Test', value: '11 parameters'),
          TestParameter(name: 'Kidney Function Test', value: '9 parameters'),
          TestParameter(name: 'Lipid Profile', value: '8 parameters'),
        ],
        precautions: [
          '8-10 hours fasting required',
          'Do not consume alcohol 24h before',
          'Morning sample preferred',
        ],
      ),
      LabTest(
        id: 't3',
        categoryId: '2',
        name: 'Diabetes Screening',
        description: 'Early detection and monitoring of blood glucose levels and insulin resistance.',
        pathoLabName: 'Lal Path Labs',
        imageUrl: 'https://images.unsplash.com/photo-1631815527621-0a24d8c10f0a?q=80&w=800&auto=format&fit=crop',
        price: 499,
        parameters: [
          TestParameter(name: 'HbA1c', value: 'Average blood sugar over 3 months'),
          TestParameter(name: 'Fasting Blood Sugar', value: 'Current glucose level'),
        ],
        precautions: [
          'Strict 10-12 hours fasting required',
          'Drink only water during fasting',
        ],
      ),
      // ... (other tests can stay basic for now)
    ];

    state = state.copyWith(categories: categories, tests: tests, isLoading: false);
  }
}
