import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path_provider/path_provider.dart';
import 'app.dart';
import 'firebase_options.dart';
import 'pages/bottom_navigation/cubit/bottom_navigation_cubit.dart';
import 'pages/profile/cubit/user_data_cubit.dart';
import 'routes/app_router.dart';
import 'services/api.service.dart';
import 'services/local_notification.service.dart';
import 'utils/resolve_notification_payload.dart';

double devicePixelRatio = 1.0;

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // if Stripe needed uncomment this part
  // Stripe.publishableKey = Env.stripePublishableKey;
  // Stripe.merchantIdentifier = 'merchant.{{packageName.lowerCase()}}';
  // await Stripe.instance.applySettings();
  final appRouter = AppRouter();
  final BottomNavigationCubit bottomNavigationCubit = BottomNavigationCubit();

  await initializeDateFormatting('de_DE', null);
  await _initializeApi();
  await _initializeFirebase();
  await _initializeFirebaseMessaging();
  await _initializeCloudMessaging(appRouter, bottomNavigationCubit);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(
      statusBarIconBrightness: Brightness.light,
    ),
  );
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<BottomNavigationCubit>(
          create: (context) => bottomNavigationCubit,
        ),
        BlocProvider<UserDataCubit>(
          create: (context) => UserDataCubit(),
        ),
      ],
      child: App(
        appRouter: appRouter,
        bottomNavigationCubit: bottomNavigationCubit,
      ),
    ),
  );
}

Future<String> writeImageToStorage(Uint8List feedbackScreenshot) async {
  final Directory output = await getTemporaryDirectory();
  final String screenshotFilePath = '${output.path}/feedback.png';
  final File screenshotFile = File(screenshotFilePath);
  await screenshotFile.writeAsBytes(feedbackScreenshot);
  return screenshotFilePath;
}

Future<void> _initializeFirebaseMessaging() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    // print('User granted permission');
    FirebaseMessaging.instance.subscribeToTopic("general");
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    // print('User granted provisional permission');
    FirebaseMessaging.instance.subscribeToTopic("general");
  } else {
    // print('User declined or has not accepted permission');
  }
}

Future<void> _initializeFirebase() async {
  // Initialize Firebase with firebase Cli
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> _initializeApi() async {
  await ApiService().initialize();
}

Future<void> _initializeCloudMessaging(
  AppRouter routes,
  BottomNavigationCubit bottomNavigationCubit,
) async {
  final localNotificationService = useLocalNotificationService();

  var messaging = FirebaseMessaging.instance;

  if (Platform.isIOS) {
    final settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      await LocalNotificationService().setUpIOSHeadUps();
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackground);
    }
  } else if (Platform.isAndroid) {
    await localNotificationService.initialize(
        onSelectNotification: (String? payload) {
      if (payload != null && payload != "") {
        Map<String, dynamic> data = jsonDecode(payload);
        resolveNotificationPayload(
          data['type'],
          jsonDecode(data['payload']),
          routes,
          bottomNavigationCubit,
        );
      }
    });
    await localNotificationService.setUpAndroidHeadUps();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackground);
  }
}

Future<void> _firebaseMessagingBackground(RemoteMessage message) async {
  // print("background  message: ${message.notification?.body}");
}
