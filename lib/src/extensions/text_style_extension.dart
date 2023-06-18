import 'package:flutter/material.dart';

extension TextStyleExtension on TextStyle {
  TextStyle get regular => const TextStyle(
        color: Colors.black,
        fontSize: 14,
      );

  TextStyle get bold => const TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.black,
        fontSize: 14,
      );

  TextStyle get italic => const TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontStyle: FontStyle.italic,
      );
}
