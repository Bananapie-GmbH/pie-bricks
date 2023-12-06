import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class Section extends MultiSliver {
  Section({
    Key? key,
    required BuildContext context,
    required Widget title,
    required List<Widget> itemList,
  }) : super(
          key: key,
          pushPinnedChildren: true,
          children: [
            SliverPinnedHeader(
              child: title,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  var item = itemList[index];
                  return item;
                },
                childCount: itemList.length,
              ),
            ),
          ],
        );
}
