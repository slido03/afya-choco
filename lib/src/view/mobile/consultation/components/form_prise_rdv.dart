import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'input_phone.dart';
import 'input_date.dart';
import 'input_text.dart';
import 'input_text_area.dart';

class FormPriseRdv extends StatelessWidget {
  const FormPriseRdv({super.key});

  @override
  Widget build(BuildContext context) {
    double maxwidth = MediaQuery.of(context).size.width * .80;

    return SingleChildScrollView(
      child: Center(
        child: Container(
          width: maxwidth * 1.115,
          margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 3),
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                ),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 231, 248, 232),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      spreadRadius: 0.0,
                      offset: Offset(0.0, 0.0),
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    const InputText(
                      labelText: 'Nom',
                      hintText: 'Votre nom',
                    ),
                    const InputText(
                      labelText: 'Prénom',
                      hintText: 'Votre prénom',
                    ),
                    const InputText(
                      labelText: 'Email',
                      hintText: 'Votre email',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        InputPhone(
                          maxwidth: MediaQuery.of(context).size.width * .40,
                        ), // Phone number input
                        InputDate(
                            maxwidth: MediaQuery.of(context).size.width *
                                .30), // Date input
                      ],
                    ),
                    const InputTextArea(
                      labelText: 'Message',
                      hintText: 'Votre message',
                    ),
                  ],
                ),
              ),
              // Submit and cancel buttons
              Container(
                width: maxwidth,
                margin:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          if (kDebugMode) {
                            print('Cancel button pressed');
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        child: const Text('Annuler')),
                    const SizedBox(width: 20),
                    OutlinedButton(
                        onPressed: () {
                          if (kDebugMode) {
                            print('Submit button pressed');
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.green,
                        ),
                        child: const Text('Envoyer')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
