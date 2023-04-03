import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/*
  * This widget is used to display Phone number input
  * in the "Prise de rendez-vous" page
*/
class InputPhone extends StatelessWidget {
    const InputPhone(
      {super.key,
      this.maxwidth,
      required this.controller,
      required String labelText,
      required String hintText});

  final double? maxwidth;
  final TextEditingController controller;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          final validator = RegExp(r'^[1-9][0-9]{7}$');
          if (value == null || value.isEmpty) {
            return 'Veuillez saisir votre numéro de téléphone';
          } else if (!validator.hasMatch(value)) {
            return 'Veuillez saisir un numéro de téléphone valide';
          }
          return null;
        },
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: 'Téléphone',
          hintText: 'Votre numéro de téléphone',
          //errorText: 'Veuillez saisir un numéro de téléphone valide',
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
        onTapOutside: (event) {
          //event. 
          final validator = RegExp(r'^[1-9][0-9]{7}$');
          // if (controller.text.isEmpty) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(
          //       content: Text('Veuillez saisir votre numéro de téléphone'),
          //     ),
          //   );
          // } else if (!validator.hasMatch(controller.text)) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(
          //       content: Text('Veuillez saisir un numéro de téléphone valide'),
          //     ),
          //   );
          // }
        },
        // onFieldSubmitted: (value) {
        //   if (kDebugMode) {
        //     print('submitted');
        //   }
        // },
      ),
    );
  }
}
