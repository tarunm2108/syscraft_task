import 'package:syscraft_task/src/extensions/text_style_extension.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? backButtonWidget;
  final PreferredSizeWidget? bottom;

  const AppBarWidget({
    this.title,
    this.actions,
    this.backButtonWidget,
    this.bottom,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      leading: backButtonWidget,
      title: Text(
        title ?? '',
        style: const TextStyle().bold.copyWith(
              color: Colors.white,
              fontSize: 18,
            ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
