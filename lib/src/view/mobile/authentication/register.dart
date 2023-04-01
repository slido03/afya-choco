import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../home_page.dart';
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
  final _emailValidator = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  String? get email => _emailController.text;
  String? _emailError;
  String? _firstPasswordError;
  String? _secondPasswordError;

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('AFYA'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(right: 10, left: 10, top: 60, bottom: 40),
          child: Container(
            height: 440,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.green,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: _emailController,
                    onSubmitted: (value) {
                      // Vérifier si la saisie utilisateur correspond à l'expression régulière pour les emails
                      if (!_emailValidator.hasMatch(value)) {
                        setState(() {
                          _emailError = "L'email saisi n'est pas valide";
                          // Effacer la saisie incorrecte
                          _emailController.clear();
                        });
                      }
                      if (value.isEmpty) {
                        setState(() {
                          _emailError = 'Veuillez sasir un email valide';
                        });
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Email',
                      errorText: _emailError,
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  TextField(
                    controller: _firstPasswordController,
                    onSubmitted: (value) {
                      if (value.length < 6) {
                        setState(() {
                          _firstPasswordError = 'Au moins 6 caractères';
                        });
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Entrez un mot de passe',
                      errorText: _firstPasswordError,
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 15.0),
                  TextField(
                    controller: _secondPasswordController,
                    onSubmitted: (value) {
                      if (value != _firstPasswordController.text) {
                        setState(() {
                          _secondPasswordError =
                              'Le mot de passe saisi est différent du précédent';
                        });
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Confirmez votre mot de passe',
                      errorText: _secondPasswordError,
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 30.0),
                  ElevatedButton(
                    child: const Text('Créer un compte'),
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
                                "Désolé l'email saisi est déjà utilisé, invalide ou désactivé, ou le mot de passe saisi n'est pas valide"));
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
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
                    navigateToLogin(context);
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

  void navigateToHome(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (context) =>
              const HomePage(title: 'HomePage')), //à changer par la home page
    );
  }

  void navigateToLogin(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }
}
