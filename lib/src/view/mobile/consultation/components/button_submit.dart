import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ButtonSubmit extends StatelessWidget {
  const ButtonSubmit({
    super.key,
    this.onPressed,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () {
          onPressed!.call();
          if (kDebugMode) {
            print('Submit button pressed');
          }
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.green,
        ),
        child: const Text('Envoyer'));
  }
}
