import 'package:flutter/material.dart';

Widget titleNotificationsSent(BuildContext context) {
  return Container(
    padding: const EdgeInsets.only(top: 20.0, bottom: 10.0, left: 10),
    margin: const EdgeInsets.only(bottom: 5.0),
    //color: Colors.white,
    decoration: BoxDecoration(
      color: Colors.greenAccent[100],
      boxShadow: const [
        // shadow as elevation
        BoxShadow(
          color: Colors.black12,
          blurRadius: 7.0,
          spreadRadius: 1.0,
          offset: Offset(0.0, 0.0),
        ),
      ], // <BoxShadow>[]
    ),
    child: Row(
      children: [
        Icon(
          Icons.notifications_none_outlined,
          color: Theme.of(context).primaryColorDark,
          size: 28.0,
        ),
        const SizedBox(width: 10.0),
        const Text(
          'Messages envoyés',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
          ),
        ),
      ],
    ),
  );
}
