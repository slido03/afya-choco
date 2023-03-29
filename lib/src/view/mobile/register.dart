import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;

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
                        _emailError = "L'email saisi n'est pas valide";
                        // Effacer la saisie incorrecte
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
                      if (_firstPasswordController.text.length < 6) {
                        _firstPasswordError =
                            'Le mot de passe doit contenir au moins 6 caractères';
                        // Effacer la saisie incorrecte
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
                      if (_secondPasswordController.text !=
                          _firstPasswordController.text) {
                        _secondPasswordError =
                            'Le mot de passe saisi est différent du précédent';
                        // Effacer la saisie incorrecte
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
                      if (await registerWithEmailAndPassword(
                          _emailController.text,
                          _secondPasswordController.text)) {
                        // ignore: use_build_context_synchronously
                        navigateToHome(context);
                      } else {
                        const snackBar = SnackBar(
                            padding: EdgeInsets.only(bottom: 30, top: 30),
                            content: Text(
                                "Désolé l'email saisi est déjà utilisé ou invalide, ou le mot de passe n'est pas valide"));
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
      String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        // L'utilisateur a été créé avec succès
        // On redirige l'utilisateur vers la page d'accueil
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
              const PatientWidget()), //à changer par la home page
    );
  }
}

//fausse homePage
class PatientWidget extends StatelessWidget {
  const PatientWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('patient'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'blablabla',
          )
        ],
      )),
    );
  }
}
