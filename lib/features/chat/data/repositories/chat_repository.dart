import '../../domain/models/channel_model.dart';
import '../../domain/models/chat_room_model.dart';
import '../../domain/models/message_model.dart';

class ChatRepository {
  const ChatRepository();

  Future<List<ChatRoomModel>> loadRooms() async => const <ChatRoomModel>[
        ChatRoomModel(
          id: 'room-general',
          channel: 'General',
          title: 'General',
          description: 'General operations chat',
          isPrivate: false,
          isPinned: true,
          unreadCount: 3,
          members: <String>['Admin', 'Ops'],
          messages: <MessageModel>[
            MessageModel(
              id: 'm1',
              author: 'System',
              text: 'Welcome to the general channel',
              createdAt: null,
              attachments: <String>['summary.pdf'],
            ),
          ],
          channelModel: ChannelModel(
            name: 'General',
            description: 'Shared team updates',
          ),
        ),
        ChatRoomModel(
          id: 'room-operations',
          channel: 'Operations',
          title: 'Operations',
          description: 'Daily operations coordination',
          unreadCount: 5,
          members: <String>['Ops'],
          messages: <MessageModel>[
            MessageModel(
              id: 'm2',
              author: 'Ops',
              text: 'Shipment schedule updated',
              createdAt: null,
            ),
          ],
          channelModel: ChannelModel(
            name: 'Operations',
            description: 'Procurement and logistics coordination',
          ),
        ),
        ChatRoomModel(
          id: 'room-warehouse',
          channel: 'Warehouse',
          title: 'Warehouse',
          description: 'Warehouse team',
          isPrivate: true,
          unreadCount: 1,
          members: <String>['Warehouse Lead'],
          messages: <MessageModel>[
            MessageModel(
              id: 'm3',
              author: 'Warehouse Lead',
              text: 'Batch B-001 is ready for release',
              createdAt: null,
              isPinned: true,
            ),
          ],
          channelModel: ChannelModel(
            name: 'Warehouse',
            description: 'Inventory handling room',
          ),
        ),
        ChatRoomModel(
          id: 'room-management',
          channel: 'Management',
          title: 'Management',
          description: 'Executive coordination',
          members: <String>['Management'],
          messages: <MessageModel>[
            MessageModel(
              id: 'm4',
              author: 'Manager',
              text: 'Review dashboard metrics',
              createdAt: null,
            ),
          ],
          channelModel: ChannelModel(
            name: 'Management',
            description: 'Manager decisions and approvals',
          ),
        ),
        ChatRoomModel(
          id: 'room-audit',
          channel: 'Audit',
          title: 'Audit',
          description: 'Fraud and audit trail',
          isPrivate: true,
          unreadCount: 2,
          members: <String>['Auditor'],
          messages: <MessageModel>[
            MessageModel(
              id: 'm5',
              author: 'Auditor',
              text: 'Audit summary attached',
              createdAt: null,
              attachments: <String>['audit.pdf'],
            ),
          ],
          channelModel: ChannelModel(
            name: 'Audit',
            description: 'Compliance and audit review',
          ),
        ),
      ];

  Future<ChatRoomModel?> findRoom(String id) async {
    final rooms = await loadRooms();
    final matches = rooms.where((room) => room.id == id).toList();
    return matches.isEmpty ? null : matches.first;
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
