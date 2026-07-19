class AlasimUserModel {
  const AlasimUserModel(
      {required this.id, required this.name, required this.role});

  final String id;
  final String name;
  final String role;
}

class AlasimCompanyModel {
  const AlasimCompanyModel({required this.id, required this.name});

  final String id;
  final String name;
}

class AlasimWarehouseModel {
  const AlasimWarehouseModel(
      {required this.id, required this.name, required this.capacity});

  final String id;
  final String name;
  final int capacity;
}

class AlasimMedicineModel {
  const AlasimMedicineModel(
      {required this.id, required this.name, required this.stock});

  final String id;
  final String name;
  final int stock;
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
