import 'package:flutter/material.dart';

import 'top_app_bar.dart';
import 'bottom_nav_bar.dart';
import 'consultation/components/menu_dialog_consultation.dart';
//import 'authentication/auth_service.dart';
import 'consultation/consultation_screen.dart';
import 'carnet/carnet_screen.dart';
import 'agenda/agenda_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  //int _tabIndexCarnet = 0;
  //int _tabIndexAgenda = 0;

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      const ConsultationScreen(),
      const CarnetScreen(),
      const AgendaScreen(),
    ]);
  }

  final List<Widget> _pages = [];

  void _onNavBarItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopAppBar(
        title: 'AFYA',
      ),
      // pages wrapped in a SingleChildScrollView to avoid overflow
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onItemTapped: _onNavBarItemTapped,
      ),
      floatingActionButton: Visibility(
        visible: _selectedIndex == 0,
        child: FloatingActionButton(
          onPressed: () {
            showSimpleDialog(context);
          },
          tooltip: 'nouvelle consultation',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
