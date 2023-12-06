import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hiddentable/pages/bottom_navigation/cubit/bottom_navigation_cubit.dart';
import 'package:hiddentable/pages/splash_screens/animated_splash_screen.dart';
import 'package:hiddentable/pages/splash_screens/splash_screen.dart';
import 'package:hiddentable/routes/app_router.dart';
import 'package:hiddentable/services/local_notification.service.dart';
import 'package:hiddentable/utils/resolve_notification_payload.dart';

class HiddentableApp extends StatefulWidget {
  HiddentableApp({
    super.key,
    required this.appRouter,
    required this.bottomNavigationCubit,
  });
  final AppRouter appRouter;
  final BottomNavigationCubit bottomNavigationCubit;

  @override
  State<HiddentableApp> createState() => _HiddentableAppState();
}

class _HiddentableAppState extends State<HiddentableApp> {
  Future<void> resolveCloudMessageOnStartUp() async {
    // Get any messages which caused the application to open from a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      resolveNotificationPayload(
        initialMessage.data['type'],
        jsonDecode(initialMessage.data['payload']),
        widget.appRouter,
        widget.bottomNavigationCubit,
      );
    }

    // Also handle any interaction when the app is in the background via a Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        resolveNotificationPayload(
          message.data['type'],
          jsonDecode(message.data['payload']),
          widget.appRouter,
          widget.bottomNavigationCubit,
        );
      },
    );

    // Also handle any interaction when the app is in the foreground via a Stream listener
    FirebaseMessaging.onMessage.listen(
      (remoteMessage) async {
        if (Platform.isAndroid) {
          await LocalNotificationService().showAndroidHeadsUp(remoteMessage);
        }
      },
    );
  }

  @override
  void initState() {
    resolveCloudMessageOnStartUp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '{{appName.}}',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      routerConfig: widget.appRouter.config(),
      builder: (context, child) {
        return AnimatedSplashScreen(
          splashScreen: const SplashScreen(),
          child: child,
        );
      },
    );
  }
}
