import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/services/settings_service.dart';

final settingsProvider = Provider<SettingsService>((ref) => const SettingsService());
