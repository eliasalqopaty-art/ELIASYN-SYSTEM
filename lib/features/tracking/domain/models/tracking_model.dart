class TrackingModel {
  const TrackingModel({
    required this.id,
    required this.shipmentId,
    required this.status,
    required this.source,
    required this.destination,
    required this.lastUpdate,
    required this.currentHolder,
    this.timeline = const <String>[],
    this.liveStatus = 'Live tracking placeholder',
  });

  final String id;
  final String shipmentId;
  final String status;
  final String source;
  final String destination;
  final String lastUpdate;
  final String currentHolder;
  final List<String> timeline;
  final String liveStatus;

  factory TrackingModel.fromMap(Map<String, dynamic> map) {
    return TrackingModel(
      id: map['id'] as String? ?? 'shipment-unknown',
      shipmentId: map['shipmentId'] as String? ?? 'SHIP-UNK',
      status: map['status'] as String? ?? 'Unknown',
      source: map['source'] as String? ?? 'Unknown',
      destination: map['destination'] as String? ?? 'Unknown',
      lastUpdate: map['lastUpdate'] as String? ?? 'Unknown',
      currentHolder: map['currentHolder'] as String? ?? 'Unknown',
      timeline: List<String>.from(map['timeline'] ?? const <String>[]),
      liveStatus: map['liveStatus'] as String? ?? 'Live tracking placeholder',
    );
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
