class MessageModel {
  const MessageModel({
    required this.id,
    required this.author,
    required this.text,
    this.createdAt,
    this.isPinned = false,
    this.attachments = const <String>[],
  });

  final String id;
  final String author;
  final String text;
  final DateTime? createdAt;
  final bool isPinned;
  final List<String> attachments;
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
