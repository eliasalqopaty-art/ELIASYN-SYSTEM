import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/services/fingerprint_service.dart';

final fingerprintProvider = Provider<FingerprintService>((ref) => const FingerprintService());
