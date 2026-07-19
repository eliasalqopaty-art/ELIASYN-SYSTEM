class MedicinesModel {
  const MedicinesModel({
    required this.id,
    required this.tradeName,
    required this.genericName,
    required this.manufacturer,
    required this.dosageForm,
    required this.strength,
    required this.batchNumber,
    required this.expiryDate,
    required this.lotNumber,
    this.status = 'ready',
  });

  final String id;
  final String tradeName;
  final String genericName;
  final String manufacturer;
  final String dosageForm;
  final String strength;
  final String batchNumber;
  final String expiryDate;
  final String lotNumber;
  final String status;

  factory MedicinesModel.fromMap(Map<String, dynamic> map) {
    return MedicinesModel(
      id: map['id'] as String? ?? 'unknown',
      tradeName: map['tradeName'] as String? ?? 'غير معروف',
      genericName: map['genericName'] as String? ?? 'غير معروف',
      manufacturer: map['manufacturer'] as String? ?? 'غير معروف',
      dosageForm: map['dosageForm'] as String? ?? 'غير معروف',
      strength: map['strength'] as String? ?? 'غير معروف',
      batchNumber: map['batchNumber'] as String? ?? 'غير معروف',
      expiryDate: map['expiryDate'] as String? ?? 'غير معروف',
      lotNumber: map['lotNumber'] as String? ?? 'غير معروف',
      status: map['status'] as String? ?? 'ready',
    );
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
