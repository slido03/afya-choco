import 'package:flutter/material.dart';
import '../../constant/tabs.dart';

class TabBarAgenda extends StatefulWidget {
  const TabBarAgenda({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TabBarAgendaState createState() => _TabBarAgendaState();
}

class _TabBarAgendaState extends State<TabBarAgenda> {
  @override
  Widget build(BuildContext context) => DefaultTabController(
    length: 5,
    child: Material(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
            children: [
              TabBar(
                tabs: tabs
                ),
               const Expanded(
                child: TabBarView(
                  children: [
                   
                    Text('Evenements'),
                    Text('Rappels'),
                    Text('Historique'),
                  ]
                ),
              )
            ],
          ),
        
      ),
    ),
    );
 
}