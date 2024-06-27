import 'package:flutter/foundation.dart';

class Config {
  static const baseUrl = 'hhttps://newsapi.org/v2/';
  static const apiKey = 'ff111c0a436344aca361e1d6f0826659';
  static const geminiKey = "AIzaSyAR0_63vEuG3mpV48zKLiS4_jxtBGUgiyA";
  static const notificationChannelId = 'nutrisee_channel_id';
  static const notificationChannelName = 'nutrisee notification';
  static const notificationChannelDesc = 'nutrisee notification';
  static const savedNotification = 'FCM_MESSAGE';
  static const timeout =
      kDebugMode ? Duration(seconds: 90) : Duration(seconds: 10);
  static const screenWidth = 390.0;
  static const screenHeight = 800.0;
}
