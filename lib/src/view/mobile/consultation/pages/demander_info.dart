import 'package:afya/src/view/mobile/consultation/components/title_demande_infos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:afya/src/application_state.dart';
import 'package:afya/src/viewModel/message_view_model.dart';
import 'package:afya/src/view/mobile/consultation/components/components.dart';

class DemanderInfos extends StatefulWidget {
  const DemanderInfos({super.key, this.title = "Demander des informations"});

  final String title;

  @override
  State<DemanderInfos> createState() => _DemanderInfosState();
}

class _DemanderInfosState extends State<DemanderInfos> {
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
              titleDemandeInfo(),
              ChangeNotifierProvider(
                create: (context) => MessageViewModel(),
                builder: ((context, child) => FormDemanderInfos(
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
