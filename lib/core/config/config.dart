import 'package:flutter/foundation.dart';

class Config {
  static const baseUrl = 'https://629867c8de3d7eea3c664c1a.mockapi.io';
  static const apiKey = 'API_KEY';
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
