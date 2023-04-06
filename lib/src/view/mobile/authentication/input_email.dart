import 'package:flutter/material.dart';

class InputEmail extends StatelessWidget {
  const InputEmail(
      {super.key,
      required this.labelText,
      required this.hintText,
      required this.controller,
      this.maxwidth});

  final String labelText;
  final String hintText;
  final double? maxwidth;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          final validator = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
          if (value == null || value.isEmpty) {
            return 'Veuillez saisir votre email';
          } else if (!validator.hasMatch(value)) {
            return 'Veuillez saisir un email valide';
          }
          return null;
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: 'Email',
          hintText: 'Votre email',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          constraints: BoxConstraints(
              maxHeight: 60.0,
              maxWidth: maxwidth ?? MediaQuery.of(context).size.width * 0.80),
        ),
      ),
    );
  }
}
