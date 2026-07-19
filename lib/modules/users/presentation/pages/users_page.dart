import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../application/providers/users_controller.dart';
import '../../domain/entities/app_user.dart';

class UsersPage extends ConsumerStatefulWidget {
  const UsersPage({super.key});

  @override
  ConsumerState<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends ConsumerState<UsersPage> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(usersControllerProvider);
    final users = state.users
        .where(
          (user) =>
              user.name.contains(_query) ||
              user.email.toLowerCase().contains(_query.toLowerCase()),
        )
        .toList();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          title: const Text('المستخدمون والصلاحيات'),
          actions: [
            ElevatedButton.icon(
              onPressed: () => _showUserDialog(context),
              icon: const Icon(Icons.add, size: 18),
              label: const Text('إضافة مستخدم'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) => setState(() => _query = value),
                      style: const TextStyle(color: AppColors.textPrimary),
                      decoration: InputDecoration(
                        hintText: 'بحث في المستخدمين...',
                        hintStyle:
                            const TextStyle(color: AppColors.textSecondary),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: AppColors.textSecondary,
                        ),
                        filled: true,
                        fillColor: AppColors.surface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton.icon(
                    onPressed: () =>
                        ref.read(usersControllerProvider.notifier).load(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('تحديث'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textSecondary,
                      side: const BorderSide(color: AppColors.border),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
              if (state.errorMessage != null) ...[
                const SizedBox(height: 12),
                Text(
                  state.errorMessage!,
                  style: const TextStyle(color: AppColors.danger),
                ),
              ],
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'قائمة المستخدمين (${users.length})',
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Divider(color: AppColors.border, height: 1),
                      Expanded(
                        child: users.isEmpty
                            ? const _EmptyUsers()
                            : ListView.separated(
                                itemCount: users.length,
                                separatorBuilder: (_, __) => const Divider(
                                  color: AppColors.border,
                                  height: 1,
                                ),
                                itemBuilder: (context, index) {
                                  return _UserRow(
                                    user: users[index],
                                    onRoles: () =>
                                        _showRolesDialog(context, users[index]),
                                    onToggle: () => ref
                                        .read(usersControllerProvider.notifier)
                                        .toggleActive(users[index].id),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showUserDialog(BuildContext context) async {
    final name = TextEditingController();
    final email = TextEditingController();
    final password = TextEditingController(text: '123456');
    final roles = <String>{'viewer'};

    await showDialog<void>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('إضافة مستخدم'),
              content: SizedBox(
                width: 420,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: name,
                      decoration: const InputDecoration(labelText: 'الاسم'),
                    ),
                    TextField(
                      controller: email,
                      decoration:
                          const InputDecoration(labelText: 'البريد الإلكتروني'),
                    ),
                    TextField(
                      controller: password,
                      decoration:
                          const InputDecoration(labelText: 'كلمة المرور'),
                    ),
                    const SizedBox(height: 12),
                    _RoleSelector(
                      selectedRoles: roles,
                      onChanged: (next) {
                        setDialogState(() {
                          roles
                            ..clear()
                            ..addAll(next);
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('إلغاء'),
                ),
                FilledButton(
                  onPressed: () async {
                    await ref.read(usersControllerProvider.notifier).createUser(
                          name: name.text,
                          email: email.text,
                          password: password.text,
                          roles: roles.toList(),
                        );
                    if (context.mounted) Navigator.of(context).pop();
                  },
                  child: const Text('حفظ'),
                ),
              ],
            );
          },
        );
      },
    );

    name.dispose();
    email.dispose();
    password.dispose();
  }

  Future<void> _showRolesDialog(BuildContext context, AppUser user) async {
    final roles = user.roles.toSet();
    await showDialog<void>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text('صلاحيات ${user.name}'),
              content: _RoleSelector(
                selectedRoles: roles,
                onChanged: (next) {
                  setDialogState(() {
                    roles
                      ..clear()
                      ..addAll(next);
                  });
                },
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('إلغاء'),
                ),
                FilledButton(
                  onPressed: () async {
                    await ref
                        .read(usersControllerProvider.notifier)
                        .updateRoles(user.id, roles.toList());
                    if (context.mounted) Navigator.of(context).pop();
                  },
                  child: const Text('حفظ'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _UserRow extends StatelessWidget {
  final AppUser user;
  final VoidCallback onRoles;
  final VoidCallback onToggle;

  const _UserRow({
    required this.user,
    required this.onRoles,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: user.isActive ? AppColors.primary : AppColors.border,
        child: Text(user.name.characters.first),
      ),
      title: Text(
        user.name,
        style: const TextStyle(color: AppColors.textPrimary),
      ),
      subtitle: Text(
        '${user.email}\n${user.roles.join(', ')}',
        style: const TextStyle(color: AppColors.textSecondary),
      ),
      isThreeLine: true,
      trailing: Wrap(
        spacing: 8,
        children: [
          IconButton(
            tooltip: 'الصلاحيات',
            onPressed: onRoles,
            icon: const Icon(Icons.admin_panel_settings_outlined),
          ),
          Switch(
            value: user.isActive,
            onChanged: (_) => onToggle(),
          ),
        ],
      ),
    );
  }
}

class _RoleSelector extends StatelessWidget {
  final Set<String> selectedRoles;
  final ValueChanged<Set<String>> onChanged;

  const _RoleSelector({
    required this.selectedRoles,
    required this.onChanged,
  });

  static const roles = ['admin', 'manager', 'auditor', 'sales', 'viewer'];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final role in roles)
          FilterChip(
            label: Text(role),
            selected: selectedRoles.contains(role),
            onSelected: (selected) {
              final next = {...selectedRoles};
              if (selected) {
                next.add(role);
              } else {
                next.remove(role);
              }
              onChanged(next);
            },
          ),
      ],
    );
  }
}

class _EmptyUsers extends StatelessWidget {
  const _EmptyUsers();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people, color: AppColors.textSecondary, size: 60),
          SizedBox(height: 16),
          Text(
            'لا توجد بيانات مطابقة',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
