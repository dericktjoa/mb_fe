import 'package:flutter/material.dart';
import 'package:mb_fe/dashboard/dashboard_page.dart';
import 'package:mb_fe/games/games.dart';
import 'package:mb_fe/animal_description/animal_3d_list_page.dart';

class bottomNav extends StatefulWidget {
  final int initialIndex;
  const bottomNav({super.key, this.initialIndex = 0});

  @override
  State<bottomNav> createState() => _bottomNavState();
}

class _bottomNavState extends State<bottomNav> {
  late final PageController _pageController;
  late int _currentIndex;

  final List<Widget> _pages = const [
    dashboardPage(),
    Animal3DListPage(),
    gamesPage(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onNavTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _pages,
        physics: const BouncingScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor:
        Theme.of(context).brightness == Brightness.dark
            ? Color(0xFF4F8F74)
            : Color(0xFF60B28C),
        currentIndex: _currentIndex,
        onTap: _onNavTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Library'),
          BottomNavigationBarItem(icon: Icon(Icons.sports_esports), label: 'Games'),
        ],
      ),
    );
  }
}
