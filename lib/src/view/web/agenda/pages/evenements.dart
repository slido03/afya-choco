import 'package:flutter/material.dart';

import '../../constant/afya_logo.dart';
import '../components/tab_bar_agenda.dart';

class EvenementAgenda extends StatelessWidget {
  const EvenementAgenda({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        AfyaLogo(),
        SizedBox(height: 3,),
        TabBarAgenda(),
    ],
    );
  }
}