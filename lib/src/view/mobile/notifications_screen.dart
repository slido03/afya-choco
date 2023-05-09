//import 'package:afya/src/model/models.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:afya/src/view/mobile/consultation/components/components.dart';
import 'package:afya/src/view/mobile/authentication/authentication.dart';
import 'package:afya/src/viewModel/message_view_model.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  AuthService authService = AuthService.instance;

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
                appBar: AppBar(),
                body: Center(
                  child: Column(
                    children: [
                      titleNotifications(context),
                      Expanded(
                        child: ChangeNotifierProvider(
                          create: (context) => MessageViewModel(),
                          builder: ((context, child) => NotificationBuilder(
                                userId: userId,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              //si l'userId est nul c'est que l'utilisateur est déconnecté et donc on le ramène à la page de login
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            }
          }
          //en cas d'erreur quelconque (snapshot.hasError)
          return Center(child: Text('erreur : ${result.error}'));
        });
  }
}
