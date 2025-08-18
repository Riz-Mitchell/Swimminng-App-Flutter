import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/external/aus/application/link_external_swims_provider.dart';
import 'package:swimming_app_frontend/features/link_external_swims/domain/models/link_external_swims_model.dart';

class LinkExternalSwimsWidget extends ConsumerWidget {
  const LinkExternalSwimsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final linkExternalSwimsState = ref.watch(linkExternalSwimsProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'Search Swimmers',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) async {
            print('Search term: $value');
            await ref
                .read(linkExternalSwimsProvider.notifier)
                .handleNewSearchTerm(value);
          },
        ),
        ..._getSearchResults(linkExternalSwimsState, ref),
      ],
    );
  }

  List<Widget> _getSearchResults(
    AsyncValue<LinkExternalSwimsModel> state,
    WidgetRef ref,
  ) {
    return state.when(
      data: (data) {
        final results = data.searchResults;
        return results.map((result) {
          return ListTile(
            title: Text(result.fullName),
            subtitle: Text(result.club),
            onTap: () {
              ref
                  .read(linkExternalSwimsProvider.notifier)
                  .selectSwimmer(result);
            },
          );
        }).toList();
      },
      error: (error, stack) => [],
      loading: () => [],
    );
  }
}
