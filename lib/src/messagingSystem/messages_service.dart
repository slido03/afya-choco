//import 'package:flutter/foundation.dart';
//import 'package:afya/src/repository/repositories.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

/* In this file we configure the firebase cloud_messaging for sending messages in
our app */

class MessageService {
  //return the mobile app fcm token to identifie the current mobile device
  static Future<String?> getMobileAppToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    return fcmToken;
  }
}
