import 'package:flutter/material.dart';

import '../../constant/navigation_rail.dart';
import '../components/creation_rdv.dart';
import '../components/rdv_top_bar.dart';


class RendezVousPage extends StatelessWidget {
  const RendezVousPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      children:  [
       
        Expanded(
          child: Column(
            children: [
              // RdvTopBar(),
              // SizedBox(height: 4,),
              Padding(
                padding: EdgeInsets.only(left: 120.0, right: 120.0,),
                child: CreationRdv(),
              ),
            ],
          ),
        )
      ],
    );
  }
}