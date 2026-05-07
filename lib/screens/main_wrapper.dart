import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';

class MainWrapper extends StatelessWidget {
  final Widget child;
  final int currentIndex;

  const MainWrapper({
    super.key,
    required this.child,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      extendBody: true, // Allows bottom nav to be floating over content
      bottomNavigationBar: CustomBottomNavBar(currentIndex: currentIndex),
    );
  }
}
