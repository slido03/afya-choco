import 'package:flutter/material.dart';

//import '../../constant/navigation_rail.dart';
import '../components/tab_app.dart';
import '../components/top_bar.dart';

class ConsultationPage extends StatelessWidget {
  const ConsultationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: const [
          TopBar(),
          SizedBox(
            height: 3,
          ),
          Expanded(child: Test()),
        ],
      ),
    );
  }
}
