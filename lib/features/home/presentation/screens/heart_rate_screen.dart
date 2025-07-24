import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/providers/polar_provider.dart';

class HeartRateScreen extends ConsumerWidget {
  const HeartRateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncDevice = ref.watch(polarDevicesProvider);
    final asyncECG = ref.watch(ecgStreamProvider);
    final asyncPPG = ref.watch(ppgStreamProvider);
    final asyncHR = ref.watch(heartRateStreamProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        asyncDevice.when(
          data: (device) => ListTile(
            title: Text('Device: ${device.name ?? "Unknown"}'),
            subtitle: Text('ID: ${device.deviceId}'),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Device error: $e')),
        ),
        const SizedBox(height: 30),
        asyncHR.when(
          data: (hrData) => Column(
            children: [
              Text(
                'Live Hr ${hrData.samples.first.hr}',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Contact Status suported ${hrData.samples.first.contactStatusSupported}',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Corrected Hr ${hrData.samples.first.correctedHr}',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'ppgQuality ${hrData.samples.first.ppgQuality}',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'rrsMs ${hrData.samples.first.rrsMs}',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Contact Status ${hrData.samples.first.contactStatus}',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          loading: () => const Text('Waiting for heart rate...'),
          error: (e, _) => Text('Heart rate error: $e'),
        ),
      ],
    );
  }
}
