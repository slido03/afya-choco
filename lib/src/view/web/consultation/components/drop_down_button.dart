import 'package:flutter/material.dart';

class DropdownCard extends StatefulWidget {
  final List<String> options; // Liste des options
  final String defaultValue;
  final String labelText; // Texte du label

  const DropdownCard(
      {Key? key,
      required this.options,
      required this.defaultValue,
      required this.labelText})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DropdownCardState createState() => _DropdownCardState();
}

class _DropdownCardState extends State<DropdownCard> {
  late String valueChoose;

  @override
  void initState() {
    super.initState();
    valueChoose =
        widget.defaultValue; // Utilisation de la valeur par défaut fournie
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 30,
      value: valueChoose,
      onChanged: (newValue) {
        setState(() {
          valueChoose = newValue!;
        });
      },
      decoration: InputDecoration(
        labelText: widget.labelText, // Utilisation du labelText fourni
        filled: true,
        fillColor: Colors.grey[200], // Couleur de fond spécifiée
        contentPadding: const EdgeInsets.only(left: 10,), // Espacement vertical ajouté
      ),
      style: const TextStyle(
        color: Colors.black, // Couleur de texte spécifiée
      ),
      items: widget.options.map((valueItem) {
        return DropdownMenuItem<String>(
          value: valueItem,
          child: Text(valueItem),
        );
      }).toList(),
    );
  }
}

// class DropdownCard extends StatefulWidget {
//   final List<String> options;
//   final String defaultValue;
//   final String labelText;

//   const DropdownCard(
//       {Key? key,
//       required this.options,
//       required this.defaultValue,
//       required this.labelText})
//       : super(key: key);

//   @override
//   _DropdownCardState createState() => _DropdownCardState();
// }

// class _DropdownCardState extends State<DropdownCard> {
//   late String valueChoose;

//   @override
//   void initState() {
//     super.initState();
//     valueChoose = widget.defaultValue;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Text(
//             widget.labelText,
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),
//         ),
//         DropdownButtonFormField<String>(
//           decoration: InputDecoration(
//             contentPadding: const EdgeInsets.all(10),
//             labelText: widget.labelText, // Utilisation du labelText fourni
//             filled: true,
//             fillColor: Colors.grey[200], // Couleur de fond spécifiée
//           ),
//           style: const TextStyle(
//             color: Colors.black, // Couleur de texte spécifiée
//           ),
//           icon: const Icon(Icons.arrow_drop_down),
//           iconSize: 30,
//           value: valueChoose,
//           onChanged: (newValue) {
//             setState(() {
//               valueChoose = newValue!;
//             });
//           },
//           items: widget.options.map((valueItem) {
//             return DropdownMenuItem<String>(
//               value: valueItem,
//               child: Text(valueItem),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
// }
