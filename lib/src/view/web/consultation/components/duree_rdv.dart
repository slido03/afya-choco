import 'package:flutter/material.dart';

class DureeRdv extends StatelessWidget {
  const DureeRdv({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController dureeController = TextEditingController();

    return Expanded(
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        ),
        child: TextFormField(
          controller: dureeController,
          decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
              hintText: '30',
              labelText: 'La duree en minutes'),
        ),
      ),
    );
  }
}
