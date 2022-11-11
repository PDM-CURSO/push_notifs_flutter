import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:push_notifs/books.dart';
import 'package:push_notifs/notif_menu.dart';

import 'utils/notification_util.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    AwesomeNotifications().requestPermissionToSendNotifications().then(
      (isAllowed) {
        if (isAllowed) {
          AwesomeNotifications().setListeners(
            onActionReceivedMethod: (receivedAction) async {
              // Escuchar por notificaciones con botones/acciones
              if (receivedAction.buttonKeyInput.isNotEmpty) {
                // respuesta de un mensaje input de texto
                print(receivedAction);
              } else {
                // abrir pantalla.
                // logica para hacer algo cuando presionen el boton
                _processDefaultActionRecieved(receivedAction);
              }
            },
            // Escuchar por notificaciones con puro texto
            onNotificationDisplayedMethod: (receivedNotification) async {
              print("Notificacion: $receivedNotification");
            },
          );
        }
      },
    );

    super.initState();
  }

  void _processDefaultActionRecieved(ReceivedAction action) {
    print("Accion recibida >>>>>> $action");
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (contex) => Books(
          datos: action.title,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: CircleAvatar(
              maxRadius: 120,
              backgroundColor: Colors.black87,
              child: Image.asset(
                "assets/books.png",
                height: 120,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: NotifMenu(
              notifSimple: () => showBasicNotification(123),
              notifConIcono: () => showLargeIconNotification(321),
              notifConImagen: () => showBigPictureAndLargeIconNotification(710),
              notifConAccion: () =>
                  showBigPictureAndActionButtonsAndReplay(789),
              notifAgendada: () => repeatMinuteNotification(159),
              cancelNotifAgendada: () => cancelAllSchedules(),
            ),
          ),
        ],
      ),
    );
  }
}
