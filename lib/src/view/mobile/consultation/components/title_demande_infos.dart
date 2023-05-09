import 'package:flutter/material.dart';

Widget titleDemandeInfo() {
  return Container(
    margin: const EdgeInsets.only(top: 20.0, bottom: 10.0),
    child: const Text(
      "Demande d'informations",
      style: TextStyle(
        color: Colors.black,
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
      ),
    ),
  );
}
