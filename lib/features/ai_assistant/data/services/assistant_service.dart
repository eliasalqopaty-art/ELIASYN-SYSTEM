import 'command_parser.dart';

class AssistantService {
  const AssistantService();

  String guidance(String command) {
    final route = const CommandParser().parse(command);
    return 'mock AI guidance for "$command": route resolved to /$route without any external API keys.';
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
