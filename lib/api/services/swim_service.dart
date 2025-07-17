import 'package:swimming_app_frontend/features/swims/enum/time_period_enum.dart';
import 'package:swimming_app_frontend/features/swims/infrastructure/models/swim_model.dart';
import 'package:swimming_app_frontend/api/repository/swim_repository.dart';

class SwimService {
  final SwimRepository _swimRepository;

  SwimService(this._swimRepository);

  Future<List<GetSwimResDTO>> getSwimsByQuery(GetSwimsQuery querySchema) async {
    List<GetSwimResDTO> swims = await _swimRepository.getAllSwimsReq(
      querySchema,
    );

    return swims;
  }

  Future<GetSwimResDTO> getSwimById(String swimId) async {
    return await _swimRepository.getSwimReq(swimId);
  }

  Future<GetSwimResDTO> getLatestSwim() async {
    GetSwimsQuery querySchema = GetSwimsQuery(page: 1, pageSize: 1);

    List<GetSwimResDTO> singleItemList = await _swimRepository.getAllSwimsReq(
      querySchema,
    );

    return singleItemList.first;
  }

  Future<List<GetSwimResDTO>> getSwimsByTimePeriodAsync(
    TimePeriod timePeriod,
  ) async {
    const int maxPageSize = 20;
    int currentPage = 1;
    List<GetSwimResDTO> allSwims = [];

    while (true) {
      final query = GetSwimsQuery(
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

  Future<void> createSwim(CreateSwimReqDTO schema) async {
    await _swimRepository.createSwimReq(schema);
  }
}
