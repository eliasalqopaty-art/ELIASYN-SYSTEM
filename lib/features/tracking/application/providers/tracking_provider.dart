import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/services/tracking_service.dart';
import '../../domain/models/tracking_model.dart';

final trackingProvider =
    Provider<TrackingService>((ref) => const TrackingService());

final trackingListProvider = FutureProvider<List<TrackingModel>>(
  (ref) async {
    final snapshot = await ref.watch(trackingProvider).load();
    return snapshot.map(TrackingModel.fromMap).toList();
  },
);

final shipmentDetailsProvider = FutureProvider.family<TrackingModel, String>(
  (ref, id) async {
    final snapshot = await ref.watch(trackingProvider).read(id);
    return TrackingModel.fromMap(snapshot);
  },
);

final liveTrackingStatusProvider = Provider<String>(
  (ref) =>
      'Live tracking placeholder: updates will be wired into the service layer next.',
);
