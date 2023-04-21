import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:afya/src/view/mobile/consultation/components/components.dart';
import 'package:afya/src/model/models.dart';
import 'package:afya/src/viewModel/rendez_vous_view_model.dart';
import 'package:afya/src/viewModel/message_view_model.dart';
import 'package:afya/src/view/mobile/home_page.dart';

class ChangerRdv extends StatefulWidget {
  const ChangerRdv({
    super.key,
    required this.rdvs,
    required this.patient,
    required this.isGoodRdv,
  });
  final Future<List<RendezVous>> rdvs;
  final Patient patient;
  final bool isGoodRdv;
  @override
  State<ChangerRdv> createState() => _ChangerRdvState();
}

class _ChangerRdvState extends State<ChangerRdv> {
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
  }

  @override
  void dispose() {
    _messageController.dispose();
    _selectedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: Future.wait([widget.rdvs]),
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
                      visible: !widget.isGoodRdv,
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
                                    if (selected != null) {
                                      await _sendMessage(
                                          widget.patient, rdvs[selected!]);
                                      // ignore: use_build_context_synchronously
                                      await _messageSentDialog(
                                          context); //problem
                                    }
                                    if (kDebugMode) {
                                      print('selected null');
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
            );
          }
          //en cas d'erreur quelconque (snapshot.hasError)
          return Center(child: Text('Erreur: ${snapshot.error.toString()}'));
        });
  }

  Future<void> _sendMessage(
    Patient patient,
    RendezVous rdv,
  ) async {
    final form = _formKey.currentState;
    if (form!.validate()) {
      setState(() {
        _isLoading = true;
      });
      form.save();
      //si les champs sont non vides on procède à l'enregistrement du message
      if (message.isNotEmpty) {
        if (kDebugMode) {
          print('message non vide');
        }
        try {
          MessageViewModel messageViewModel = MessageViewModel();
          Secretaire? secretaire =
              await messageViewModel.getSecretariatCentral();
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
      if (kDebugMode) {
        print('message vide !!!!!!!');
      }
      setState(() {
        _isLoading = false;
      });
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
                    _returnToHome(context);
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
      _returnToHome(context);
    }
  }

  void _returnToHome(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (context) => const HomePage(title: 'HomePage')),
    );
  }
}
