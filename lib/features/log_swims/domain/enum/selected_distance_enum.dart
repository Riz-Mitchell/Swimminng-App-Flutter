enum SelectedDistanceEnum {
  unselected,
  fifty,
  oneHundred,
  twoHundred,
  fourHundred,
  eightHundred,
  oneThousandFiveHundred,
}

extension SelectedDistanceEnumExtension on SelectedDistanceEnum {
  static int getIntDistanceByEnum(SelectedDistanceEnum distance) {
    switch (distance) {
      case SelectedDistanceEnum.fifty:
        return 50;
      case SelectedDistanceEnum.oneHundred:
        return 100;
      case SelectedDistanceEnum.twoHundred:
        return 200;
      case SelectedDistanceEnum.fourHundred:
        return 400;
      case SelectedDistanceEnum.eightHundred:
        return 800;
      case SelectedDistanceEnum.oneThousandFiveHundred:
        return 1500;
      case SelectedDistanceEnum.unselected:
        return 0; // or throw an error if unselected is not valid
    }
  }
}
