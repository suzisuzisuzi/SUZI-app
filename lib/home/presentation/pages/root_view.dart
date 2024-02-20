import 'package:flutter/material.dart';
import 'package:suzi_app/heatmap/presentation/pages/heatmap_page.dart';
import 'package:suzi_app/home/presentation/pages/home_page.dart';

class RootView extends StatefulWidget {
  const RootView({super.key});

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        switch (_currentIndex) {
          case 0:
            return const HomePage();
          case 1:
            return const HeatmapPage();
          default:
            return const HomePage();
        }
      }),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/nav1.png"),
            activeIcon: Image.asset("assets/icons/nav1s.png"),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/nav2.png"),
            activeIcon: Image.asset("assets/icons/nav2s.png"),
            label: "Map",
          ),
        ],
      ),
    );
  }
}
