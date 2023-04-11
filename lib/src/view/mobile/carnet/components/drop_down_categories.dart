import 'package:flutter/material.dart';
import 'package:afya/src/model/models.dart';

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
      items: [
        const DropdownMenuItem(
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
            Specialite.cardiologie.value,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        DropdownMenuItem(
          value: 3,
          child: Text(
            Specialite.hematologie.value,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        DropdownMenuItem(
          value: 4,
          child: Text(
            Specialite.gynecologieObstetrique.value,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const DropdownMenuItem(
          value: 5,
          child: Text(
            'Autres',
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
      onChanged: (value) {
        onChanged(value, 'categorie');
      },
    );
  }

  List<DropdownMenuItem<int>> specialiteItems() {
    List<DropdownMenuItem<int>> items = [];
    items.add(const DropdownMenuItem<int>(
      value: 1,
      child: Text(
        'Tous',
        softWrap: true,
        overflow: TextOverflow.ellipsis,
      ),
    ));
    for (int index = 2; index < Specialite.values.length + 2; index++) {
      DropdownMenuItem<int> item = DropdownMenuItem<int>(
        value: index,
        child: Text(
          Specialite.values[index].value,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
        ),
      );
      items.add(item);
    }
    return items;
  }
}
