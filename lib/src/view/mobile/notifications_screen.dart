import 'package:flutter/material.dart';

import 'consultation/components/title_notificaions.dart';
import 'consultation/components/notification_view.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  final List<Map<String, dynamic>> _notifications = const [
    {
      'date': '26/03/2023',
      'heure': '12:00',
      'title': 'Rendez-vous avec le Dr. Jean',
      'description': 'Votre rendez-vous est confirmé avec le Dr. Jean à 12h00',
      'readed': false,
    },
    {
      'date': '25/03/2023',
      'heure': '10:00',
      'title': 'Demande de rendez-vous avec le Dr. Koffi',
      'description': 'Votre rendez-vous est confirmé',
      'readed': false,
    },
    {
      'date': '12/12/2020',
      'heure': '12:00',
      'title': 'Rendez-vous',
      'description': 'Votre rendez-vous est confirmé',
      'readed': false,
    },
    {
      'date': '12/12/2020',
      'heure': '12:00',
      'title': 'Rendez-vous',
      'description': 'Votre rendez-vous est confirmé',
      'readed': true,
    },
    {
      'date': '12/12/2020',
      'heure': '12:00',
      'title': 'Rendez-vous',
      'description': 'Votre rendez-vous est confirmé',
      'readed': false,
    },
    {
      'date': '12/12/2020',
      'heure': '12:00',
      'title': 'Rendez-vous',
      'description': 'Votre rendez-vous est confirmé',
      'readed': true,
    },
    {
      'date': '12/12/2020',
      'heure': '12:00',
      'title': 'Rendez-vous',
      'description': 'Votre rendez-vous est confirmé',
      'readed': false,
    },
    {
      'date': '12/12/2020',
      'heure': '12:00',
      'title': 'Rendez-vous',
      'description': 'Votre rendez-vous est confirmé',
      'readed': true,
    },
    {
      'date': '12/12/2020',
      'heure': '12:00',
      'title': 'Rendez-vous',
      'description': 'Votre rendez-vous est confirmé',
      'readed': false,
    },
    {
      'date': '12/12/2020',
      'heure': '12:00',
      'title': 'Rendez-vous',
      'description': 'Votre rendez-vous est confirmé',
      'readed': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Center(
        child: Column(
          children: [
            titleNotifications(context),
            Expanded(
              child: ListView.builder(
                itemCount: _notifications.length,
                itemBuilder: (context, index) {
                  return NotificationView(
                    datas: _notifications[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
