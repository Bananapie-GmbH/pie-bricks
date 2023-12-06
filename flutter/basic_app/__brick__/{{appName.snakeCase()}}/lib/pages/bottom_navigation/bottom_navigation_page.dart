import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hiddentable/models/bottom_bar_navigation_item.dart';
import 'package:hiddentable/pages/bottom_navigation/cubit/bottom_navigation_cubit.dart';
import 'package:hiddentable/pages/home/widgets/home_page.dart';
import 'package:hiddentable/pages/profile/widgets/profile_page.dart';

@RoutePage()
class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key});

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  final List<BottombarNavigationItem> _pages = [
    BottombarNavigationItem(
      builder: (context, data) {
        return const HomePage();
      },
    ),
    BottombarNavigationItem(
      builder: (context, data) {
        return const ProfilePage();
      },
    ),
  ];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BottomNavigationCubit>(context).setIndex(0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: _pages.elementAt(state.index ?? 1).builder(context, state.data),
          bottomNavigationBar: MediaQuery.removePadding(
            context: context,
            removeBottom: true,
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              padding: EdgeInsets.only(bottom: Platform.isIOS ? 23 : 0),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                selectedLabelStyle: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                elevation: 0,
                items: const [
                  BottomNavigationBarItem(
                    label: "Home",
                    icon: SizedBox(
                      height: 30,
                      width: 30,
                      child: Icon(
                        Icons.home_outlined,
                        size: 22,
                      ),
                    ),
                    activeIcon: SizedBox(
                      height: 30,
                      width: 30,
                      child: Icon(
                        Icons.home_filled,
                        size: 22,
                      ),
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: "Profil",
                    icon: SizedBox(
                      height: 33,
                      width: 33,
                      child: Icon(
                        Icons.person_outline,
                        size: 22,
                      ),
                    ),
                    activeIcon: SizedBox(
                      height: 33,
                      width: 33,
                      child: Icon(
                        Icons.person,
                        size: 22,
                      ),
                    ),
                  ),
                ],
                currentIndex: state.index ?? 0,
                onTap: (index) {
                  HapticFeedback.lightImpact();
                  BlocProvider.of<BottomNavigationCubit>(context).setIndex(
                    index,
                    data: index == 0
                        ? {
                            "resetHome": true,
                          }
                        : null,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
