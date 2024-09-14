import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:untitled/services/user_permissions.dart';
import '../services/firebase_notifiction_service.dart';
import '../services/server_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  NotificationServices notifications = NotificationServices();
  UserPermissions permissions = UserPermissions();
  TextEditingController messageController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    permissions.requestNotificationPermissions();
    notifications.firebaseInit(context);
    notifications.setupInteractMessage(context);
    permissions.getDeviceToken().then((val){
      print('Value $val');
    });
  }
  @override
  Widget build(BuildContext context) {


    return  Scaffold(
appBar: AppBar(
  title: Text('Notifications'),
),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: messageController ,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.black)
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.black)
                ),
                hintText: "Message"
              ),
            ),
            SizedBox(height: 20,),
            Center(
              child: TextButton(
                onPressed: (){
                  notifications.sendNotificationFromOneDeviceToOther(messageController.text);
            },
                  child: Text('Send Message'),)
            ),
          ],
        ),
      )
    );
  }
}
