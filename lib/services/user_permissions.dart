import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class UserPermissions{
  FirebaseMessaging messagingInstance = FirebaseMessaging.instance;

  void requestNotificationPermissions() async {
    NotificationSettings settings = const NotificationSettings(
      alert: AppleNotificationSetting.enabled,
      announcement: AppleNotificationSetting.enabled,
      authorizationStatus: AuthorizationStatus.provisional,
      badge: AppleNotificationSetting.enabled,
      carPlay: AppleNotificationSetting.enabled,
      lockScreen: AppleNotificationSetting.enabled,
      notificationCenter: AppleNotificationSetting.enabled,
      showPreviews: AppleShowPreviewSetting.always,
      timeSensitive: AppleNotificationSetting.enabled,
      criticalAlert: AppleNotificationSetting.disabled,
      sound: AppleNotificationSetting.enabled,
    );

    if (kDebugMode) {
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('permission allowed ${settings.authorizationStatus}');
      } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
        print('permission allowed ${settings.authorizationStatus}');
      } else {
        print('permission denied ${settings.authorizationStatus}');
      }
    }
  }

  Future<String?> getDeviceToken() async {
    try {
      print('call');
      var token = await messagingInstance.getToken();
      print('Token is $token');
      return token;
    } catch (e) {
      print('ERROR $e');
    }
  }
}