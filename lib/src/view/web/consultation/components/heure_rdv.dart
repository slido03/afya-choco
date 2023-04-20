import 'package:flutter/material.dart';

class HeureRdv extends StatelessWidget {
  const HeureRdv({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController heureController = TextEditingController();
    return Expanded(
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        ),
        child: TextFormField(
          controller: heureController,
          decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
              hintText: '10:10',
              labelText: 'L\'heure'),
        ),
      ),
    );
  }
}
