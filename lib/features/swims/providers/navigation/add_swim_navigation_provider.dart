import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/shared/providers/router_provider.dart';
import 'package:swimming_app_frontend/shared/providers/swim_provider.dart';

enum AddSwimPage {
  selectEvent,
  selectEventDistance,
  selectPoolType,
  selectExertion,
  addSplit,
  done,
}

class AddSwimNavigationController extends Notifier<AddSwimPage> {
  @override
  AddSwimPage build() => AddSwimPage.selectEvent;

  Future<void> next() async {
    switch (state) {
      case AddSwimPage.selectEvent:
        ref.read(routerProvider).go('/add-swim-select-event-distance');
        break;
      case AddSwimPage.selectEventDistance:
        ref.read(routerProvider).go('/add-swim-select-pool-type');
        break;
      case AddSwimPage.selectPoolType:
        ref.read(routerProvider).go('/add-swim-select-exertion');
        break;
      case AddSwimPage.selectExertion:
        ref.read(routerProvider).go('/add-swim-add-split');
        break;
      case AddSwimPage.addSplit:
        await ref
            .read(swimControllerProvider.notifier)
            .submitSwimAsync(); // Need to implement
        ref.read(routerProvider).go('/add-swim-done');
        break;
      case AddSwimPage.done:
        ref.read(routerProvider).go('/swims-landing');
        break;
    }
    return Future.value();
  }
}

final addSwimNavigationProvider =
    NotifierProvider<AddSwimNavigationController, AddSwimPage>(
      () => AddSwimNavigationController(),
    );
