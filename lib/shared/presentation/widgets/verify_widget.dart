import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';

class VerifyWidget extends ConsumerWidget {
  final Function(String) onCompleted;

  const VerifyWidget({super.key, required this.onCompleted});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Pinput(length: 6, onCompleted: (code) async => onCompleted(code));
  }
}
