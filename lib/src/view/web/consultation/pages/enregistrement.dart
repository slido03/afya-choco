import 'package:flutter/material.dart';

import '../../constant/navigation_rail.dart';
import '../components/EnregistrementPatient/enregistrement_patient.dart';
import '../components/top_bar.dart';

class Enregistrement extends StatelessWidget {
  const Enregistrement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        NavigationRailPage(),
        Expanded(
          child: Column(
            children: [
               TopBar(),
               SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(right: 90, left: 90),
                child: EnregistrementPatient()
                ),
            ],
          ),
        ),
      ],
    );
  }
}
