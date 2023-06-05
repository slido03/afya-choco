import 'package:flutter/material.dart';

import 'date_rdv.dart';
import 'drop_down_button.dart';
import 'duree_rdv.dart';
import 'heure_rdv.dart';

class CreationRdv extends StatefulWidget {
  const CreationRdv({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CreationRdvState createState() => _CreationRdvState();
}


class _CreationRdvState extends State<CreationRdv> {
  @override
  Widget build(BuildContext context) {

    final TextEditingController dateController = TextEditingController();
    final TextEditingController medecinController = TextEditingController();
    final TextEditingController patientController = TextEditingController();
    final TextEditingController objetController = TextEditingController();
    final TextEditingController lieuController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    List <String> listePatient = ['KOKOU', 'KOFI','KOSSIGAN'];
    List <String> listeMedecin = ['KOKOUO', 'KOFIGO','KOSSIGANTOR'];
    List <String> listeObjet = ['Consultation', 'Examens','Analyses'];
     String labelTextPatient  = 'Liste des patients';
     String labelTextMedecin  = 'Liste des medecins';
     String labelTextObjet  = 'Liste des objets';

    @override
    void initState() {
      super.initState();
    }

    return Material(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(28.0),
            child: Center(
              child: Text(
                'Creation de rendez-vous',
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            padding: const EdgeInsets.all(40),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(37, 211, 102, 0.4),
            ),
            child: Center(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const Row(
                      children: [
                       DateRdv(),
                        SizedBox(
                          width: 20,
                        ),
                       HeureRdv(),
                        SizedBox(
                          width: 20,
                        ),
                       DureeRdv(),
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    const Divider(
                      color: Color.fromRGBO(97, 89, 89, 0.72),
                      thickness: 1.5,
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                            ),
                            child: DropdownCard(options : listeMedecin, defaultValue: listeMedecin[0], labelText: labelTextMedecin,),
                           
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                         Expanded(
                          child: Card(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                            ),
                            child: DropdownCard(options : listePatient, defaultValue: listePatient[0], labelText: labelTextPatient,),
                           
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 29,
                    ),
                    Row(
                      children: [
                         Expanded(
                          child: Card(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                            ),
                            child: DropdownCard(options : listeObjet, defaultValue: listeObjet[0], labelText: labelTextObjet,),
                            
                          ),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        Expanded(
                          child: Card(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                            ),
                            child: TextFormField(
                              controller: lieuController,
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10.0),
                                hintText: 'Hopital',
                                labelText: 'Lieu',
                              ),
                            ),
                          ),
                        ),
                       
                      ],
                    ),
                    const SizedBox(
                      height: 29,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: null,
                            child: const Text(
                              'Annuler',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            )),
                        const SizedBox(
                          width: 30,
                        ),
                        OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: null,
                            child: const Text(
                              'Enregistrer',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
