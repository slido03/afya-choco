//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';

// class ApplicationState extends ChangeNotifier {
//   ApplicationState() {
//     init();
//   }

//   bool _loggedIn = false;
//   User? _currentUser;
//   User? get currentUser => _currentUser;
//   bool get loggedIn => _loggedIn;

//   Future<void> init() async {
//     FirebaseAuth.instance.userChanges().listen((user) {
//       if (user != null) {
//         _loggedIn = true;
//         _currentUser = user;
//       } else {
//         _loggedIn = false;
//         _currentUser = null;
//       }
//       notifyListeners();
//     });
//   }
// }
