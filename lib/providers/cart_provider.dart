import 'package:flutter_riverpod/legacy.dart';
import '../models/cart.dart';
import '../notifiers/cart_notifier.dart';

final cartProvider = StateNotifierProvider<CartNotifier, Cart>((ref) {
  return CartNotifier();
});
