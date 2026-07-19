import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/services/wholesales_service.dart';

final wholesalesProvider = Provider<WholesalesService>((ref) => const WholesalesService());
