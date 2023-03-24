import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title;

  TopAppBar({super.key, required this.title});

  // the name of app is afya
  //Widget miniLogo =

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
      elevation: 2,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.person_outlined),
          onPressed: () {
            // do something
          },
        ),
        IconButton(
          icon: const Icon(Icons.notifications_none),
          onPressed: () {
            // do something
          },
        ),
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {
            // do something
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
