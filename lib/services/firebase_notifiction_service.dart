import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart'as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:untitled/services/server_key.dart';
import 'package:untitled/services/user_permissions.dart';
import 'package:untitled/view/message_screen.dart';




class NotificationServices {
  FirebaseMessaging messagingInstance = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


  void getDeviceTokenRefresh() {
    try {
      print('call');
      messagingInstance.onTokenRefresh.listen((event) {
        print(event.toString());
      });
    } catch (e) {
      print('ERROR $e');
    }
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      print('Message ${message.notification!.title}');
      print('Message body ${message.notification!.body}');
      if (Platform.isAndroid) {
        initNotifications(context, message);
        showNotifications(message);
      } else {
        showNotifications(message);
        foreGroundMassages();
      }
    });
  }

  void initNotifications(BuildContext context, RemoteMessage message) async {
    var androidInitializationSetting = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSetting = const DarwinInitializationSettings();

    var initSetting = InitializationSettings(
      android: androidInitializationSetting,
      iOS: iosInitializationSetting,
    );

    await plugin.initialize(
      initSetting,
      onDidReceiveNotificationResponse: (response) {
        notificationHandlerWithNavigator(context,message);
      },
    );
  }

  static void notificationHandlerWithNavigator(BuildContext context, RemoteMessage message) {
    if (message.data['title'] == 'massage') {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => MessageScreeen(message: message.data['massage'] ?? '',)));
    }
  }

  void showNotifications(RemoteMessage message) {
    if (kDebugMode) {
      print('notification call');
    }

    try {
      AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(10000).toString(),
        'Important',
        importance: Importance.max,
      );
      print(channel);

      AndroidNotificationDetails details = AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: 'important channel',
        importance: Importance.high,
        priority: Priority.high,
        ticker: 'ticker',
      );
      print(details);

      final DarwinNotificationDetails iosDetails = const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      NotificationDetails notificationDetails = NotificationDetails(
        android: details,
        iOS: iosDetails,
      );
      print(notificationDetails);

      Future.delayed(Duration.zero, () {
        print("show is ${plugin.show(0, message.notification!.title, message.notification!.body, notificationDetails)}");

        plugin.show(
          0,
          message.notification!.title,
          message.notification!.body,
          notificationDetails,

        );
      });
    } on Exception catch (e) {
      print("ERROR $e");
    }
  }


  Future<void> setupInteractMessage(BuildContext context)async{

    // when app is terminated
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if(initialMessage != null){
      notificationHandlerWithNavigator(context, initialMessage);
    }


    //when app is in  background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      notificationHandlerWithNavigator(context, event);
    });

  }


   Future<dynamic> sendNotificationFromOneDeviceToOther (String? massage)async {
    var serverKey = await ServerKeyService().getServiceKey();
    var deviceToken = await UserPermissions().getDeviceToken();
    print("Server key $serverKey");
    print("Device token $deviceToken");



    var data = {
      "message":{
        "token": deviceToken.toString(),
        "notification":{
          "body":"You receive a message",
          "title":"Message Alert"},
        'data' : {
          'title' : 'massage' ,
          'massage': massage?? ''
        }
      }
    };

    await http.post(Uri.parse('https://fcm.googleapis.com/v1/projects/fire-notifications-b065c/messages:send'),
        body: jsonEncode(data) ,
        headers : {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${serverKey.toString()}',
        }
    ).then((value){
      if (kDebugMode) {
        print("data is ${value.body.toString()}");
      }
    }).onError((error, stackTrace){
      if (kDebugMode) {
        print("error is $error");
      }

    });
  }

  Future foreGroundMassages()async{
await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
alert: true,
  badge: true,
  sound: true,
);

  }
}
