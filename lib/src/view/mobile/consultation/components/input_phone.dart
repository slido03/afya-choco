import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/*
  * This widget is used to display Phone number input
  * in the "Prise de rendez-vous" page
*/
class InputPhone extends StatelessWidget {
  const InputPhone({super.key, this.maxwidth});

  final double? maxwidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: TextFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: 'Téléphone',
          hintText: 'Votre numéro de téléphone',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          constraints: BoxConstraints(
              maxHeight: 60.0,
              maxWidth: maxwidth ?? MediaQuery.of(context).size.width * 0.80),
        ),
        onChanged: (value) {
          if (kDebugMode) {
            print(value);
          }
        },
      ),
    );
  }
}
