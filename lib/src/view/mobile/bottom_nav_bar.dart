import 'package:flutter/material.dart';
import 'package:flutter_material_symbols/flutter_material_symbols.dart';

// ignore: must_be_immutable
class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

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
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white60,
      showUnselectedLabels: true,
      backgroundColor: Colors.green,
      onTap: (int index) {
        setState(() {
          _selectedIndex = index;
        });

        switch (index) {
          case 0:
            //Navigator.pushNamed(context, '/consultation');
            break;
          case 1:
            //Navigator.pushNamed(context, '/carnet');
            break;
          case 2:
            //Navigator.pushNamed(context, '/agenda');
            break;
        }
      },
    );
  }
}
