import 'barcode.dart';
import 'qr.dart';

class InventoryItem {
  const InventoryItem({
    required this.id,
    required this.sku,
    this.barcode = '',
    this.qrCode,
    this.batch = '',
    this.expiryDate = '',
    this.packageLength = 0.0,
    this.packageWidth = 0.0,
    this.packageHeight = 0.0,
    this.packageWeight = 0.0,
    this.packageVolume = 0.0,
    this.packageColor = 'Default',
    this.packageType = 'Box',
  });

  final String id;
  final String sku;
  final String barcode;
  final QR? qrCode;
  final String batch;
  final String expiryDate;
  final double packageLength;
  final double packageWidth;
  final double packageHeight;
  final double packageWeight;
  final double packageVolume;
  final String packageColor;
  final String packageType;

  Barcode get barcodeModel => Barcode(code: barcode);
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
