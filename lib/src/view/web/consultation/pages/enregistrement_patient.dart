import 'package:flutter/material.dart';

class EnregistrementPatient extends StatefulWidget {
  const EnregistrementPatient({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EnregistrementPatientState createState() => _EnregistrementPatientState();
}

class _EnregistrementPatientState extends State<EnregistrementPatient> {
  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController adresseController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController telephoneController = TextEditingController();
  final TextEditingController naissanceController = TextEditingController();
  final TextEditingController sexeController = TextEditingController();
  List<String> sexes = ['Masculin', 'Féminin'];
  String choix = '';

  @override
  Widget build(BuildContext context) {

    final formKey = GlobalKey<FormState>();
    return Material(
      color: const Color.fromRGBO(37, 211, 102, 0.4),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(50.0),
              child: Center(
                child: Text('Enregistrement d\'un nouveau patient', style: TextStyle(fontSize: 25),)
                ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: TextFormField(
                        controller: idController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                          labelText: 'Identifiant du rendez-vous',
                          hintText:
                              'Veuillez saisir l\'identifiant du rendez-vous',
                        ),
                      ),
                    ),
                  ),
                ),
                // const SizedBox(
                //   width: 50,
                // ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                      'NB : Le saisir que si le patient a fait une demande en ligne'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: TextFormField(
                        controller: nomController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                          labelText: 'Nom',
                          hintText: 'Votre nom',
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: TextFormField(
                        controller: prenomController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                          labelText: 'Prenoms',
                          hintText: 'Vos prenoms',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
      
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
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
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: TextFormField(
                        controller: adresseController,
                        decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 15.0),
                          labelText: 'Adresse',
                          hintText: 'Votre adresse',
                        ),
                      ),
                    ),
                  ),
                ),
              
              ],
            ),
      
             Row(
               children: [
                 Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: TextFormField(
                        controller: telephoneController,
                        decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 15.0),
                          labelText: 'Telephone',
                          hintText: 'Votre numero de telephone',
                        ),
                      ),
                    ),
                      ),
                    ),
      
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
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
            ),
      
              Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
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
            ),
               ],
             ),
      
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.red,
                        minimumSize: const Size(200, 60),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: null,
                    child: const Text(
                      'Annuler',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.green,
                        minimumSize: const Size(200, 60),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: null,
                    child: const Text(
                      'Enregistrer',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      
                    ),
                  ),
                ],
              ),
            )
       
          ],
        ),
      ),
    );
  }
}

     //  Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: Card(
            //     child: DropdownButtonFormField<String>(
            //       value: choix,
            //       items: sexes.map((value){
            //         return DropdownMenuItem<String>(
            //           value: value,
            //           child: Text(value),
            //           );
            //       }).toList(),
      
            //       onChanged: (newValue){
            //         setState(() {
            //           choix = newValue!;
            //         });
            //       },
            //     ),
            //   ),
            // ),