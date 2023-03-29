import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  const InputText(
      {super.key,
      required this.labelText,
      required this.hintText,
      this.maxwidth});

  final String labelText;
  final String hintText;
  final double? maxwidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: labelText,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          contentPadding: const EdgeInsets.all(10.0),
          constraints: BoxConstraints(
              maxHeight: 60.0,
              maxWidth: maxwidth ?? MediaQuery.of(context).size.width * 0.80),
        ),
        onChanged: (value) {
          if (kDebugMode) {
            print(value);
          }
        },
      ),
    );
  }
}
