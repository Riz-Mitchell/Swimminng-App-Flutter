import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SelectedSwimLogbookNotifier extends Notifier<int> {
  @override
  int build() {
    return 0; // Default to the first swim logbook entry
  }

  void setIndex(int index) {
    state = index;
  }
}

final selectedSwimLogbookProvider =
    NotifierProvider<SelectedSwimLogbookNotifier, int>(
      SelectedSwimLogbookNotifier.new,
    );

final carouselControllerProvider = Provider(
  (ref) => CarouselSliderController(),
);
