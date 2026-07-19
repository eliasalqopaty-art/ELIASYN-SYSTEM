import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../modules/users/application/providers/users_controller.dart';
import '../theme/app_colors.dart';

class MainScaffold extends StatefulWidget {
  final Widget child;

  const MainScaffold({super.key, required this.child});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  bool _sidebarExpanded = true;

  static const List<_NavItem> _navItems = [
    _NavItem(icon: Icons.dashboard, label: 'لوحة التحكم', path: '/dashboard'),
    _NavItem(icon: Icons.people, label: 'المستخدمون', path: '/users'),
    _NavItem(
        icon: Icons.local_pharmacy, label: 'الصيدليات', path: '/pharmacies'),
    _NavItem(icon: Icons.warehouse, label: 'المخازن', path: '/warehouses'),
    _NavItem(
        icon: Icons.inventory_2, label: 'المخزون والجرد', path: '/inventory'),
    _NavItem(
        icon: Icons.person_pin, label: 'المندوبون', path: '/representatives'),
    _NavItem(
        icon: Icons.local_shipping, label: 'الموزعون', path: '/distributors'),
    _NavItem(icon: Icons.factory, label: 'المصانع', path: '/factories'),
    _NavItem(icon: Icons.storefront, label: 'محلات الجملة', path: '/wholesale'),
    _NavItem(icon: Icons.map, label: 'التتبع بالخريطة', path: '/tracking'),
    _NavItem(
        icon: Icons.medical_services, label: 'الأدوية', path: '/medicines'),
    _NavItem(
        icon: Icons.security, label: 'الأمان والموافقة', path: '/security'),
    _NavItem(
        icon: Icons.smart_toy, label: 'المساعد الذكي', path: '/ai-assistant'),
    _NavItem(icon: Icons.bar_chart, label: 'التقارير', path: '/reports'),
    _NavItem(icon: Icons.history, label: 'سجل المراجعة', path: '/audit'),
  ];

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouterState.of(context).uri.path;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: _sidebarExpanded ? 260 : 72,
              color: AppColors.surface,
              child: Column(
                children: [
                  SizedBox(
                    height: 70,
                    child: Row(
                      children: [
                        const SizedBox(width: 12),
                        Image.asset(
                          'assets/images/logo.png',
                          height: 30,
                          fit: BoxFit.contain,
                        ),
                        if (_sidebarExpanded) ...[
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Text(
                              'نظام الياسين',
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                        IconButton(
                          onPressed: () {
                            setState(
                                () => _sidebarExpanded = !_sidebarExpanded);
                          },
                          icon: Icon(
                            _sidebarExpanded
                                ? Icons.chevron_right
                                : Icons.chevron_left,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(color: AppColors.border, height: 1),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: _navItems.length,
                      itemBuilder: (context, index) {
                        final item = _navItems[index];
                        return _buildNavItem(item, currentPath == item.path);
                      },
                    ),
                  ),
                  const Divider(color: AppColors.border, height: 1),
                  Consumer(
                    builder: (context, ref, _) {
                      return ListTile(
                        leading:
                            const Icon(Icons.logout, color: AppColors.danger),
                        title: _sidebarExpanded
                            ? const Text(
                                'تسجيل الخروج',
                                style: TextStyle(color: AppColors.danger),
                              )
                            : null,
                        onTap: () async {
                          await ref
                              .read(authControllerProvider.notifier)
                              .logout();
                          if (context.mounted) context.go('/login');
                        },
                        dense: true,
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            Expanded(child: widget.child),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(_NavItem item, bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color:
            isActive ? AppColors.primary.withValues(alpha: 0.15) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: isActive
            ? Border.all(color: AppColors.primary.withValues(alpha: 0.3))
            : null,
      ),
      child: ListTile(
        leading: Icon(
          item.icon,
          color: isActive ? AppColors.primary : AppColors.textSecondary,
          size: 22,
        ),
        title: _sidebarExpanded
            ? Text(
                item.label,
                style: TextStyle(
                  color: isActive ? AppColors.primary : AppColors.textSecondary,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  fontSize: 13,
                ),
              )
            : null,
        onTap: () => context.go(item.path),
        dense: true,
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  final String path;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.path,
  });
}
