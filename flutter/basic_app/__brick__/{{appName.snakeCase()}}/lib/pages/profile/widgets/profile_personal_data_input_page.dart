import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';

import '../cubit/user_data_cubit.dart';

@RoutePage()
class ProfilePersonalDataInputPage extends StatefulWidget {
  const ProfilePersonalDataInputPage({
    super.key,
    required this.title,
    this.value,
  });
  final String title;
  final String? value;

  @override
  State<ProfilePersonalDataInputPage> createState() =>
      _ProfilePersonalDataInputPageState();
}

class _ProfilePersonalDataInputPageState
    extends State<ProfilePersonalDataInputPage> {
  late TextEditingController? controller;
  bool isChanged = false;
  DateTime? birthday;
  bool isLoading = false;

  @override
  void initState() {
    controller = TextEditingController(text: widget.value);
    if (widget.title == "Geburtstag") {
      setState(() {
        birthday = widget.value != null
            ? DateFormat("yyyy-MM-dd").parse(widget.value ?? "")
            : DateTime.now();
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        actions: [
          if (isChanged)
            GestureDetector(
              onTap: () async {
                setState(() {
                  isLoading = true;
                });
                switch (widget.title) {
                  case "Firstname":
                    await BlocProvider.of<UserDataCubit>(context)
                        .updateUserData(firstname: controller?.text);
                    break;
                  case "Lastname":
                    if (!context.mounted) return;
                    await BlocProvider.of<UserDataCubit>(context)
                        .updateUserData(lastname: controller?.text);
                    break;
                  case "Email":
                    if (!context.mounted) return;
                    await BlocProvider.of<UserDataCubit>(context)
                        .updateUserData(email: controller?.text);
                    break;
                  case "Mobile":
                    if (!context.mounted) return;
                    await BlocProvider.of<UserDataCubit>(context)
                        .updateUserData(phone: controller?.text);
                    break;
                  case "Address":
                    if (!context.mounted) return;
                    await BlocProvider.of<UserDataCubit>(context)
                        .updateUserData(address: controller?.text);
                    break;
                  case "Geburtstag":
                    if (!context.mounted) return;
                    if (birthday != null) {
                      await BlocProvider.of<UserDataCubit>(context)
                          .updateUserData(
                              birthday:
                                  DateFormat("yyyy-MM-dd").format(birthday!));
                    }
                    break;
                  default:
                }
                setState(() {
                  isLoading = false;
                });
                if (context.mounted) {
                  Navigator.of(context).maybePop();
                }
              },
              child: const Icon(
                Icons.done,
                size: 25,
              ),
            ),
          const SizedBox(
            width: 20,
          )
        ],
        elevation: 0,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: widget.title == "Geburtstag"
                  ? SizedBox(
                      height: 200,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: birthday,
                        onDateTimeChanged: (DateTime newDateTime) {
                          setState(
                            () {
                              isChanged = true;
                              birthday = newDateTime;
                            },
                          );
                        },
                      ),
                    )
                  : TextField(
                      controller: controller,
                      keyboardType: widget.title == "Mobilnummer"
                          ? TextInputType.number
                          : null,
                      textInputAction: TextInputAction.done,
                      onChanged: (value) => setState(
                        () {
                          isChanged = true;
                        },
                      ),
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                    ),
            ),
            if (isLoading == true)
              const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
