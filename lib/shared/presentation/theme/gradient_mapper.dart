import 'dart:ui';

import 'package:swimming_app_frontend/shared/presentation/theme/metric_colors.dart';

import 'package:flutter/material.dart';

const double purpleThreshold = -5;
const double blueMin = -4;
const double blueMax = 4;
const double orangeThreshold = 5;

Color mapValueToColor(double value, double opacity) {
  // Gradient definition
  final colors = [
    metricPurple.withOpacity(opacity), // -0.08
    metricPurple.withOpacity(opacity), // -0.05
    metricBlue.withOpacity(opacity), // -0.04
    metricBlue.withOpacity(opacity), //  0.04
    metricOrange.withOpacity(opacity), //  0.05
    metricOrange.withOpacity(opacity), //  0.08
  ];

  final stops = [
    -8, // purple
    -5, // purple
    -4, // purple→blue transition
    4, // blue
    5, // blue→orange transition
    9, // orange
  ];

  // Clamp value to domain
  value = value.clamp(-8, 8);

  // Find the two stops this value falls between
  for (int i = 0; i < stops.length - 1; i++) {
    final start = stops[i];
    final end = stops[i + 1];
    if (value >= start && value <= end) {
      final t = (value - start) / (end - start);
      return Color.lerp(colors[i], colors[i + 1], t)!;
    }
  }

  // Fallback (should never happen if value is clamped)
  return colors.last;
}

List<double> calculateStops(double minY, double maxY) {
  double normalize(double y) => (y - minY) / (maxY - minY);

  return [
    0.0, // bottom = minY
    normalize(purpleThreshold), // -5
    normalize(blueMin), // -4
    normalize(blueMax), // +4
    normalize(orangeThreshold), // +5
    1.0, // top = maxY
  ];
}
