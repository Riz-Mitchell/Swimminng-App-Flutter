import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polar/polar.dart';

/// Shared instance of Polar across the app
final polarServiceProvider = Provider<Polar>((ref) => Polar());

/// Stream provider that listens to device discovery
final polarDevicesProvider = StreamProvider.autoDispose<PolarDeviceInfo>((ref) {
  final polar = ref.watch(polarServiceProvider);
  return polar.searchForDevice();
});

final heartRateStreamProvider = StreamProvider.autoDispose<PolarHrData>((
  ref,
) async* {
  final polar = ref.watch(polarServiceProvider);

  // Wait until a device is found
  final device = await ref.watch(polarDevicesProvider.future);

  // Connect to the device
  await polar.connectToDevice(device.deviceId);

  // Start heart rate streaming
  yield* polar.startHrStreaming(device.deviceId);
});

final ppgStreamProvider = StreamProvider.autoDispose<PolarPpgData>((
  ref,
) async* {
  final polar = ref.watch(polarServiceProvider);
  final device = await ref.watch(polarDevicesProvider.future);

  await polar.connectToDevice(device.deviceId);

  // Start PPG streaming (assuming this returns Stream<Map<String, dynamic>> or raw data)
  yield* polar.startPpgStreaming(device.deviceId);
});

final ecgStreamProvider = StreamProvider.autoDispose<PolarEcgData>((
  ref,
) async* {
  final polar = ref.watch(polarServiceProvider);
  final device = await ref.watch(polarDevicesProvider.future);

  await polar.connectToDevice(device.deviceId);

  // Start R-R intervals streaming
  yield* polar.startEcgStreaming(device.deviceId);
});
