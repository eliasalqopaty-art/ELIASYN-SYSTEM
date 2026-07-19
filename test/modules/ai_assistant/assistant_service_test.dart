import 'package:alasim_management/features/ai_assistant/data/services/assistant_service.dart';
import 'package:alasim_management/features/ai_assistant/data/services/command_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('CommandParser maps Arabic commands to routes', () {
    expect(const CommandParser().parse('افتح المخازن'), 'warehouses');
    expect(const CommandParser().parse('افتح الصيدليات'), 'medicines');
    expect(const CommandParser().parse('افتح الأدوية'), 'medicines');
    expect(const CommandParser().parse('افتح التقارير'), 'reports');
    expect(const CommandParser().parse('افتح التتبع'), 'tracking');
  });

  test('AssistantService provides mock navigation guidance', () {
    const service = AssistantService();

    final guidance = service.guidance('افتح المخازن');

    expect(guidance, contains('المخازن'));
    expect(guidance, contains('mock'));
  });
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
