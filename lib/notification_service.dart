import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

import 'message_screen.dart';

class NotificationService {
  String token = "";
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("User granted provisional permission");
    } else {
      print("User declined or has not accepted   permission");
    }
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }
  void getToken() async {
    await messaging.getToken().then((tokendata) {
      token = tokendata!;
      print(
          "My Token aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa $token");
    });
    saveToken(token);
  }

  void isTokenrefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
    });
  }

  void saveToken(String token) async {
    await FirebaseFirestore.instance.collection("UserTokens").doc("User1").set({
      'token': token,
    });
  }
  initLocalNotification(BuildContext context,RemoteMessage message) async {
    var androidInitialize =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettings =
        InitializationSettings(android: androidInitialize);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) async {
      handleMessage(context, message);
        });

  }

  firbaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      print("...................onMessage.......................");

      print(
          "onMessage: ${message.notification!.title} / ${message.notification!.body}");
      print(message.data["id"]);
      if(Platform.isIOS){
        forgroundMessage();
      }


      if(Platform.isAndroid){
        initLocalNotification(context, message);
        showNotification(message);
      }else{
        showNotification(message);
      }

    });

  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(1000).toString(), "name",
        importance: Importance.max);
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        message.notification!.body.toString(),
        htmlFormatBigText: true,
        contentTitle: message.notification!.title.toString(),
        htmlFormatContentTitle: true);

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            channel.id.toString(), channel.name.toString(),
            channelDescription: "HIiiii",
            importance: Importance.max,
            priority: Priority.high,
            ticker: "ticker",
            styleInformation: bigTextStyleInformation,
            playSound: true);
    const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
        presentAlert: true ,
        presentBadge: true ,
        presentSound: true
    ) ;
    NotificationDetails platformChannelSpecifiics =
        NotificationDetails(android: androidNotificationDetails,iOS: darwinNotificationDetails);

    Future.delayed(Duration.zero, () async {
      await flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title.toString(),
          message.notification!.body,
          platformChannelSpecifiics,
          payload: message.data['body'],);
    });
  }

  void handleMessage(BuildContext context,RemoteMessage message){
    if(message.data['type'] =='chat'){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => MessageScreen(
            id: message.data['id'] ,
          )));
    }

  }

  Future<void> setupInteractMessage(BuildContext context)async{

    // when app is terminated
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if(initialMessage != null){
      handleMessage(context, initialMessage);
    }


    //when app ins background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });

  }



  void sendPushMessage(String token, String body, String title) async {
    var d = {
      'priority': 'high',
      'data': <String, dynamic>{
        'click_action': 'Flutter_Notification_Click',
        'status': 'done',
        'body': body,
        'title': title,
      },
      "notification": <String, dynamic>{
        'body': body,
        'title': title,
        'android_channel_id': "ddddd"
      },
      'to': token
    };
    var data = {
      'to': token.toString(),
      'notification': {
        'title': title.toString(),
        'body': body.toString(),
      },
      'android': {
        'notification': {
          'notification_count': 23,
        },
      },
      'data': {'type': 'msj', 'id': 'Asif Taj'}
    };
    // print("dataaaaaaaaaaaa$data");
    await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: jsonEncode(d),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'key=$token'
        }).then((value) {
      print("ssssssssssssssssssssssssss");
      print(value.toString());
      print(value.body.toString());
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error);
      }
    });
    // try{
    //   await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
    //   headers: <String,String>{
    //     'Content-Type':'application/json',
    //     'Authorization':"key=eGBmijptRgiDZaC8Mgrd6M:APA91bF0Wf-U7pNgjbZHhldcbc9QlyfDZSy2WA1P9YCgHNBOfytzVoJA8SSVBA91KiNmkOsbzQT--RQj7vb5AR1QKDFcRIkSYEMJ3mLqoOT37L8CN3hd1ofXvHF2YuS45lT9xc4msiPS"
    //
    //   },
    //
    //     body: jsonEncode(<String,dynamic>{
    //       'priority':'high',
    //       'data':<String,dynamic>{
    //         'click_action':'Flutter_Notification_Click',
    //         'status':'done',
    //         'body':body,
    //         'title':title,
    //       },
    //       "notification":<String,dynamic>{
    //         'body':body,
    //         'title':title,
    //         'android_channel_id':"ddddd"
    //       },
    //       'to':token
    //     })
    //   );
    // }catch(e){
    //
    //
    // }
  }
  Future forgroundMessage() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}
