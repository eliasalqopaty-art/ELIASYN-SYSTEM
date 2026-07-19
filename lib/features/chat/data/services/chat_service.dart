import '../../domain/models/chat_room_model.dart';
import '../repositories/chat_repository.dart';

class ChatService {
  const ChatService({this.repository = const ChatRepository()});

  final ChatRepository repository;

  Future<List<ChatRoomModel>> loadRooms() => repository.loadRooms();

  Future<ChatRoomModel?> readRoom(String id) => repository.findRoom(id);
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
