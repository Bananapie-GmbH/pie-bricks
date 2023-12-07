import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../routes/app_router.dart';
import '../../services/authentication.service.dart';

@RoutePage()
class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isRegistering = false;
  bool _passwordVisible = false;

  bool termsAndCondition = false;
  bool agb = false;
  @override
  void initState() {
    super.initState();
  }

  static const TextStyle kButtonStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text("Superpie"),
    );
  }

  Widget buildRegisterButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (isRegistering) return;
        try {
          if (termsAndCondition != true && agb != true) {
            return;
          }
          setState(() {
            isRegistering = true;
          });
          var userCred =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
          // Uncomment this after the Endpoint for that is implemented
          // var userData =
          //     await useAuthenticationService().signup(isAnonymous: false);

          setState(() {
            isRegistering = false;
          });
          if (context.mounted) {
            AutoRouter.of(context).replace(const HomeWrapperRoute());
          }
        } catch (e) {
          await FirebaseAuth.instance.signOut();
          setState(() {
            isRegistering = false;
          });
          if (e is FirebaseAuthException && context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
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
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: termsAndCondition == true && agb == true
              ? Colors.yellow
              : Colors.grey,
        ),
        child: const Text(
          "Register",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: buildAppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "Register",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 40,
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Email",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: TextFormField(
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        autofillHints: const [
                          AutofillHints.email,
                        ],
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          const pattern =
                              r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                              r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                              r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                              r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                              r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                              r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                              r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
                          final regex = RegExp(pattern);

                          return value!.isNotEmpty && !regex.hasMatch(value)
                              ? 'Enter a valid email address'
                              : null;
                        },
                        controller: emailController,
                        cursorColor: Colors.black,
                        autocorrect: false,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                        decoration: InputDecoration(
                          hintText: "Example@domain.com",
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            borderSide: const BorderSide(
                              color: Colors.yellow,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Password",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Form(
                      autovalidateMode: AutovalidateMode.disabled,
                      child: TextFormField(
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        autofillHints: const [
                          AutofillHints.newPassword,
                        ],
                        validator: (value) {
                          RegExp regex = RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                          if (value?.isEmpty == true) {
                            return 'Please enter password';
                          } else {
                            if (!regex.hasMatch(value ?? "")) {
                              return 'Enter a valid password';
                            } else {
                              return null;
                            }
                          }
                        },
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                        controller: passwordController,
                        cursorColor: Colors.black,
                        obscureText: !_passwordVisible,
                        autocorrect: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            borderSide: const BorderSide(
                              color: Colors.yellow,
                              width: 2,
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Do you have an account? ",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        TextSpan(
                          text: "Login",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              AutoRouter.of(context).push(const SigninRoute());
                            },
                          style: const TextStyle(
                            color: Colors.yellow,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Theme(
                  data: Theme.of(context).copyWith(
                    checkboxTheme: Theme.of(context).checkboxTheme.copyWith(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                  ),
                  child: CheckboxListTile(
                    contentPadding: const EdgeInsets.only(
                      right: 0,
                      left: 0,
                      top: 0,
                      bottom: 0,
                    ),
                    activeColor: Colors.black,
                    onChanged: (bool? value) {
                      setState(() {
                        termsAndCondition = !termsAndCondition;
                      });
                    },
                    value: termsAndCondition,
                    title: GestureDetector(
                      onTap: () async {
                        // AutoRouter.of(context).push(
                        //   WebviewRoute(
                        //       url:
                        //           "Term of Use URL"),
                        // );
                      },
                      child: const Text(
                        "Terms of Use *",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                Theme(
                  data: Theme.of(context).copyWith(
                    checkboxTheme: Theme.of(context).checkboxTheme.copyWith(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                  ),
                  child: CheckboxListTile(
                    contentPadding: const EdgeInsets.only(
                      right: 0,
                      left: 0,
                      top: 0,
                      bottom: 0,
                    ),
                    activeColor: Colors.black,
                    onChanged: (bool? value) {
                      setState(() {
                        agb = !agb;
                      });
                    },
                    value: agb,
                    title: GestureDetector(
                      onTap: () async {
                        // AutoRouter.of(context).push(
                        //   WebviewRoute(url: "AGB URL"),
                        // );
                      },
                      child: const Text(
                        "AGB *",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                buildRegisterButton(context),
                const SizedBox(height: 10),
              ],
            ),
          ),
          if (isRegistering)
            Align(
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height,
                child: const CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
