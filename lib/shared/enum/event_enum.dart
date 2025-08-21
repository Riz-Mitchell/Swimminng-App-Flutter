import 'package:swimming_app_frontend/shared/enum/stroke_enum.dart';

enum EventEnum {
  none,
  freestyle50,
  freestyle100,
  freestyle200,
  freestyle400,
  freestyle800,
  freestyle1500,
  backstroke50,
  backstroke100,
  backstroke200,
  breaststroke50,
  breaststroke100,
  breaststroke200,
  butterfly50,
  butterfly100,
  butterfly200, // Add all your C# enum values here
  individualMedley100,
  individualMedley200,
  individualMedley400,
}

extension EventEnumExtension on EventEnum {
  static EventEnum getEventByStrokeAndDistance({
    StrokeEnum? stroke,
    required int distance,
  }) {
    print('stroke: ${stroke} distance: ${distance}');
    switch (stroke) {
      case null:
        switch (distance) {
          case 100:
            return EventEnum.individualMedley100;
          case 200:
            return EventEnum.individualMedley200;
          case 400:
            return EventEnum.individualMedley400;
        }
      case StrokeEnum.freestyle:
        switch (distance) {
          case 50:
            return EventEnum.freestyle50;
          case 100:
            return EventEnum.freestyle100;
          case 200:
            return EventEnum.freestyle200;
          case 400:
            return EventEnum.freestyle400;
          case 800:
            return EventEnum.freestyle800;
          case 1500:
            return EventEnum.freestyle1500;
        }
      case StrokeEnum.backstroke:
        switch (distance) {
          case 50:
            return EventEnum.backstroke50;
          case 100:
            return EventEnum.backstroke100;
          case 200:
            return EventEnum.backstroke200;
        }
      case StrokeEnum.breaststroke:
        switch (distance) {
          case 50:
            return EventEnum.breaststroke50;
          case 100:
            return EventEnum.breaststroke100;
          case 200:
            return EventEnum.breaststroke200;
        }
      case StrokeEnum.butterfly:
        switch (distance) {
          case 50:
            return EventEnum.butterfly50;
          case 100:
            return EventEnum.butterfly100;
          case 200:
            return EventEnum.butterfly200;
        }
    }

    return EventEnum.none;
  }

  String getAssetPath() {
    switch (this) {
      case EventEnum.freestyle50:
      case EventEnum.freestyle100:
      case EventEnum.freestyle200:
      case EventEnum.freestyle400:
      case EventEnum.freestyle800:
      case EventEnum.freestyle1500:
        return 'assets/svg/Freestyle.svg';
      case EventEnum.backstroke50:
      case EventEnum.backstroke100:
      case EventEnum.backstroke200:
        return 'assets/svg/Backstroke.svg';
      case EventEnum.breaststroke50:
      case EventEnum.breaststroke100:
      case EventEnum.breaststroke200:
        return 'assets/svg/Breaststroke.svg';
      case EventEnum.butterfly50:
      case EventEnum.butterfly100:
      case EventEnum.butterfly200:
        return 'assets/svg/Butterfly.svg';
      case EventEnum.individualMedley100:
      case EventEnum.individualMedley200:
      case EventEnum.individualMedley400:
        return 'assets/svg/IndividualMedley.svg';
      case EventEnum.none:
        return 'assets/svg/None.svg';
    }
  }

  String toReadableString() {
    switch (this) {
      case EventEnum.freestyle50:
        return '50 Free';
      case EventEnum.freestyle100:
        return '100 Free';
      case EventEnum.freestyle200:
        return '200 Free';
      case EventEnum.freestyle400:
        return '400 Free';
      case EventEnum.freestyle800:
        return '800 Free';
      case EventEnum.freestyle1500:
        return '1500 Free';
      case EventEnum.backstroke50:
        return '50 Back';
      case EventEnum.backstroke100:
        return '100 Back';
      case EventEnum.backstroke200:
        return '200 Back';
      case EventEnum.breaststroke50:
        return '50 Breast';
      case EventEnum.breaststroke100:
        return '100 Breast';
      case EventEnum.breaststroke200:
        return '200 Breast';
      case EventEnum.butterfly50:
        return '50 Fly';
      case EventEnum.butterfly100:
        return '100 Fly';
      case EventEnum.butterfly200:
        return '200 Fly';
      case EventEnum.individualMedley100:
        return '100 IM';
      case EventEnum.individualMedley200:
        return '200 IM';
      case EventEnum.individualMedley400:
        return '400 IM';
      case EventEnum.none:
        return 'None';
    }
  }
}
