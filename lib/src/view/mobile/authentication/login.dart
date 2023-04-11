import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './authentication.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? get email => _emailController.text;
  // initialisation du compteur, ce sera le nombre de fois où l'on ouvre l'application
  int _counter = 0;

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // permet de charger le compteur
  void _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0);
    });
  }

  // permet d'incrémenter le compteur
  void _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0) + 1;
      prefs.setInt('counter', _counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    double maxwidth = MediaQuery.of(context).size.width * .80;
    if (_counter == 0) {
      return IntroductionScreen(
        pages: [
          PageViewModel(
            titleWidget: const Center(
              child: Text(
                "Bienvenue sur Afya",
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.green,
                ),
              ),
            ),
            image: const Center(
              child: Icon(
                Icons.android,
                size: 100,
                color: Colors.green,
              ),
            ),
            body:
                "Une application qui facilite votre vie hospitalière et médicale",
            decoration: const PageDecoration(
              titleTextStyle:
                  TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
              bodyTextStyle: TextStyle(fontSize: 18.0),
              pageColor: Colors.white,
              imagePadding: EdgeInsets.zero,
            ),
          ),
          PageViewModel(
            titleWidget: const Center(
              child: Text(
                "Consultation",
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.green,
                ),
              ),
            ),
            body:
                "Vous pouvez prendre rendez-vous avec votre médecin, demander des informations à votre Clinique ou à votre pharmacie, et bien plus encore.",
            image: const Center(
              child: Icon(
                //FlutterMaterialSymbols.calendar,
                Icons.medical_services_rounded,
                size: 100,
                color: Colors.green,
              ),
            ),
            decoration: const PageDecoration(
              titleTextStyle:
                  TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
              bodyTextStyle: TextStyle(fontSize: 18.0),
              pageColor: Colors.white,
              imagePadding: EdgeInsets.zero,
            ),
          ),
          PageViewModel(
            titleWidget: const Center(
              child: Text(
                "Carnet de santé",
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.green,
                ),
              ),
            ),
            body:
                "Vous pouvez consulter votre dossier médical, vos résultats d'analyses, vos ordonnances, vos vaccins, et bien plus encore.",
            image: const Center(
              child: Icon(
                Icons.book,
                size: 100,
                color: Colors.green,
              ),
            ),
            decoration: const PageDecoration(
              titleTextStyle:
                  TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
              bodyTextStyle: TextStyle(fontSize: 18.0),
              pageColor: Colors.white,
              imagePadding: EdgeInsets.zero,
            ),
          ),
          PageViewModel(
            titleWidget: const Center(
              child: Text(
                "Agenda médical",
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.green,
                ),
              ),
            ),
            body:
                "Vous pouvez consulter votre agenda médical, et avoir des rappels de vos rendez-vous, et bien plus encore.",
            image: const Center(
              child: Icon(
                Icons.calendar_month,
                size: 100,
                color: Colors.green,
              ),
            ),
            decoration: const PageDecoration(
              titleTextStyle:
                  TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
              bodyTextStyle: TextStyle(fontSize: 18.0),
              pageColor: Colors.white,
              imagePadding: EdgeInsets.zero,
            ),
          ),
        ],
        onDone: () => {
          _incrementCounter(),
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          ),
        },
        onSkip: () => {
          _incrementCounter(),
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          ),
        },
        showSkipButton: true,
        skip: MediaQuery.of(context).size.width < 335
            ? const Text("Passer",
                style: TextStyle(
                  fontSize: 10,
                ))
            : const Text(
                "Passer",
              ),
        done: const Text("Fait", style: TextStyle(fontWeight: FontWeight.w600)),
        next: MediaQuery.of(context).size.width < 335
            ? const Icon(
                Icons.arrow_forward,
                size: 14,
              )
            : const Icon(Icons.arrow_forward),
        back: const Icon(Icons.arrow_back),
        dotsFlex: 2,
        controlsPadding: MediaQuery.of(context).size.width < 335
            ? const EdgeInsets.all(10)
            : const EdgeInsets.all(16),
        dotsDecorator: DotsDecorator(
          size: MediaQuery.of(context).size.width < 335
              ? const Size(7.0, 7.0)
              : const Size(10.0, 10.0),
          color: const Color(0xFFBDBDBD),
          activeSize: MediaQuery.of(context).size.width < 335
              ? const Size(14.0, 7.0)
              : const Size(20.0, 10.0),
          activeColor: Colors.green,
          activeShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
          spacing: MediaQuery.of(context).size.width < 335
              ? const EdgeInsets.symmetric(horizontal: 2.5)
              : const EdgeInsets.symmetric(horizontal: 5.0),
        ),
      );
    }
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
              key: _formKey,
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
                          'Bienvenu(e) dans Afya, votre santé en poche.',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
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
                            child: const Text(
                                'Nouvel utilisateur? Créez un compte')),
                        InputEmail(
                          labelText: 'Email',
                          hintText: 'Votre email',
                          controller: _emailController,
                        ),
                        InputPassword(
                          labelText: 'Mot de passe',
                          hintText: 'Votre mot de passe',
                          controller: _passwordController,
                        ),
                        const SizedBox(height: 5.0),
                        TextButton(
                            onPressed: () {
                              _resetPassword(context);
                            },
                            child: const Text('Mot de passe oublié?')),
                        const SizedBox(
                          height: 20,
                        ),
                        // login button
                        _isLoading
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                                child: const Text(
                                  'Se connecter',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                onPressed: () async {
                                  bool signedIn =
                                      await signInWithEmailAndPassword(
                                          _emailController.text,
                                          _passwordController.text);
                                  if (signedIn) {
                                    if (kDebugMode) {
                                      print('user signed in');
                                    }
                                    // ignore: use_build_context_synchronously
                                    _navigateToHome(context);
                                  } else {
                                    const snackBar = SnackBar(
                                        padding: EdgeInsets.only(
                                            bottom: 50, top: 30),
                                        content: Text(
                                            'Désolé votre email ou mot de passe sont invalides ou non vérifiés ou votre compte a été désactivé'));
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

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    AuthService authService = AuthService();
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
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (context) => const HomePage(title: 'HomePage')),
    );
  }

  void _resetPassword(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Réinitialisation de mot de passe"),
          content: InputEmail(
            labelText: 'Email',
            hintText: 'Votre email',
            controller: _emailController,
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
                try {
                  await FirebaseAuth.instance
                      .sendPasswordResetEmail(email: email!);
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
}

Future<void> logout(BuildContext context) async {
  AuthService authService = AuthService();
  //l'utilisateur est déconnecté
  await authService.signOut();
  // ignore: use_build_context_synchronously
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => const LoginPage()),
  );
}
