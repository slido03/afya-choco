import 'package:afya/src/model/models.dart';
import 'package:flutter/material.dart';
import 'package:afya/src/viewModel/view_models.dart';
import 'dart:async';
import '../components/card_note.dart';

/// la page de l'onglet "Notes" de l'agenda
/// avec en entete des boutons de filtre pour classer les Notes
/// selon les 3 derniers jours, la semaine en cours, le mois en cours
class Notes extends StatefulWidget {
  const Notes({super.key, required this.userId, required this.evenement});
  final String userId;
  final Evenement evenement;

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  NoteViewModel noteViewModel = NoteViewModel();

  @override
  Widget build(BuildContext context) {
    Future<List<Note>> not = noteViewModel.lister(widget.evenement);

    return FutureBuilder(
        future: Future.wait([
          not,
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
              // ignore: avoid_unnecessary_containers
              return Container(
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FilterChip(
                              label: const Text('3 jours'),
                              onSelected: (bool selected) {},
                            ),
                            FilterChip(
                              label: const Text('Semaine'),
                              onSelected: (bool selected) {},
                            ),
                            FilterChip(
                              selected: true,
                              label: const Text('Mois'),
                              onSelected: (bool selected) {},
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 20),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(30),
                            ),
                            color: Color.fromRGBO(37, 211, 102, 0.12),
                          ),
                          child: ListView.builder(
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
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text(
                  'Aucune Note pour le moment',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              );
            }
          }
          //en cas d'erreur quelconque (snapshot.hasError)
          return Center(child: Text('Erreur: ${snapshot.error}'));
        });
  }
}
