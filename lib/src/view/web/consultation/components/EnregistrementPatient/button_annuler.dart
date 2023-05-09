import 'package:flutter/material.dart';

class ButtonAnnuler extends StatelessWidget {
  const ButtonAnnuler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          backgroundColor: Colors.red,
          minimumSize: const Size(200, 60),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      onPressed: null,
      child: const Text(
        'Annuler',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
