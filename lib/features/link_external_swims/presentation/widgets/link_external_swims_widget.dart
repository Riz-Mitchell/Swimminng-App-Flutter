import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/external/aus/application/link_external_swims_provider.dart';
import 'package:swimming_app_frontend/features/link_external_swims/domain/models/link_external_swims_model.dart';
import 'package:swimming_app_frontend/shared/enum/event_enum.dart';
import 'package:swimming_app_frontend/shared/presentation/widgets/metric_button_widget.dart';

class LinkExternalSwimsWidget extends ConsumerWidget {
  const LinkExternalSwimsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final linkExternalSwimsState = ref.watch(linkExternalSwimsProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 30,
      children: [
        Text(
          'What\s your full name?',
          style: textTheme.displayMedium?.copyWith(color: colorScheme.primary),
        ),
        TextField(
          style: textTheme.bodyMedium?.copyWith(color: colorScheme.primary),
          decoration: InputDecoration(
            labelText: 'Search Swimmers',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: colorScheme.primary),
            ),
          ),
          onChanged: (value) async {
            print('Search term: $value');
            await ref
                .read(linkExternalSwimsProvider.notifier)
                .handleNewSearchTerm(value);
          },
        ),
        ..._getSearchResults(linkExternalSwimsState, ref),
        SizedBox(height: 50),
        MetricButtonWidget(
          text: 'Link Swims',
          isEnabled:
              linkExternalSwimsState.whenOrNull(
                data: (data) => data.selectedSwimmer != null,
              ) ??
              false,
          onPressed: () async {
            final selectedSwimmer = linkExternalSwimsState.whenOrNull(
              data: (data) => data.selectedSwimmer,
            );

            print('Linking swims for swimmer ${selectedSwimmer}...');
            // await ref.read(linkExternalSwimsProvider.notifier).getSwimsToLink();
          },
        ),
        ...getFirst5Swims(linkExternalSwimsState, ref),
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
            subtitle: Text(result.club ?? 'No club information'),
            onTap: () {
              print('Selected swimmer: ${result.fullName}');
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

  List<Widget> getFirst5Swims(
    AsyncValue<LinkExternalSwimsModel> state,
    WidgetRef ref,
  ) {
    return state.when(
      data: (data) {
        final swims = data.swimsToLink.take(5).toList();
        return swims.map((swim) {
          return ListTile(
            title: Text(swim.event.toReadableString()),
            subtitle: Text('${swim.meetName} on Date: ${swim.date}'),
          );
        }).toList();
      },
      error: (error, stack) => [],
      loading: () => [],
    );
  }
}
