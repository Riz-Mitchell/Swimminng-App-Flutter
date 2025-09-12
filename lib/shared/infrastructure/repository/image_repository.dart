import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mime/mime.dart';
import 'package:swimming_app_frontend/shared/infrastructure/api.dart';
import 'package:swimming_app_frontend/shared/infrastructure/entities/image_entity.dart';

class ImageRepository {
  final ApiClient _apiClient;

  ImageRepository(this._apiClient);

  Future<CreateImageResEntity> requestProfileImageUpload(
    CreateImageReqEntity schema,
  ) async {
    try {
      final res = await _apiClient.post(
        '/api/Image/request-profile-image-upload',
        data: schema.toJson(),
      );

      if (res?.data == null) {
        throw Exception('No data in response');
      }

      return CreateImageResEntity.fromJson(res!.data);
    } catch (e) {
      print('Error requesting image upload: $e');
      rethrow;
    }
  }

  /// Returns true if the image upload is confirmed successfully
  Future<bool> confirmProfileImageUpload(ConfirmImageReqEntity schema) async {
    try {
      final res = await _apiClient.post(
        '/api/Image/confirm-profile-image-upload',
        data: schema.toJson(),
      );

      if (res?.statusCode == 200) {
        return true;
      } else {
        print(
          'Failed to confirm image upload, status code: ${res?.statusCode}',
        );
        return false;
      }
    } catch (e) {
      print('Error confirming image upload: $e');
      return false;
    }
  }

  Future<bool> uploadProfileImage(String uploadUrl, File imageFile) async {
    try {
      final fileBytes = await imageFile.readAsBytes();
      final mimeType =
          lookupMimeType(imageFile.path) ?? 'application/octet-stream';

      final res = await _apiClient.put(
        uploadUrl,
        data: fileBytes,
        options: Options(
          headers: {
            'Content-Type': mimeType,
            'Content-Length': fileBytes.length.toString(),
          },
        ),
      );

      if (res?.statusCode == 200 || res?.statusCode == 201) {
        return true;
      } else {
        print('Failed to upload image, status code: ${res?.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error uploading image: $e');
      return false;
    }
  }
}
