import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonBottomNavBar extends StatelessWidget {
  // final List<BottomNavigationBarItem> items;
  final int selectedIndex;
  final void Function(int) onItemSelected;

  const CommonBottomNavBar({
    Key? key,
    // required this.items,
    required this.selectedIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: selectedIndex,
          onTap: onItemSelected,
        ));
  }
}
