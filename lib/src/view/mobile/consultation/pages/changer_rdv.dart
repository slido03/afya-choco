import 'package:afya/src/viewModel/rendez_vous_view_model.dart';
import 'package:flutter/material.dart';
import 'package:afya/src/view/mobile/authentication/authentication.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
//import 'package:afya/src/application_state.dart';
import 'package:afya/src/view/mobile/consultation/components/components.dart';

class ChangerRdv extends StatefulWidget {
  const ChangerRdv({super.key, this.title = 'Changer de rendez-vous'});

  final String title;

  @override
  State<ChangerRdv> createState() => _ChangerRdvState();
}

class _ChangerRdvState extends State<ChangerRdv> {
  AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<String?> uid = authService.getCurrentUserUid();
    return FutureBuilder(
        future: Future.wait([uid]),
        builder: (context, result) {
          if (result.connectionState == ConnectionState.waiting) {
            return Center(
                child: Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            ));
          } else if (result.hasData) {
            final List<String?> data = result.data!;
            final userId = data[0];
            //si l'utilisateur est connecté
            if (userId != null) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(widget.title),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      titleChangerRdv(),
                      ChangeNotifierProvider(
                        create: (context) => RendezVousViewModel(),
                        builder: ((context, child) => FormChangerRdv(
                              userId: userId,
                            )),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            }
          }
          //en cas d'erreur quelconque (snapshot.hasError)
          return Center(child: Text('Erreur: ${result.error}'));
        });
  }
}
