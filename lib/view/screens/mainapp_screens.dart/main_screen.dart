import 'package:flutter/material.dart';
import 'package:momo_track/view/widgets/bottom_navigation.dart';
import 'history.dart';
import 'home.dart';
import 'reports.dart';
import 'settings.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [Home(), History(), Reports(), Settings()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: false, // bottom inset is handled by BottomNavBar's own SafeArea
        child: IndexedStack(index: _currentIndex, children: _screens),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTabSelected: (index) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}
