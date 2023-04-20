import 'package:flutter/material.dart';

class DateRdv extends StatelessWidget {
  const DateRdv({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final TextEditingController dateController = TextEditingController();
    return Expanded(
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        ),
        child: TextFormField(
          controller: dateController,
          decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
              hintText: '10/02/2020',
              labelText: 'Date de rendez-vous'),
        ),
      ),
    );
  }
}
