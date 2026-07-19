class CommandParser {
  const CommandParser();

  String parse(String input) {
    final normalized = input.trim().toLowerCase();

    if (normalized.contains('المخازن')) {
      return 'warehouses';
    }
    if (normalized.contains('الصيدليات') ||
        normalized.contains('الأدوية') ||
        normalized.contains('أدوية')) {
      return 'medicines';
    }
    if (normalized.contains('التقارير')) {
      return 'reports';
    }
    if (normalized.contains('التتبع')) {
      return 'tracking';
    }

    return 'dashboard';
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
