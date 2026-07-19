import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/services/assistant_service.dart';
import '../../data/services/command_parser.dart';
import '../../data/services/voice_service.dart';

final voiceServiceProvider =
    Provider<VoiceService>((ref) => const VoiceService());
final assistantServiceProvider =
    Provider<AssistantService>((ref) => const AssistantService());
final commandParserProvider =
    Provider<CommandParser>((ref) => const CommandParser());
