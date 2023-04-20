import 'package:flutter/material.dart';

import '../../constant/navigation_rail.dart';
import '../components/tab_app.dart';
import '../components/top_bar.dart';

class DemandeConsultation extends StatefulWidget {
  const DemandeConsultation({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DemandeConsultationState createState() => _DemandeConsultationState();
}

class _DemandeConsultationState extends State<DemandeConsultation> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
         child: Row(
          children: [
            TopBar(),
          ]
         ),
      ),
    );
  }
}