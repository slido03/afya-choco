import 'package:flutter/material.dart';

class DropdownCard extends StatefulWidget {
  const DropdownCard({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DropdownCardState createState() => _DropdownCardState();
}

class _DropdownCardState extends State<DropdownCard> {
  List <String> listItem = [   
     "Option 1",    "Option 2",    "Option 3",    "Option 4", 
  ];
  late String valueChoose = listItem[0];

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
       // print(newValue);
      },
      items: listItem.map((valueItem) {
        return DropdownMenuItem<String>(
          value: valueItem,
          child: Text(valueItem),
        );
      }).toList(),
    );
  }
}
