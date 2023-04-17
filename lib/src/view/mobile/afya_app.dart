import 'package:flutter/material.dart';
import './authentication/login.dart';
import 'agenda/agenda_screen.dart';
import 'carnet/carnet_screen.dart';
import 'intro_screen.dart';
import 'notifications_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AfyaApp extends StatelessWidget {
  const AfyaApp({super.key});

  // This widget is the root of our application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Afya Demo',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), //English
        Locale('fr', ''), // Français
      ],
      locale: const Locale('fr', ''), //locale de l'app en français
      builder: EasyLoading.init(),
      theme: ThemeData(
        //const Color.fromARGB(255, 33, 243, 156)
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      //mettre les destinations principales ici : /, /carnet, /agenda
      routes: {
        '/': (context) => const LoginPage(),
        '/carnet': (context) => const CarnetScreen(),
        '/agenda': (context) => const AgendaScreen(),
        '/notifications': (context) => const NotificationsScreen(),
        '/intro': (context) => const IntroScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
