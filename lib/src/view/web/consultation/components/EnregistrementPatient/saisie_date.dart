import 'package:flutter/material.dart';

class SaisieDate extends StatelessWidget {
  const SaisieDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController naissanceController = TextEditingController();

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          ),
          child: TextFormField(
            controller: naissanceController,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
              labelText: 'Date de naissance',
              hintText: '11/02/2022',
            ),
          ),
        ),
      ),
    );
  }
}
