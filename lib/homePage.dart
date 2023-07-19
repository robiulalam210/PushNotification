import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

import 'notification_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController bodycontroller = TextEditingController();
  NotificationService notificationService = NotificationService();

  @override
  void initState() {
    // TODO: implement initState
    notificationService.requestPermission();
    notificationService.getToken();
    notificationService.getDeviceToken();
    notificationService.isTokenrefresh();
    setState(() {});
    notificationService. firbaseInit(context) ;
    notificationService.setupInteractMessage(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: namecontroller,
              decoration: InputDecoration(
                  hintText: "Name Data",
                  contentPadding: EdgeInsets.all(0),
                  border: OutlineInputBorder(
                      gapPadding: 4, borderRadius: BorderRadius.circular(10))),
            ),
            TextField(
              controller: titlecontroller,
              decoration: InputDecoration(
                  hintText: "Title Data",
                  contentPadding: EdgeInsets.all(0),
                  border: OutlineInputBorder(
                      gapPadding: 4, borderRadius: BorderRadius.circular(10))),
            ),
            TextField(
              controller: bodycontroller,
              decoration: InputDecoration(
                  hintText: "Body Data",
                  contentPadding: EdgeInsets.all(0),
                  border: OutlineInputBorder(
                      gapPadding: 4, borderRadius: BorderRadius.circular(10))),
            ),
            // TextButton(
            //     onPressed: () async {
            //       String name = namecontroller.text.trim();
            //       String title = titlecontroller.text.trim();
            //       String body = bodycontroller.text.trim();
            //
            //       if (name != "") {
            //         DocumentSnapshot snp = await FirebaseFirestore.instance
            //             .collection("UserTokens")
            //             .doc(name)
            //             .get();
            //         String token = snp['token'];
            //         print("token$token");
            //         setState(() {});
            //         notificationService.sendPushMessage(token, body, title);
            //       }
            //     },
            //     child: Text("Submit"))

        Center(
          child: TextButton(onPressed: (){

            // send notification from one device to another
            notificationService.getDeviceToken().then((value)async{

              var data = {
                'to' : value.toString(),
                'priority':'high',
                'notification' : {
                  'title' : 'Robiul Alam' ,
                  'body' : 'Subscribe to my channel' ,
                  "sound": "jetsons_doorbell.mp3"
                },
                'android': {
                  'notification': {
                    'notification_count': 23,
                  },
                },
                'data' : {
                  'type' : 'chat' ,
                  'id' : 'Asif Taj'
                }
              };

              await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
                  body: jsonEncode(data) ,
                  headers: {
                    'Content-Type': 'application/json; charset=UTF-8',
                    'Authorization' : 'key=AAAASay1-zk:APA91bFdA0i26_fbvfQGEaGBkb6JGyXbKXimIOETxBObrFWbuQ4cUmq1aYQyypEgjj8Cp3fWBPqNZ15Ydp94v2UyfF1RV1b4VQO1P0rhUcgWUA1IwahkU_0xvYWLLo6zZL-gjUzVOqZy'
                  }
              ).then((value){
                if (kDebugMode) {
                  print(value.body.toString());
                }
              }).onError((error, stackTrace){
                if (kDebugMode) {
                  print(error);
                }
              });
            });
          },
              child: Text('Send Notifications')),
        ),

          ],
        ),
      ),
    );
  }
}
