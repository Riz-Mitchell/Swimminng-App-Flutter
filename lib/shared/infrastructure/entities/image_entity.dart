import 'package:flutter/material.dart';

@immutable
class CreateImageReqEntity {
  final String contentType;

  const CreateImageReqEntity({required this.contentType});

  Map<String, dynamic> toJson() {
    return {'contentType': contentType};
  }
}

@immutable
class CreateImageResEntity {
  final String uploadUrl;
  final String key;

  const CreateImageResEntity({required this.uploadUrl, required this.key});

  factory CreateImageResEntity.fromJson(Map<String, dynamic> json) {
    return CreateImageResEntity(
      uploadUrl: json['uploadUrl'] as String,
      key: json['key'] as String,
    );
  }
}

@immutable
class ConfirmImageReqEntity {
  final String key;

  const ConfirmImageReqEntity({required this.key});

  Map<String, dynamic> toJson() {
    return {'key': key};
  }
}
