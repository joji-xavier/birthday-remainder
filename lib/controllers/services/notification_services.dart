import 'package:birthday_reminder/view/screen/user_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:get/get.dart';

class NotifyHelper{
   FlutterLocalNotificationsPlugin
  flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin(); //

  initializeNotification() async {
    tz.initializeTimeZones();
 final IOSInitializationSettings initializationSettingsIOS =
     IOSInitializationSettings(
         requestSoundPermission: false,
         requestBadgePermission: false,
         requestAlertPermission: false,
         onDidReceiveLocalNotification: onDidReceiveLocalNotification
     );

 const AndroidInitializationSettings initializationSettingsAndroid =
     AndroidInitializationSettings("appicon");


    final InitializationSettings initializationSettings =
        InitializationSettings(
       iOS: initializationSettingsIOS,
       android:initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onSelectNotification: selectNotification);

 
  }
  Future selectNotification(String? payload) async {
    if (payload != null) {
    } else {
    }
     Get.to(()=>const UserScreen());
  }
  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  scheduledNotification({String ? title, String? note}) async {
     await flutterLocalNotificationsPlugin.zonedSchedule(
         0,
         title,
           note,
         tz.TZDateTime.now(tz.local).add(const Duration(seconds: 30)),
         const NotificationDetails(
             android: AndroidNotificationDetails('your channel id',
                 'your channel name', 'your channel description')),
         androidAllowWhileIdle: true,
         uiLocalNotificationDateInterpretation:
             UILocalNotificationDateInterpretation.absoluteTime);

   }
   displayNotification({required String title, required String body}) async {
    var androidPlatformChannelSpecifics =  const AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics =  const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'You change your theme',
      'You changed your theme back !',
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }
   Future onDidReceiveLocalNotification(
      int? id, String? title, String? body, String? payload) async {
    
    Get.dialog(const Text(''));
  }
  
}