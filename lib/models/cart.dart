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
  final double? latitude;
  final double? longitude;

  Cart({
    this.items = const [],
    this.receiverName,
    this.phone,
    this.address,
    this.latitude,
    this.longitude,
  });

  Cart copyWith({
    List<CartItem>? items,
    String? receiverName,
    String? phone,
    String? address,
    double? latitude,
    double? longitude,
  }) {
    return Cart(
      items: items ?? this.items,
      receiverName: receiverName ?? this.receiverName,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  double get subTotal => items.fold(0, (sum, item) => sum + item.totalPrice);
  double get deliveryFee => subTotal > 0 ? 40.0 : 0.0;
  double get tax => subTotal * 0.05; // 5% tax
  double get total => subTotal + deliveryFee + tax;
}
