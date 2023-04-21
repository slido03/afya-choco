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
      items: specialiteItems(),
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
    for (int index = 0; index < Specialite.values.length; index++) {
      DropdownMenuItem<int> item = DropdownMenuItem<int>(
        value: index + 2,
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
