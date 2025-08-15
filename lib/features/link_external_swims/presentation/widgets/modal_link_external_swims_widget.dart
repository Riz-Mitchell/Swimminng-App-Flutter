import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ModalLinkExternalSwimsWidget extends ConsumerWidget {
  const ModalLinkExternalSwimsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final linkExternalSwimsState = ref.watch(linkExternalSwimsProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SearchBarWidget(),
        ..._getSearchResults(linkExternalSwimsState),
      ],
    );
  }

  List<Widget> _getSearchResults(AsyncData<LinkExternalSwimsModel> state) {
    return state.when(
      data: (data) {
        final results = data.getSearchResults();
        results.map((result) {
          return ListTile(
            title: Text(result.name),
            subtitle: Text(result.club),
            onTap: () {
              // Handle tap on search result
            },
          );
        }).toList();
      },
      error: (error, stack) => [],
      loading: () => [],
    );
  }
}
