import 'package:flutter/material.dart';

class NavigationRailPage extends StatefulWidget {
  const NavigationRailPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NavigationRailPageState createState() => _NavigationRailPageState();
}

class _NavigationRailPageState extends State<NavigationRailPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
        backgroundColor: const Color.fromRGBO(37, 211, 102, 0.6),
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        labelType: NavigationRailLabelType.all,
        destinations: const [
          NavigationRailDestination(
            icon: Icon(Icons.home),
            label: Text('Home'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.health_and_safety),
            label: Text('Consultation'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.people_alt_outlined),
            label: Text('Patient'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.calendar_month_outlined),
            label: Text('Carnet'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.person),
            label: Text('Profil'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.logout_outlined),
            label: Text('Deconnexion'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.mode_night_outlined),
            label: Text('Mode sombre'),
          ),
        ],
    );
  }
}
