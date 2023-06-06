import 'package:flutter/material.dart';

import '../constant/navigation_rail.dart';
import 'components/tab_app.dart';
import 'components/top_bar.dart';

class DemandeScreen extends StatefulWidget {
  const DemandeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DemandeScreenState createState() => _DemandeScreenState();
}

class _DemandeScreenState extends State<DemandeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Row(children: [
        NavigationRailPage(),
        Column(
          children: [
            TopBar(),
            Test(),
          ],
        )
      ]),
    );
  }
}
