import 'package:swimming_app_frontend/features/swims/infrastructure/models/swim_model.dart';

class HomeModel {
  final GetSwimResDTO latestSwimData;

  const HomeModel({required this.latestSwimData});

  HomeModel copyWith({GetSwimResDTO? latestSwimData}) {
    return HomeModel(latestSwimData: latestSwimData ?? this.latestSwimData);
  }
}
