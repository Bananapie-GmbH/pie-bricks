import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hiddentable/pages/bottom_navigation/cubit/bottom_navigation_cubit.dart';
import 'package:hiddentable/routes/app_router.dart';

void resolveNotificationPayload(
  String type,
  Map<String, dynamic>? payload,
  AppRouter routes,
  BottomNavigationCubit bottomNavigationCubit,
) {
  if (payload == null || payload.isEmpty == true) {
    return;
  }
  FlutterNativeSplash.remove();
  final dataType = type.toLowerCase();
  switch (dataType) {
    // case [payLoadType]:
    //Navigate to a page or do something else
    //break;
    default:
  }
}
