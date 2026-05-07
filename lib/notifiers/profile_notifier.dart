import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/user.dart';
import '../providers/auth_provider.dart';

class ProfileState {
  final User? user;
  final bool isLoading;

  ProfileState({this.user, this.isLoading = false});

  ProfileState copyWith({User? user, bool? isLoading}) {
    return ProfileState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ProfileNotifier extends StateNotifier<ProfileState> {
  final Ref _ref;

  ProfileNotifier(this._ref) : super(ProfileState()) {
    // Initialize with auth user if available
    _init();
  }

  void _init() {
    final authUser = _ref.read(authProvider).user;
    state = state.copyWith(user: authUser);
  }

  Future<void> updateProfile(User user) async {
    state = state.copyWith(isLoading: true);
    // Simulate API update
    await Future.delayed(const Duration(seconds: 1));
    state = state.copyWith(user: user, isLoading: false);
  }
}
