import 'package:flutter/material.dart';

import 'create_page.dart';
import 'home_page.dart';
import 'profile_page.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(
        onCreateTap: () {
          setState(() {
            _currentIndex = 1;
          });
        },
      ),
      const CreatePage(),
      const Center(child: Text('Kaydedilenler')),
      const ProfilePage(),
    ];
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Ana sayfa',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_photo_alternate_outlined),
            selectedIcon: Icon(Icons.add_photo_alternate),
            label: 'Oluştur',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_border),
            selectedIcon: Icon(Icons.bookmark),
            label: 'Kaydedilenler',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
