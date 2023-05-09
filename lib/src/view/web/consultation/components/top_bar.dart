import 'package:flutter/material.dart';
import '../../constant/afya_logo.dart';
import 'liste_message.dart';
import 'nouveau_message.dart';

class TopBar extends StatefulWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
        width: screenWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 2), // Changement de position de l'ombre
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              AfyaLogo(),
              SizedBox(width : 600),
              ListeMessage(),
              SizedBox(width : 40),
              NouveauMessage(),
            ],
          ),
        ),
    );
  }
}
