import 'package:flutter/material.dart';

class SaisiePrenom extends StatelessWidget {
  const SaisiePrenom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController prenomController = TextEditingController();

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          ),
          child: TextFormField(
            controller: prenomController,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
              labelText: 'Prenoms',
              hintText: 'Vos prenoms',
            ),
          ),
        ),
      ),
    );
  }
}
