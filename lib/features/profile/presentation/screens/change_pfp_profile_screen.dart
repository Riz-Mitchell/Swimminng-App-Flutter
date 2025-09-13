import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swimming_app_frontend/features/profile/application/profile_image_provider.dart';
import 'package:swimming_app_frontend/features/profile/application/profile_provider.dart';
import 'package:swimming_app_frontend/features/profile/domain/helpers/image_permission_helper.dart';
import 'package:swimming_app_frontend/shared/application/providers/router_provider.dart';
import 'package:swimming_app_frontend/shared/presentation/screens/main_shell_screen.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/icon_button_widget.dart';

class ChangePFPProfileScreen extends ConsumerWidget {
  const ChangePFPProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final profileImage = ref.watch(profileImageProvider);

    Future<void> _selectImage() async {
      final granted = await requestImagePermissions(context);

      print('Permission result: $granted');

      if (!granted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Permission denied')));
        return;
      }

      print('Permissions granted, proceed to pick image');

      final file = await pickAndCropImage(context);
      if (file != null) {
        ref.read(profileImageProvider.notifier).setImage(file);
      }
    }

    return MainShellScreen(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButtonWidget(
                path: 'assets/svg/close.svg',
                overrideColor: colorScheme.primary,
                onTapped: () => ref.read(routerProvider).pop(),
              ),
            ],
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: _selectImage,
            child: Container(
              width: 150,
              height: 150,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: colorScheme.primary, width: 4.0),
              ),
              child: profileImage != null
                  ? Image.file(profileImage, fit: BoxFit.cover)
                  : SvgPicture.asset(
                      'assets/svg/user_placeholder.svg',
                      colorFilter: ColorFilter.mode(
                        colorScheme.primary,
                        BlendMode.srcIn,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: profileImage == null
                ? null
                : () {
                    // TODO: Upload image to server or S3
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Profile picture selected!'),
                      ),
                    );
                  },
            child: const Text('Save Profile Picture'),
          ),
        ],
      ),
    );
  }

  Future<File?> pickAndCropImage(BuildContext context) async {
    final picker = ImagePicker();

    // Ask user to choose source
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a photo'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from gallery'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );

    if (source == null) return null;

    final pickedFile = await picker.pickImage(source: source, imageQuality: 80);
    if (pickedFile == null) return null;

    // Crop the image (1:1)
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          lockAspectRatio: true,
          hideBottomControls: false,
        ),
        IOSUiSettings(title: 'Crop Image', aspectRatioLockEnabled: true),
      ],
    );

    if (croppedFile == null) return null;
    return File(croppedFile.path);
  }
}
