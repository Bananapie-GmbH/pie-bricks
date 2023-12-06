// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    BottomNavigationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BottomNavigationPage(),
      );
    },
    HomeWrapperRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeWrapperPage(),
      );
    },
    LoginWrapperRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginWrapperPage(),
      );
    },
    ProfileLegalRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfileLegalPage(),
      );
    },
    ProfilePersonalDataInputRoute.name: (routeData) {
      final args = routeData.argsAs<ProfilePersonalDataInputRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ProfilePersonalDataInputPage(
          key: args.key,
          title: args.title,
          value: args.value,
        ),
      );
    },
    ProfilePersonalDataRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfilePersonalDataPage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RegisterPage(),
      );
    },
    SigninRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SigninPage(),
      );
    },
    SignupRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignupPage(),
      );
    },
    WebviewRoute.name: (routeData) {
      final args = routeData.argsAs<WebviewRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WebviewPage(
          key: args.key,
          url: args.url,
        ),
      );
    },
  };
}

/// generated route for
/// [BottomNavigationPage]
class BottomNavigationRoute extends PageRouteInfo<void> {
  const BottomNavigationRoute({List<PageRouteInfo>? children})
      : super(
          BottomNavigationRoute.name,
          initialChildren: children,
        );

  static const String name = 'BottomNavigationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeWrapperPage]
class HomeWrapperRoute extends PageRouteInfo<void> {
  const HomeWrapperRoute({List<PageRouteInfo>? children})
      : super(
          HomeWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeWrapperRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginWrapperPage]
class LoginWrapperRoute extends PageRouteInfo<void> {
  const LoginWrapperRoute({List<PageRouteInfo>? children})
      : super(
          LoginWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginWrapperRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProfileLegalPage]
class ProfileLegalRoute extends PageRouteInfo<void> {
  const ProfileLegalRoute({List<PageRouteInfo>? children})
      : super(
          ProfileLegalRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileLegalRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProfilePersonalDataInputPage]
class ProfilePersonalDataInputRoute
    extends PageRouteInfo<ProfilePersonalDataInputRouteArgs> {
  ProfilePersonalDataInputRoute({
    Key? key,
    required String title,
    String? value,
    List<PageRouteInfo>? children,
  }) : super(
          ProfilePersonalDataInputRoute.name,
          args: ProfilePersonalDataInputRouteArgs(
            key: key,
            title: title,
            value: value,
          ),
          initialChildren: children,
        );

  static const String name = 'ProfilePersonalDataInputRoute';

  static const PageInfo<ProfilePersonalDataInputRouteArgs> page =
      PageInfo<ProfilePersonalDataInputRouteArgs>(name);
}

class ProfilePersonalDataInputRouteArgs {
  const ProfilePersonalDataInputRouteArgs({
    this.key,
    required this.title,
    this.value,
  });

  final Key? key;

  final String title;

  final String? value;

  @override
  String toString() {
    return 'ProfilePersonalDataInputRouteArgs{key: $key, title: $title, value: $value}';
  }
}

/// generated route for
/// [ProfilePersonalDataPage]
class ProfilePersonalDataRoute extends PageRouteInfo<void> {
  const ProfilePersonalDataRoute({List<PageRouteInfo>? children})
      : super(
          ProfilePersonalDataRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfilePersonalDataRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RegisterPage]
class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute({List<PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SigninPage]
class SigninRoute extends PageRouteInfo<void> {
  const SigninRoute({List<PageRouteInfo>? children})
      : super(
          SigninRoute.name,
          initialChildren: children,
        );

  static const String name = 'SigninRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignupPage]
class SignupRoute extends PageRouteInfo<void> {
  const SignupRoute({List<PageRouteInfo>? children})
      : super(
          SignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignupRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WebviewPage]
class WebviewRoute extends PageRouteInfo<WebviewRouteArgs> {
  WebviewRoute({
    Key? key,
    required String url,
    List<PageRouteInfo>? children,
  }) : super(
          WebviewRoute.name,
          args: WebviewRouteArgs(
            key: key,
            url: url,
          ),
          initialChildren: children,
        );

  static const String name = 'WebviewRoute';

  static const PageInfo<WebviewRouteArgs> page =
      PageInfo<WebviewRouteArgs>(name);
}

class WebviewRouteArgs {
  const WebviewRouteArgs({
    this.key,
    required this.url,
  });

  final Key? key;

  final String url;

  @override
  String toString() {
    return 'WebviewRouteArgs{key: $key, url: $url}';
  }
}
