import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:push_notifs/home_page.dart';

import 'utils/constants_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initLocalNotifications();
  runApp(MyApp());
}

Future initLocalNotifications() async {
  // Inicializar canales/grupos para notificar

  // Local notifications initialization
  await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: channelSimpleId,
        channelName: channelSimpleName,
        channelDescription: channelSimpleDescr,
        defaultColor: Colors.purple,
        ledColor: Colors.blue,
        importance: NotificationImportance.Default,
      ),
      NotificationChannel(
        channelKey: channelBigPictureId,
        channelName: channelBigPictureName,
        channelDescription: channelBigPictureDescr,
        defaultColor: Colors.purple,
        ledColor: Colors.yellow,
        importance: NotificationImportance.High,
      ),
      NotificationChannel(
        channelKey: channelScheduleId,
        channelName: channelScheduleName,
        channelDescription: channelScheduleDescr,
        defaultColor: Colors.purple,
        ledColor: Colors.red,
        importance: NotificationImportance.Default,
      ),
    ],
  );
  // await AwesomeNotificationsFcm().initialize(
  //   onFcmTokenHandle: (fcmToken) async {
  //     // obtener fcm token de usuario
  //     print("TOKEN DE FCM: $fcmToken");
  //     // guardar el token para poderle mandar notifs push
  //   },
  //   onFcmSilentDataHandle: (FcmSilentData silentData) async {
  //     if (silentData.createdLifeCycle != NotificationLifeCycle.Foreground) {
  //       print("FCM On Background msg recieved: ${silentData.data}");
  //     } else {
  //       print("FCM On Foreground msg recieved: ${silentData.data}");
  //     }
  //   },
  // );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme(
          primary: Colors.indigo,
          primaryContainer: Colors.indigoAccent,
          secondary: Colors.green,
          secondaryContainer: Colors.lime,
          surface: Colors.grey[200]!,
          background: Colors.grey[200]!,
          // background: Colors.deepPurple[100]!,
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.grey,
          onBackground: Colors.deepPurple[100]!,
          onError: Colors.red,
          brightness: Brightness.light,
        ),
      ),
      home: HomePage(),
    );
  }
}
