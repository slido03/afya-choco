import 'package:flutter/material.dart';

class ButtonEnregistrer extends StatelessWidget {
  const ButtonEnregistrer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          backgroundColor: Colors.green,
          minimumSize: const Size(200, 60),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      onPressed: null,
      child: const Text(
        'Enregistrer',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
