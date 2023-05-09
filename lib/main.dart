//import 'package:flutter/foundation.dart';
import 'package:afya/src/view/web/afya_app.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../src/application_state.dart';
//import './src/repository/repositories.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Initialise la liaison
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /* ChangeNotifierProvider permet d'utiliser l'application state dans toute l'arborescence
  de l'application. 
  À savoir, ApplicationState permet de savoir à tout instant si l'user est authentifié 
  et de recupérer l'utilisateur courant de l'application */
  runApp(ChangeNotifierProvider(
    create: (context) => ApplicationState(),
    builder: ((context, child) => const AfyaApp()),
  ));
}

