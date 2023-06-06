import 'package:flutter/material.dart';
import '../../constant/tabs.dart';
import '../pages/rendez_vous.dart';
import 'liste_demande.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 5,
        child: Material(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                TabBar(tabs: tabs),
                Expanded(
                  child: TabBarView(children: [
                    ListeDemande(),
                    ListeDemande(),
                    ListeDemande(),
                    ListeDemande(),
                    const RendezVousPage(),
                  ]),
                )
              ],
            ),
          ),
        ),
      );
}
