import 'package:flutter/material.dart';
import 'constant/navigation_rail.dart';
import 'consultation/pages/rendez_vous.dart';

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
