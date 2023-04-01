import 'package:flutter/material.dart';

import './authentication/login.dart';
import 'consultation/pages/changer_rdv.dart';
import 'notifications_screen.dart';
import 'consultation/pages/prise_rdv.dart';

class AfyaApp extends StatelessWidget {
  const AfyaApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sten Demo',
      theme: ThemeData(
        //const Color.fromARGB(255, 33, 243, 156)
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/prise_rendez_vous': (context) => const PriseRdv(),
        '/changer_rendez_vous': (context) => const ChangerRdv(),
        '/notifications': (context) => const NotificationsScreen(),
      },
      debugShowCheckedModeBanner: false,
      //home: const MyHomePage(title: 'StenDemo Home Page'),
    );
  }
}
