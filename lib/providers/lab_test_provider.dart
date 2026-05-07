import 'package:flutter_riverpod/legacy.dart';
import '../notifiers/lab_test_notifier.dart';

final labTestProvider = StateNotifierProvider<LabTestNotifier, LabTestState>((ref) {
  return LabTestNotifier();
});
