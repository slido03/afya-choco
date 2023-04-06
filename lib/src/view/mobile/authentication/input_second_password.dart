import 'package:flutter/material.dart';

class InputSecondPassword extends StatefulWidget {
  const InputSecondPassword(
      {super.key,
      required this.labelText,
      required this.hintText,
      required this.firstPasswordController,
      required this.controller,
      this.maxwidth});

  final String labelText;
  final String hintText;
  final double? maxwidth;
  final TextEditingController controller;
  final TextEditingController firstPasswordController;

  @override
  State<InputSecondPassword> createState() => _InputSecondPasswordState();
}

class _InputSecondPasswordState extends State<InputSecondPassword> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: widget.controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Veuillez saisir votre mot de passe';
          } else if (value.length < 6) {
            return 'Au moins 6 caractères!!!';
          } else if (value != widget.firstPasswordController.text) {
            return "Le second mot de passe est différent du premier";
          }
          return null;
        },
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
          filled: true,
          fillColor: Colors.white,
          labelText: widget.labelText,
          hintText: widget.hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          contentPadding: const EdgeInsets.all(10.0),
          constraints: BoxConstraints(
              maxHeight: 60.0,
              maxWidth:
                  widget.maxwidth ?? MediaQuery.of(context).size.width * 0.80),
        ),
        obscureText: !_passwordVisible,
      ),
    );
  }
}
