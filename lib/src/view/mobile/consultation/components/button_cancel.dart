import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

class ButtonCancel extends StatelessWidget {
  const ButtonCancel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () {
          //SystemChannels.textInput.invokeMethod('TextInput.hide');
          FocusScope.of(context).unfocus();
          Navigator.pop(context);
          // fermer le clavier
          if (kDebugMode) {
            print('Cancel button pressed');
          }
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.red,
        ),
        child: const Text('Annuler'));
  }
}
