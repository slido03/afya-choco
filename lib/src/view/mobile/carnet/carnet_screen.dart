import 'package:flutter/material.dart';

import '../tabs.dart';
import 'pages/examens.dart';
import 'pages/ordonnances.dart';
import 'pages/profile.dart';
//import 'components/tab_bar_carnet.dart';

class CarnetScreen extends StatefulWidget {
  const CarnetScreen({
    super.key,
    this.tabIndex = 0,
  });

  final int tabIndex;

  @override
  State<CarnetScreen> createState() => _CarnetScreenState();
}

class _CarnetScreenState extends State<CarnetScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: widget.tabIndex,
    );

    _tabController = TabController(
      length: tabs[1].length,
      vsync: this,
      initialIndex: widget.tabIndex,
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
          tabs: tabs[1],
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
                child: Profile(),
              ),
              Center(
                child: Examens(),
              ),
              Center(
                child: Ordonnances(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
