import 'package:flutter/material.dart';

import '../pages/prise_rdv.dart';
import '../pages/changer_rdv.dart';

showSimpleDialog(BuildContext context) {
  // configurer la boîte de dialogue

  Map<String, Widget> menus = {
    "Prise de rendez-vous": const PriseRdv(),
    "Changer de rendez-vous": const ChangerRdv(),
    "Annuler votre rendez-vous": const Placeholder(), //AnnulerRdv(),
    "Demander des informations": const Placeholder() //DemanderInfo(),
  };
  /*
    * This class is used to display the separator
    * in the simple dialog
  */
  separator() {
    return Container(
      height: 1,
      color: Colors.black12,
    );
  }

  Widget menuItem({required String title, Function()? onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        separator(),
        SimpleDialogOption(
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
      menuItem(title: "Prise de rendez-vous"),
      menuItem(title: "Changer de rendez-vous"),
      menuItem(title: "Annuler votre rendez-vous"),
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
