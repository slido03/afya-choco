import 'package:afya/src/view/mobile/consultation/pages/demander_info.dart';
import 'package:flutter/material.dart';

import '../pages/prendre_rdv.dart';
import '../pages/changer_rdv.dart';
import '../components/separator.dart';

showSimpleDialog(BuildContext context) {
  // configurer la boîte de dialogue

  Map<String, Widget> menus = {
    "Prendre rendez-vous": const PrendreRdv(),
    "Changer de rendez-vous": const ChangerRdv(),
    "Demander des informations": const DemanderInfos()
  };
  /*
    * This class is used to display the separator
    * in the simple dialog
  */

  Widget menuItem({required String title, Function()? onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        separator(),
        SizedBox(
          width: double.infinity,
          child: SimpleDialogOption(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            onPressed: () {
              // fermer la boîte de dialogue et ouvrir la page de prise de rendez-vous
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => menus[title]!,
                ),
              );
            },
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }

  SimpleDialog dialog = SimpleDialog(
    title: const Text("Que voulez-vous faire ?"),
    titleTextStyle: const TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    backgroundColor: Colors.green[100],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    children: [
      menuItem(title: "Prendre rendez-vous"),
      menuItem(title: "Changer de rendez-vous"),
      menuItem(title: "Demander des informations"),
    ],
  );

  // afficher la boîte de dialogue
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return dialog;
    },
  );
}
