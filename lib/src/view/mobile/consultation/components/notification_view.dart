import 'package:flutter/material.dart';
import 'package:afya/src/model/models.dart';
import 'package:intl/intl.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      color: (message.statut == StatutMessage.traite)
          ? Colors.white
          : const Color.fromARGB(255, 231, 248, 232),
      //margin: const EdgeInsets.symmetric(vertical: 5.0),
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
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: const TextStyle(
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }
}

extension FormatDate on DateTime {
  String get dateFormatted => DateFormat('dd/MM/yyyy').format(this);
  String get timeFormatted => DateFormat('HH:mm').format(this);
}
