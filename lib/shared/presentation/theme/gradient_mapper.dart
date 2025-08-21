import 'dart:ui';

import 'package:swimming_app_frontend/shared/presentation/theme/metric_colors.dart';

Color mapValueToGradient(double value, {double opacity = 1.0}) {
  // Clamp value to valid range
  if (value <= -0.08) return metricPurple.withOpacity(opacity);
  if (value >= 0.08) return metricOrange.withOpacity(opacity);

  // Purple range
  if (value <= -0.05) return metricPurple.withOpacity(opacity);

  // Purple → Blue transition
  if (value <= -0.04) {
    double t = (value - (-0.05)) / (0.01); // scale into [0,1]
    return Color.lerp(metricPurple, metricBlue, t)!.withOpacity(opacity);
  }

  // Solid Blue
  if (value < 0.04) return metricBlue.withOpacity(opacity);

  // Blue → Orange transition
  if (value <= 0.05) {
    double t = (value - 0.04) / (0.01); // scale into [0,1]
    return Color.lerp(metricBlue, metricOrange, t)!.withOpacity(opacity);
  }

  // Orange range
  return metricOrange.withOpacity(opacity);
}
