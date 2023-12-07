import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../common/webview_page.dart';
import '../pages/authentication/register_page.dart';
import '../pages/authentication/signin_page.dart';
import '../pages/authentication/signup_page.dart';
import '../pages/bottom_navigation/bottom_navigation_page.dart';
import '../pages/profile/widgets/profile_legal_page.dart';
import '../pages/profile/widgets/profile_personal_data_input_page.dart';
import '../pages/profile/widgets/profile_personal_data_page.dart';
import 'guards/auth_guard.dart';
import 'wrappers/home_wrapper_page.dart';
import 'wrappers/login_wrapper_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: LoginWrapperRoute.page,
          children: [
            AutoRoute(
              page: RegisterRoute.page,
              initial: true,
            ),
            AutoRoute(
              page: SigninRoute.page,
            ),
            AutoRoute(
              page: SignupRoute.page,
            ),
            AutoRoute(
              page: WebviewRoute.page,
            ),
          ],
        ),
        AutoRoute(
          page: HomeWrapperRoute.page,
          guards: [
            AuthGuard(),
          ],
          initial: true,
          children: [
            AutoRoute(
              page: BottomNavigationRoute.page,
              initial: true,
            ),
            AutoRoute(
              page: ProfilePersonalDataRoute.page,
            ),
            AutoRoute(
              page: ProfilePersonalDataInputRoute.page,
            ),
            AutoRoute(
              page: ProfileLegalRoute.page,
            ),
            AutoRoute(
              page: WebviewRoute.page,
            ),
          ],
        )
      ];
}
