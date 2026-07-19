import 'package:hive/hive.dart';

import '../../modules/audit_trail/domain/entities/audit_event.dart';
import '../../modules/users/domain/entities/app_user.dart';

void registerHiveAdapters() {
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(AppUserAdapter());
  }
  if (!Hive.isAdapterRegistered(2)) {
    Hive.registerAdapter(AuditEventAdapter());
  }
}

class AppUserAdapter extends TypeAdapter<AppUser> {
  @override
  final int typeId = 1;

  @override
  AppUser read(BinaryReader reader) {
    return AppUser.fromMap(Map<String, dynamic>.from(reader.readMap()));
  }

  @override
  void write(BinaryWriter writer, AppUser obj) {
    writer.writeMap(obj.toMap());
  }
}

class AuditEventAdapter extends TypeAdapter<AuditEvent> {
  @override
  final int typeId = 2;

  @override
  AuditEvent read(BinaryReader reader) {
    return AuditEvent.fromMap(Map<String, dynamic>.from(reader.readMap()));
  }

  @override
  void write(BinaryWriter writer, AuditEvent obj) {
    writer.writeMap(obj.toMap());
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
