import 'package:flutter/material.dart';
import 'authentication/login_form.dart';
import 'constant/navigation_rail.dart';
import 'consultation/components/creation_rdv.dart';
import 'consultation/components/drop_down_button.dart';
import 'consultation/components/liste_demande.dart';
import 'consultation/components/saisie_identifiant.dart';
import 'consultation/components/tab_app.dart';
import 'consultation/components/top_bar.dart';
import 'consultation/components/top_rdv.dart';
import 'consultation/consultation_screen.dart';
import 'consultation/pages/consultation.dart';
import 'consultation/pages/demande.dart';
import 'consultation/pages/enregistrement.dart';
import 'consultation/pages/rendez_vous.dart';
import 'home/pages/login_page.dart';

class AfyaApp extends StatelessWidget {
  const AfyaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Afya Demo',
      theme: ThemeData(
        //const Color.fromARGB(255, 33, 243, 156)
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        
      ),
      //  initialRoute: '/',
      // //mettre les destinations principales ici : /, /carnet, /agenda
      // routes: {
      //   '/': (context) => const LoginPage(),
      // },
      home: const NavigationRailPage(),
      debugShowCheckedModeBanner: false,  
      );
  }

}
