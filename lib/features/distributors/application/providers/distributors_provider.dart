import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/services/distributors_service.dart';

final distributorsProvider = Provider<DistributorsService>((ref) => const DistributorsService());
