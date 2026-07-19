import 'package:alasim_management/features/dashboard/application/providers/dashboard_provider.dart';
import 'package:alasim_management/features/dashboard/data/repositories/dashboard_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('executiveDashboardProvider exposes mock metrics and alerts', () async {
    final container = ProviderContainer(overrides: [
      dashboardRepositoryProvider
          .overrideWithValue(const DashboardRepository()),
    ]);

    addTearDown(container.dispose);

    final state = await container.read(executiveDashboardProvider.future);

    expect(state.totalCompanies, isA<int>());
    expect(state.totalWarehouses, isA<int>());
    expect(state.totalMedicines, isA<int>());
    expect(state.totalUsers, isA<int>());
    expect(state.totalShipments, isA<int>());
    expect(state.alerts, isNotEmpty);
    expect(state.alerts.map((alert) => alert.category), contains('AI alerts'));
  });
}
