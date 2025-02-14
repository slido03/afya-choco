//import 'package:afya/src/view/web/home/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
//import 'constant/navigation_rail.dart';
// import 'authentication/login_form.dart';
// import 'constant/navigation_rail.dart';
// import 'consultation/components/creation_rdv.dart';
// import 'consultation/components/drop_down_button.dart';
// import 'consultation/components/liste_demande.dart';
// import 'consultation/components/saisie_identifiant.dart';
// import 'consultation/components/tab_app.dart';
// import 'consultation/components/top_bar.dart';
// import 'consultation/components/top_rdv.dart';
// import 'consultation/consultation_screen.dart';
// import 'consultation/pages/consultation.dart';
// import 'consultation/pages/demande.dart';
// import 'consultation/pages/enregistrement.dart';
// import 'consultation/pages/rendez_vous.dart';
import 'constant/navigation_rail.dart';
import 'home/pages/login_page.dart';
import 'package:go_router/go_router.dart';

class AfyaApp extends StatelessWidget {
  const AfyaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const Scaffold(
            body: NavigationRailPage(),
          ),
        )
      ],
    );
    return MaterialApp.router(
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
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
