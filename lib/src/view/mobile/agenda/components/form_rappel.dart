import 'package:afya/src/view/mobile/agenda/agenda_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:afya/src/model/models.dart';
import 'package:afya/src/viewModel/view_models.dart';
import 'package:afya/src/view/mobile/consultation/components/input_text.dart';
import 'package:afya/src/view/mobile/consultation/components/input_text_area.dart';
import 'package:afya/src/view/mobile/consultation/components/button_cancel.dart';
import 'package:afya/src/view/mobile/agenda/components/input_date.dart';
import 'package:afya/src/view/mobile/agenda/components/input_time.dart';

class FormRappel extends StatefulWidget {
  const FormRappel(
      {super.key, required this.evenement, this.title = 'Créer un rappel'});
  final Evenement evenement;
  final String title;

  @override
  State<FormRappel> createState() => _FormRappelState();
}

class _FormRappelState extends State<FormRappel> {
  final TextEditingController _titreController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final RappelViewModel rappelViewModel = RappelViewModel();
  String get titre => _titreController.text;
  String get description => _descriptionController.text;
  DateTime get date => parseDate(_dateController.text);
  TimeOfDay get time => parseTime(_timeController.text);

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _titreController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double maxwidth = MediaQuery.of(context).size.width * .80;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
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
                          InputDate(
                            labelText: 'Date',
                            hintText: 'Date du rappel',
                            controller: _dateController,
                            initialDate: widget.evenement.rendezVous.dateHeure,
                            maxwidth: maxwidth,
                          ),
                          InputTime(
                            labelText: 'Heure',
                            hintText: 'Heure du rappel',
                            controller: _timeController,
                            initialTime: TimeOfDay.fromDateTime(
                                widget.evenement.rendezVous.dateHeure),
                            maxwidth: maxwidth,
                          ),
                          InputText(
                            labelText: 'Titre',
                            hintText: 'Titre du rappel',
                            controller: _titreController,
                          ),
                          InputTextArea(
                            labelText: 'Description',
                            hintText: 'Description du rappel (optionnel)',
                            controller: _descriptionController,
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
                                    await _addRappel(rappelViewModel);
                                    // ignore: use_build_context_synchronously
                                    await _rappelAddedDialog(context);
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
        ));
  }

  Future<void> _addRappel(RappelViewModel rappelViewModel) async {
    final form = _formKey.currentState;
    if (form!.validate()) {
      setState(() {
        _isLoading = true;
      });
      form.save();
      //si les champs sont non vides on procède à l'ajout
      if ((titre.isNotEmpty) &&
          (_dateController.text.isNotEmpty) &&
          (_timeController.text.isNotEmpty)) {
        if (kDebugMode) {
          print('titre, date, time non nuls');
        }
        try {
          //puis on ajoute le rappel
          Future.microtask(() => rappelViewModel.ajouter(Rappel(
                titre,
                description,
                DateTime(
                  date.year,
                  date.month,
                  date.day,
                  time.hour,
                  time.minute,
                ),
                widget.evenement,
              )));
          if (kDebugMode) {
            print('rappel added');
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

  Future<void> _rappelAddedDialog(BuildContext context) async {
    //pushed permet de savoir si l'utilisateur a bien cliqué sur le bouton OK
    final pushed = await showDialog<bool?>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Rappel"),
              content: const Text(
                  "Le rappel a été ajouté à votre agenda avec succès."),
              actions: [
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    _navigateToAgenda(context);
                  },
                ),
              ],
            );
          },
        ) ??
        false;
    //si l'utilisateur n'a pas cliquer sur OK on le redirige quand même à la page agenda
    if (!pushed) {
      // ignore: use_build_context_synchronously
      _navigateToAgenda(context);
    }
  }

  void _navigateToAgenda(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const AgendaScreen()),
    );
  }

  DateTime parseDate(String inputString) {
    final format = DateFormat('dd/MM/yyyy');
    return format.parse(inputString);
  }

  TimeOfDay parseTime(String inputString) {
    final format = DateFormat('HH:mm');
    return TimeOfDay.fromDateTime(format.parse(inputString));
  }
}
