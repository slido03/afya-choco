import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './authentication.dart';
import './login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstPasswordController =
      TextEditingController();
  final TextEditingController _secondPasswordController =
      TextEditingController();
  String? get email => _emailController.text;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstPasswordController.dispose();
    _secondPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double maxwidth = MediaQuery.of(context).size.width * .80;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AFYA',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: maxwidth * 1.115,
            margin: const EdgeInsets.symmetric(
              vertical: 30.0,
              horizontal: 3,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 25.0,
            ),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 10.0,
                    ),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 231, 248, 232),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                          offset: Offset(0.0, 0.0),
                        ),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        const Text(
                          'Nous sommes heureux de vous accueillir dans Afya.\nVeuillez entrer vos information de connexion.',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        InputEmail(
                          labelText: 'Email',
                          hintText: 'Votre email',
                          controller: _emailController,
                        ),
                        InputPassword(
                          labelText: 'Mot de passe',
                          hintText: 'Entrez un mot de passe',
                          controller: _firstPasswordController,
                        ),
                        InputSecondPassword(
                          labelText: 'Mot de passe',
                          hintText: 'Confirmez votre mot de passe',
                          controller: _secondPasswordController,
                          firstPasswordController: _firstPasswordController,
                        ),
                        // register button
                        const SizedBox(
                          height: 25,
                        ),
                        ElevatedButton(
                          child: const Text(
                            'Créer un compte',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          onPressed: () async {
                            //Si l'user a été créé
                            // ignore: use_build_context_synchronously
                            if (!await registerWithEmailAndPassword(
                                _emailController.text,
                                _secondPasswordController.text,
                                context)) {
                              const snackBar = SnackBar(
                                  padding: EdgeInsets.only(bottom: 30, top: 30),
                                  content: Text(
                                      "Désolé vous êtes déconnecté soit l'email saisi est déjà utilisé, invalide ou désactivé."));
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> registerWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Si l'utilisateur a été créé avec succès
      if (userCredential.user != null) {
        //envoie de l'email de vérification au nouvel utilisateur
        await userCredential.user!.sendEmailVerification();
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Vérification de votre email"),
              content:
                  Text("Un e-mail de vérification vous a été envoyé à $email"),
              actions: [
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                    _navigateToLogin(context);
                  },
                ),
              ],
            );
          },
        );
        return true;
      }
      // L'utilisateur est créé avec succès.
    } catch (e) {
      return false;
    }
    return false;
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }
}
