import 'package:afya/src/model/models.dart';
import 'package:afya/src/view/mobile/consultation/components/notification_view.dart';
import 'package:flutter/material.dart';

/*
  * Widget qui affiche les détails d'une notification
*/
class NotificationPresentation extends StatelessWidget {
  const NotificationPresentation({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
      ),
      body: SingleChildScrollView(
        child: Card(
          elevation: (message.statut == StatutMessage.traite) ? 1.5 : 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 15.0,
            ),
            //margin: const EdgeInsets.symmetric(vertical: 5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: (message.statut == StatutMessage.traite)
                  ? Colors.white
                  : const Color.fromARGB(255, 231, 248, 232),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        message.dateHeure.dateFormatted,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        message.dateHeure.timeFormatted,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                // statut
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 10.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: (message.statut == StatutMessage.traite)
                        ? Colors.green[600]
                        : Colors.orange[800],
                  ),
                  child: Text(
                    message.statut.value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                // objet
                Text(
                  message.objet.value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                // contenu
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    message.contenu,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
