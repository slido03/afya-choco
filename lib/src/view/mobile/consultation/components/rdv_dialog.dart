import 'package:flutter/material.dart';
import 'package:afya/src/model/models.dart';
import 'package:intl/intl.dart';

/*
 * This is a dialog that is used to confirm the cancellation of a rendez-vous. the last one.
 * It is used in the pages: ChangerRdv and PriseRdv.
 */
class RdvDialog extends StatelessWidget {
  const RdvDialog({super.key, this.rdv});
  //const RdvDialog({super.key, required this.rdv});

  //final Object? rdv;
  final RendezVous? rdv;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: const Text(
        'Est-ce bien ce rendez-vous?',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w400,
          fontFamily: 'Roboto',
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              "Objet: ${rdv?.objet.value ?? 'Indéfini'}",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                fontFamily: 'Roboto',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              "Médecin: ${rdv?.medecin.nom ?? 'Iconnu(e)'}",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                fontFamily: 'Roboto',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              "Date: ${rdv?.dateHeure.formatDate() ?? '01/12/1970'}",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                fontFamily: 'Roboto',
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Non'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Oui'),
        ),
      ],
    );
  }
}

extension DateFormatString on DateTime {
  String formatDate() {
    return DateFormat('dd/MM/yyyy').format(this);
  }
}
