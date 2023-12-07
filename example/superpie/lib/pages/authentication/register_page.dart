import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../../routes/app_router.dart';
import '../../services/authentication.service.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isLoginIn = false;
  int page = 0;
  final PageController pageController = PageController();
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  static const TextStyle kButtonStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text("Superpie"),
      actions: [
        if (page == 2)
          GestureDetector(
            onTap: () async {
              try {
                if (isLoginIn) return;
                setState(() {
                  isLoginIn = true;
                });
                final credential =
                    await FirebaseAuth.instance.signInAnonymously();
                var userData =
                    await useAuthenticationService().signup(isAnonymous: true);

                setState(() {
                  isLoginIn = false;
                });

                if (context.mounted) {
                  await AutoRouter.of(context)
                      .replace(const HomeWrapperRoute());
                }
              } catch (e) {
                await FirebaseAuth.instance.signOut();
                setState(() {
                  isLoginIn = false;
                });
                if (e is DioException && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                        e.response?.data["message"] ?? "",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  );
                }
              }
            },
            child: const Text(
              "Überspringen",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }

  Widget buildRegisterButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AutoRouter.of(context).push(
          const SignupRoute(),
        );
      },
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: Colors.yellow,
        ),
        child: const Text(
          "Login with Email",
          style: kButtonStyle,
        ),
      ),
    );
  }

  Widget buildSocialButton(Icon icon, {void Function()? onTap}) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        width: 45,
        height: 45,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.yellow,
        ),
        child: icon,
      ),
    );
  }

  Widget buildIllustrationAndTitle({
    // required String imageUrl,
    required String title,
    required String subTitle,
    required BoxConstraints constraints,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Image.asset(
        //   imageUrl,
        //   width: MediaQuery.of(context).size.width,
        //   height: constraints.maxHeight <= 591 ? 200 : 270,
        // ),
        const SizedBox(height: 30),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          subTitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  double calculateResponsiveHeight(BoxConstraints constraints) {
    if (constraints.maxHeight > 737) {
      return 150;
    } else if (constraints.maxHeight <= 737 && constraints.maxHeight > 591) {
      return 80;
    } else if (constraints.maxHeight <= 591) {
      return 30;
    }
    return 80;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: buildAppBar(),
      body: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: calculateResponsiveHeight(constraints),
                    width: 60,
                  ),
                  SizedBox(
                    height: constraints.maxHeight <= 591 ? 340 : 410,
                    child: PageView(
                      controller: pageController,
                      onPageChanged: (value) {
                        setState(() {
                          page = value;
                        });
                      },
                      children: [
                        buildIllustrationAndTitle(
                          // imageUrl: "./assets/png/image-name.png",
                          title: "Page1",
                          subTitle: "Sub1",
                          constraints: constraints,
                        ),
                        buildIllustrationAndTitle(
                          // imageUrl: "./assets/png/image-name.png",
                          title: "Page2",
                          subTitle: "Sub2",
                          constraints: constraints,
                        ),
                        buildIllustrationAndTitle(
                          // imageUrl: "./assets/png/image-name.png",
                          title: "Page3",
                          subTitle: "Sub3",
                          constraints: constraints,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: page == 2,
                    maintainState: true,
                    maintainAnimation: true,
                    maintainSize: true,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          buildRegisterButton(context),
                          const SizedBox(height: 10),
                          const Text(
                            "OR",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              buildSocialButton(
                                const Icon(
                                  Icons.apple,
                                  color: Colors.black,
                                  size: 26,
                                ),
                                onTap: () async {
                                  if (isLoginIn) return;
                                  try {
                                    setState(() {
                                      isLoginIn = true;
                                    });

                                    final userCredential =
                                        await signInWithApple();

                                    var userData =
                                        await useAuthenticationService()
                                            .login(isAnonymous: false);

                                    setState(() {
                                      isLoginIn = false;
                                    });
                                    if (context.mounted) {
                                      AutoRouter.of(context)
                                          .replace(const HomeWrapperRoute());
                                    }
                                  } catch (e) {
                                    await FirebaseAuth.instance.signOut();
                                    setState(() {
                                      isLoginIn = false;
                                    });
                                    if (e is FirebaseAuthException &&
                                        context.mounted) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              e.code.replaceAll("-", " "),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                },
                              ),
                              const SizedBox(width: 20),
                              buildSocialButton(
                                const Icon(
                                  FontAwesomeIcons.google,
                                  color: Colors.black,
                                  size: 23,
                                ),
                                onTap: () async {
                                  try {
                                    if (isLoginIn) return;
                                    setState(() {
                                      isLoginIn = true;
                                    });
                                    final userCredential =
                                        await signInWithGoogle();
                                    if (userCredential != null) {
                                      var userData =
                                          await useAuthenticationService()
                                              .login(isAnonymous: false);

                                      setState(() {
                                        isLoginIn = false;
                                      });
                                      if (context.mounted) {
                                        AutoRouter.of(context)
                                            .replace(const HomeWrapperRoute());
                                      }
                                    } else {
                                      setState(() {
                                        isLoginIn = false;
                                      });
                                    }
                                  } catch (e) {
                                    await FirebaseAuth.instance.signOut();
                                    setState(() {
                                      isLoginIn = false;
                                    });

                                    if (e is FirebaseAuthException &&
                                        context.mounted) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              e.code.replaceAll("-", " "),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                },
                              ),
                              // Uncomment if Facebook Login needed
                              // const SizedBox(width: 20),
                              // buildSocialButton(
                              //   const Icon(
                              //     FontAwesomeIcons.facebookF,
                              //     color: Colors.black,
                              //     size: 23,
                              //   ),
                              //   onTap: () async {
                              //     try {
                              //       if (isLoginIn) return;
                              //       setState(() {
                              //         isLoginIn = true;
                              //       });
                              //       final userCredential =
                              //           await signInWithFacebook();

                              //       var userData =
                              //           await useAuthenticationService()
                              //               .login(isAnonymous: false);

                              //       setState(() {
                              //         isLoginIn = false;
                              //       });
                              //       if (context.mounted) {
                              //         AutoRouter.of(context)
                              //             .replace(const HomeWrapperRoute());
                              //       }
                              //     } catch (e) {
                              //       await FirebaseAuth.instance.signOut();
                              //       setState(() {
                              //         isLoginIn = false;
                              //       });

                              //       if (e is FirebaseAuthException &&
                              //           context.mounted) {
                              //         ScaffoldMessenger.of(context).showSnackBar(
                              //           SnackBar(
                              //             backgroundColor: Colors.red,
                              //             content: Container(
                              //               alignment: Alignment.center,
                              //               child: Text(
                              //                 e.code.replaceAll("-", " "),
                              //                 style: const TextStyle(
                              //                   color: Colors.white,
                              //
                              //                   fontWeight: FontWeight.w700,
                              //                   fontSize: 18,
                              //                 ),
                              //               ),
                              //             ),
                              //           ),
                              //         );
                              //       }
                              //     }
                              //   },
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  DotsIndicator(
                    dotsCount: 3,
                    position: page,
                    decorator: const DotsDecorator(
                      activeColor: Colors.yellow,
                      size: Size.square(7),
                      activeSize: Size.square(9),
                      spacing: EdgeInsets.all(5.0),
                    ),
                  ),
                ],
              ),
            ),
            if (isLoginIn)
              Align(
                alignment: Alignment.center,
                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }

  Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) return null;

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook() async {
    var permissions = await FacebookAuth.instance.permissions;
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  Future<UserCredential> signInWithApple() async {
    final appleProvider = AppleAuthProvider();
    appleProvider.addScope('email');
    appleProvider.setCustomParameters({
      'locale': 'de',
    });
    if (kIsWeb) {
      return await FirebaseAuth.instance.signInWithPopup(appleProvider);
    } else {
      return await FirebaseAuth.instance.signInWithProvider(appleProvider);
    }
  }
}
