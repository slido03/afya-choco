import 'package:flutter/material.dart';
import 'package:afya/src/view/mobile/authentication/authentication.dart';
//import 'package:afya/src/viewModel/view_models.dart';
import '../tabs.dart';
import 'pages/examens.dart';
import 'pages/ordonnances.dart';
import 'pages/profile.dart';
//import 'components/tab_bar_carnet.dart';

class CarnetScreen extends StatefulWidget {
  const CarnetScreen({
    super.key,
    this.index = 0,
  });

  final int index;

  @override
  State<CarnetScreen> createState() => _CarnetScreenState();
}

class _CarnetScreenState extends State<CarnetScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late TabController _tabController;
  AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: widget.index,
    );

    _tabController = TabController(
      length: tabs[1].length,
      vsync: this,
      initialIndex: widget.index,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  /*void _onTabTapped(int index) {
    setState(() {
      _tabController.index = index;
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    });
  }*/

  @override
  Widget build(BuildContext context) {
    Future<String?> uid = authService.getCurrentUserUid();
    return FutureBuilder(
        future: Future.wait([uid]),
        builder: (context, result) {
          if (result.connectionState == ConnectionState.waiting) {
            return Center(
                child: Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            ));
          } else if (result.hasData) {
            final List<String?> data = result.data!;
            final userId = data[0];
            //si l'utilisateur est connecté
            if (userId != null) {
              return Column(
                children: [
                  TabBar(
                    tabs: tabs[1],
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
                      children: <Widget>[
                        Center(
                          child: Profile(
                            userId: userId,
                          ),
                        ),
                        Center(
                          child: Examens(
                            userId: userId,
                          ),
                        ),
                        Center(
                          child: Ordonnances(
                            userId: userId,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            }
          }
          //en cas d'erreur quelconque (result.hasError)
          return Center(child: Text('Erreur: ${result.error}'));
        });
  }
}
