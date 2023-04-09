import 'package:flutter/foundation.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'src/view/mobile/afya_app.dart'; //importing the main mobile app
//import 'package:provider/provider.dart';
//import '../src/application_state.dart';
//import './src/repository/repositories.dart';
//import 'package:afya/src/seeder/seeders.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Initialise la liaison
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (kDebugMode) {
    print('firebase initialized');
  }
  // AppSeeder appSeeder =
  //     AppSeeder(email: 'birregahcredo@gmail.com', password: '');
  // await appSeeder.seed();

  runApp(const AfyaApp());
}
