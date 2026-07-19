import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/services/reports_service.dart';

final reportsProvider = Provider<ReportsService>((ref) => const ReportsService());
