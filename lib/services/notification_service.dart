// import 'dart:convert';
// import 'dart:developer';

// import 'package:emartdriver/main.dart';
// import 'package:emartdriver/rental_service/rental_service_dashboard.dart';
// import 'package:emartdriver/services/helper.dart';
// import 'package:emartdriver/ui/chat_screen/chat_screen.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Future<void> firebaseMessageBackgroundHandle(RemoteMessage message) async {
//   log("BackGround Message :: ${message.messageId}");
// }

// class NotificationService {
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   final GlobalKey<NavigatorState> navigatorKey =
//       new GlobalKey<NavigatorState>();

//   initInfo() async {
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//     var request = await FirebaseMessaging.instance.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );

//     if (request.authorizationStatus == AuthorizationStatus.authorized ||
//         request.authorizationStatus == AuthorizationStatus.provisional) {
//       const AndroidInitializationSettings initializationSettingsAndroid =
//           AndroidInitializationSettings('@mipmap/ic_launcher');
//       var iosInitializationSettings = const DarwinInitializationSettings();
//       final InitializationSettings initializationSettings =
//           InitializationSettings(
//               android: initializationSettingsAndroid,
//               iOS: iosInitializationSettings);
//       await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//           onDidReceiveNotificationResponse: (payload) {
//         _handleNotificationResponse(payload);
//       });
//       setupInteractedMessage();
//     }
//   }

//   Future<void> setupInteractedMessage() async {
//     RemoteMessage? initialMessage =
//         await FirebaseMessaging.instance.getInitialMessage();
//     if (initialMessage != null) {
//       FirebaseMessaging.onBackgroundMessage(
//           (message) => firebaseMessageBackgroundHandle(message));
//     }

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       log("::::::::::::onMessage:::::::::::::::::");
//       if (message.notification != null) {
//         log(message.notification.toString());
//         display(message);
//       }
//     });
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       log("::::::::::::onMessageOpenedApp:::::::::::::::::");
//       if (message.notification != null) {
//         log(message.notification.toString());
//         // display(message);

//         String orderId = message.data['orderId'];
//         print("shivani$orderId");
//         // if (message.data['type'] == 'rental_order') {
//         //   pushReplacement(
//         //       navigatorKey.currentContext!,
//         //       RentalServiceDashBoard(
//         //         user: MyAppState.currentUser!,
//         //       ));
//         // } else if (message.data['type'] == 'cab_parcel_chat' || message.data['type'] == 'vendor_chat') {
//         //   push(
//         //       navigatorKey.currentContext!,
//         //       ChatScreens(
//         //         orderId: orderId,
//         //         customerId: message.data['customerId'],
//         //         customerName: message.data['customerName'],
//         //         customerProfileImage: message.data['customerProfileImage'],
//         //         restaurantId: message.data['restaurantId'],
//         //         restaurantName: message.data['restaurantName'],
//         //         restaurantProfileImage: message.data['restaurantProfileImage'],
//         //         token: message.data['token'],
//         //         chatType: message.data['chatType'],
//         //         type: message.data['type'],
//         //       ));
//         // } else {
//         //   /// receive message through inbox
//         //   push(
//         //       navigatorKey.currentContext!,
//         //       ChatScreens(
//         //         orderId: orderId,
//         //         customerId: message.data['customerId'],
//         //         customerName: message.data['customerName'],
//         //         customerProfileImage: message.data['customerProfileImage'],
//         //         restaurantId: message.data['restaurantId'],
//         //         restaurantName: message.data['restaurantName'],
//         //         restaurantProfileImage: message.data['restaurantProfileImage'],
//         //         token: message.data['token'],
//         //         chatType: message.data['chatType'],
//         //       ));
//         // }
//       }
//     });
//     log("::::::::::::Permission authorized:::::::::::::::::");
//     await FirebaseMessaging.instance.subscribeToTopic("eMart_driver");
//   }

