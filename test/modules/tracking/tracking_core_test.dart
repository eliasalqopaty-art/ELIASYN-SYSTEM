import 'package:alasim_management/features/tracking/data/repositories/tracking_repository.dart';
import 'package:alasim_management/features/tracking/domain/models/tracking_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('TrackingRepository returns shipment records with core tracking fields',
      () async {
    const repository = TrackingRepository();

    final items = await repository.fetchAll();

    expect(items, isNotEmpty);
    expect(items.first['shipmentId'], isA<String>());
    expect(items.first['status'], isA<String>());
    expect(items.first['currentHolder'], isA<String>());
  });

  test('TrackingModel parses shipment details from repository data', () {
    const item = TrackingModel(
      id: 'shp-1',
      shipmentId: 'SHIP-001',
      status: 'In Transit',
      source: 'صنعاء',
      destination: 'عدن',
      lastUpdate: 'قبل 12 دقيقة',
      currentHolder: 'مخزن الجنوب',
    );

    expect(item.shipmentId, 'SHIP-001');
    expect(item.currentHolder, 'مخزن الجنوب');
    expect(item.status, 'In Transit');
  });
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
