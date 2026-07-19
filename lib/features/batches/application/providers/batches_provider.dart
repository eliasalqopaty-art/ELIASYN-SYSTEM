import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/services/batches_service.dart';

final batchesProvider = Provider<BatchesService>((ref) => const BatchesService());
