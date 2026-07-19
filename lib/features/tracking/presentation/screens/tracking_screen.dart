import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../application/providers/tracking_provider.dart';
import '../../domain/models/tracking_model.dart';
import 'shipment_details_screen.dart';

class TrackingScreen extends ConsumerWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(trackingListProvider);
    final liveStatus = ref.watch(liveTrackingStatusProvider);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: state.when(
        loading: () => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
        error: (error, stack) => Scaffold(
          appBar: AppBar(title: const Text('التتبع')),
          body: Center(
            child: Text(
              'فشل تحميل الشحنات: $error',
              style: const TextStyle(color: AppColors.danger),
            ),
          ),
        ),
        data: (shipments) {
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              backgroundColor: AppColors.surface,
              title: const Text('Shipment Tracking'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  _LiveStatusCard(text: liveStatus),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: ListView.separated(
                        itemCount: shipments.length,
                        separatorBuilder: (_, __) => const Divider(
                          color: AppColors.border,
                          height: 1,
                        ),
                        itemBuilder: (context, index) {
                          final shipment = shipments[index];
                          return _ShipmentRow(
                            shipment: shipment,
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => ShipmentDetailsScreen(
                                  shipmentId: shipment.id,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _LiveStatusCard extends StatelessWidget {
  final String text;

  const _LiveStatusCard({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          const Icon(Icons.wifi_tethering, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShipmentRow extends StatelessWidget {
  final TrackingModel shipment;
  final VoidCallback onTap;

  const _ShipmentRow({required this.shipment, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: AppColors.primary.withValues(alpha: 0.16),
        child: const Icon(Icons.local_shipping, color: AppColors.primary),
      ),
      title: Text(
        shipment.shipmentId,
        style: const TextStyle(color: AppColors.textPrimary),
      ),
      subtitle: Text(
        '${shipment.source} → ${shipment.destination} • ${shipment.status}',
        style: const TextStyle(color: AppColors.textSecondary),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            shipment.lastUpdate,
            style: const TextStyle(color: AppColors.success, fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(
            shipment.currentHolder,
            style:
                const TextStyle(color: AppColors.textSecondary, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
