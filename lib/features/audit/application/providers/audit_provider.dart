import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/services/audit_service.dart';

final auditProvider = Provider<AuditService>((ref) => const AuditService());
