import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileImageNotifier extends Notifier<File?> {
  @override
  File? build() {
    // Initial state is null (no image)
    return null;
  }

  // Set the profile image
  void setImage(File image) {
    state = image;
  }

  // Clear the profile image
  void clearImage() {
    state = null;
  }
}

// -------------------------
// Provider
// -------------------------
final profileImageProvider = NotifierProvider<ProfileImageNotifier, File?>(
  () => ProfileImageNotifier(),
);
