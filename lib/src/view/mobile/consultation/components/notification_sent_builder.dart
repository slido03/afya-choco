import 'package:afya/src/repository/repositories.dart';
import 'package:afya/src/view/mobile/authentication/login.dart';
import 'package:afya/src/view/mobile/consultation/components/notification_view.dart';
import 'package:flutter/material.dart';
import 'package:afya/src/viewModel/message_view_model.dart';
import 'package:provider/provider.dart';
//import '../../../../model/notifications/message.dart';

/*
 * This class is used to display the first presentation of the app
*/
class NotificationSent extends StatefulWidget {
  const NotificationSent({super.key, required this.userId});
  final String? userId;

  @override
  State<NotificationSent> createState() => _NotificationSentState();
}

class _NotificationSentState extends State<NotificationSent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MessageViewModel>(
        builder: (context, messageViewModel, child) {
      if (widget.userId != null) {
        Future<List<Message>> messages = messageViewModel.listerEnvoyeObjet(
          widget.userId!,
          ObjetMessage.prendreRendezVous,
        );
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
                  return Center(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: msgRecus.length,
                      itemBuilder: (context, index) {
                        return NotificationView(
                          message: msgRecus[index],
                        );
                      },
                    ),
                  );
                } else {
                  return Center(
                      child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.only(top: 40),
                    child: Text(
                      'Aucun message envoyé',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueGrey[200],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ));
                }
              } else {
                return Center(
                    child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.only(top: 40),
                  child: Text(
                    'Aucun message envoyé',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueGrey[200],
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
