import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';

//service d'authentification avec mise en cache
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final storage = const FlutterSecureStorage();
  static AuthService? _instance;

  AuthService._(); //constructeur privé

  static AuthService get instance {
    _instance ??= AuthService._();
    return _instance!;
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
        String email = userCredential.user!.email!;
        if (kDebugMode) {
          print('local storage starts');
        }
        await storage.write(
          key: 'uid',
          value: uid,
        ); // stocke l'ID utilisateur dans le cache local
        await storage.write(
          key: 'email',
          value: email,
        ); // stocke l'email utilisateur dans le cache local
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
    String? uid = await storage.read(key: 'uid');
    if (uid != null) {
      return uid;
    }
    return null;
  }

  // Vérifie si l'utilisateur est déjà connecté et renvoie son email
  Future<String?> getCurrentUserEmail() async {
    String? email = await storage.read(key: 'email');
    if (email != null) {
      return email;
    }
    return null;
  }

  // Déconnexion
  Future<void> signOut() async {
    await storage.delete(
        key: 'uid'); // supprime l'ID utilisateur du cache local
    await storage.delete(
        key: 'email'); // supprime l'email utilisateur du cache local
    return _auth.signOut();
  }
}
