import '../repositories/dashboard_repository.dart';

class DashboardService {
  const DashboardService({this.repository = const DashboardRepository()});

  final DashboardRepository repository;

  Future<Map<String, dynamic>> fetchSnapshot() async {
    return repository.loadSnapshot();
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
