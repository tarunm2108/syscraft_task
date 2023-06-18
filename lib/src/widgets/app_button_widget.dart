
import 'package:syscraft_task/src/extensions/text_style_extension.dart';
import 'package:syscraft_task/src/widgets/circular_loader_widget.dart';
import 'package:flutter/material.dart';

class AppButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final bool? showLoader;

  const AppButtonWidget({
    required this.onPressed,
    required this.title,
    this.showLoader,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return showLoader ?? false
        ? const CircularLoaderWidget()
        : ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
            child: Center(
              child: Text(
                title,
                style: const TextStyle().bold.copyWith(
                      fontSize: 16,
                  color: Colors.white,
                    ),
              ),
            ),
          );
  }
}