//   static getToken() async {
//     String? token = await FirebaseMessaging.instance.getToken();
//     return token!;
//   }

//   void display(RemoteMessage message) async {
//     log('Got a message whilst in the foreground!');
//     log('Message data: ${message.notification!.body.toString()}');
//     try {
//       // final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

//       AndroidNotificationChannel channel = const AndroidNotificationChannel(
//         "01",
//         "emart_driver",
//         description: 'Show Emart Notification',
//         importance: Importance.max,
//       );
//       AndroidNotificationDetails notificationDetails =
//           AndroidNotificationDetails(channel.id, channel.name,
//               channelDescription: 'your channel Description',
//               importance: Importance.high,
//               priority: Priority.high,
//               ticker: 'ticker');
//       const DarwinNotificationDetails darwinNotificationDetails =
//           DarwinNotificationDetails(
//               presentAlert: true, presentBadge: true, presentSound: true);
//       NotificationDetails notificationDetailsBoth = NotificationDetails(
//           android: notificationDetails, iOS: darwinNotificationDetails);
//       await FlutterLocalNotificationsPlugin().show(
//         0,
//         message.notification!.title,
//         message.notification!.body,
//         notificationDetailsBoth,
//         payload: jsonEncode(message.data),
//       );
//     } on Exception catch (e) {
//       log(e.toString());
//     }
//   }

//   void _handleNotificationResponse( payload) {
//     print("on notification tapped");
//     if (payload.payload != null) {
//       final Map<String, dynamic> data = jsonDecode(payload.payload!);
//       print("DATA IS$data");

//       // _handleNotificationData(data);
//     }
//   }
// }

/////new
import 'dart:convert';
import 'dart:developer';

import 'package:emartdriver/main.dart';
import 'package:emartdriver/rental_service/rental_service_dashboard.dart';
import 'package:emartdriver/services/helper.dart';
import 'package:emartdriver/ui/chatScreen.dart';
import 'package:emartdriver/ui/chat_screen/chat_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> firebaseMessageBackgroundHandle(RemoteMessage message) async {
  log("BackGround Message :: ${message.messageId}");
}

class NotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  initInfo() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    var request = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (request.authorizationStatus == AuthorizationStatus.authorized ||
        request.authorizationStatus == AuthorizationStatus.provisional) {
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      var iosInitializationSettings = const DarwinInitializationSettings();
      final InitializationSettings initializationSettings =
          InitializationSettings(
              android: initializationSettingsAndroid,
              iOS: iosInitializationSettings);

      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {
          handleNotificationTap(notificationResponse);
        },
      );
      setupInteractedMessage();
    }
  }

  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      handleNotificationTap(NotificationResponse(
        payload: jsonEncode(initialMessage.data),
        notificationResponseType: NotificationResponseType.selectedNotification,
      ));
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      log("::::::::::::onMessage:::::::::::::::::");
      if (message.notification != null) {
        SharedPreferences reference = await SharedPreferences.getInstance();
        var ridde =
            reference.setString("inprogressId", message.data["rides_id"]);
        print(ridde);

        log(message.notification.toString());

        display(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log("::::::::::::onMessageOpenedApp:::::::::::::::::");
      if (message.notification != null) {
        log(message.notification.toString());
        handleNotificationTap(NotificationResponse(
          payload: jsonEncode(message.data),
          notificationResponseType:
              NotificationResponseType.selectedNotification,
        ));
      }
    });

    log("::::::::::::Permission authorized:::::::::::::::::");
    await FirebaseMessaging.instance.subscribeToTopic("eMart_driver");
  }

  void handleNotificationTap(NotificationResponse notificationResponse) {
    print("notificationRelated");
    print("notificationTypeis${notificationResponse}");
    var data;
    if (notificationResponse.payload != null) {
      data = jsonDecode(notificationResponse.payload!);
      print("Notification data: ${notificationResponse.payload}");
      print("Notification data: ${data}");
    } else {
      print("no payload data found here");
    }
    Get.to(
      () => NotificationPagScreen(
        id: data['rides_id'],
      ),
    );
    // Print the entire data payload
    // if (notificationResponse.payload == null ||
    //     notificationResponse.notificationResponseType !=
    //         NotificationResponseType.selectedNotification) {
    //   return;
    // }

    // final Map<String, dynamic> data = jsonDecode(notificationResponse.payload!);
    // print('Data received: $data');

    // String orderId = data['orderId'];
    // if (navigatorKey.currentState != null) {
    //   print("this is naviagtor key");
    //   navigatorKey.currentState!.push(
    //     MaterialPageRoute(
    //       builder: (context) => NotificationPagScreen(),
    //     ),
    //   );
    // } else {
    //   print('Navigator key is not available.');
    // }
  }

  static Future<String> getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    return token!;
  }

  void display(RemoteMessage message) async {
    log('Got a message whilst in the foreground!');
    // Map<String, dynamic> datas = jsonDecode(message.data);
    log('Message data: ${message.notification!.body}');
    SharedPreferences reference = await SharedPreferences.getInstance();
    
        await reference.setString("inprogressId", message.data["rides_id"]);
    print("finalrideuuid${reference.setString("inprogressId", message.data["rides_id"])}");

    log('Message data: ${message.data["rides_id"]}');
    try {
      AndroidNotificationChannel channel = const AndroidNotificationChannel(
        "01",
        "emart_driver",
        description: 'Show Emart Notification',
        importance: Importance.max,
      );
      AndroidNotificationDetails notificationDetails =
          AndroidNotificationDetails(channel.id, channel.name,
              channelDescription: 'your channel Description',
              importance: Importance.high,
              priority: Priority.high,
              ticker: 'ticker');
      const DarwinNotificationDetails darwinNotificationDetails =
          DarwinNotificationDetails(
              presentAlert: true, presentBadge: true, presentSound: true);
      NotificationDetails notificationDetailsBoth = NotificationDetails(
          android: notificationDetails, iOS: darwinNotificationDetails);
      await flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title,
        // message.data["ride_id"] ?? 'no id',
        message.notification!.body,
        notificationDetailsBoth,
        payload: jsonEncode(message.data),
      );
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  // void display(RemoteMessage message) async {
  //   log('Got a message whilst in the foreground!');
  //   log('Message data: ${message.notification!.body}');
  //       log('Message data: ${message.data}');

  //   try {
  //     // Extract the ride_id from the message data
  //     String rideId = message.data['ride_id'] ?? 'Unknown';

  //     // Create a dynamic title using the ride_id
  //     String notificationTitle = 'New Ride Request: Ride ID $rideId';
  //     String notificationBody =
  //         message.notification?.body ?? 'You have a new ride request.';

  //     AndroidNotificationChannel channel = const AndroidNotificationChannel(
  //       "01",
  //       "emart_driver",
  //       description: 'Show Emart Notification',
  //       importance: Importance.max,
  //     );
  //     AndroidNotificationDetails notificationDetails =
  //         AndroidNotificationDetails(
  //       channel.id,
  //       channel.name,
  //       channelDescription: channel.description,
  //       importance: Importance.high,
  //       priority: Priority.high,
  //       ticker: 'ticker',
  //     );
  //     const DarwinNotificationDetails darwinNotificationDetails =
  //         DarwinNotificationDetails(
  //       presentAlert: true,
  //       presentBadge: true,
  //       presentSound: true,
  //     );
  //     NotificationDetails notificationDetailsBoth = NotificationDetails(
  //       android: notificationDetails,
  //       iOS: darwinNotificationDetails,
  //     );

  //     await flutterLocalNotificationsPlugin.show(
  //       0,
  //       notificationTitle,
  //       notificationBody,
  //       notificationDetailsBoth,
  //       payload: jsonEncode(message.data),
  //     );
  //   } on Exception catch (e) {
  //     log(e.toString());
  //   }
  // }
}
