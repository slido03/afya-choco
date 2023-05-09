import 'package:flutter/material.dart';

class SaisieAdresse extends StatefulWidget {
  const SaisieAdresse({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SaisieAdresseState createState() => _SaisieAdresseState();
}

class _SaisieAdresseState extends State<SaisieAdresse> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController adresseController = TextEditingController();

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          ),
          child: TextFormField(
            controller: adresseController,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
              labelText: 'Adresse',
              hintText: 'Votre adresse',
            ),
          ),
        ),
      ),
    );
  }
}
