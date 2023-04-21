import 'package:flutter/material.dart';

class DropDownMois extends StatelessWidget {
  const DropDownMois({
    super.key,
    required this.filterState,
    required this.width,
    required this.onChanged,
  });

  final Map<String, int> filterState;
  final double width;
  final Function(int?, String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: filterState['mois'],
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade200,
        labelText: 'Mois',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        constraints: BoxConstraints(
          maxWidth: width,
        ),
        contentPadding: const EdgeInsets.all(3),
      ),
      menuMaxHeight: 250,
      borderRadius: BorderRadius.circular(10.0),
      focusColor: Colors.white38,
      items: const [
        DropdownMenuItem(
          value: 1,
          child: Text('Tous'),
        ),
        DropdownMenuItem(
          value: 2,
          child: Text('Janvier'),
        ),
        DropdownMenuItem(
          value: 3,
          child: Text('Février'),
        ),
        DropdownMenuItem(
          value: 4,
          child: Text('Mars'),
        ),
        DropdownMenuItem(
          value: 5,
          child: Text('Avril'),
        ),
        DropdownMenuItem(
          value: 6,
          child: Text('Mai'),
        ),
        DropdownMenuItem(
          value: 7,
          child: Text('Juin'),
        ),
        DropdownMenuItem(
          value: 8,
          child: Text('Juillet'),
        ),
        DropdownMenuItem(
          value: 9,
          child: Text('Août'),
        ),
        DropdownMenuItem(
          value: 10,
          child: Text('Septembre'),
        ),
        DropdownMenuItem(
          value: 11,
          child: Text('Octobre'),
        ),
        DropdownMenuItem(
          value: 12,
          child: Text('Novembre'),
        ),
        DropdownMenuItem(
          value: 13,
          child: Text('Décembre'),
        ),
      ],
      onChanged: (int? value) {
        onChanged(value, 'mois');
      },
    );
  }
}
