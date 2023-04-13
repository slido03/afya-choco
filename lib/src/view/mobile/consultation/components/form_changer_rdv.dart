import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:afya/src/view/mobile/consultation/components/components.dart';
import 'package:afya/src/model/models.dart';
import 'package:afya/src/viewModel/rendez_vous_view_model.dart';
import 'package:afya/src/viewModel/message_view_model.dart';
import 'package:afya/src/view/mobile/home_page.dart';
import 'package:afya/src/view/mobile/authentication/login.dart';

/*
 * This is a form that is used to change a rendez-vous. the last one for préférence.
 */
class FormChangerRdv extends StatefulWidget {
  const FormChangerRdv({super.key, required this.userId});

  final String? userId;

  @override
  State<FormChangerRdv> createState() => _FormChangerRdvState();
}

class _FormChangerRdvState extends State<FormChangerRdv> {
  late bool _isGoodRdv;
  late bool _dialogPushed;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _selectedController = TextEditingController();
  RendezVousViewModel rendezVousViewModel = RendezVousViewModel();

  String get message => _messageController.text;
  int? get selected => int.tryParse(_selectedController.text);

  @override
  initState() {
    super.initState();
    _isGoodRdv = true;
    _dialogPushed = false;
  }

  Future<void> _showRdvDialog(BuildContext context, Patient? patient) async {
    RendezVous? rendezVous;
    final Widget dialog;

    if (patient != null) {
      rendezVous = await rendezVousViewModel.getLastForPatient(patient.uid);
      //si le patient a au moins un rendez-vous à venir (dans le future par rapport au jour d'hui)
      if (rendezVous != null) {
        dialog = RdvDialog(rdv: rendezVous);
      } else {
        //au cas contraire
        dialog = AlertDialog(
          title: const Text("Aucun rendez-vous à venir"),
          content: const Text(
              "Désolé vous n'avez aucun rendez-vous à venir pour le moment."),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.pop(context);
                _navigateToHome(context);
              },
            ),
          ],
        );
      }
    } else {
      dialog = AlertDialog(
        title: const Text("Aucun rendez-vous pris"),
        content: const Text(
            "Désolé vous n'avez aucun rendez-vous à changer pour le moment."),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.pop(context);
              _navigateToHome(context);
            },
          ),
        ],
      );
    }
    // ignore: use_build_context_synchronously
    final isGoodRdv_ = await showDialog<bool?>(
          context: context,
          builder: (BuildContext context) {
            return dialog;
          },
        ) ??
        false;

    //si le patient est nul ou il est non nul et n'a aucun rendez-vous en attente
    //et de plus il a appuyé hors de la zone du dialog on le ramène à la HomePage
    if (((patient == null) || (rendezVous == null)) && (isGoodRdv_ == false)) {
      // ignore: use_build_context_synchronously
      _navigateToHome(context);
    }

    setState(() {
      _isGoodRdv = isGoodRdv_;
      _dialogPushed = true;
      if (kDebugMode) {
        print('isGoodRdv_ = $_isGoodRdv');
      }
    });
  }

  void _navigateToHome(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (context) => const HomePage(title: 'HomePage')),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.userId != null) {
      Future<Patient?> p =
          rendezVousViewModel.trouverPatientUid(widget.userId!);
      Future<PatientIntermediaire?> patientI =
          rendezVousViewModel.trouverPatientIntermediaireUid(widget.userId!);
      Future<List<RendezVous>> liste =
          rendezVousViewModel.listerEnAttentePatient(widget.userId!);
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
            if (patient != null) {
              if (_dialogPushed) {
                return _changerRdv(context, liste, patient);
              }
              return _formChanger(context, liste, patient);
            } else if (patientIntermediaire != null) {
              if (_dialogPushed) {
                return _changerRdv(context, liste, patientIntermediaire);
              }
              return _formChanger(context, liste, patientIntermediaire);
            } else {
              //patient et patient intermédiaire nuls
              _showRdvDialog(context, null);
            }
          } else if (snapshot.hasError) {
            //en cas d'erreur quelconque (snapshot.hasError)
            return Center(child: Text('Erreur: ${snapshot.error.toString()}'));
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

  Widget _formChanger(
      BuildContext context, Future<List<RendezVous>> rdvs, Patient patient) {
    _showRdvDialog(context, patient);
    return _changerRdv(context, rdvs, patient);
  }

  Widget _changerRdv(
      BuildContext context, Future<List<RendezVous>> rdvs, Patient patient) {
    var size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: Future.wait([rdvs]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            ));
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            final rdvs = data[0];
            return Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Visibility(
                      visible: !_isGoodRdv,
                      child: SelectRdv(
                        rdvs: rdvs,
                        selectedController: _selectedController,
                        maxwidth: size.width * 0.95,
                      ),
                    ),
                    InputTextArea(
                      labelText: "message",
                      hintText: "quel est le motif de ce changement ?",
                      controller: _messageController,
                      maxwidth: size.width * 0.95,
                    ),
                    Container(
                      width: size.width * 0.95,
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
                                    await _sendMessage(patient, rdvs);
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
            );
          }
          //en cas d'erreur quelconque (snapshot.hasError)
          return Center(child: Text('Erreur: ${snapshot.error.toString()}'));
        });
  }

  Future<void> _sendMessage(
    Patient patient,
    List<RendezVous> rdvs,
  ) async {
    final form = _formKey.currentState;
    if (form!.validate()) {
      setState(() {
        _isLoading = true;
      });
      form.save();
      //si les champs sont non vides on procède à l'enregistrement du message
      if ((message.isNotEmpty) && (selected != null)) {
        if (kDebugMode) {
          print('message et sélection de rendez-vous non nuls');
        }
        try {
          MessageViewModel messageViewModel = MessageViewModel();
          Secretaire? secretaire =
              await messageViewModel.getSecretariatCentral();
          RendezVous rdv = rdvs[selected!];
          //puis on envoie le message de prise de rendez-vous
          Future.microtask(() => messageViewModel.envoyer(Message(
                patient,
                secretaire!,
                DateTime.now(),
                ObjetMessage.modifierRendezVous,
                '${rdv.dateHeure.millisecondsSinceEpoch}||${patient.identifiant}||${rdv.medecin.identifiant}||$message',
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
    }
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
