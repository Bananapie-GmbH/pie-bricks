import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../../routes/app_router.dart';
import '../cubit/profile_cubit.dart';
import 'profile_item_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileCubit _profileCubit = ProfileCubit();
  bool isReviewLoading = false;

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        elevation: 0,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: false,
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        bloc: _profileCubit,
        builder: (context, state) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    ProfileItemWidget(
                      icon: Icons.account_circle_outlined,
                      title: "Personal Data",
                      hasBottomBorder: true,
                      onClick: () => AutoRouter.of(context).push(
                        const ProfilePersonalDataRoute(),
                      ),
                    ),
                    const ProfileItemWidget(
                      icon: Icons.contact_support_outlined,
                      title: "Helpcenter",
                      hasBottomBorder: true,
                      // Uncomment and add Helpcenter URL
                      // onClick: () => AutoRouter.of(context).push(
                      //   WebviewRoute(url: "Helpcenter URL"),
                      // ),
                    ),
                    ProfileItemWidget(
                      icon: Icons.done_all,
                      title: "Legal",
                      hasBottomBorder: false,
                      onClick: () => AutoRouter.of(context).push(
                        const ProfileLegalRoute(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
