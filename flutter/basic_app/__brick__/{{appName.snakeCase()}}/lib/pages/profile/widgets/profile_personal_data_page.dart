import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

import '../../../routes/app_router.dart';
import '../cubit/user_data_cubit.dart';

@RoutePage()
class ProfilePersonalDataPage extends StatefulWidget {
  const ProfilePersonalDataPage({super.key});

  @override
  State<ProfilePersonalDataPage> createState() =>
      _ProfilePersonalDataPageState();
}

class _ProfilePersonalDataPageState extends State<ProfilePersonalDataPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserDataCubit>(context).fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(
          "Personal Data",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: false,
      ),
      body: BlocBuilder<UserDataCubit, UserDataState>(
        builder: (context, state) {
          if (state.isLoading == true) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                createTileWidget(
                  title: "Username",
                  value: state.userData?.displayName,
                  onTap: () {
                    AutoRouter.of(context).push(
                      ProfilePersonalDataInputRoute(
                        title: "Username",
                        value: state.userData?.displayName,
                      ),
                    );
                  },
                  hasBottomBoarder: true,
                ),
                createTileWidget(
                  title: "Email",
                  value: state.userData?.email,
                  onTap: () {
                    AutoRouter.of(context).push(
                      ProfilePersonalDataInputRoute(
                        title: "Email",
                        value: state.userData?.email,
                      ),
                    );
                  },
                  hasBottomBoarder: true,
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () async {
                    if (await GoogleSignIn().isSignedIn()) {
                      await GoogleSignIn().signOut();
                    }
                    await FacebookAuth.instance.logOut();
                    await FirebaseAuth.instance.signOut();

                    if (!mounted) return;
                    await AutoRouter.of(context)
                        .replace(const LoginWrapperRoute());
                  },
                  child: Container(
                    height: 30,
                    width: 100,
                    alignment: Alignment.center,
                    child: const Row(
                      children: [
                        Icon(
                          Icons.logout,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Logout",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget createTileWidget({
    String? title,
    dynamic value,
    bool? hasBottomBoarder,
    void Function()? onTap,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            onTap: () => onTap?.call(),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title ?? "",
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      value ?? "",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            contentPadding: const EdgeInsets.only(right: 12, left: 15),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 21,
            ),
          ),
        ),
        if (hasBottomBoarder == true)
          const Divider(
            height: 5,
            color: Colors.grey,
            indent: 15,
            endIndent: 15,
          ),
      ],
    );
  }
}
