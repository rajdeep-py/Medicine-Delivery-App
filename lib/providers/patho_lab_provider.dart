import 'package:flutter_riverpod/legacy.dart';
import '../models/patho_lab.dart';

class PathoLabState {
  final List<PathoLab> labs;
  final bool isLoading;
  final String? error;

  PathoLabState({required this.labs, this.isLoading = false, this.error});

  PathoLabState copyWith({
    List<PathoLab>? labs,
    bool? isLoading,
    String? error,
  }) {
    return PathoLabState(
      labs: labs ?? this.labs,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class PathoLabNotifier extends StateNotifier<PathoLabState> {
  PathoLabNotifier() : super(PathoLabState(labs: _mockLabs));

  static final List<PathoLab> _mockLabs = [
    PathoLab(
      id: 'l1',
      name: 'Apollo Diagnostics',
      address: 'Plot No. 12, Sector 18, Noida, UP',
      imageUrl:
          'https://images.unsplash.com/photo-1579152276503-68fe28dc435b?q=80&w=800&auto=format&fit=crop',
      rating: 4.8,
      reviewsCount: 1250,
      testIds: ['t1', 't2'],
    ),
    PathoLab(
      id: 'l2',
      name: 'Lal Path Labs',
      address: 'Shop No. 5, Market Area, Indirapuram, Ghaziabad',
      imageUrl:
          'https://images.unsplash.com/photo-1581093588401-fbb62a02f120?q=80&w=800&auto=format&fit=crop',
      rating: 4.5,
      reviewsCount: 840,
      testIds: ['t3', 't4'],
    ),
    PathoLab(
      id: 'l3',
      name: 'SRL Diagnostics',
      address: 'Building A, Commercial Belt, Alpha 1, Greater Noida',
      imageUrl:
          'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?q=80&w=800&auto=format&fit=crop',
      rating: 4.6,
      reviewsCount: 920,
      testIds: ['t5'],
    ),
  ];

  void searchLabs(String query) {
    if (query.isEmpty) {
      state = state.copyWith(labs: _mockLabs);
      return;
    }
    final filtered = _mockLabs
        .where(
          (lab) =>
              lab.name.toLowerCase().contains(query.toLowerCase()) ||
              lab.address.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
    state = state.copyWith(labs: filtered);
  }
}

final pathoLabProvider = StateNotifierProvider<PathoLabNotifier, PathoLabState>(
  (ref) {
    return PathoLabNotifier();
  },
);
