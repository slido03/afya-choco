import 'package:flutter/material.dart';

class AfyaLogo extends StatelessWidget {
  const AfyaLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 105,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(5)
      ),
        child: const Center(
          child: Text(
          'AFYA',
          style: TextStyle(
            fontSize: 40,
            color: Color.fromRGBO(30, 82, 42, 1),
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
          ),
        ),
    );
  }
}
