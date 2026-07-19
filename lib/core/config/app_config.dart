class AppConfig {
  const AppConfig._();

  static const String appName = 'ALASIM SYSTEM';
  static const String environment = 'development';
  static const String supabaseUrl = 'https://your-project.supabase.co';
  static const String supabaseAnonKey = 'replace-with-your-anon-key';
  static const bool enableOfflineMode = true;
  static const bool enableFingerprintMock = true;
  static const bool enableAiForecasting = true;
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
