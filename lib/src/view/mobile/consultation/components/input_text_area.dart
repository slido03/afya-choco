import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class InputTextArea extends StatelessWidget {
  const InputTextArea(
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
        maxLines: 5,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          constraints: BoxConstraints(
              minHeight: 60.0,
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
