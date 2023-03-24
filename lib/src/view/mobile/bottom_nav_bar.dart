import 'package:flutter/material.dart';
import 'package:flutter_material_symbols/flutter_material_symbols.dart';

// ignore: must_be_immutable
class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          // health metrics icon from material symbols
          icon: Icon(MaterialSymbols.health_and_safety_filled),
          label: 'consultation',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book_outlined),
          label: 'carnet',
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined), label: 'agenda'),
      ],
      currentIndex: 0,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      onTap: (int index) {
        // do something
      },
    );
  }
}
