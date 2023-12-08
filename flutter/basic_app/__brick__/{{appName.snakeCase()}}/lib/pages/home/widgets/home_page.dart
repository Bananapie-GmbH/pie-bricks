import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'dart:developer' as developer;

import '../../../services/authentication.service.dart';
import '../cubit/home_page_cubit.dart';

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

    // uncomment this after implementing the endpoint
    // _updateFcmToken();
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
  // uncomment this after implementing the endpoint
  // Future<void> _updateFcmToken() async {
  //   try {
  //     final fcmToken = await FirebaseMessaging.instance.getToken();
  //     if (fcmToken != null) {

  //       useAuthenticationService().updateToken(fcmToken);
  //     }
  //   } catch (e) {
  //     developer.log(e.toString());
  //   }
  // }
}
