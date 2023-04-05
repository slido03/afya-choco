import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'register.dart';
import '../home_page.dart';

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
  int _counter = 0; // initialisation du compteur, ce sera le nombre de fois où l'on ouvre l'application

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
          body: "Une application qui facilite votre vie hospitalière et médicale",
          decoration: const PageDecoration(
            titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
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
          body: "Vous pouvez prendre rendez-vous avec votre médecin, demander des informations à votre Clinique ou à votre pharmacie, et bien plus encore.",
          image: const Center(
            child: Icon(
              //FlutterMaterialSymbols.calendar,
              Icons.medical_services_rounded,
              size: 100, 
              color: Colors.green,
            ),
          ),
          decoration: const PageDecoration(
            titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
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
          body: "Vous pouvez consulter votre dossier médical, vos résultats d'analyses, vos ordonnances, vos vaccins, et bien plus encore.",
          image: const Center(
            child: Icon(
              Icons.book,
              size: 100, 
              color: Colors.green,
            ),
          ),
          decoration: const PageDecoration(
            titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
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
          body: "Vous pouvez consulter votre agenda médical, et avoir des rappels de vos rendez-vous, et bien plus encore.",
          image: const Center(
            child: Icon(
              Icons.calendar_month,
              size: 100, 
              color: Colors.green,
            ),
          ),
          decoration: const PageDecoration(
            titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
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
                        setState(() {
                          _errorText = "L'email saisi n'est pas valide";
                          // Effacer la saisie incorrecte
                          _emailController.clear();
                        });
                      }
                      if (value.isEmpty) {
                        setState(() {
                          _errorText = 'Veuillez saisir un email valide';
                        });
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
                                'Désolé votre email ou mot de passe sont invalides ou non vérifiés ou votre compte a été désactivé'));
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

  void navigateToHome(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (context) =>
              const HomePage(title: 'HomePage')), //à changer par la home page
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
                setState(() {
                  errorText = "L'email saisi est invalide";
                  _emailController.clear();
                });
              }
              if (value.isEmpty) {
                setState(() {
                  errorText = 'Veuillez sasir un email valide';
                });
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
