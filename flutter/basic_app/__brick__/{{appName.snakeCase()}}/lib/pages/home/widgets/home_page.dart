import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hiddentable/pages/home/cubit/home_page_cubit.dart';
import 'package:hiddentable/services/authentication.service.dart';

import 'dart:developer' as developer;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late HomePageCubit _homePageCubit;

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();

    _homePageCubit = HomePageCubit();

    _updateFcmToken();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _homePageCubit,
      child: const Scaffold(
        body: Center(
          child: Text(
            "This is Home Page",
          ),
        ),
      ),
    );
  }

  Future<void> _updateFcmToken() async {
    try {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken != null) {
        useAuthenticationService().updateToken(fcmToken);
      }
    } catch (e) {
      developer.log(e.toString());
    }
  }
}
