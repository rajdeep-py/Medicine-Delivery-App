import 'package:flutter_riverpod/legacy.dart';
import '../notifiers/order_prescription_notifier.dart';

final orderPrescriptionProvider =
    StateNotifierProvider<OrderPrescriptionNotifier, OrderPrescriptionState>((
      ref,
    ) {
      return OrderPrescriptionNotifier();
    });
