import 'package:swimming_app_frontend/shared/enum/event_enum.dart';

enum StrokeEnum { backstroke, butterfly, breaststroke, freestyle }

extension StrokeEnumExtension on StrokeEnum {
  String get readableString {
    switch (this) {
      case StrokeEnum.backstroke:
        return 'Backstroke';
      case StrokeEnum.butterfly:
        return 'Butterfly';
      case StrokeEnum.breaststroke:
        return 'Breaststroke';
      case StrokeEnum.freestyle:
        return 'Freestyle';
    }
  }
}

getDefaultStrokeByEvent(EventEnum event) {
  switch (event) {
    case EventEnum.freestyle50:
    case EventEnum.freestyle100:
    case EventEnum.freestyle200:
    case EventEnum.freestyle400:
    case EventEnum.freestyle800:
    case EventEnum.freestyle1500:
      return StrokeEnum.freestyle;
    case EventEnum.backstroke100:
    case EventEnum.backstroke200:
      return StrokeEnum.backstroke;
    case EventEnum.butterfly100:
    case EventEnum.butterfly200:
      return StrokeEnum.butterfly;
    case EventEnum.breaststroke100:
    case EventEnum.breaststroke200:
      return StrokeEnum.breaststroke;
    default:
      return StrokeEnum.freestyle; // Default to freestyle if no match
  }
}
