import 'package:flutter/material.dart';

class SaisieIdentifiant extends StatelessWidget {
  const SaisieIdentifiant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController idController = TextEditingController();

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          ),
          child: TextFormField(
            controller: idController,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
              labelText: 'Identifiant du rendez-vous',
              hintText: 'Veuillez saisir l\'identifiant du rendez-vous',
            ),
          ),
        ),
      ),
    );
  }
}
