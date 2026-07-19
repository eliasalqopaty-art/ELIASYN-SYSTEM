class ChannelModel {
  const ChannelModel({
    required this.name,
    required this.description,
    this.isActive = true,
  });

  final String name;
  final String description;
  final bool isActive;
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
