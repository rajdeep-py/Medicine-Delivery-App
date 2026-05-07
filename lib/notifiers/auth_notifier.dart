import 'package:flutter_riverpod/legacy.dart';
import '../models/user.dart';

class AuthState {
  final User? user;
  final bool isLoading;
  final String? error;

  AuthState({this.user, this.isLoading = false, this.error});

  AuthState copyWith({User? user, bool? isLoading, String? error}) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState());

  Future<void> login(String phoneNumber) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      // In a real app, you would send OTP here
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> verifyOtp(String phoneNumber, String otp) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      final user = User(id: '1', phoneNumber: phoneNumber, name: 'John Doe');
      state = state.copyWith(isLoading: false, user: user);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void logout() {
    state = AuthState();
  }
}
