import 'package:afya/src/model/models.dart';
import 'package:flutter/material.dart';
import 'package:afya/src/viewModel/view_models.dart';
import 'dart:async';
import '../components/card_note.dart';

/// la page de l'onglet "Notes" de l'agenda
/// avec en entete des boutons de filtre pour classer les Notes
/// selon les 3 derniers jours, la semaine en cours, le mois en cours
class Notes extends StatefulWidget {
  const Notes({
    super.key,
    required this.userId,
    required this.evenement,
    this.title = 'Liste des notes',
  });
  final String userId;
  final Evenement evenement;
  final String title;

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  NoteViewModel noteViewModel = NoteViewModel();

  @override
  Widget build(BuildContext context) {
    Future<List<Note>> note = noteViewModel.lister(widget.evenement);

    return FutureBuilder(
        future: Future.wait([
          note,
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            ));
          } else if (snapshot.hasData) {
            final List<List<Note>> data = snapshot.data!;
            final notes = data[0];
            if (notes.isNotEmpty) {
              return Scaffold(
                  appBar: AppBar(
                    title: Text(widget.title),
                  ),
                  body: Column(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 20,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(30),
                            ),
                            color: Colors.grey[100],
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: notes.length,
                            itemBuilder: (context, index) {
                              return CardNote(
                                note: notes[index],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ));
            } else {
              return Scaffold(
                  appBar: AppBar(
                    title: Text(widget.title),
                  ),
                  body: const Center(
                    child: Text(
                      'Aucune note pour le moment',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ));
            }
          }
          //en cas d'erreur quelconque (snapshot.hasError)
          return Center(child: Text('Erreur: ${snapshot.error}'));
        });
  }
}
