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

  void updateSelfTalk(SelfTalkOptionsEnum selfTalk) {
    state = state.copyWith(selfTalk: selfTalk);
  }

  void updateNerves(NervesOptionsEnum nerves) {
    state = state.copyWith(nerves: nerves);
  }

  void updateEnergyLevel(EnergyLevelOptionsEnum energyLevel) {
    state = state.copyWith(energyLevel: energyLevel);
  }

  void updateBreathing(BreathingOptionsEnum breathing) {
    state = state.copyWith(breathing: breathing);
  }

  void updateCatchFeel(CatchFeelOptionsEnum catchFeel) {
    state = state.copyWith(catchFeel: catchFeel);
  }

  void updateStrokeLength(StrokeLengthOptionsEnum strokeLength) {
    state = state.copyWith(strokeLength: strokeLength);
  }

  void updateKickTechnique(KickTechniqueOptionsEnum kickTechnique) {
    state = state.copyWith(kickTechnique: kickTechnique);
  }

  void updateKickThroughout(KickThroughoutOptionsEnum kickThroughout) {
    state = state.copyWith(kickThroughout: kickThroughout);
  }

  void updateHeadPosition(HeadPositionOptionsEnum headPosition) {
    state = state.copyWith(headPosition: headPosition);
  }

  void updateTurn(TurnOptionsEnum turn) {
    state = state.copyWith(turn: turn);
  }
}

final postSwimQuestionnaireLogSwimsProvider =
    NotifierProvider<
      PostSwimQuestionnaireLogSwimsProvider,
      PostSwimQuestionnaireModel
    >(PostSwimQuestionnaireLogSwimsProvider.new);
