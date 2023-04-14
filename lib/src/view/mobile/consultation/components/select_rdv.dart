import 'package:flutter/material.dart';
import 'package:afya/src/model/models.dart';
import 'separator.dart';

/*
  * utilisé pour la selection du rendez-vous que l'on veut changer
*/

class SelectRdv extends StatefulWidget {
  const SelectRdv(
      {super.key,
      this.title = 'Selectionner un rendez-vous',
      required this.rdvs,
      required this.selectedController,
      required this.maxwidth});

  final String title;
  final List<RendezVous> rdvs;
  final double maxwidth;
  final TextEditingController selectedController;

  @override
  State<SelectRdv> createState() => _SelectRdvState();
}

class _SelectRdvState extends State<SelectRdv> {
  late int selectedOption;
  late List<String> options;

  @override
  initState() {
    super.initState();
    selectedOption = 0;
    //liste de 0 à wdget.rdvs!.length
    options = List<String>.generate(
        widget.rdvs.length, (int index) => index.toString());
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
        value: selectedOption.toString(),
        menuMaxHeight: 250,
        items: options.map<DropdownMenuItem<String>>((String option) {
          return DropdownMenuItem<String>(
              value: option,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text:
                          '${widget.rdvs[int.parse(option)].dateHeure.jourMois}, Dr', // la vrai date est dans la base de donnée et doit être formaté : 01 Jan
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: widget.rdvs[int.parse(option)].medecin.nom,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  separator(),
                ],
              ));
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            selectedOption = int.parse(newValue!);
            widget.selectedController.text = newValue;
          });
        },
        hint: const Text('Selectionner un rendez-vous'),
        decoration: InputDecoration(
          labelText: 'Rendez-vous',
          border: const OutlineInputBorder(),
          constraints: BoxConstraints(
            maxWidth: widget.maxwidth,
            minHeight: 100,
          ),
        ));
  }
}

extension DateFormat on DateTime {
  String get jourMois {
    String? jour;
    String? mois;
    if (day < 10) {
      String j = '0$day';
      jour = '$j ';
    }
    jour = '$day ';
    switch (month) {
      case 1:
        mois = 'Jan';
        break;
      case 2:
        mois = 'Fev';
        break;
      case 3:
        mois = 'Mar';
        break;
      case 4:
        mois = 'Avr';
        break;
      case 5:
        mois = 'Mai';
        break;
      case 6:
        mois = 'Juin';
        break;
      case 7:
        mois = 'Jul';
        break;
      case 8:
        mois = 'Aôut';
        break;
      case 9:
        mois = 'Sep';
        break;
      case 10:
        mois = 'Oct';
        break;
      case 11:
        mois = 'Nov';
        break;
      case 12:
        mois = 'Dec';
        break;
    }
    return '$jour$mois';
  }
}
