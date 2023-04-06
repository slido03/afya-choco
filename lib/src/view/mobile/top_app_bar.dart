
//import 'dart:ui';

import 'package:flutter/material.dart';

//import 'agenda/components/tab_bar_agenda.dart';
//import 'carnet/components/tab_bar_carnet.dart';
import 'consultation/components/popupmenu_more.dart';
import 'consultation/components/popupmenu_user.dart';
//import '../mobile/tabs.dart';


// ignore: must_be_immutable
class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TopAppBar({
    super.key,
    required this.title,
  });

  final String title;

  // the name of app is afya
  //Widget miniLogo = const Text('Afya');

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto',
          fontStyle: FontStyle.italic,
        ),
      ),
      actions: <Widget>[
        const PopupMenuUser(),
        IconButton(
          icon: const Icon(Icons.notifications_none),
          onPressed: () {
            Navigator.pushNamed(context, '/notifications');
          },
        ),
        const PopupMenuMore(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
