import 'package:flutter/material.dart';

import '../components/title_changer_rdv.dart';
import '../components/form_changer_rdv.dart';

class ChangerRdv extends StatefulWidget {
  const ChangerRdv({super.key, this.title = 'Changer de rendez-vous'});

  final String title;

  @override
  State<ChangerRdv> createState() => _ChangerRdvState();
}

class _ChangerRdvState extends State<ChangerRdv> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            titleChangerRdv(),
            const FormChangerRdv(),
          ],
        ),
      ),
    );
  }
}
