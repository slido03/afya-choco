

// // class CustomNavigationRail extends StatefulWidget {
// //   const CustomNavigationRail({super.key});

// //   @override
// //   CustomNavigationRailState createState() => CustomNavigationRailState();
// // }

// // class CustomNavigationRailState extends State<CustomNavigationRail> {
// //   int _selectedIndex = 0;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Row(
// //         children: [
// //           NavigationRail(
// //             selectedIndex: _selectedIndex,
// //             onDestinationSelected: (int index) {
// //               setState(() {
// //                 _selectedIndex = index;
// //               });
// //             },
// //             labelType: NavigationRailLabelType.all,
// //             destinations: const [
// //               NavigationRailDestination(
// //                 icon: Icon(Icons.home),
// //                 label: Text('Accueil'),
// //               ),
// //               NavigationRailDestination(
// //                 icon: Icon(Icons.explore),
// //                 label: Text('Explorer'),
// //               ),
// //               NavigationRailDestination(
// //                 icon: Icon(Icons.settings),
// //                 label: Text('Paramètres'),
// //               ),
// //             ],
// //           ),
// //           const VerticalDivider(thickness: 1, width: 1),
// //           Expanded(
// //             child: _getPage(_selectedIndex),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// // switch (index) {
// //       case 0:
// //         return const Center(
// //           child: Text('Page d\'accueil'),
// //         );
// //       case 1:
// //         return const Center(
// //           child: Text('Page d\'exploration'),
// //         );
// //       case 2:
// //         return const Center(
// //           child: Text('Page des paramètres'),
// //         );
// //       default:
// //         return const Text("Page not found");
// //     }


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
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            backgroundColor: Colors.green,
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
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // const Expanded(
          //   child: Center(
          //     child: Text('Page content goes here.'),
          //   ),
          // ),
        ],
      ),
    );
  }
}
