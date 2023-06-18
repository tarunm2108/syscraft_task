import 'package:syscraft_task/app_locale/lang_key.dart';
import 'package:syscraft_task/src/extensions/space_extension.dart';
import 'package:syscraft_task/src/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

class NoInternetView extends StatelessWidget {
  const NoInternetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.wifi_off_rounded,
              size: 120,
            ),
            20.toSpace,
            const Text(LangKey.noInternet)
          ],
        ),
      ),
    );
  }
}
