import 'package:flutter/material.dart';

import 'separator.dart';

/*
  * utilisé pour la selection du rendez-vous que l'on veut changer
*/

class SelectRdv extends StatefulWidget {
  const SelectRdv(
      {super.key,
      this.title = 'Selectionner un rendez-vous',
      required this.rdvs,
      required this.maxwidth});

  final String title;
  final List<Map<String, dynamic>> rdvs;
  final double maxwidth;

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
    //liste de 0 à wifget.rdvs!.length
    options = List<String>.generate(
        widget.rdvs.length, (int index) => index.toString());
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
        value: selectedOption.toString(),
        items: options.map<DropdownMenuItem<String>>((String option) {
          return DropdownMenuItem<String>(
              value: option,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text:
                          'RDV du ${widget.rdvs[int.parse(option)]['date']}, ', // la vrai date est dans la base de donnée et doit être formaté : 01,Jan
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              'avec ${widget.rdvs[int.parse(option)]['medecin']}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
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
