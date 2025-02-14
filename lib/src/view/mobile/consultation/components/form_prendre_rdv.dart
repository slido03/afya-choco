import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:afya/src/viewModel/message_view_model.dart';
import 'package:afya/src/model/models.dart';
import 'package:afya/src/view/mobile/authentication/login.dart';
import 'package:afya/src/view/mobile/consultation/components/input_text.dart';
import 'package:afya/src/view/mobile/consultation/components/input_date.dart';
import 'package:afya/src/view/mobile/consultation/components/input_text_area.dart';
import 'package:afya/src/view/mobile/consultation/components/input_phone.dart';
import 'package:afya/src/view/mobile/consultation/components/button_cancel.dart';
import 'package:afya/src/view/mobile/home_page.dart';

class FormPrendreRdv extends StatefulWidget {
  const FormPrendreRdv({super.key, required this.userId, required this.email});

  final String? userId;
  final String? email;

  @override
  State<FormPrendreRdv> createState() => _FormPrendreRdvState();
}

class _FormPrendreRdvState extends State<FormPrendreRdv> {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final MessageViewModel messageViewModel = MessageViewModel();
  String get date => _dateController.text;
  String get message => _messageController.text;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _dateController.dispose();
    _telephoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double maxwidth = MediaQuery.of(context).size.width * .80;

