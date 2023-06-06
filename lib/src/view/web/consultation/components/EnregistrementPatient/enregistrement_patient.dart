import 'package:afya/src/view/web/consultation/components/EnregistrementPatient/saisie_adresse.dart';
import 'package:afya/src/view/web/consultation/components/EnregistrementPatient/saisie_date.dart';
import 'package:afya/src/view/web/consultation/components/EnregistrementPatient/saisie_email.dart';
import 'package:afya/src/view/web/consultation/components/EnregistrementPatient/saisie_nom.dart';
import 'package:afya/src/view/web/consultation/components/EnregistrementPatient/saisie_numero.dart';
import 'package:afya/src/view/web/consultation/components/EnregistrementPatient/saisie_prenoms.dart';
import 'package:afya/src/view/web/consultation/components/EnregistrementPatient/saisie_sexe.dart';
import 'package:flutter/material.dart';
import 'package:afya/src/model/models.dart';

import 'button_annuler.dart';
import 'button_enregistrer.dart';

class EnregistrementPatient extends StatefulWidget {
  const EnregistrementPatient({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EnregistrementPatientState createState() => _EnregistrementPatientState();
}

class _EnregistrementPatientState extends State<EnregistrementPatient> {
  final TextEditingController sexeController = TextEditingController();
  String _selectedGender = Sexe.femme.value;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Material(
        child: Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 30.0),
          child: Center(
            child: Text(
              'Enregistrement d\'un nouveau patient',
              style: TextStyle(fontSize: 25),
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
            padding: const EdgeInsets.all(40),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(37, 211, 102, 0.4),
            ),
            child: Center(
              child: Form(
                key: formKey,
                child: const Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SaisieNom(),
                      SaisiePrenom(),
                    ],
                  ),
                  Row(
                    children: [
                      SaisieEmail(),
                      SaisieAdresse(),
                    ],
                  ),
                  Row(
                    children: [
                      const SaisieNumero(),
                      const SaisieDate(),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SelectionItem(
                          valueChoose: _selectedGender,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedGender = newValue!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ButtonAnnuler(),
                        SizedBox(
                          width: 50,
                        ),
                        ButtonEnregistrer(),
                      ],
                    ),
                  )
                ]),
              ),
            ))
      ],
    ));
  }
}
