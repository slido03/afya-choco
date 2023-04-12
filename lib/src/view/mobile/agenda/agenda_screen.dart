import 'package:afya/src/view/mobile/agenda/pages/evenements.dart';
import 'package:afya/src/view/mobile/agenda/pages/rappels.dart';
import 'package:flutter/material.dart';

import '../tabs.dart';
import 'pages/historiques.dart';

// placeholder
class AgendaScreen extends StatefulWidget {
  const AgendaScreen({
    super.key,
    this.index = 0,
  });

  final int index;
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
      initialPage: widget.index,
    );

    _tabController = TabController(
      length: tabs[2].length,
      vsync: this,
      initialIndex: widget.index,
    );
  }

  // void _onTabTapped(int index) {
  //   setState(() {
  //     _tabController.index = index;
  //     _pageController.animateToPage(index,
  //         duration: const Duration(milliseconds: 300), curve: Curves.ease);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          tabs: tabs[2],
          controller: _tabController,
          onTap: (index) {
            _tabController.index = index;
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease);
          },
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
        ),
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
                _tabController.index = index;
                _tabController.animateTo(index);
            },
            children: const <Widget>[
              Evenements(),
              Rappels(),
              Historiques(),
            ],
          ),
        ),
      ],
    );
  }
}
