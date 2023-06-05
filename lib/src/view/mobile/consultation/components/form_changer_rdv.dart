import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:afya/src/view/mobile/consultation/components/components.dart';
import 'package:afya/src/model/models.dart';
import 'package:afya/src/viewModel/rendez_vous_view_model.dart';
//import 'package:afya/src/view/mobile/home_page.dart';
import 'package:afya/src/view/mobile/authentication/login.dart';
import 'changer_rdv.dart';

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
  RendezVousViewModel rendezVousViewModel = RendezVousViewModel();

  @override
  initState() {
    super.initState();
    _isGoodRdv = true;
    _dialogPushed = false;
  }

  @override
  void dispose() {
    super.dispose();
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
                _returnToHome(context);
              },
            ),
          ],
        );
      }
    } else {
      //if patient == null
      dialog = AlertDialog(
        title: const Text("Aucun rendez-vous pris"),
        content: const Text(
            "Désolé vous n'avez aucun rendez-vous à changer pour le moment."),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.pop(context);
              _returnToHome(context);
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
    if ((rendezVous == null) && (isGoodRdv_ == false)) {
      // ignore: use_build_context_synchronously
      _returnToHome(context);
    }

    setState(() {
      _isGoodRdv = isGoodRdv_;
      _dialogPushed = true;
      if (kDebugMode) {
        print('isGoodRdv_ = $_isGoodRdv');
      }
    });
  }

  void _returnToHome(BuildContext context) {
    Navigator.pop(context);
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
                return ChangerRdv(
                  rdvs: liste,
                  patient: patient,
                  isGoodRdv: _isGoodRdv,
                );
              }
              return _formChanger(context, liste, patient);
            } else if (patientIntermediaire != null) {
              if (_dialogPushed) {
                return ChangerRdv(
                  rdvs: liste,
                  patient: patientIntermediaire,
                  isGoodRdv: _isGoodRdv,
                );
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
            child: Text(
              'Aucune donnée disponible',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
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
    return ChangerRdv(rdvs: rdvs, patient: patient, isGoodRdv: _isGoodRdv);
  }
}
