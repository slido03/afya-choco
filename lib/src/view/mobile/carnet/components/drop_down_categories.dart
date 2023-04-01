import 'package:flutter/material.dart';

class DropDownCategories extends StatelessWidget {
  const DropDownCategories({
    super.key,
    required this.width,
    required this.filterState,
    required this.onChanged,
  });

  final double width;
  final Map<String, int> filterState;
  final Function(int?, String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      // couleur de fond de la liste déroulante
      decoration: InputDecoration(
        labelText: 'Catégorie',
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        constraints: BoxConstraints(
          maxWidth: width,
        ),
        contentPadding: const EdgeInsets.all(5),
      ),
      menuMaxHeight: 250,
      borderRadius: BorderRadius.circular(10.0),
      value: filterState['categorie'],
      focusColor: Colors.white38,
      items: const [
        DropdownMenuItem(
          value: 1,
          child: Text(
            'Tous',
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        DropdownMenuItem(
          value: 2,
          child: Text(
            'Radiologie',
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        DropdownMenuItem(
          value: 3,
          child: Text(
            'Biologie',
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        DropdownMenuItem(
          value: 4,
          child: Text(
            'Echographie',
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        DropdownMenuItem(
          value: 5,
          child: Text(
            'Autres',
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
      onChanged: (int? value) {
        onChanged(value, 'categorie');
      },
    );
  }
}
