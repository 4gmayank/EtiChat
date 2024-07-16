import 'dart:convert';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:eti_chat/app_routes.dart';
import 'package:eti_chat/core/common_widget/text_widget.dart';
import 'package:eti_chat/core/conifg/navigation.dart';
import 'package:eti_chat/core/utils/constants.dart';
import 'package:eti_chat/feature/presentation/home_screen/home_bloc.dart';
import 'package:eti_chat/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_mobile_vision/qr_camera.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  String _fcmToken = "";
  bool isFcmSent = false;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  final TextEditingController _messageController = TextEditingController();
  final List<Message> _messages = [];

  @pragma('vm:entry-point')
  void notificationTapBackground(NotificationResponse notificationResponse) {}

  onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    var payloadData = jsonDecode(notificationResponse.payload ?? '');
  }

  @override
  void initState() {
    super.initState();
    _fcm.getToken().then((fcmToken) {
      _fcmToken = fcmToken!;
      debugPrint("FCM token = $_fcmToken");
      // BlocProvider.of<HomeBloc>(context).add(ShouldPassFCMTokenToServerEvent());
    });
    flutterLocalNotificationsPlugin.initialize(
        InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher')),
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      // onDidReceiveBackgroundNotificationResponse:
    );


    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("${message.toString()}");
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (message.data != null && message.data.length > 0) {
        String? route = message.data["redirect_to"];
        String? routeDetailId = message.data["id"];
      }
      if (notification != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              // color: AppColors.appDarkColor,
              playSound: true,
              icon: '@mipmap/ic_launcher',
            ),
          ),
          payload: json.encode(message.data),
        );

        /// show notification Count
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen(
          (RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        if (message.data != null) {
          String route = message.data["redirect_to"];
          String routeDetailId = message.data["id"];
          // if (!this.isAppActive) {
          //   BlocProvider.of<MainBloc>(context).add(
          //       StoreNotificationRouteMainEvent(
          //           route: route, id: routeDetailId));
          // }
          AndroidNotification? android = message.notification?.android;
          if (notification != null && android != null) {
            onSelectNotification(message);
          }
        }
      },
    );
  }

  Future<dynamic> onSelectNotification(payload) async {
    if (payload != null) {
      try {
        final data = json.decode(payload);
        String? screenIdData = data["msg"];
        if (screenIdData != null &&
            screenIdData.isNotEmpty) {
          final String msg = screenIdData;
        }
      } on Exception catch (e) {
        debugPrint("exception occurred ${e.toString()}");
        return false;
      }
    }
  }

  void _sendMessage() {
    if (_messageController.text.isEmpty) return;

    setState(() {
      _messages.add(Message(text: _messageController.text, isSentByMe: true));
    });

    _messageController.clear();
  }

  showDia(String? token) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: (token != null && token.isNotEmpty)
                  ? getCodeDesign(token)
                  : getScannerDesign());
        });
  }

  String? result;

  getScannerDesign() {
    result = null;
    return SizedBox(
      height: 330,
      width: 280.0,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QrCamera(
              key: qrKey,
              qrCodeCallback: (String? value) {
                if (result == null && value != null) {
                  debugPrint("\n\n QR data $value");
                  result = value as String;
                  AnimatedSnackBar.material(
                    value,
                    type: AnimatedSnackBarType.info,
                  ).show(context);
                  Navigator.pop(context);
                }
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          TextWidget(
            constText: "scan_code",
            appFonts: AppFonts.normalStyle(),
          ),
        ],
      ),
    );
  }

  getCodeDesign(String qrCode) {
    result = null;
    return SizedBox(
      height: 330,
      width: 280.0,
      child: Column(
        children: <Widget>[
          if (qrCode != null && qrCode.isNotEmpty)
            QrImageView(
              data: '1234567890',
              version: QrVersions.auto,
              size: 200.0,
            )
          else
            Expanded(
              flex: 5,
              child: QrCamera(
                key: qrKey,
                qrCodeCallback: (String? value) {
                  if (result == null && value != null) {
                    debugPrint("\n\n QR data $value");
                    result = value as String;
                    AnimatedSnackBar.material(
                      value,
                      type: AnimatedSnackBarType.info,
                    ).show(context);
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                ),
                // overlay: ,
              ),
            ),
          TextWidget(
            constText: "scan_code",
            appFonts: AppFonts.normalStyle(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        top: true,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.appColor,
            elevation: 1,
            leading: null,
            centerTitle: true,
            title: Text('Home'),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  Navigation.intentWithClearAllRoutes(
                      context, AppRoutes.loginScreen);
                },
              ),
            ],
          ),
          body: BlocConsumer<HomeBloc, HomeState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.qr_code),
                        onPressed: () {
                          showDia("data");
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.document_scanner_outlined),
                        onPressed: () {
                          showDia(null);
                        },
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final message = _messages[index];
                        return ChatBubble(message: message);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _messageController,
                            decoration: const InputDecoration(
                              hintText: 'Enter your message...',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.send),
                          onPressed: _sendMessage,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class Message {
  final String text;
  final bool isSentByMe;

  Message({required this.text, required this.isSentByMe});
}

class ChatBubble extends StatelessWidget {
  final Message message;

  const ChatBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          message.isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        decoration: BoxDecoration(
          color: message.isSentByMe ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: message.isSentByMe ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
