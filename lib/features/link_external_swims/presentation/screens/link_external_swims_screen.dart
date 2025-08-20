import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/link_external_swims/presentation/widgets/link_external_swims_widget.dart';
import 'package:swimming_app_frontend/shared/presentation/screens/outside_shell_screen.dart';

class LinkExternalSwimsScreen extends ConsumerWidget {
  const LinkExternalSwimsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OutsideShellScreen(child: LinkExternalSwimsWidget());
  }
}
