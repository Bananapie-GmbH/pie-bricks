import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProfileLegalPage extends StatefulWidget {
  const ProfileLegalPage({super.key});

  @override
  State<ProfileLegalPage> createState() => _ProfileLegalPageState();
}

class _ProfileLegalPageState extends State<ProfileLegalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(
          "Legal",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              createTileWidget(
                title: "AGB",
                hasBottomBoarder: true,
                // onTap: () => AutoRouter.of(context).push(
                //   WebviewRoute(url: "AGB URL"),
                // ),
              ),
              createTileWidget(
                title: "Privacy",
                hasBottomBoarder: true,
                // onTap: () => AutoRouter.of(context).push(
                //   WebviewRoute(
                //       url: "Privacy URL"),
                // ),
              ),
              createTileWidget(
                title: "Legal Notice",
                hasBottomBoarder: true,
                // onTap: () => AutoRouter.of(context).push(
                //   WebviewRoute(url: "Legal Notice URL"),
                // ),
              ),
              createTileWidget(
                title: "Terms of Use",
                hasBottomBoarder: true,
                // onTap: () => AutoRouter.of(context).push(
                //   WebviewRoute(
                //       url: "Terms of Use URL"),
                // ),
              ),
              createTileWidget(
                title: "Credits",
                hasBottomBoarder: false,
                // onTap: () => AutoRouter.of(context).push(
                //   WebviewRoute(url: "Credits Url"),
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget createTileWidget({
    String? title,
    bool? hasBottomBoarder,
    void Function()? onTap,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            onTap: () => onTap?.call(),
            title: Text(
              title ?? "",
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            contentPadding: const EdgeInsets.only(right: 12, left: 15),
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
