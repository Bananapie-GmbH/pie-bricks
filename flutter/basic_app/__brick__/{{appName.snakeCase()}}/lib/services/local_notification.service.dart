import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class LocalNotificationService {
  LocalNotificationService._();

  static final instance = LocalNotificationService._();

  factory LocalNotificationService() {
    return instance;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.max,
  );
  Future<void> initialize({
    void Function(String?)? onSelectNotification,
  }) async {
    flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"),
        iOS: DarwinInitializationSettings(),
      ),
      onDidReceiveNotificationResponse: (notificationResponse) {
        onSelectNotification?.call(notificationResponse.payload);
      },
    );
  }

  Future<void> setUpAndroidHeadUps() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  Future<void> setUpIOSHeadUps() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  Future<String?> _downloadAndSavePicture(
      RemoteNotification? notification) async {
    if (notification?.android?.imageUrl == null) return null;
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/notifImage';
    final http.Response response =
        await http.get(Uri.parse(notification?.android?.imageUrl ?? ""));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  BigPictureStyleInformation? _buildBigPictureStyleInformation(
    String? title,
    String? body,
    String? picturePath,
    bool showBigPicture,
  ) {
    if (picturePath == null) return null;
    final FilePathAndroidBitmap filePath = FilePathAndroidBitmap(picturePath);
    return BigPictureStyleInformation(
      showBigPicture ? filePath : const FilePathAndroidBitmap("empty"),
      largeIcon: filePath,
      contentTitle: title,
      htmlFormatContentTitle: true,
      summaryText: body,
      htmlFormatSummaryText: true,
    );
  }

  Future<void> showAndroidHeadsUp(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    String? picturePath = await _downloadAndSavePicture(notification);
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            largeIcon:
                picturePath != null ? FilePathAndroidBitmap(picturePath) : null,
            styleInformation: _buildBigPictureStyleInformation(
              notification.title,
              notification.body,
              picturePath,
              notification.android?.imageUrl != null,
            ),
          ),
        ),
        payload: jsonEncode(message.data),
      );
    }
  }
}

LocalNotificationService useLocalNotificationService() {
  return LocalNotificationService();
}
