import 'package:afya/src/view/web/afya_app.dart';

import 'firebase_options.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
//import 'src/view/mobile/afya_app.dart'; //importing the main mobile app
import 'src/view/web/afya_app.dart'; //importing the main web app
//import 'package:provider/provider.dart';
//import './src/repository/repositories.dart';
//import 'package:afya/src/seeder/seeders.dart';
=======
>>>>>>> 1772f7950f67f1d4cfc9496f5144b0fd04aa5d31

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Initialise la liaison
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (kDebugMode) {
    print('firebase initialized');
  }

  runApp(const AfyaApp());
}
