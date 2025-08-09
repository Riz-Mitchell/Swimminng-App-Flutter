import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/questionnaire_options_enum.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/models/post_swim_questionnaire_model.dart';

class PostSwimQuestionnaireLogSwimsProvider
    extends Notifier<PostSwimQuestionnaireModel> {
  @override
  PostSwimQuestionnaireModel build() => PostSwimQuestionnaireModel();

  void resetQuestionnaire() {
    state = PostSwimQuestionnaireModel();
  }

  void selectSelfTalk(SelfTalkOptionsEnum option) {
    print(
      'inside selectSelfTalk with option: $option, runtimeType: ${option.runtimeType}',
    );
    state = state.updateQuestionnaireField(option, state.selfTalk);
  }

  void selectNerve(NervesOptionsEnum option) {
    state = state.updateQuestionnaireField(option, state.nerves);
  }

  void selectEnergyLevel(EnergyLevelOptionsEnum option) {
    state = state.updateQuestionnaireField(option, state.energyLevel);
  }

  void selectBreathing(BreathingOptionsEnum option) {
    state = state.updateQuestionnaireField(option, state.breathing);
  }

  void selectCatchFeel(CatchFeelOptionsEnum option) {
    state = state.updateQuestionnaireField(option, state.catchFeel);
  }

  void selectStrokeLength(StrokeLengthOptionsEnum option) {
    state = state.updateQuestionnaireField(option, state.strokeLength);
  }

  void selectKickTechnique(KickTechniqueOptionsEnum option) {
    state = state.updateQuestionnaireField(option, state.kickTechnique);
  }

  void selectKickThroughout(KickThroughoutOptionsEnum option) {
    state = state.updateQuestionnaireField(option, state.kickThroughout);
  }

  void selectHeadPosition(HeadPositionOptionsEnum option) {
    state = state.updateQuestionnaireField(option, state.headPosition);
  }

  void selectTurn(TurnOptionsEnum option) {
    state = state.updateQuestionnaireField(option, state.turn);
  }

  List<SelfTalkOptionsEnum> getAvailableSelfTalkOptions() {
    final options = SelfTalkOptionsEnum.values
        .where((option) => option != SelfTalkOptionsEnum.unselected)
        .toList();

    print('Available SelfTalk Options: ${options.length}');
    return options;
  }

  List<NervesOptionsEnum> getAvailableNervesOptions() {
    return NervesOptionsEnum.values
        .where((option) => option != NervesOptionsEnum.unselected)
        .toList();
  }

  List<EnergyLevelOptionsEnum> getAvailableEnergyLevelOptions() {
    return EnergyLevelOptionsEnum.values
        .where((option) => option != EnergyLevelOptionsEnum.unselected)
        .toList();
  }

  List<BreathingOptionsEnum> getAvailableBreathingOptions() {
    return BreathingOptionsEnum.values
        .where((option) => option != BreathingOptionsEnum.unselected)
        .toList();
  }

  List<CatchFeelOptionsEnum> getAvailableCatchFeelOptions() {
    return CatchFeelOptionsEnum.values
        .where((option) => option != CatchFeelOptionsEnum.unselected)
        .toList();
  }

  List<StrokeLengthOptionsEnum> getAvailableStrokeLengthOptions() {
    return StrokeLengthOptionsEnum.values
        .where((option) => option != StrokeLengthOptionsEnum.unselected)
        .toList();
  }

  List<KickTechniqueOptionsEnum> getAvailableKickTechniqueOptions() {
    return KickTechniqueOptionsEnum.values
        .where((option) => option != KickTechniqueOptionsEnum.unselected)
        .toList();
  }

  List<KickThroughoutOptionsEnum> getAvailableKickThroughoutOptions() {
    return KickThroughoutOptionsEnum.values
        .where((option) => option != KickThroughoutOptionsEnum.unselected)
        .toList();
  }

  List<HeadPositionOptionsEnum> getAvailableHeadPositionOptions() {
    return HeadPositionOptionsEnum.values
        .where((option) => option != HeadPositionOptionsEnum.unselected)
        .toList();
  }

  List<TurnOptionsEnum> getAvailableTurnOptions() {
    return TurnOptionsEnum.values
        .where((option) => option != TurnOptionsEnum.unselected)
        .toList();
  }

  void handleSelectedOption(Enum option) {
    print(
      'Handling selected option: $option, runtimeType: ${option.runtimeType}',
    );
    if (option is SelfTalkOptionsEnum) {
      print('Selecting self talk option: $option');
      selectSelfTalk(option);
    } else if (option is NervesOptionsEnum) {
      selectNerve(option);
    } else if (option is EnergyLevelOptionsEnum) {
      selectEnergyLevel(option);
    } else if (option is BreathingOptionsEnum) {
      selectBreathing(option);
    } else if (option is CatchFeelOptionsEnum) {
      selectCatchFeel(option);
    } else if (option is StrokeLengthOptionsEnum) {
      selectStrokeLength(option);
    } else if (option is KickTechniqueOptionsEnum) {
      selectKickTechnique(option);
    } else if (option is KickThroughoutOptionsEnum) {
      selectKickThroughout(option);
    } else if (option is HeadPositionOptionsEnum) {
      selectHeadPosition(option);
    } else if (option is TurnOptionsEnum) {
      selectTurn(option);
    } else {
      throw ArgumentError(
        'Unknown option type in handleSelectedOption: $option',
      );
    }
  }
}

final postSwimQuestionnaireLogSwimsProvider =
    NotifierProvider<
      PostSwimQuestionnaireLogSwimsProvider,
      PostSwimQuestionnaireModel
    >(PostSwimQuestionnaireLogSwimsProvider.new);
