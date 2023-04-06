import 'package:flutter/material.dart';

import 'button_submit.dart';
import 'input_phone.dart';
import 'input_date.dart';
import 'input_text.dart';
import 'button_cancel.dart';
import 'input_text_area.dart';

class FormPriseRdv extends StatefulWidget {
  const FormPriseRdv({super.key, required this.uid});

  final String uid;

  @override
  State<FormPriseRdv> createState() => _FormPriseRdvState();
}

class _FormPriseRdvState extends State<FormPriseRdv> {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  //final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    //_emailController.dispose();
    _telephoneController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double maxwidth = MediaQuery.of(context).size.width * .80;

    return SingleChildScrollView(
      child: Center(
        child: Container(
          width: maxwidth * 1.115,
          margin: const EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 3,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 20.0,
          ),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 10.0,
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
                      InputText(
                        labelText: 'Nom',
                        hintText: 'Votre nom',
                        controller: _nomController,
                      ),
                      InputText(
                        labelText: 'Prénom',
                        hintText: 'Vos prénoms',
                        controller: _prenomController,
                      ),
                      /*const InputText(
                        labelText: 'Email',
                        hintText: 'Votre email',
                      ),*/ // à enlevrr car email = user email
                      LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth > 390) {
                            return Row(
                              children: [
                                Expanded(
                                  child: InputPhone(
                                    labelText: 'Téléphone',
                                    hintText: 'Votre téléphone (+228)',
                                    controller: _telephoneController,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                const Expanded(
                                  child: InputDate(
                                    labelText: 'Date',
                                    hintText: 'Votre date',
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Column(
                              children: [
                                InputPhone(
                                  labelText: 'Téléphone',
                                  hintText: 'Votre téléphone',
                                  controller: _telephoneController,
                                ),
                                const SizedBox(height: 20),
                                InputDate(
                                  labelText: 'Date',
                                  hintText: 'Votre date',
                                  maxwidth:
                                      MediaQuery.of(context).size.width * .80,
                                ),
                              ],
                            );
                          }
                        },
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
                    children: const <Widget>[
                      ButtonCancel(),
                      SizedBox(width: 20),
                      ButtonSubmit(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
