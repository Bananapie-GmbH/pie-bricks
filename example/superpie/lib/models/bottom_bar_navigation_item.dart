import 'package:flutter/material.dart';

class BottombarNavigationItem {
  final Widget Function(BuildContext context, dynamic data) builder;

  BottombarNavigationItem({
    required this.builder,
  });
}
