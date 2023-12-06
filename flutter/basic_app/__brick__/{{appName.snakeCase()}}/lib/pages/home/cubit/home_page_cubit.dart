import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

part 'home_page_state.dart';

enum OfferFrom {
  today(),
  tomorrow(),
  dayAfterTomorrow(),
  event();

  const OfferFrom();

  static String getString(OfferFrom? offerFrom) {
    switch (offerFrom) {
      case OfferFrom.today:
        return "Heute";
      case OfferFrom.tomorrow:
        return "Morgen";
      case OfferFrom.dayAfterTomorrow:
        return DateFormat('EEEE', 'de_DE')
            .format(
              DateTime.now().add(
                const Duration(
                  days: 2,
                ),
              ),
            )
            .toString();
      case OfferFrom.event:
        return "Events";
      default:
        return "";
    }
  }

  static String getStringEnglish(OfferFrom? offerFrom) {
    switch (offerFrom) {
      case OfferFrom.today:
        return "today";
      case OfferFrom.tomorrow:
        return "tomorrow";
      case OfferFrom.dayAfterTomorrow:
        return "nextTomorrow";
      default:
        return "";
    }
  }
}

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit()
      : super(
          HomePageState.initialize(),
        );

  void init() async {}
}
