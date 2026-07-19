import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../application/providers/chat_provider.dart';
import '../../domain/models/message_model.dart';

class PrivateChatScreen extends ConsumerWidget {
  final String roomId;

  const PrivateChatScreen({super.key, required this.roomId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomState = ref.watch(roomDetailsProvider(roomId));

    return Directionality(
      textDirection: TextDirection.rtl,
      child: roomState.when(
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (error, stack) => Scaffold(
            appBar: AppBar(title: const Text('محادثة خاصة')),
            body: Center(
                child: Text('فشل تحميل المحادثة: $error',
                    style: const TextStyle(color: AppColors.danger)))),
        data: (room) {
          final messages = room?.messages ?? const <MessageModel>[];
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              backgroundColor: AppColors.surface,
              title: Text(room?.title ?? 'محادثة خاصة'),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Chip(
                      label: Text('${room?.members.length ?? 0} عضو'),
                      backgroundColor: AppColors.primary.withValues(alpha: 0.12)),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(children: [
                Expanded(
                  child: ListView(
                    children: [
                      for (final message in messages)
                        _PrivateMessageBubble(message: message),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border)),
                  child: Row(children: [
                    const Icon(Icons.attach_file,
                        color: AppColors.textSecondary),
                    const SizedBox(width: 10),
                    Expanded(
                        child: Text(
                            'Attachments Placeholder: ${messages.where((m) => m.attachments.isNotEmpty).length} attachment(s)',
                            style: const TextStyle(
                                color: AppColors.textSecondary))),
                    const Icon(Icons.send, color: AppColors.primary),
                  ]),
                ),
              ]),
            ),
          );
        },
      ),
    );
  }
}

class _PrivateMessageBubble extends StatelessWidget {
  final MessageModel message;

  const _PrivateMessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(message.author,
            style: const TextStyle(
                color: AppColors.primary, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        Text(message.text,
            style: const TextStyle(color: AppColors.textPrimary)),
        if (message.isPinned)
          const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text('📌 Pinned',
                  style: TextStyle(color: AppColors.warning, fontSize: 12))),
      ]),
    );
  }
}
