import 'channel_model.dart';
import 'message_model.dart';

class ChatRoomModel {
  const ChatRoomModel({
    required this.id,
    required this.channel,
    required this.title,
    this.description = '',
    this.isPrivate = false,
    this.isPinned = false,
    this.unreadCount = 0,
    this.members = const <String>[],
    this.messages = const <MessageModel>[],
    this.channelModel,
  });

  final String id;
  final String channel;
  final String title;
  final String description;
  final bool isPrivate;
  final bool isPinned;
  final int unreadCount;
  final List<String> members;
  final List<MessageModel> messages;
  final ChannelModel? channelModel;
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
