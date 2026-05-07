import 'package:flutter_riverpod/legacy.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../models/medicine.dart';

class MedicineState {
  final List<MedicineCategory> categories;
  final List<Medicine> medicines;
  final bool isLoading;
  final String? error;

  MedicineState({
    required this.categories,
    required this.medicines,
    this.isLoading = false,
    this.error,
  });

  MedicineState copyWith({
    List<MedicineCategory>? categories,
    List<Medicine>? medicines,
    bool? isLoading,
    String? error,
  }) {
    return MedicineState(
      categories: categories ?? this.categories,
      medicines: medicines ?? this.medicines,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class MedicineNotifier extends StateNotifier<MedicineState> {
  MedicineNotifier()
    : super(
        MedicineState(categories: _mockCategories, medicines: _mockMedicines),
      );

  static final List<MedicineCategory> _mockCategories = [
    MedicineCategory(
      id: 'c1',
      name: 'Pain Relief',
      icon: IconsaxPlusLinear.health,
      isPopular: true,
    ),
    MedicineCategory(
      id: 'c2',
      name: 'Cold & Cough',
      icon: IconsaxPlusLinear.mask,
      isMostOrdered: true,
    ),
    MedicineCategory(
      id: 'c3',
      name: 'Diabetes',
      icon: IconsaxPlusLinear.activity,
      isPopular: true,
    ),
    MedicineCategory(
      id: 'c4',
      name: 'Baby Care',
      icon: IconsaxPlusLinear.lovely,
    ),
    MedicineCategory(
      id: 'c5',
      name: 'Skin Care',
      icon: IconsaxPlusLinear.mirror,
      isMostOrdered: true,
    ),
    MedicineCategory(id: 'c6', name: 'Vitamins', icon: IconsaxPlusLinear.glass),
    MedicineCategory(
      id: 'c7',
      name: 'Homeopathy',
      icon: IconsaxPlusLinear.flash,
    ),
    MedicineCategory(
      id: 'c8',
      name: 'Ayurveda',
      icon: IconsaxPlusLinear.path_2,
    ),
  ];

  static final List<Medicine> _mockMedicines = [
    Medicine(
      id: 'm1',
      name: 'Dolo 650 Tablet',
      description:
          'Used for fever and mild to moderate pain. Dolo 650 Tablet helps relieve pain and fever by blocking the release of certain chemical messengers that cause pain and fever.',
      categoryId: 'c1',
      price: 30.0,
      images: [
        'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?q=80&w=800&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1550572017-4fcdbb59cc32?q=80&w=800&auto=format&fit=crop',
      ],
      manufacturer: 'Micro Labs Ltd',
      isPrescriptionRequired: false,
      quantity: '15 Tablets',
      composition: 'Paracetamol (650mg)',
      precautions: [
        'Do not take more than the recommended dose.',
        'Avoid alcohol while taking this medicine.',
        'Consult your doctor if you have liver or kidney disease.',
      ],
      shopName: 'City Pharma & Wellness',
      shopAddress: '123 Health Street, Sector 5, Kolkata',
    ),
    Medicine(
      id: 'm2',
      name: 'Vicks Action 500',
      description:
          'Relief from cold and flu symptoms including headache, body ache, and sore throat.',
      categoryId: 'c2',
      price: 55.0,
      images: [
        'https://images.unsplash.com/photo-1631549916768-4119b255f946?q=80&w=800&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1584017911766-d451b3d0e843?q=80&w=800&auto=format&fit=crop',
      ],
      manufacturer: 'P&G',
      isPrescriptionRequired: false,
      quantity: '10 Tablets',
      composition:
          'Paracetamol (500mg), Phenylephrine Hydrochloride (5mg), Caffeine (30mg)',
      precautions: [
        'May cause drowsiness.',
        'Not for children under 12 years.',
        'Do not take with other paracetamol-containing products.',
      ],
      shopName: 'Apollo Pharmacy',
      shopAddress: 'Gariahat Road, South Kolkata',
    ),
    Medicine(
      id: 'm3',
      name: 'Glycomet 500',
      description:
          'Glycomet 500 Tablet is a medicine used to treat type 2 diabetes mellitus. It helps control blood sugar levels and thus prevent serious complications of diabetes.',
      categoryId: 'c3',
      price: 120.0,
      images: [
        'https://images.unsplash.com/photo-1471864190281-a93a3070b6de?q=80&w=800&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1576091160550-2173bdd99625?q=80&w=800&auto=format&fit=crop',
      ],
      manufacturer: 'USV Pvt Ltd',
      isPrescriptionRequired: true,
      quantity: '20 Tablets',
      composition: 'Metformin (500mg)',
      precautions: [
        'Take with food to reduce stomach upset.',
        'Regular monitoring of blood sugar is essential.',
        'Inform your doctor if you experience severe nausea or vomiting.',
      ],
      shopName: 'MedPlus Pharmacy',
      shopAddress: 'Salt Lake, Sector 2, Kolkata',
    ),
  ];

  void searchCategories(String query) {
    if (query.isEmpty) {
      state = state.copyWith(categories: _mockCategories);
      return;
    }
    final filtered = _mockCategories
        .where((c) => c.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    state = state.copyWith(categories: filtered);
  }

  void searchMedicines(String query, String categoryId) {
    final categoryMeds = _mockMedicines
        .where((m) => m.categoryId == categoryId)
        .toList();
    if (query.isEmpty) {
      state = state.copyWith(medicines: categoryMeds);
      return;
    }
    final filtered = categoryMeds
        .where(
          (m) =>
              m.name.toLowerCase().contains(query.toLowerCase()) ||
              m.manufacturer.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
    state = state.copyWith(medicines: filtered);
  }

  void searchAllMedicines(String query) {
    if (query.isEmpty) {
      state = state.copyWith(medicines: []);
      return;
    }
    final filtered = _mockMedicines
        .where(
          (m) =>
              m.name.toLowerCase().contains(query.toLowerCase()) ||
              m.manufacturer.toLowerCase().contains(query.toLowerCase()) ||
              m.description.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
    state = state.copyWith(medicines: filtered);
  }
}

final medicineProvider = StateNotifierProvider<MedicineNotifier, MedicineState>(
  (ref) {
    return MedicineNotifier();
  },
);
