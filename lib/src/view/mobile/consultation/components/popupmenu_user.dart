import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:afya/src/view/mobile/authentication/login.dart';

class PopupMenuUser extends StatelessWidget {
  const PopupMenuUser({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.person_2_outlined),
      itemBuilder: (context) => [
        // user profile
        PopupMenuItem(
          value: 1,
          child: Row(
            children: const [
              Icon(Icons.person_2_outlined, color: Colors.black),
              SizedBox(width: 10.0),
              Text('Profile'),
            ],
          ),
        ),
        // logout
        PopupMenuItem(
          value: 2,
          child: Row(
            children: const [
              Icon(Icons.logout, color: Colors.black),
              SizedBox(width: 10.0),
              Text('Déconnexion'),
            ],
          ),
        ),
      ],
      onSelected: (value) {
        switch (value) {
          case 1:
            if (kDebugMode) {
              print('Edit');
            }
            break;
          case 2:
            logout(context);
            break;
        }
      },
    );
  }
}
