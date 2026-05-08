import 'package:flutter_riverpod/legacy.dart';

class HomeState {
  final bool isLoading;
  final List<String> banners;

  HomeState({this.isLoading = false, this.banners = const []});

  HomeState copyWith({bool? isLoading, List<String>? banners}) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      banners: banners ?? this.banners,
    );
  }
}

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier()
    : super(
        HomeState(
          banners: [
            'https://img.freepik.com/free-vector/medical-healthcare-banner-with-doctor-character_1017-31355.jpg',
            'https://img.freepik.com/free-vector/horizontal-banner-medical-theme_23-2148560117.jpg',
          ],
        ),
      );

  void setLoading(bool loading) => state = state.copyWith(isLoading: loading);
}
