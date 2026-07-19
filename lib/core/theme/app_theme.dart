import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light() => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      );

  static ThemeData dark() => ThemeData.dark(useMaterial3: true).copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
      );
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
