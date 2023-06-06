import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late bool _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    //final formKey = GlobalKey<FormState>();
    return Container(
      //width: 20,
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.green,
      ),
      child: SingleChildScrollView(
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
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                  hintText: 'Adresse e-mail',
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
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    hintText: 'Mot de passe',
                    suffixIcon: IconButton(
                      icon: Icon(_passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    )),
                obscureText: !_passwordVisible,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const TextButton(
            onPressed: null,
            child: Text('Mot de passe oublie?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(37, 107, 211, 0.27),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: const Size(448, 60),
              ),
              onPressed: null,
              child: const Text(
                'Se connecter',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          )
        ],
      )),
    );
  }
}
