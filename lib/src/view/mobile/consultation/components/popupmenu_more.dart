import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


/*
 * This is a popup menu button 
 * It is used to options like A propos, politique de confidentialité, etc.
 */
class PopupMenuMore extends StatelessWidget {
  const PopupMenuMore({super.key});


  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert),
      itemBuilder: (context) => [
        // user profile
        const PopupMenuItem(
          value: 1,
          child: Text('A propos'),
        ),
        // logout
        const PopupMenuItem(
          value: 2,
          child: Text('Politique de confidentialité'),
        ),
      ],
      onSelected: (value) {
        switch (value) {
          case 1:
            print('Edit');
            break;
          case 2:
            print('Delete');
            break;
        }
      },
    );
  }
}