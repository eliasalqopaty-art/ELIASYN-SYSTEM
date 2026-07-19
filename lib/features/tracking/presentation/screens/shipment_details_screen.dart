import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../application/providers/tracking_provider.dart';

class ShipmentDetailsScreen extends ConsumerWidget {
  final String shipmentId;

  const ShipmentDetailsScreen({super.key, required this.shipmentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(shipmentDetailsProvider(shipmentId));
    final liveStatus = ref.watch(liveTrackingStatusProvider);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: state.when(
        loading: () => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
        error: (error, stack) => Scaffold(
          appBar: AppBar(title: const Text('تفاصيل الشحنة')),
          body: Center(
            child: Text(
              'فشل تحميل تفاصيل الشحنة: $error',
              style: const TextStyle(color: AppColors.danger),
            ),
          ),
        ),
        data: (shipment) => Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.surface,
            title: Text('تفاصيل ${shipment.shipmentId}'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                _SummaryCard(shipment: shipment, liveStatus: liveStatus),
                const SizedBox(height: 20),
                Expanded(
                  child: _TimelineWidget(timeline: shipment.timeline),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final dynamic shipment;
  final String liveStatus;

  const _SummaryCard({required this.shipment, required this.liveStatus});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('الحالة الحالية: ${shipment.status}',
              style: const TextStyle(
                  color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _DetailLine(label: 'Shipment ID', value: shipment.shipmentId),
          _DetailLine(label: 'Status', value: shipment.status),
          _DetailLine(label: 'Source', value: shipment.source),
          _DetailLine(label: 'Destination', value: shipment.destination),
          _DetailLine(label: 'Last Update', value: shipment.lastUpdate),
          _DetailLine(label: 'Current Holder', value: shipment.currentHolder),
          const SizedBox(height: 12),
          Text(liveStatus, style: const TextStyle(color: AppColors.primary)),
        ],
      ),
    );
  }
}

class _DetailLine extends StatelessWidget {
  final String label;
  final String value;

  const _DetailLine({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(label,
                style: const TextStyle(color: AppColors.textSecondary)),
          ),
          Expanded(
              child: Text(value,
                  style: const TextStyle(color: AppColors.textPrimary))),
        ],
      ),
    );
  }
}

class _TimelineWidget extends StatelessWidget {
  final List<String> timeline;

  const _TimelineWidget({required this.timeline});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Timeline',
              style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
          const SizedBox(height: 12),
          ...timeline.map(
            (entry) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.radio_button_checked,
                      color: AppColors.primary, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                      child: Text(entry,
                          style:
                              const TextStyle(color: AppColors.textPrimary))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
