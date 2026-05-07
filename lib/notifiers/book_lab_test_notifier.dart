import 'package:flutter_riverpod/legacy.dart';
import '../models/lab_test_booking.dart';

class BookLabTestState {
  final bool isLoading;
  final String? error;
  final bool isSuccess;

  BookLabTestState({
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
  });

  BookLabTestState copyWith({bool? isLoading, String? error, bool? isSuccess}) {
    return BookLabTestState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

class BookLabTestNotifier extends StateNotifier<BookLabTestState> {
  BookLabTestNotifier() : super(BookLabTestState());

  Future<void> createBooking(LabTestBooking booking) async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void reset() {
    state = BookLabTestState();
  }
}
