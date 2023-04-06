import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
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
  const FormChangerRdv({super.key, required this.user});

  final User? user;

  @override
  State<FormChangerRdv> createState() => _FormChangerRdvState();
}

class _FormChangerRdvState extends State<FormChangerRdv> {
  late bool _isGoodRdv;
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _selectedController = TextEditingController();
  String get message => _messageController.text;
  int? get selected => int.tryParse(_selectedController.text);

  @override
  initState() {
    super.initState();
    // _isGoodRdv = true;
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   showRdvDialog(context);
    // });
  }

  Future<void> _showRdvDialog(BuildContext context, Patient? patient) async {
    RendezVousViewModel rendezVousViewModel = RendezVousViewModel();
    RendezVous? rendezVous;
    final Widget dialog;

    if (patient != null) {
      rendezVous = await rendezVousViewModel.getLastForPatient(patient.uid);
      dialog = RdvDialog(rdv: rendezVous);
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

    setState(() {
      _isGoodRdv = isGoodRdv_;
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
    return Consumer<RendezVousViewModel>(
      builder: (context, rendezVousViewModel, child) {
        if (widget.user != null) {
          String? uid = widget.user!.uid;
          Future<Patient?> patient = rendezVousViewModel.trouverPatientUid(uid);
          Future<PatientIntermediaire?> patientIntermediaire =
              rendezVousViewModel.trouverPatientIntermediaireUid(uid);
          Future<List<RendezVous>> liste =
              rendezVousViewModel.listerEnAttentePatient(uid);
          return FutureBuilder(
            future: Future.wait([
              patient,
              patientIntermediaire,
              liste,
            ]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                ));
              } else if (snapshot.hasData) {
                final List<Object?> data = snapshot.data!;
                final patient = data[0] as Patient?;
                final patientIntermediaire = data[1] as PatientIntermediaire?;
                //cette liste est soit vide, en fonction du patient ou en fonction du patient intermédiaire
                final listeRendezVous = data[2] as List<RendezVous>;
                if (patient != null) {
                  _isGoodRdv = true;
                  _showRdvDialog(context, patient);
                  return _changerRdv(context, listeRendezVous, patient);
                } else if (patientIntermediaire != null) {
                  _isGoodRdv = true;
                  _showRdvDialog(context, patientIntermediaire);
                  return _changerRdv(
                      context, listeRendezVous, patientIntermediaire);
                } else {
                  //patient et patient intermédiaire nuls
                  _isGoodRdv = true;
                  _showRdvDialog(context, null);
                }
              }
              //en cas d'erreur quelconque (snapshot.hasError)
              return Center(child: Text('Erreur: ${snapshot.error}'));
            },
          );
        } else {
          //si l'user est nul c'est que l'utilisateur est déconnecté et donc on le ramène à la page de login
          return const LoginPage();
        }
      },
    );
  }

  Widget _changerRdv(
      BuildContext context, List<RendezVous> rdvs, Patient patient) {
    var size = MediaQuery.of(context).size;
    return Center(
      child: Form(
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
              margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  const ButtonCancel(),
                  const SizedBox(width: 20),
                  //submit button
                  OutlinedButton(
                      onPressed: () async {
                        await _sendMessage(patient, rdvs);
                        // ignore: use_build_context_synchronously
                        _messageSentDialog(context);
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

  Future<void> _sendMessage(
    Patient patient,
    List<RendezVous> rdvs,
  ) async {
    //si les champs sont non vides on procède à l'enregistrement du message
    if ((message.isNotEmpty) && (selected != null)) {
      if (kDebugMode) {
        print('message et sélection de rendez-vous non nuls');
      }
      try {
        MessageViewModel messageViewModel = MessageViewModel();
        Secretaire? secretaire = await messageViewModel.getSecretariatCentral();
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
        if (kDebugMode) {
          print(e.toString());
        }
      }
    }
  }

  void _messageSentDialog(BuildContext context) {
    showDialog(
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
                Navigator.pop(context);
                _navigateToHome(context);
              },
            ),
          ],
        );
      },
    );
  }
}
