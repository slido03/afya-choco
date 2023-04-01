import 'package:flutter/material.dart';

import '../tabs.dart';

// placeholder
class AgendaScreen extends StatefulWidget {
  const AgendaScreen({super.key});

  @override
  State<AgendaScreen> createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
    );

    _tabController = TabController(
      length: tabs[2].length,
      vsync: this,
      initialIndex: 0,
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _tabController.index = index;
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          tabs: tabs[2],
          controller: _tabController,
          onTap: _onTabTapped,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
        ),
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _tabController.index = index;
                _tabController.animateTo(index);
              });
            },
            children: const <Widget>[
              Center(
                child: Text('Page 1 agenda'),
              ),
              Center(
                child: Text('Page 2 agenda'),
              ),
              Center(
                child: Text('Page 3 agenda'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
