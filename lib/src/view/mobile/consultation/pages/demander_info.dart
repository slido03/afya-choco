import 'package:afya/src/view/mobile/consultation/components/title_demande_infos.dart';
import 'package:flutter/material.dart';
import 'dart:async';
//import 'package:provider/provider.dart';
import 'package:afya/src/view/mobile/authentication/authentication.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:afya/src/application_state.dart';
//import 'package:afya/src/viewModel/message_view_model.dart';
import 'package:afya/src/view/mobile/consultation/components/components.dart';

class DemanderInfos extends StatefulWidget {
  const DemanderInfos({super.key, this.title = "Demande d'informations"});

  final String title;

  @override
  State<DemanderInfos> createState() => _DemanderInfosState();
}

class _DemanderInfosState extends State<DemanderInfos> {
  AuthService authService = AuthService.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<String?> uid = authService.getCurrentUserUid();
    Future<String?> email = authService.getCurrentUserEmail();
    return FutureBuilder(
        future: Future.wait([
          uid,
          email,
        ]),
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
            final userEmail = data[1];
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
                      titleDemandeInfo(),
                      FormDemanderInfos(
                        userId: userId,
                        email: userEmail,
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
