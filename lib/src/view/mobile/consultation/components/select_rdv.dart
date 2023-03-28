import 'package:flutter/material.dart';

/*
  * utilisé pour la selection du rendez-vous que l'on veut changer
*/

class SelectRdv extends StatefulWidget {
  const SelectRdv(
      {super.key,
      this.title = 'Selectionner un rendez-vous',
      required this.rdvs});

  final String title;
  final List<Map<String, dynamic>> rdvs;

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
          child: Text(option),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          selectedOption = int.parse(newValue!);
        });
      },
      hint: const Text('Selectionner un rendez-vous'),
    );
  }
}
