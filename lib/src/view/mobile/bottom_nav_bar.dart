import 'package:flutter/material.dart';
import 'package:flutter_material_symbols/flutter_material_symbols.dart';

// ignore: must_be_immutable

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, required this.currentIndex, required this.onItemTapped});

  final int currentIndex;
  final void Function(int) onItemTapped;

  
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 2.0,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          // health metrics icon from material symbols
          icon: Icon(MaterialSymbols.health_and_safety_outlined),
          label: 'consultation',
          activeIcon: Icon(MaterialSymbols.health_and_safety_filled),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book_outlined),
          label: 'carnet',
          activeIcon: Icon(Icons.book),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month_outlined),
          label: 'agenda',
          activeIcon: Icon(Icons.calendar_month),
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white60,
      showUnselectedLabels: true,
      backgroundColor: Colors.green,
      onTap: onItemTapped,
    );
  }
}
