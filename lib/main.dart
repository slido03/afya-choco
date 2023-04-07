import 'package:flutter/foundation.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'src/view/mobile/afya_app.dart'; //importing the main app
//import 'package:provider/provider.dart';
//import '../src/application_state.dart';
//import './src/repository/repositories.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Initialise la liaison
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (kDebugMode) {
    print('firebase initialized');
  }
  
  runApp(const AfyaApp());
}
