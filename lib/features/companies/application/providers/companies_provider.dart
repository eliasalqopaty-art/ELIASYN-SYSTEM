import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/services/companies_service.dart';

final companiesProvider = Provider<CompaniesService>((ref) => const CompaniesService());
