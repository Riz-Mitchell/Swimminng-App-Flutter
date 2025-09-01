import 'package:swimming_app_frontend/shared/enum/time_period_enum.dart';
import 'package:swimming_app_frontend/shared/infrastructure/entities/swim_entity.dart';
import 'package:swimming_app_frontend/shared/infrastructure/repository/swim_repository.dart';

class SwimService {
  final SwimRepository _swimRepository;

  SwimService(this._swimRepository);

  Future<List<GetSwimEntity>> getSwimsByQuery(
    QuerySwimEntity querySchema,
  ) async {
    List<GetSwimEntity> swims = await _swimRepository.getAllSwimsReq(
      querySchema,
    );

    print('Retrieved ${swims.length} swims with query: $querySchema');

    return swims;
  }

  Future<GetSwimEntity> getSwimById(String swimId) async {
    return await _swimRepository.getSwimReq(swimId);
  }

  Future<GetSwimEntity> getLatestSwim() async {
    QuerySwimEntity querySchema = QuerySwimEntity(page: 1, pageSize: 1);

    List<GetSwimEntity> singleItemList = await _swimRepository.getAllSwimsReq(
      querySchema,
    );

    return singleItemList.first;
  }

  Future<List<GetSwimEntity>> getSwimsByTimePeriodEnumAsync(
    TimePeriodEnum timePeriod,
  ) async {
    const int maxPageSize = 20;
    int currentPage = 1;
    List<GetSwimEntity> allSwims = [];

    while (true) {
      final query = QuerySwimEntity(
        timePeriod: timePeriod,
        page: currentPage,
        pageSize: maxPageSize,
      );

      final swims = await _swimRepository.getAllSwimsReq(query);

      if (swims.isEmpty) {
        break; // No more data
      }

      allSwims.addAll(swims);
      currentPage++;
    }

    return allSwims;
  }

  Future<List<GetSwimEntity>> getSwimsByMonthAsync(DateTime time) async {
    const int maxPageSize = 20;
    int currentPage = 1;
    List<GetSwimEntity> allSwims = [];

    final timeInUtc = time.toUtc();

    while (true) {
      final query = QuerySwimEntity(
        year: timeInUtc.year,
        month: timeInUtc.month,
        page: currentPage,
        pageSize: maxPageSize,
      );

      final swims = await _swimRepository.getAllSwimsReq(query);

      if (swims.isEmpty) {
        break; // No more data
      }

      allSwims.addAll(swims);
      currentPage++;
    }

    return allSwims;
  }

  Future<List<GetSwimEntity>> getSwimsByDayAsync(DateTime time) async {
    const int maxPageSize = 20;
    int currentPage = 1;
    List<GetSwimEntity> allSwims = [];
    final timeInUtc = time.toUtc();

    while (true) {
      final query = QuerySwimEntity(
        year: timeInUtc.year,
        month: timeInUtc.month,
        day: timeInUtc.day,
        page: currentPage,
        pageSize: maxPageSize,
      );

      final swims = await _swimRepository.getAllSwimsReq(query);

      if (swims.isEmpty) {
        break; // No more data
      }

      allSwims.addAll(swims);
      currentPage++;
    }

    return allSwims;
  }

  List<GetSwimEntity> _reverseSwims(List<GetSwimEntity> swims) {
    return swims.reversed.toList();
  }

  Future<void> createSwim(CreateSwimEntity schema) async {
    await _swimRepository.createSwimReq(schema);
  }

  Future<void> deleteSwim(String id) async {
    await _swimRepository.deleteSwimReq(id);
  }
}
