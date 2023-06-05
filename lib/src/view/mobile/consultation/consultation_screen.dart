import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../viewModel/message_view_model.dart';
import '../authentication/auth_service.dart';
import '../authentication/login.dart';
import 'components/banner_carousel.dart';
import 'components/notification_sent_builder.dart';
import 'components/title_notifications_sent.dart';

class ConsultationScreen extends StatefulWidget {
  const ConsultationScreen({super.key});

  @override
  State<ConsultationScreen> createState() => _ConsultationScreenState();
}

class _ConsultationScreenState extends State<ConsultationScreen> {
  AuthService authService = AuthService.instance;

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
            return Center(
                child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 5.0),
                  const BannerCarousel(),
                  const SizedBox(height: 5.0),
                  titleNotificationsSent(context),
                  Expanded(
                    child: ChangeNotifierProvider(
                      create: (context) => MessageViewModel(),
                      builder: ((context, child) => NotificationSent(
                            userId: userId,
                          )),
                    ),
                  ),
                ],
              ),
            ));
          } else {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          }
        }
        //en cas d'erreur quelconque (result.hasError)
        return Center(child: Text('Erreur: ${result.error}'));
      },
    );
  }
}
