import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import './register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _emailValidator = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  String? get email => _emailController.text;
  bool _passwordVisible = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
              const EdgeInsets.only(right: 10, left: 10, top: 70, bottom: 50),
          child: Container(
            height: 470,
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
                  const Text(
                    'Bienvenu(e) dans Afya, votre santé  en poche.',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  const RegisterPage()), //page de création de compte
                        );
                      },
                      child: const Text('Nouvel utilisateur? Créez un compte')),
                  TextField(
                    controller: _emailController,
                    onSubmitted: (value) {
                      // Vérifier si la saisie utilisateur correspond à l'expression régulière pour les emails
                      if (!_emailValidator.hasMatch(value)) {
                        _errorText = "L'email saisi n'est pas valide";
                        // Effacer la saisie incorrecte
                        _emailController.clear();
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Email',
                      errorText: _errorText,
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Mot de passe',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                    obscureText: !_passwordVisible,
                  ),
                  const SizedBox(height: 5.0),
                  TextButton(
                      onPressed: () {
                        resetPassword(context);
                      },
                      child: const Text('Mot de passe oublié?')),
                  const SizedBox(height: 25.0),
                  ElevatedButton(
                    child: const Text('Se connecter'),
                    onPressed: () async {
                      if (await signInWithEmailAndPassword(
                          _emailController.text, _passwordController.text)) {
                        // ignore: use_build_context_synchronously
                        navigateToHome(context);
                      } else {
                        const snackBar = SnackBar(
                            padding: EdgeInsets.only(bottom: 50, top: 30),
                            content: Text(
                                'Désolé votre email ou mot de passe est invalide ou vous avez été déconnecté'));
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        // L'utilisateur a été connecté avec succès
        // On redirige l'utilisateur vers la page d'accueil
        return true;
      }
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

  void resetPassword(BuildContext context) {
    String? errorText;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Réinitialisation de mot de passe"),
          content: TextField(
            controller: _emailController,
            onSubmitted: (value) {
              // Vérifier si la saisie utilisateur correspond à l'expression régulière pour les emails
              if (!_emailValidator.hasMatch(value)) {
                errorText = 'Le mot de passe saisi est invalide';
              }
            },
            decoration: InputDecoration(
              hintText: "Entrer votre adresse e-mail",
              errorText: errorText,
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Annuler"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text("Envoyer"),
              onPressed: () {
                FirebaseAuth.instance.sendPasswordResetEmail(email: email!);
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Réinitialisation de mot de passe"),
                      content: Text(
                          "Un e-mail de réinitialisation a été envoyé à $email"),
                      actions: [
                        TextButton(
                          child: const Text("OK"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> logout() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return await FirebaseAuth.instance.signOut();
    }
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
