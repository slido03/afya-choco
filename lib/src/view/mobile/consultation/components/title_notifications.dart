import 'package:flutter/material.dart';

Widget titleNotifications(BuildContext context) {
  return Container(
    padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
    margin: const EdgeInsets.only(bottom: 5.0),
    //color: Colors.white,
    decoration: const BoxDecoration(
      color: Colors.white,
      boxShadow: [
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
          Icons.notifications,
          color: Theme.of(context).primaryColorDark,
          size: 28.0,
        ),
        const SizedBox(width: 10.0),
        const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black,
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
          ),
        ),
      ],
    ),
  );
}
