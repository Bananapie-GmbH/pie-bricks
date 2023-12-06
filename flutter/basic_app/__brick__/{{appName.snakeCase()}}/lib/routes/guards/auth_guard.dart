import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hiddentable/routes/app_router.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    // the navigation is paused until resolver.next() is called with either
    // true to resume/continue navigation or false to abort navigation

    if (FirebaseAuth.instance.currentUser != null) {
      resolver.next(true);
    } else {
      router.push(
        const LoginWrapperRoute(),
      );
    }
  }
}
