import 'package:flutter/material.dart';

class ProfileItemWidget extends StatelessWidget {
  const ProfileItemWidget({
    super.key,
    this.onClick,
    this.hasBottomBorder,
    this.icon,
    this.title,
  });
  final VoidCallback? onClick;
  final bool? hasBottomBorder;
  final IconData? icon;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick?.call(),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        height: 65,
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Icon(
                    icon,
                    size: 17,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      title ?? "",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (hasBottomBorder == true)
              const Divider(
                height: 5,
                color: Colors.grey,
                indent: 10,
                endIndent: 10,
              )
          ],
        ),
      ),
    );
  }
}
