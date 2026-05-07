import 'package:flutter_riverpod/legacy.dart';
import '../notifiers/book_lab_test_notifier.dart';

final bookLabTestProvider =
    StateNotifierProvider<BookLabTestNotifier, BookLabTestState>((ref) {
      return BookLabTestNotifier();
    });
