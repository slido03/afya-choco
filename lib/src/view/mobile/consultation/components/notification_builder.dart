import 'package:flutter/material.dart';
import 'package:afya/src/model/models.dart';
import 'package:provider/provider.dart';
import 'package:afya/src/viewModel/message_view_model.dart';
//import 'package:afya/src/view/mobile/home_page.dart';
import 'package:afya/src/view/mobile/authentication/login.dart';
import 'package:afya/src/view/mobile/consultation/components/components.dart';

//construit la liste de message en fonction du stream de messages
class NotificationBuilder extends StatefulWidget {
  const NotificationBuilder({super.key, required this.userId});
  final String? userId;

  @override
  State<NotificationBuilder> createState() => _NotificationBuilderState();
}

class _NotificationBuilderState extends State<NotificationBuilder> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MessageViewModel>(
        builder: (context, messageViewModel, child) {
      if (widget.userId != null) {
        Future<List<Message>> messages =
            messageViewModel.listerRecu(widget.userId!);
        return StreamBuilder<List<Message>>(
          stream: Stream.fromFuture(messages),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ));
            } else if (snapshot.hasData) {
              //si le stream contient des données
              final msgRecus = snapshot.data;
              if (msgRecus != null) {
                if (msgRecus.isNotEmpty) {
                  return SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: msgRecus.length,
                              itemBuilder: (context, index) {
                                return NotificationView(
                                  message: msgRecus[index],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Center(
                      child: Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text(
                      'Aucune notification disponible pour le moment',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ));
                }
              } else {
                return const Center(
                    child: Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Text(
                    'Aucune notification disponible pour le moment',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ));
              }
            } else {
              return Center(child: Text('erreur : ${snapshot.error}'));
            }
          },
        );
      } else {
        //si l'userId est nul c'est que l'utilisateur est déconnecté et donc on le ramène à la page de login
        return const LoginPage();
      }
    });
  }
}
