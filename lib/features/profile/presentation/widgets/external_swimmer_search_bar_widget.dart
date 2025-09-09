import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swimming_app_frontend/external/aus/application/link_external_swims_provider.dart';
import 'package:swimming_app_frontend/features/link_external_swims/domain/models/link_external_swims_model.dart';
import 'package:swimming_app_frontend/features/profile/presentation/widgets/external_swimmer_result_widget.dart';

class ExternalSwimmerSearchBarWidget extends ConsumerWidget {
  const ExternalSwimmerSearchBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final linkExternalSwimsState = ref.watch(linkExternalSwimsProvider);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            children: [
              // Text field for search input
              SvgPicture.asset(
                'assets/svg/search.svg',
                width: 30,
                height: 30,
                colorFilter: ColorFilter.mode(
                  colorScheme.primary,
                  BlendMode.srcIn,
                ),
              ),
              Expanded(
                child: TextField(
                  textAlignVertical: TextAlignVertical.top,
                  textAlign: TextAlign.start,
                  style: textTheme.bodyLarge?.copyWith(
                    color: colorScheme.primary,
                  ),
                  onChanged: (value) async {
                    print('Search term: $value');
                    await ref
                        .read(linkExternalSwimsProvider.notifier)
                        .handleNewSearchTerm(value);
                  },
                  decoration: InputDecoration(
                    // hintStyle: textTheme.body?.copyWith(
                    //   color: Colors.grey,
                    // ),
                    hintText: 'Enter swimmer name',
                    border: InputBorder.none,
                    // contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  ),
                ),
              ),
            ],
          ),
          ..._getSearchResults(
            linkExternalSwimsState,
            ref,
            colorScheme,
            textTheme,
          ),
        ],
      ),
    );
  }

  List<Widget> _getSearchResults(
    AsyncValue<LinkExternalSwimsModel> state,
    WidgetRef ref,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return state.when(
      data: (data) {
        final results = data.searchResults;

        if (results.isEmpty) {
          return [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'No swimmers found',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.secondary,
                ),
              ),
            ),
          ];
        }

        return [
          // Wrap the whole thing in a Column with separators
          ...List.generate(results.length, (index) {
            final result = results[index];
            return ExternalSwimmerResultWidget(
              fullName: result.fullName,
              club: result.club,
              onTap: () {
                print('Selected swimmer: ${result.fullName}');
                ref
                    .read(linkExternalSwimsProvider.notifier)
                    .selectSwimmer(result);
              },
            );
            // Add divider except aft
          }),
        ];
      },
      error: (error, stack) => [],
      loading: () => [],
    );
  }
}
