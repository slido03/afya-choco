import 'package:flutter/material.dart';

class NouveauMessage extends StatelessWidget {
  const NouveauMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TextButton(
      onPressed: null, 
      child: Text('Nouveau message',style: TextStyle(fontSize: 24),)
      );
  }
}
