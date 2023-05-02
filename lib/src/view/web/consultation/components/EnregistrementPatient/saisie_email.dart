import 'package:flutter/material.dart';

class SaisieEmail extends StatelessWidget {
  const SaisieEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          ),
          child: TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
              labelText: 'Email',
              hintText: 'Votre e-mail',
            ),
          ),
        ),
      ),
    );
  }
}