    if (widget.userId != null) {
      Future<Patient?> p = messageViewModel.trouverPatientUid(widget.userId!);
      Future<PatientIntermediaire?> patientI =
          messageViewModel.trouverPatientIntermediaireUid(widget.userId!);
      return FutureBuilder(
        future: Future.wait([
          p,
          patientI,
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            ));
          } else if (snapshot.hasData) {
            final List<Patient?> data = snapshot.data!;
            final patient = data[0];
            final patientIntermediaire = data[1];
            //si les deux objets renvoyés sont nuls
            if ((patient == null) && (patientIntermediaire == null)) {
              //alors l'utilisateur n'est ni un patient, ni un patient intermédiaire
              //on lui affiche le formulaire suivant
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
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
                                  labelText: 'Prénoms',
                                  hintText: 'Vos prénoms',
                                  controller: _prenomController,
                                ),
                                LayoutBuilder(
                                  builder: (context, constraints) {
                                    if (constraints.maxWidth > 390) {
                                      return Row(
                                        children: [
                                          Expanded(
                                            child: InputPhone(
                                              labelText: 'Téléphone',
                                              hintText:
                                                  'Votre téléphone (+228)',
                                              controller: _telephoneController,
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          Expanded(
                                            child: InputDate(
                                              labelText: 'Date',
                                              hintText: 'Votre date',
                                              controller: _dateController,
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
                                            controller: _dateController,
                                            maxwidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .80,
                                          ),
                                        ],
                                      );
                                    }
                                  },
                                ),
                                InputTextArea(
                                  labelText: 'Message',
                                  hintText: 'Votre message',
                                  controller: _messageController,
                                ),
                              ],
                            ),
                          ),
                          // Submit and cancel buttons
                          Container(
                            width: maxwidth,
                            margin: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                const ButtonCancel(),
                                const SizedBox(width: 20),
                                //submit button
                                _isLoading
                                    ? const CircularProgressIndicator()
                                    : OutlinedButton(
                                        onPressed: () async {
                                          await _sendPatientAndMessage(
                                            widget.userId!,
                                            messageViewModel,
                                          );
                                          // ignore: use_build_context_synchronously
                                          await _messageSentDialog(context);
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
                ),
              );
            } else if ((patient != null) || (patientIntermediaire != null)) {
              //si l'un des deux objets est non nul
              return SingleChildScrollView(
                child: Center(
                  child: Container(
                    width: maxwidth * 1.115,
                    margin: const EdgeInsets.symmetric(
                      vertical: 30.0,
                      horizontal: 3,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                    ),
                    child: Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 25.0,
                              horizontal: 10.0,
                            ),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 231, 248, 232),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
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
                                InputDate(
                                  labelText: 'Date',
                                  hintText: 'Votre date',
                                  controller: _dateController,
                                  maxwidth:
                                      MediaQuery.of(context).size.width * .80,
                                ),
                                InputTextArea(
                                  labelText: 'Message',
                                  hintText: 'Votre message',
                                  controller: _messageController,
                                ),
                              ],
                            ),
                          ),
                          // Submit and cancel buttons
                          Container(
                            width: maxwidth,
                            margin: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                const ButtonCancel(),
                                const SizedBox(width: 20),
                                //submit button
                                _isLoading
                                    ? const CircularProgressIndicator()
                                    : OutlinedButton(
                                        onPressed: () async {
                                          //on vérifie d'abord si le patient existe
                                          if (patient != null) {
                                            await _sendMessage(
                                              patient,
                                              messageViewModel,
                                            );
                                            // ignore: use_build_context_synchronously
                                            await _messageSentDialog(context);
                                            //au cas contraire on envoie le message au nom du patient intermédiaire
                                          } else if (patientIntermediaire !=
                                              null) {
                                            await _sendMessage(
                                              patientIntermediaire,
                                              messageViewModel,
                                            );
                                            // ignore: use_build_context_synchronously
                                            await _messageSentDialog(context);
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
                ),
              );
            }
          } else if (snapshot.hasError) {
            //en cas d'erreur quelconque (snapshot.hasError)
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }
          return const Center(
              child: Text('La récupération de données a échoué'));
        },
      );
    } else {
      //si l'userId est nul c'est que l'utilisateur est déconnecté et donc on le ramène à la page de login
      return const LoginPage();
    }
  }

  Future<void> _sendMessage(
    Patient patient,
    MessageViewModel messageViewModel,
  ) async {
    final form = _formKey.currentState;
    if (form!.validate()) {
      setState(() {
        _isLoading = true;
      });
      form.save();
      //si les champs sont non vides on procède à l'envoie
      if ((date.isNotEmpty) && (message.isNotEmpty)) {
        if (kDebugMode) {
          print('date et message non nuls');
        }
        try {
          Secretaire? secretaire =
              await messageViewModel.getSecretariatCentral();
          //puis on envoie le message de prise de rendez-vous
          Future.microtask(() => messageViewModel.envoyer(Message(
                patient,
                secretaire!,
                DateTime.now(),
                ObjetMessage.prendreRendezVous,
                '$date||$message',
                StatutMessage.nonTraite,
              )));
          if (kDebugMode) {
            print('message sent');
          }
        } catch (e) {
          setState(() {
            _isLoading = false;
          });
          if (kDebugMode) {
            print(e.toString());
          }
        }
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _sendPatientAndMessage(
      String uid, MessageViewModel messageViewModel) async {
    //si tous les champs de saisie sont non vides on procède à l'envoie
    if (_nomController.text.isNotEmpty &&
        _prenomController.text.isNotEmpty &&
        _telephoneController.text.isNotEmpty) {
      if (kDebugMode) {
        print('nom, prenoms, telephone non nuls');
      }
      try {
        //on persiste le nouveau patient intermédiaire
        PatientIntermediaire patient =
            await messageViewModel.ajouter(PatientIntermediaire(
          uid,
          null,
          _nomController.text,
          _prenomController.text,
          _telephoneController.text,
          widget.email!,
          null,
          null,
          null,
          null,
        ));
        if (kDebugMode) {
          print('patient intermediaire ajouté');
        }
        // ignore: use_build_context_synchronously
        await _sendMessage(patient, messageViewModel);
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
    }
  }

  void _navigateToHome(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (context) => const HomePage(title: 'HomePage')),
    );
  }

  Future<void> _messageSentDialog(BuildContext context) async {
    //pushed permet de savoir si l'utilisateur a bien cliqué sur le bouton OK
    final pushed = await showDialog<bool?>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Confirmation d'envoie"),
              content: const Text(
                  "Votre demande a bien été envoyée. \nLa clinique vous fera un retour dans les bref délais."),
              actions: [
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    _navigateToHome(context);
                  },
                ),
              ],
            );
          },
        ) ??
        false;
    //si l'utilisateur n'a pas cliquer sur OK on le redirige quand même à la HomePage
    if (!pushed) {
      // ignore: use_build_context_synchronously
      _navigateToHome(context);
    }
  }
}
