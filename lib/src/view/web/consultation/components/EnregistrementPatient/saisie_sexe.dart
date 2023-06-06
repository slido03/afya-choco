import 'package:flutter/material.dart';
import 'package:afya/src/model/models.dart';

class SelectionItem extends StatefulWidget {
  final List<String> choix = _sexeValues();
  final String valueChoose;
  final Function(String?) onChanged;

  SelectionItem({
    Key? key,
    required this.onChanged,
    required this.valueChoose,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SelectionItemState createState() => _SelectionItemState();
}

class _SelectionItemState extends State<SelectionItem> {
  late String valueChoose;

  @override
  void initState() {
    super.initState();
    valueChoose = widget.valueChoose;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24.0,
      elevation: 16,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 16.0,
      ),
      decoration: const InputDecoration(
        labelText: 'Sélectionnez votre sexe',
        border: OutlineInputBorder(),
      ),
      value: valueChoose,
      onChanged: (newValue) {
        setState(() {
          valueChoose = newValue!;
          widget.onChanged(newValue);
        });
      },
      items: widget.choix.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

List<String> _sexeValues() {
  List<String> values = [];
  for (var sexe in Sexe.values) {
    values.add(sexe.value);
  }
  return values;
}
