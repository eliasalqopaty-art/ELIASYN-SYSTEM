import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/services/warehouses_service.dart';

final warehousesProvider = Provider<WarehousesService>((ref) => const WarehousesService());
