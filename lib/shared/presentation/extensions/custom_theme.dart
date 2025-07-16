import 'package:flutter/material.dart';

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  final Color belowCard;

  const CustomColors({required this.belowCard});

  @override
  CustomColors copyWith({Color? belowCard}) {
    return CustomColors(belowCard: belowCard ?? this.belowCard);
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) return this;
    return CustomColors(
      belowCard: Color.lerp(belowCard, other.belowCard, t) ?? belowCard,
    );
  }
}
