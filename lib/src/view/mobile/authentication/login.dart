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
  int _counter =
      0; // initialisation du compteur, ce sera le nombre de fois où l'on ouvre l'application

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
                "Consultaion",
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          ),
        },
        onSkip: () => {
          _incrementCounter(),
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          ),
        },
        showSkipButton: true,
        skip: const Text("Passer"),
        next: const Icon(Icons.arrow_forward),
        back: const Icon(Icons.arrow_back),
        done: const Text("Fait", style: TextStyle(fontWeight: FontWeight.w600)),
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Color(0xFFBDBDBD),
          activeSize: Size(22.0, 10.0),
          activeColor: Colors.green,
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
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
                        ElevatedButton(
                          child: const Text(
                            'Se connecter',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          onPressed: () async {
                            if (await signInWithEmailAndPassword(
                                _emailController.text,
                                _passwordController.text)) {
                              // ignore: use_build_context_synchronously
                              _navigateToHome(context);
                            } else {
                              const snackBar = SnackBar(
                                  padding: EdgeInsets.only(bottom: 50, top: 30),
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
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if ((userCredential.user != null)) {
        if ((userCredential.user!.emailVerified)) {
          // L'utilisateur a été connecté avec succès et a son email vérifié
          // On redirige l'utilisateur vers la page d'accueil
          return true;
        }
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  void _navigateToHome(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (context) =>
              const HomePage(title: 'HomePage')), //à changer par la home page
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
                await FirebaseAuth.instance
                    .sendPasswordResetEmail(email: email!);
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
              },
            ),
          ],
        );
      },
    );
  }
}

Future<void> logout(BuildContext context) async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    await FirebaseAuth.instance.signOut();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (context) => const LoginPage()), //à changer par la home page
    );
  }
}
