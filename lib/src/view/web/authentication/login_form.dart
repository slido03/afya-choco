import 'package:afya/src/view/web/authentication/auth_service.dart';
import 'package:afya/src/view/web/constant/navigation_rail.dart';
//import 'package:afya/src/view/web/constant/navigation_rail.dart';
//import 'package:afya/src/view/web/consultation/consultation_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//import '../home/pages/home_page.dart';
//import '../home/pages/login_page.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late bool _passwordVisible = false;

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: 20,
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.green,
      ),
      child: SingleChildScrollView(
          child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 40),
              child: Center(
                child: Text(
                  'AFYA',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Card(
                child: TextFormField(
                  //style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                  controller: usernameController,
                  validator: (value) {
                    final validator =
                        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (value == null || value.isEmpty) {
                      return 'Veuillez saisir votre email';
                    } else if (!validator.hasMatch(value)) {
                      return 'Veuillez saisir un email valide';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    hintText: 'Email',
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Card(
                child: TextFormField(
                  //style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez saisir votre mot de passe';
                    } else if (value.length < 6) {
                      return 'Au moins 6 caractères!!!';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                      hintText: 'Mot de passe',
                      suffixIcon: IconButton(
                        icon: Icon(_passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          _toggleVisibility();
                        },
                      )),
                  obscureText: !_passwordVisible,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                _resetPassword(context);
              },
              child: const Text('Mot de passe oublie?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor:
                            const Color.fromRGBO(37, 107, 211, 0.27),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: const Size(448, 60),
                      ),
                      onPressed: () async {
                        bool signedIn = await signInWithEmailAndPassword(
                            usernameController.text, passwordController.text);
                        if (signedIn) {
                          if (kDebugMode) {
                            print('user signed in');
                          }
                          // ignore: use_build_context_synchronously
                          _navigateToHome(context);
                        } else {
                          const snackBar = SnackBar(
                              padding: EdgeInsets.only(bottom: 50, top: 30),
                              content: Text(
                                  'Email ou mot de passe invalides ou non vérifiés ou compte désactivé'));
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: const Text(
                        'Se connecter',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
            )
          ],
        ),
      )),
    );
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    AuthService authService = AuthService.instance;
    final form = _formKey.currentState;
    if (form!.validate()) {
      setState(() {
        _isLoading = true;
      });
      form.save();
      if (kDebugMode) {
        print('sign in starts');
      }
      try {
        User? user =
            await authService.signInWithEmailAndPassword(email, password);
        if ((user != null)) {
          if (kDebugMode) {
            print('user signed-in non null');
          }
          if ((user.emailVerified)) {
            if (kDebugMode) {
              print('user email verified');
            }
            // L'utilisateur a été connecté avec succès et a son email est vérifié
            // On redirige l'utilisateur vers la page d'accueil
            return true;
          }
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        return false;
      }
    }
    if (kDebugMode) {
      print('sign in not achieved');
    }
    setState(() {
      _isLoading = false;
    });
    return false;
  }

  void _navigateToHome(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const NavigationRailPage(),
    ));
  }

  void _resetPassword(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Réinitialisation de mot de passe"),
          content: TextFormField(
            //style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
            controller: usernameController,
            validator: (value) {
              final validator = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
              if (value == null || value.isEmpty) {
                return 'Veuillez saisir votre email';
              } else if (!validator.hasMatch(value)) {
                return 'Veuillez saisir un email valide';
              }
              return null;
            },
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              hintText: 'Email',
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
              onPressed: () async {
                if (kDebugMode) {
                  print('password sending starts');
                }
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
                // ignore: use_build_context_synchronously
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Réinitialisation de mot de passe"),
                      content: Text(
                          "Un e-mail de réinitialisation a été envoyé à ${usernameController.text}"),
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
                try {
                  await FirebaseAuth.instance
                      .sendPasswordResetEmail(email: usernameController.text);
                  if (kDebugMode) {
                    print('password sent');
                  }
                } catch (e) {
                  if (kDebugMode) {
                    print('error while sending password : ');
                  }
                  if (kDebugMode) {
                    print(e.toString());
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _toggleVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }
}

Future<void> logout(BuildContext context) async {
  AuthService authService = AuthService.instance;
  //ProfileStorage.clear();
  //l'utilisateur est déconnecté
  await authService.signOut();
  //ignore: use_build_context_synchronously
  return context.go('/');
}
