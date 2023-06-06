import 'package:flutter/material.dart';
//import '../../constant/navigation_rail.dart';
import '../components/consultation_tab.dart';
import '../components/top_bar.dart';

class ConsultationPage extends StatelessWidget {
  const ConsultationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Column(
        children: [
          TopBar(),
          SizedBox(
            height: 3,
          ),
          Expanded(child: ConsultationTab()),
        ],
      ),
    );
  }
}
