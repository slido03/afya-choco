import 'package:flutter/material.dart';

class ListeMessage extends StatelessWidget {
  const ListeMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(37, 211, 102, 0.8),
        borderRadius: BorderRadius.circular(5),
      ),
      child: const TextButton(
        onPressed: null,
        child: Expanded(
            child: Text(
          'Liste des messages',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        )),
      ),
    );
  }
}
