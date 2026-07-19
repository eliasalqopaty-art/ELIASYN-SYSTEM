class VoiceService {
  const VoiceService();

  Future<String> listen() async => 'mock voice input';

  Future<String> speak(String text) async => 'mock response for: $text';
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
