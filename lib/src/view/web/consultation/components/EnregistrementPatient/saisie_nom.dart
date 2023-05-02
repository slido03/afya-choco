import 'package:flutter/material.dart';

class SaisieNom extends StatelessWidget {
  const SaisieNom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController nomController = TextEditingController();

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          ),
          child: TextFormField(
            controller: nomController,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
              labelText: 'Nom',
              hintText: 'Votre nom',
            ),
          ),
        ),
      ),
    );
  }
}
