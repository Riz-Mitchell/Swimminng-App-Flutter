import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> requestImagePermissions(BuildContext context) async {
  final permissions = [
    Permission.camera,
    Permission.photos, // iOS
    Permission.storage, // Android < 13
    Permission.mediaLibrary, // Android 13+
  ];

  Map<Permission, PermissionStatus> statuses = {};

  // Request permissions
  try {
    statuses = await permissions.request();
  } catch (e) {
    print('Error requesting permissions: $e');
    return false;
  }

  for (var entry in statuses.entries) {
    if (entry.value.isPermanentlyDenied) {
      // Show dialog guiding user to settings
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Permission Required"),
          content: Text(
            "The app needs ${entry.key.toString().split('.').last} permission. "
            "Please enable it in your device settings.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                openAppSettings();
              },
              child: const Text("Open Settings"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
          ],
        ),
      );
      // Permanently denied, so return false
      return false;
    }

    if (!entry.value.isGranted) {
      print('Permission ${entry.key} is ${entry.value}');
      return false;
    }
  }

  // All permissions granted
  return true;
}
