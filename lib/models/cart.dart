import 'medicine.dart';

class CartItem {
  final Medicine medicine;
  final int quantity;

  CartItem({
    required this.medicine,
    this.quantity = 1,
  });

  CartItem copyWith({
    Medicine? medicine,
    int? quantity,
  }) {
    return CartItem(
      medicine: medicine ?? this.medicine,
      quantity: quantity ?? this.quantity,
    );
  }

  double get totalPrice => medicine.price * quantity;
}

class Cart {
  final List<CartItem> items;
  final String? receiverName;
  final String? phone;
  final String? address;

  Cart({
    this.items = const [],
    this.receiverName,
    this.phone,
    this.address,
  });

  Cart copyWith({
    List<CartItem>? items,
    String? receiverName,
    String? phone,
    String? address,
  }) {
    return Cart(
      items: items ?? this.items,
      receiverName: receiverName ?? this.receiverName,
      phone: phone ?? this.phone,
      address: address ?? this.address,
    );
  }

  double get subTotal => items.fold(0, (sum, item) => sum + item.totalPrice);
  double get deliveryFee => subTotal > 0 ? 40.0 : 0.0;
  double get tax => subTotal * 0.05; // 5% tax
  double get total => subTotal + deliveryFee + tax;
}
