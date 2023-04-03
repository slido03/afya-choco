import 'package:flutter/material.dart';

//import '../components/title_prise_rdv.dart';
import '../components/form_prise_rdv.dart';
import '../components/title_prise_rdv.dart';

class PriseRdv extends StatefulWidget {
  const PriseRdv({super.key, this.title = 'Prise de rendez-vous'});

  final String title;
  
  @override
  State<PriseRdv> createState() => _PriseRdvState();
}

class _PriseRdvState extends State<PriseRdv> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            titlePriseRdv(),
            const FormPriseRdv(),
          ],
        ),
      ),
    );
  }
}
