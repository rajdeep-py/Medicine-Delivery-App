import 'package:flutter_riverpod/legacy.dart';
import '../models/cart.dart';
import '../models/medicine.dart';

class CartNotifier extends StateNotifier<Cart> {
  CartNotifier() : super(Cart());

  void addToCart(Medicine medicine) {
    final existingIndex = state.items.indexWhere(
      (item) => item.medicine.id == medicine.id,
    );
    if (existingIndex != -1) {
      final updatedItems = [...state.items];
      updatedItems[existingIndex] = updatedItems[existingIndex].copyWith(
        quantity: updatedItems[existingIndex].quantity + 1,
      );
      state = state.copyWith(items: updatedItems);
    } else {
      state = state.copyWith(
        items: [
          ...state.items,
          CartItem(medicine: medicine),
        ],
      );
    }
  }

  void removeFromCart(String medicineId) {
    state = state.copyWith(
      items: state.items
          .where((item) => item.medicine.id != medicineId)
          .toList(),
    );
  }

  void updateQuantity(String medicineId, int quantity) {
    if (quantity <= 0) {
      removeFromCart(medicineId);
      return;
    }
    final updatedItems = state.items.map((item) {
      if (item.medicine.id == medicineId) {
        return item.copyWith(quantity: quantity);
      }
      return item;
    }).toList();
    state = state.copyWith(items: updatedItems);
  }

  void updateDeliveryDetails({String? name, String? phone, String? address}) {
    state = state.copyWith(
      receiverName: name ?? state.receiverName,
      phone: phone ?? state.phone,
      address: address ?? state.address,
    );
  }

  void clearCart() {
    state = Cart();
  }
}
