class eliasynUserModel {
  const eliasynUserModel(
      {required this.id, required this.name, required this.role});

  final String id;
  final String name;
  final String role;
}

class eliasynCompanyModel {
  const eliasynCompanyModel({required this.id, required this.name});

  final String id;
  final String name;
}

class eliasynWarehouseModel {
  const eliasynWarehouseModel(
      {required this.id, required this.name, required this.capacity});

  final String id;
  final String name;
  final int capacity;
}

class eliasynMedicineModel {
  const eliasynMedicineModel(
      {required this.id, required this.name, required this.stock});

  final String id;
  final String name;
  final int stock;
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
