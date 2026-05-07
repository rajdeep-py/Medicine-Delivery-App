import 'package:flutter_riverpod/legacy.dart';
import '../models/order_prescription.dart';

class OrderPrescriptionState {
  final List<OrderPrescription> orders;
  final bool isLoading;
  final String? error;

  OrderPrescriptionState({
    this.orders = const [],
    this.isLoading = false,
    this.error,
  });

  OrderPrescriptionState copyWith({
    List<OrderPrescription>? orders,
    bool? isLoading,
    String? error,
  }) {
    return OrderPrescriptionState(
      orders: orders ?? this.orders,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class OrderPrescriptionNotifier extends StateNotifier<OrderPrescriptionState> {
  OrderPrescriptionNotifier() : super(OrderPrescriptionState());

  Future<void> submitOrder(OrderPrescription order) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // Mock API call delay
      await Future.delayed(const Duration(seconds: 2));

      state = state.copyWith(
        orders: [...state.orders, order],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
