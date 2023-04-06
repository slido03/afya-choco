import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:afya/src/application_state.dart';
import 'package:afya/src/viewModel/message_view_model.dart';
import 'package:afya/src/view/mobile/consultation/components/components.dart';

class PrendreRdv extends StatefulWidget {
  const PrendreRdv({super.key, this.title = "Prendre rendez-vous"});

  final String title;

  @override
  State<PrendreRdv> createState() => _PrendreRdvState();
}

class _PrendreRdvState extends State<PrendreRdv> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(builder: (context, appState, child) {
      User? user;
      //si l'user est connecté uid contient son uid
      if (appState.loggedIn) {
        user = appState.currentUser!;
      }
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              titlePriseRdv(),
              ChangeNotifierProvider(
                create: (context) => MessageViewModel(),
                builder: ((context, child) => FormPrendreRdv(
                      user: user,
                    )),
              ),
            ],
          ),
        ),
      );
    });
  }
}
