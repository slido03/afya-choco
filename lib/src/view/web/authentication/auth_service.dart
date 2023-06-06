import 'package:firebase_auth/firebase_auth.dart';
import 'package:localstorage/localstorage.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';

//service d'authentification avec mise en cache
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static final LocalStorage storage = LocalStorage('storage');
  static AuthService? _instance;

  AuthService._(); //constructeur privé

  static AuthService get instance {
    _instance ??= AuthService._();
    return _instance!;
  }

  static Future<bool> _initialization() async {
    bool storageReady = await storage.ready;
    if (storageReady) {
      return true;
    }
    return false;
  }

  // Connexion avec email et mot de passe et renvoie l'uid après l'avoir stocké en cache
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      if (kDebugMode) {
        print('sign in goes on');
      }
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        if (kDebugMode) {
          print('userCredential non nul');
        }
        String uid = userCredential.user!.uid;
        if (kDebugMode) {
          print('local storage starts');
        }
        if (await _initialization()) {
          await storage.setItem(
            'uid',
            uid,
          ); // stocke l'ID utilisateur dans le cache local
        }
        if (kDebugMode) {
          print('local storage ended');
        }
        return userCredential.user;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  // Vérifie si l'utilisateur est déjà connecté et renvoie son ID utilisateur
  Future<String?> getCurrentUserUid() async {
    if (await _initialization()) {
      String? uid = await storage.getItem('uid');
      return uid;
    }
    return null;
  }

  // Déconnexion
  Future<void> signOut() async {
    await storage.clear();
    return _auth.signOut();
  }
}
