import 'package:flutter/widgets.dart';
import 'package:hiddentable/interfaces/list_item.dart';

class ListItemSpacer extends ListItem {
  ListItemSpacer({
    this.height,
    this.width,
  });
  final double? height;
  final double? width;

  Widget build() {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
