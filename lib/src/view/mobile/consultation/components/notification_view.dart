import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:afya/src/model/models.dart';
import 'package:intl/intl.dart';

import 'notification_presentation.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: (message.statut == StatutMessage.traite) ? 1.5 : 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        child: Container(
          padding: const EdgeInsets.all(10.0),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    message.dateHeure.dateFormatted,
                    style: const TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                  Text(
                    message.dateHeure.timeFormatted,
                    style: const TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 2,
              ),

              // objet
              Text(
                message.objet.value,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              // content of notification

              Text(
                message.contenu,
                style: const TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
        // effet de click sur la notification
        onTap: () {
          // conduire à la page de présentation de la notification
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotificationPresentation(
                message: message,
              ),
            ),
          );
          if (kDebugMode) {
            print('Notification clicked');
          }
        },
      ),
    );
  }
}

extension FormatDate on DateTime {
  String get dateFormatted => DateFormat('dd/MM/yyyy').format(this);
  String get timeFormatted => DateFormat('HH:mm').format(this);
}
