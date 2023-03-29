
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'src/view/mobile/afya_app.dart'; //importing the main app
import 'package:provider/provider.dart';
import '../src/application_state.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Initialise la liaison
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider(
    create: (context) => ApplicationState(),
    builder: ((context, child) => const AfyaApp()),
  ));
}


