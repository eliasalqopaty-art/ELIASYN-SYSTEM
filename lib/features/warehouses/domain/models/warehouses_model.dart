class WarehousesModel {
  const WarehousesModel({
    required this.id,
    required this.name,
    this.status = 'ready',
  });

  final String id;
  final String name;
  final String status;
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
